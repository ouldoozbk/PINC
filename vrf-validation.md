# VRF A.5: Intent Validation Through JSON Specification Comparison

## Overview

This proposal introduces an intermediate verification step (VRF A.5) between VRF A (compilation checking) and VRF B (functional testing) to address the critical gap identified in Section 5 of the PINC paper: **ensuring that generated P4 code actually implements the user's intended behavior, not just compilable code**.

## The Problem

Current PINC pipeline:
1. **VRF A**: Validates compilation success ✓
2. **VRF B**: Validates functional correctness via P4TestGen ✓
3. **Missing**: Intent alignment validation ✗

As noted in the paper's limitations:
> "A model can produce syntactically valid and internally consistent P4 code that does not align with the intended policy. For example, if the prompt requests a program that drops all packets on a given port, but the model outputs a program that forwards packets instead, the program will still compile and pass P4TestGen."

## Proposed Solution: Intent Specification Matching

### Architecture

```
User Intent
    ↓
[Intent Parser] → Expected Behavior JSON (JSON_EXPECTED)
    ↓
[LLM Code Generation]
    ↓
[VRF A: Compilation Check] ✓
    ↓
[VRF A.5: INTENT VALIDATION] ← NEW STEP
    ├─ Generated Code → [Behavior Extractor] → Actual Behavior JSON (JSON_ACTUAL)
    ├─ JSON_EXPECTED vs JSON_ACTUAL → [Semantic Comparator]
    └─ Match Score > Threshold? → Pass/Fail
    ↓
[VRF B: Functional Testing]
    ↓
Deployment
```

### Component Details

#### 1. Intent Parser (Pre-Generation)

**Purpose**: Convert natural language intent into a structured JSON specification BEFORE code generation.

**Input**: User's natural language intent
```
"Implement a basic Ethernet switch with source MAC learning and destination MAC forwarding"
```

**Output**: `expected_behavior.json`
```json
{
  "intent_id": "ethernet_switch_001",
  "timestamp": "2026-02-11T10:30:00Z",
  "intent_type": "ethernet_switching",
  "required_behaviors": [
    {
      "behavior_id": "mac_learning",
      "description": "Learn source MAC addresses from incoming packets",
      "components": {
        "table_required": true,
        "table_type": "exact",
        "key_fields": ["ethernet.srcAddr"],
        "action_types": ["learn", "update"]
      }
    },
    {
      "behavior_id": "mac_forwarding",
      "description": "Forward packets based on destination MAC",
      "components": {
        "table_required": true,
        "table_type": "exact",
        "key_fields": ["ethernet.dstAddr"],
        "action_types": ["forward", "broadcast"]
      }
    }
  ],
  "headers_required": ["ethernet"],
  "control_blocks": {
    "ingress": {
      "required": true,
      "must_contain": ["mac_learning_logic", "forwarding_decision"]
    },
    "egress": {
      "required": false
    }
  },
  "prohibited_behaviors": [
    "packet_drop_by_default",
    "static_routing"
  ],
  "performance_constraints": {
    "table_size_min": 1024,
    "lookup_type": "exact_match"
  }
}
```

**Implementation Approach**:
- Use the fine-tuned LLM with a specialized prompt to extract intent structure
- Alternative: Use the intent classifier (Section 4.1.3) + template mapping
- Alternative: Few-shot prompting with intent-to-JSON examples

#### 2. Behavior Extractor (Post-Generation)

**Purpose**: Parse generated P4 code and extract its actual behavioral specification.

**Input**: Generated P4 code (post VRF A compilation)

**Output**: `actual_behavior.json`
```json
{
  "code_id": "generated_001",
  "timestamp": "2026-02-11T10:30:15Z",
  "detected_behaviors": [
    {
      "behavior_id": "mac_learning_impl",
      "evidence": {
        "table_name": "mac_learning",
        "table_type": "exact",
        "key_fields": ["hdr.ethernet.srcAddr"],
        "actions": ["learn_mac", "NoAction"],
        "default_action": "NoAction"
      }
    },
    {
      "behavior_id": "mac_forwarding_impl",
      "evidence": {
        "table_name": "forward",
        "table_type": "exact",
        "key_fields": ["hdr.ethernet.dstAddr"],
        "actions": ["set_egress_port", "broadcast"],
        "default_action": "broadcast"
      }
    }
  ],
  "headers_defined": ["ethernet_t"],
  "control_blocks": {
    "ingress": ["MyIngress"],
    "egress": ["MyEgress"]
  },
  "suspicious_patterns": []
}
```

**Implementation Approach**:
- Parse P4 AST (Abstract Syntax Tree) using p4c compiler frontend
- Alternative: Use regex/pattern matching for key P4 constructs
- Alternative: LLM-based extraction with structured output prompt

#### 3. Semantic Comparator

**Purpose**: Compare expected vs actual behavior specifications and compute match score.

**Comparison Logic**:

```python
def compute_intent_match_score(expected_json, actual_json):
    """
    Returns a match score between 0.0 and 1.0
    """
    scores = {
        'required_behaviors': 0.0,  # Weight: 0.5
        'headers': 0.0,              # Weight: 0.15
        'control_blocks': 0.0,       # Weight: 0.15
        'prohibited_check': 0.0,     # Weight: 0.2
    }
    
    # 1. Check required behaviors
    required = set(b['behavior_id'] for b in expected_json['required_behaviors'])
    detected = set(b['behavior_id'].replace('_impl', '') 
                   for b in actual_json['detected_behaviors'])
    
    scores['required_behaviors'] = len(required & detected) / len(required)
    
    # 2. Check headers
    expected_headers = set(expected_json['headers_required'])
    actual_headers = set(h.replace('_t', '') for h in actual_json['headers_defined'])
    
    scores['headers'] = len(expected_headers & actual_headers) / len(expected_headers)
    
    # 3. Check control blocks
    for block in ['ingress', 'egress']:
        if expected_json['control_blocks'][block]['required']:
            scores['control_blocks'] += 0.5 if actual_json['control_blocks'][block] else 0
    
    # 4. Check prohibited behaviors
    prohibited = set(expected_json['prohibited_behaviors'])
    suspicious = set(actual_json.get('suspicious_patterns', []))
    
    scores['prohibited_check'] = 1.0 if not (prohibited & suspicious) else 0.0
    
    # Weighted final score
    weights = {'required_behaviors': 0.5, 'headers': 0.15, 
               'control_blocks': 0.15, 'prohibited_check': 0.2}
    
    final_score = sum(scores[k] * weights[k] for k in scores)
    
    return final_score, scores
```

**Validation Decision**:
- **Score ≥ 0.85**: PASS → Proceed to VRF B
- **0.60 ≤ Score < 0.85**: PARTIAL → Flag for human review + proceed to VRF B
- **Score < 0.60**: FAIL → Regenerate code with specific feedback

#### 4. Feedback Loop

When VRF A.5 fails, generate specific feedback for the LLM:

```python
def generate_intent_mismatch_feedback(expected_json, actual_json, scores):
    """
    Generate actionable feedback for LLM regeneration
    """
    feedback = {
        'validation_result': 'INTENT_MISMATCH',
        'match_score': scores['final_score'],
        'issues': []
    }
    
    # Identify missing behaviors
    required = set(b['behavior_id'] for b in expected_json['required_behaviors'])
    detected = set(b['behavior_id'].replace('_impl', '') 
                   for b in actual_json['detected_behaviors'])
    missing = required - detected
    
    if missing:
        feedback['issues'].append({
            'type': 'MISSING_BEHAVIOR',
            'severity': 'CRITICAL',
            'details': f"Required behaviors not implemented: {list(missing)}",
            'suggestion': "Add tables and actions to implement these behaviors"
        })
    
    # Identify prohibited behaviors
    prohibited = set(expected_json['prohibited_behaviors'])
    suspicious = set(actual_json.get('suspicious_patterns', []))
    violations = prohibited & suspicious
    
    if violations:
        feedback['issues'].append({
            'type': 'PROHIBITED_BEHAVIOR',
            'severity': 'CRITICAL',
            'details': f"Code contains prohibited patterns: {list(violations)}",
            'suggestion': "Remove or modify the following logic to avoid these patterns"
        })
    
    return feedback
```

### Integration into PINC Pipeline

#### Modified `main()` function:

```python
def main():
    cleanup_files()
    
    # Get user intent
    intent = get_user_intent()
    
    # NEW: Generate expected behavior JSON BEFORE code generation
    print("\n[VRF A.5 Pre-Check] Analyzing intent and generating expected behavior specification...")
    expected_behavior_json = generate_expected_behavior(intent)
    save_json(expected_behavior_json, "expected_behavior.json")
    
    # Get YANG model and data
    yang_model = get_yang_model()
    yang_data = get_yang_data()
    
    max_attempts = 10
    attempt = 1
    
    while attempt <= max_attempts:
        print(f"\nAttempt {attempt} of {max_attempts}")
        
        # Generate code
        prompt = create_detailed_prompt(intent, yang_model, yang_data, error_feedback)
        p4_code = generate_p4_code(prompt)
        
        # VRF A: Compilation check
        print("\n[VRF A] Validating compilation...")
        compilation_success, compile_errors = validate_p4_compilation(p4_code)
        
        if not compilation_success:
            error_feedback = compile_errors
            attempt += 1
            continue
        
        # NEW: VRF A.5: Intent validation
        print("\n[VRF A.5] Validating intent alignment...")
        actual_behavior_json = extract_behavior_from_code(p4_code)
        save_json(actual_behavior_json, "actual_behavior.json")
        
        match_score, detailed_scores = compute_intent_match_score(
            expected_behavior_json, 
            actual_behavior_json
        )
        
        print(f"  Intent Match Score: {match_score:.2%}")
        print(f"  - Required Behaviors: {detailed_scores['required_behaviors']:.2%}")
        print(f"  - Headers: {detailed_scores['headers']:.2%}")
        print(f"  - Control Blocks: {detailed_scores['control_blocks']:.2%}")
        print(f"  - Prohibited Checks: {detailed_scores['prohibited_check']:.2%}")
        
        if match_score < 0.60:
            print("  ❌ INTENT MISMATCH - Regenerating code...")
            intent_feedback = generate_intent_mismatch_feedback(
                expected_behavior_json, 
                actual_behavior_json, 
                detailed_scores
            )
            error_feedback = format_feedback_for_llm(intent_feedback)
            attempt += 1
            continue
        elif match_score < 0.85:
            print("  ⚠️  PARTIAL MATCH - Flagging for review but proceeding...")
            log_partial_match(intent, p4_code, match_score, detailed_scores)
        else:
            print("  ✅ INTENT VALIDATED")
        
        # VRF B: Functional testing
        print("\n[VRF B] Running functional tests...")
        functional_success, test_errors = run_p4testgen_validation(p4_code)
        
        if functional_success:
            print("\n✅ All verification steps passed!")
            return p4_code
        else:
            error_feedback = test_errors
            attempt += 1
    
    print(f"\n❌ Failed after {max_attempts} attempts")
    return None
```

### Implementation Files

#### New Files to Create:

1. **`intent_parser.py`**: Intent → Expected Behavior JSON
2. **`behavior_extractor.py`**: P4 Code → Actual Behavior JSON  
3. **`semantic_comparator.py`**: JSON comparison and scoring
4. **`vrf_a5_validator.py`**: Main VRF A.5 orchestrator

#### Modified Files:

1. **`generate_p4.py`**: Integrate VRF A.5 into main loop
2. **`validate_p4.sh`**: Add intent validation step

### Example Workflow

```bash
$ python generate_p4.py

Please provide your network intent:
> Implement a firewall that drops all TCP SYN packets from IP 10.0.0.5

[VRF A.5 Pre-Check] Analyzing intent...
✓ Generated expected_behavior.json

[Attempt 1]
Generating P4 code...

[VRF A] Validating compilation...
✓ Code compiles successfully

[VRF A.5] Validating intent alignment...
✓ Extracted actual_behavior.json
  Intent Match Score: 92.5%
  - Required Behaviors: 100.0%
  - Headers: 100.0%
  - Control Blocks: 75.0%
  - Prohibited Checks: 100.0%
  ✅ INTENT VALIDATED

[VRF B] Running functional tests...
✓ All test cases passed (10/10)

✅ All verification steps passed!
```

## Benefits

1. **Early Intent Mismatch Detection**: Catch intent violations before expensive functional testing
2. **Interpretable Feedback**: JSON comparison provides clear, actionable feedback for regeneration
3. **Reduced False Positives**: Avoid passing compilable but incorrect code to VRF B
4. **Audit Trail**: JSON specifications provide documentation of intent vs implementation
5. **Human Review Support**: Partial matches flagged for expert validation

## Challenges & Mitigations

| Challenge | Mitigation Strategy |
|-----------|---------------------|
| LLM hallucination in intent parsing | Use constrained generation / structured output formats |
| Complex intents → JSON ambiguity | Develop intent taxonomy with canonical JSON templates |
| P4 code diversity makes extraction hard | Build AST parser using p4c frontend libraries |
| Threshold tuning (when is 85% enough?) | Collect human validation data to calibrate thresholds |
| Computational overhead | Cache parsed behaviors, parallelize JSON comparison |

## Future Enhancements

1. **Learned Comparators**: Train a classifier to predict intent match from (expected, actual) JSON pairs
2. **Incremental Validation**: Check intent alignment during code generation (not just after)
3. **Multi-Intent Support**: Handle composite intents with multiple sub-goals
4. **Natural Language Explanations**: Generate human-readable reports of mismatches
5. **Integration with VRF C**: Use runtime telemetry to update expected behavior specs

## References

- PINC Paper Section 5: Limitations (Intent alignment gap)
- P4 Language Specification: https://p4.org/p4-spec/docs/P4-16-v1.2.0.html
- P4C Compiler Frontend: https://github.com/p4lang/p4c
- Structured Output Prompting: OpenAI Function Calling / Anthropic Tool Use

---

## Implementation Checklist

- [ ] Design JSON schema for expected behavior specification
- [ ] Implement intent parser (LLM-based or template-based)
- [ ] Implement P4 AST behavior extractor
- [ ] Implement semantic comparator with scoring logic
- [ ] Integrate VRF A.5 into main pipeline
- [ ] Create test suite with known intent/code pairs
- [ ] Calibrate scoring thresholds with validation data
- [ ] Document JSON schema and examples
- [ ] Add logging and monitoring for VRF A.5 metrics

---

**Author**: PINC Research Team  
**Date**: February 11, 2026  
**Status**: Proposal / Design Document