import os  # The os module in Python provides a way to interact with the operating system.
import re
import glob
import json
import subprocess
import time

# VRF A.5: Intent validation (expected/actual behavior comparison)
from intent_parser import generate_expected_behavior, save_expected_behavior
from vrf_a5_validator import run_vrf_a5

# Use Replicate if REPLICATE_API_TOKEN is set, otherwise OpenAI
if os.getenv('REPLICATE_API_TOKEN'):
    import replicate
else:
    import openai  # The OpenAI API library for generating P4 code

def cleanup_files():
    """Clean up all P4 and error-related files before starting."""
    # Files to remove
    patterns = [
       "*.p4",
       "*.p4i",
       "test.json",    # JSON configuration files
       "validation_status.txt",
       "error_summary.txt",
       "p4_validation_errors.txt",
       "temp_errors.txt",
       "detailed_prompt.txt",
       "expected_behavior.json",
       "actual_behavior.json",
   ]
    
    print("\nCleaning up previous files...")
    for pattern in patterns:
        for file in glob.glob(pattern):
            try:
                os.remove(file)
                print(f"Removed: {file}")
            except OSError as e:
                print(f"Error removing {file}: {e}")
    print("Cleanup complete.\n")

def get_user_intent():
    #Get the networking intent from the user
    print("\nPlease provide your network intent here, please try to be as specific as possible (e.g., 'Create a P4 program for basic packet forwarding'):")
    return input("> ").strip() #Getting the user's intent

def get_yang_model():
    """Get YANG model (schema) from file or user input (optional)"""
    import shutil
    # First, check if there's a YANG file in the current directory
    yang_files = glob.glob("*.yang")
    
    if yang_files:
        print(f"\nFound YANG file(s): {', '.join(yang_files)}")
        print("Do you want to use the YANG file for configuration? (y/n):")
        choice = input("> ").strip().lower()
        
        if choice in ['y', 'yes']:
            if len(yang_files) == 1:
                yang_file = yang_files[0]
            else:
                print("\nMultiple YANG files found. Please select one:")
                for i, file in enumerate(yang_files, 1):
                    print(f"{i}. {file}")
                while True:
                    try:
                        selection = int(input("Enter number: ").strip())
                        if 1 <= selection <= len(yang_files):
                            yang_file = yang_files[selection - 1]
                            break
                        else:
                            print("Invalid selection. Please try again.")
                    except ValueError:
                        print("Please enter a valid number.")
            # Validate the YANG file using pyang before proceeding
            try:
                if not shutil.which("pyang"):
                    raise FileNotFoundError("pyang not found in PATH. Please install it with 'pip install pyang' or your package manager.")
                validate_result = subprocess.run([
                    'pyang', yang_file
                ], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
                if validate_result.returncode != 0:
                    print(f"\n❌ The selected YANG file '{yang_file}' is not valid.")
                    print("pyang error message:")
                    print(validate_result.stderr)
                    print("Exiting.")
                    exit(1)
            except FileNotFoundError as e:
                print(f"Error: {e}")
                print("Exiting.")
                exit(1)
            # Instead of pyang -f tree, just read and display the raw YANG file content
            try:
                with open(yang_file, 'r') as f:
                    yang_content = f.read()
                print("\n" + "="*60)
                print("📋 RAW YANG CONFIGURATION")
                print("="*60)
                print(yang_content)
                print("="*60)
                print("\nDo you want to proceed with this configuration? (y/n):")
                proceed = input("> ").strip().lower()
                if proceed in ['y', 'yes']:
                    return yang_content
                else:
                    print("Configuration rejected. Continuing without YANG configuration.")
                    return None
            except Exception as e:
                print(f"Error reading YANG file {yang_file}: {e}")
                print("Falling back to manual input...")
    # If no YANG file or user does not want to use one, just print a message and return None
    print("\nNo YANG configuration file found or selected.")
    return None

#getting the actual yang data/current configuration
def get_yang_data(yang_model_file=None):
    """Get YANG data (JSON) from file if available."""
    json_files = glob.glob("*.json")
    if json_files:
        print(f"\nFound JSON config file(s): {', '.join(json_files)}")
        print("Do you want to use a JSON config file for current network data? (y/n):")
        choice = input("> ").strip().lower()
        if choice in ['y', 'yes']:
            if len(json_files) == 1:
                json_file = json_files[0]
            else:
                print("\nMultiple JSON files found. Please select one:")
                for i, file in enumerate(json_files, 1):
                    print(f"{i}. {file}")
                while True:
                    try:
                        selection = int(input("Enter number: ").strip())
                        if 1 <= selection <= len(json_files):
                            json_file = json_files[selection - 1]
                            break
                        else:
                            print("Invalid selection. Please try again.")
                    except ValueError:
                        print("Please enter a valid number.")
            try:
                with open(json_file, 'r') as f:
                    yang_data = f.read()
                print("\n" + "="*60)
                print("📋 YANG DATA (JSON)")
                print("="*60)
                print(yang_data)
                print("="*60)
                print("\nDo you want to proceed with this data? (y/n):")
                proceed = input("> ").strip().lower()
                if proceed in ['y', 'yes']:
                    return yang_data
                else:
                    print("Data rejected. Continuing without YANG data.")
                    return None
            except Exception as e:
                print(f"Error reading JSON file {json_file}: {e}")
    print("\nNo YANG data file found or selected.")
    return None


# Making a function that uses the user's intent to create a detailed prompt for the LLM
def create_detailed_prompt(intent, yang_model=None, yang_data=None, error_feedback=None):
    base_prompt = f"""Generate P4-16 code that implements the following network intent: {intent}"""

    # Add YANG model (schema)
    if yang_model:
        base_prompt += f"""

YANG Model (Schema):
--------------------
{yang_model}
"""

    # Add YANG data (actual config)
    if yang_data:
        base_prompt += f"""

YANG Data (Current Configuration):
---------------------------------
{yang_data}
"""

    base_prompt += f"""

Please generate P4 code that:
1. Implements the user's intent: "{intent}"
2. Works with the current network configuration
3. Respects existing interface and firewall rules
4. Avoids conflicts with current setup

IMPORTANT: Start your response with the P4 code directly. Do not include any text, explanations, or markdown formatting before the code.

The code must be compatible with the v1model.p4 architecture and follow P4_16 syntax. Include:

1. Required includes:
   #include <core.p4>
   #include <v1model.p4>

2. Header and metadata definitions:
   - Define headers using 'header' keyword, not 'header_type'
   - Use 'const' for constants (never 'constant'), with an initializer: e.g. const bit<16> ETHERTYPE_IPV4 = 0x0800;
   - Define a metadata struct
   - Define a headers struct containing all headers

3. Define the following components with UNIQUE names (avoid using standard names like Parser, Ingress, etc.):
   - Parser: (packet_in packet, out headers hdr, inout metadata meta, inout standard_metadata_t standard_metadata)
   - VerifyChecksum: (inout headers hdr, inout metadata meta)
   - Ingress: (inout headers hdr, inout metadata meta, inout standard_metadata_t standard_metadata)
   - Egress: (inout headers hdr, inout metadata meta, inout standard_metadata_t standard_metadata)
   - ComputeChecksum: (inout headers hdr, inout metadata meta)
   - Deparser: (packet_out packet, in headers hdr)

4. End with V1Switch instantiation using your unique component names:
   V1Switch(MyParser(), MyVerifyChecksum(), MyIngress(), MyEgress(), MyComputeChecksum(), MyDeparser()) main;

The code should be complete, properly structured, and ready to compile with p4c.
"""

    # Golden P4-16 example — use a regular string (NOT f-string) to avoid
    # conflicts between P4 braces and Python f-string interpolation.
    base_prompt += """
MINIMAL COMPILABLE P4-16 REFERENCE (use this as a structural template):
------------------------------------------------------------------------
#include <core.p4>
#include <v1model.p4>

const bit<16> ETHERTYPE_IPV4 = 0x0800;

header ethernet_t {
    bit<48> dstAddr;
    bit<48> srcAddr;
    bit<16> etherType;
}

struct metadata { }

struct headers {
    ethernet_t ethernet;
}

parser MyParser(packet_in packet, out headers hdr, inout metadata meta,
                inout standard_metadata_t standard_metadata) {
    state start {
        packet.extract(hdr.ethernet);
        transition accept;
    }
}

control MyVerifyChecksum(inout headers hdr, inout metadata meta) { apply { } }

control MyIngress(inout headers hdr, inout metadata meta,
                  inout standard_metadata_t standard_metadata) {
    action forward(bit<9> port) {
        standard_metadata.egress_spec = port;
    }
    table fwd_table {
        key = { hdr.ethernet.dstAddr: exact; }
        actions = { forward; NoAction; }
        size = 1024;
        default_action = NoAction();
    }
    apply {
        fwd_table.apply();
    }
}

control MyEgress(inout headers hdr, inout metadata meta,
                 inout standard_metadata_t standard_metadata) { apply { } }

control MyComputeChecksum(inout headers hdr, inout metadata meta) { apply { } }

control MyDeparser(packet_out packet, in headers hdr) {
    apply { packet.emit(hdr.ethernet); }
}

V1Switch(MyParser(), MyVerifyChecksum(), MyIngress(), MyEgress(),
         MyComputeChecksum(), MyDeparser()) main;
------------------------------------------------------------------------
KEY POINTS from the template above:
- Tables are applied with table_name.apply() NOT apply_table(table_name)
- Use parameter names (hdr, meta, standard_metadata) NOT type names (headers, metadata, standard_metadata_t) in the body
- All logic is inside apply { } blocks
- "const" is used, never "constant"
"""

    # Add the example at the end of the prompt
    try:
        with open('example_case.txt', 'r') as f:
            example_case = f.read()
        base_prompt += f"""

Here is an example mapping of intent, configuration, and P4 code for your reference:
{example_case}

Please use this as a guide for style, structure, and how to map intent and configuration to P4 code.
"""
    except FileNotFoundError:
        pass  # No example provided

    if error_feedback:
        base_prompt += f"\n\nHere is the complete history of validation errors from previous attempts. Please analyze these errors carefully and ensure the new code addresses ALL of these issues:\n{error_feedback}\n\nGenerate a corrected version that addresses all these issues and does not repeat any of the previous errors. Remember to start with the code directly, no text before it."

    return base_prompt

SYSTEM_PROMPT = """You are a P4 programming expert. Your task is to generate P4 code.
IMPORTANT RULES:
1. Start your response with the P4 code directly
2. Do not include any text, explanations, or markdown formatting before the code
3. Do not include any text after the code
4. The code must be complete and valid P4-16 code (NOT P4-14).
5. P4-16 syntax only — NEVER use P4-14 constructs:
   - Use "const" for constants, NEVER "constant". Example: const bit<16> ETHERTYPE_IPV4 = 0x0800;
   - Use "header" for headers (e.g. "header ethernet_t { ... }"), not "header_type"
6. Control block structure — CRITICAL:
   - Inside a control block, ONLY actions, tables, and the apply { } block are allowed at the top level.
   - ALL packet-processing logic (if/else, table applies, assignments) MUST be inside apply { ... }.
   - Do NOT place any statements or expressions outside of apply { }.
7. Table application syntax — CRITICAL:
   - P4-16 uses table_name.apply();  (method call on the table object)
   - NEVER use apply_table(table_name);  (that is P4-14 syntax and will NOT compile)
   - Example: mac_table.apply();  NOT apply_table(mac_table);
8. Parameter names vs type names — CRITICAL:
   - When the control signature is: control MyIngress(inout headers hdr, inout metadata meta, inout standard_metadata_t standard_metadata)
   - Use the PARAMETER names (hdr, meta, standard_metadata) in the body, NOT the type names.
   - Write: meta.ingress_port  NOT metadata.ingress_port
   - Write: standard_metadata.egress_spec  NOT standard_metadata_t.egress_spec
   - Write: hdr.ethernet  NOT headers.ethernet
9. V1Switch architecture — CRITICAL:
   - Define EXACTLY 6 components: Parser, VerifyChecksum, Ingress, Egress, ComputeChecksum, Deparser.
   - Do NOT create extra control blocks (e.g. MyForwarding, MyControl). They are unused and cause errors.
   - Put ALL forwarding/learning/processing logic inside MyIngress and MyEgress, not in separate control blocks.
10. .apply() is ONLY for tables — CRITICAL:
   - NEVER write MyIngress.apply() or MyEgress.apply() or any ControlName.apply().
   - .apply() is a method on TABLE objects only. Controls are invoked by V1Switch, not by calling .apply().
   - Correct: my_table.apply();  WRONG: MyIngress.apply();
11. Ensure all code follows P4-16 standards and best practices."""


def _generate_p4_code_replicate(prompt):
    """Generate P4 code using Replicate (e.g. Meta Llama 3). Set REPLICATE_API_TOKEN."""
    try:
        # meta/meta-llama-3-8b-instruct supports system_prompt + prompt; output may stream
        output = replicate.run(
            "meta/meta-llama-3-8b-instruct",
            input={
                "prompt": prompt,
                "system_prompt": SYSTEM_PROMPT,
                "temperature": 0.7,
                "max_tokens": 4000,
            },
        )
        # Replicate text models can return an iterator (streaming); join to get full string
        if hasattr(output, "__iter__") and not isinstance(output, str):
            return "".join(str(chunk) for chunk in output)
        return str(output) if output is not None else None
    except Exception as e:
        print(f"Error generating P4 code (Replicate): {e}")
        return None


def _generate_p4_code_openai(prompt):
    """Generate P4 code using OpenAI. Set OPENAI_API_KEY."""
    try:
        openai.api_key = os.getenv("OPENAI_API_KEY")
        response = openai.ChatCompletion.create(
            model="gpt-4",
            messages=[
                {"role": "system", "content": SYSTEM_PROMPT},
                {"role": "user", "content": prompt},
            ],
            temperature=0.7,
            max_tokens=4000,
        )
        return response.choices[0].message["content"]
    except Exception as e:
        print(f"Error generating P4 code (OpenAI): {e}")
        return None


def generate_p4_code(prompt):
    """Generate P4 code using Replicate (if REPLICATE_API_TOKEN set) or OpenAI (if OPENAI_API_KEY set)."""
    if os.getenv("REPLICATE_API_TOKEN"):
        return _generate_p4_code_replicate(prompt)
    if os.getenv("OPENAI_API_KEY"):
        return _generate_p4_code_openai(prompt)
    print("Error: Set either REPLICATE_API_TOKEN or OPENAI_API_KEY")
    return None

def clean_p4_code(raw_code):
    """Clean up the generated P4 code by removing markdown formatting and extra content."""
    # Find the P4 code block
    p4_block = re.search(r'```(?:P4|p4)?\n(.*?)```', raw_code, re.DOTALL)
    if p4_block:
        code = p4_block.group(1).strip()
    else:
        # If no code block found, try to find the first #include
        code = raw_code.strip()
        if '#include' in code:
            code = code[code.find('#include'):]
    
    # Remove any text before the first #include
    if '#include' in code:
        code = code[code.find('#include'):]
    
    # Remove any "p4" or "P4" line at the start of the file
    code = re.sub(r'^[pP]4\s*\n', '', code)

    # P4-16 uses "const", not "constant" (P4-14). Fix common LLM mistake.
    code = re.sub(r'\bconstant\b', 'const', code)

    # P4-16 uses table_name.apply(), not apply_table(table_name) (P4-14).
    code = re.sub(r'\bapply_table\s*\(\s*(\w+)\s*\)', r'\1.apply()', code)

    # Fix common LLM mistake: using struct type name "metadata" instead of
    # the parameter name "meta" inside control blocks.
    # Pattern: metadata.<field> used as an lvalue/rvalue (not in struct definition).
    # We only fix occurrences that look like assignments or expressions, not the
    # "struct metadata { ... }" definition itself.
    # Negative lookbehind for "struct " avoids mangling the struct definition line.
    code = re.sub(r'(?<!struct )(?<!\w)metadata\.', 'meta.', code)

    # Fix common LLM mistake: calling ControlName.apply() as if it were a table.
    # In P4-16, .apply() is only valid on tables, never on control blocks.
    # The V1Switch controls have known names — remove lines that call them with .apply().
    v1_control_names = _extract_v1switch_control_names(code)
    for ctrl_name in v1_control_names:
        # Remove lines like "            MyIngress.apply();"
        code = re.sub(
            r'^\s*' + re.escape(ctrl_name) + r'\s*\.\s*apply\s*\(\s*\)\s*;\s*$',
            '',
            code,
            flags=re.MULTILINE
        )

    # Remove extra control blocks not part of V1Switch (e.g. MyForwarding).
    # V1Switch uses exactly 6 controls. Any control definition not in that list is dead code
    # and may cause "unused" warnings or errors.
    if v1_control_names:
        code = _remove_unused_controls(code, v1_control_names)

    # Remove any leading/trailing whitespace
    code = code.strip()

    return code


def _extract_v1switch_control_names(code: str):
    """Extract the control names used in the V1Switch(...) instantiation."""
    m = re.search(r'V1Switch\s*\(([^;]+)\)\s*main\s*;', code, re.DOTALL)
    if not m:
        return set()
    inner = m.group(1)
    return set(re.findall(r'(\w+)\s*\(\s*\)', inner))


def _remove_unused_controls(code: str, v1switch_names: set):
    """Remove control block definitions that are not referenced in V1Switch."""
    # Also keep parser/deparser (they appear in V1Switch too)
    # Find all control definitions: control Name(...) { ... }
    result = code
    for m in list(re.finditer(r'control\s+(\w+)\s*\([^)]*\)\s*\{', code)):
        name = m.group(1)
        if name not in v1switch_names:
            # Find the matching closing brace for this control block
            start = m.start()
            brace_start = code.index('{', m.start())
            depth = 1
            i = brace_start + 1
            while i < len(code) and depth > 0:
                if code[i] == '{':
                    depth += 1
                elif code[i] == '}':
                    depth -= 1
                i += 1
            # Remove the entire control block (from 'control' to closing '}')
            block = code[start:i]
            result = result.replace(block, '', 1)
    # Clean up any resulting double blank lines
    result = re.sub(r'\n{3,}', '\n\n', result)
    return result

def validate_p4_code(p4_code, filename, attempt):
    # Clean up the code before saving
    cleaned_code = clean_p4_code(p4_code)
    
    # Save the code to a file
    with open(filename, 'w') as f:
        f.write(cleaned_code)
    
    # Run the validation script with attempt number
    # Note: do NOT use shell=True with list args — it ignores extra elements on Unix.
    subprocess.run(['./validate_p4.sh', str(attempt)])
    
    # Check validation status
    try:
        with open('validation_status.txt', 'r') as f:
            status = f.read().strip()
        
        if status == "SUCCESS":
            return True, None
        
        # If validation failed, read the error summary
        with open('error_summary.txt', 'r') as f:
            error_feedback = f.read()
        return False, error_feedback
    
    except FileNotFoundError:
        return False, "Validation process failed to create status file"

def validate_p4_compilation(p4_code, filename="test.p4", attempt=1):
    """Run compilation-only validation (VRF A). Returns (success, error_feedback_string)."""
    cleaned = clean_p4_code(p4_code)
    with open(filename, "w") as f:
        f.write(cleaned)
    subprocess.run(["./validate_p4.sh", str(attempt)])
    try:
        with open("validation_status.txt", "r") as f:
            status = f.read().strip()
        if status == "SUCCESS":
            return True, None
        with open("error_summary.txt", "r") as f:
            return False, f.read()
    except FileNotFoundError:
        return False, "Validation process failed to create status file"


def read_error_summary():
    """Read the error summary file and return its contents."""
    try:
        with open("error_summary.txt", "r") as f:
            content = f.read()
            # Only return the last 3 attempts to keep the context size manageable
            attempts = content.split("=== Attempt")
            if len(attempts) > 4:  # Keep header + last 3 attempts
                return "=== P4 Code Validation Error History ===\n" + "=== Attempt".join(attempts[-3:])
            return content
    except FileNotFoundError:
        return "No error history available."

def main():
    # Clean up existing files
    cleanup_files()
    
    # Check for at least one API key (Replicate or OpenAI)
    if not os.getenv("REPLICATE_API_TOKEN") and not os.getenv("OPENAI_API_KEY"):
        print("Error: No API token set.")
        print("Use Replicate: export REPLICATE_API_TOKEN='r8_...'")
        print("Or OpenAI:     export OPENAI_API_KEY='sk-...'")
        return

    # Get user intent
    intent = get_user_intent()

    # VRF A.5 Pre-Check: generate expected behavior JSON before code generation
    print("\n[VRF A.5 Pre-Check] Analyzing intent and generating expected behavior specification...")
    expected_behavior_json = generate_expected_behavior(intent)
    save_expected_behavior(expected_behavior_json, "expected_behavior.json")
    print("  Generated expected_behavior.json")

    # Get YANG model (schema) and YANG data (actual config)
    yang_model = None
    yang_model_file = None
    yang_files = glob.glob("*.yang")
    if yang_files:
        yang_model = get_yang_model()
        # Determine which file was selected
        if yang_model:
            # Try to find the selected file by matching content
            for f in yang_files:
                with open(f, 'r') as file:
                    if file.read() == yang_model:
                        yang_model_file = f
                        break
    yang_data = get_yang_data(yang_model_file)
    
    # Maximum number of validation attempts
    max_attempts = 10
    attempt = 1
    intent_feedback = None  # VRF A.5 feedback when intent validation fails
    generated_p4_code = None

    while attempt <= max_attempts:
        print(f"\nAttempt {attempt} of {max_attempts}")

        if attempt == 1:
            prompt = create_detailed_prompt(intent, yang_model, yang_data, intent_feedback)
            with open("detailed_prompt.txt", "w") as f:
                f.write(prompt)
            print("\nGenerating P4 code according to your intent...")
        else:
            error_history = read_error_summary()
            # Re-generate the full detailed prompt (with golden example and P4-16 rules)
            # and append the error history so the LLM has both the structural guidance
            # AND the specific errors to fix.
            error_section = f"""

=== PREVIOUS ATTEMPT THAT FAILED ===
{generated_p4_code}

=== COMPILATION / VALIDATION ERROR HISTORY ===
{error_history}
"""
            if intent_feedback:
                error_section += f"\n=== INTENT VALIDATION FEEDBACK ===\n{intent_feedback}\n"
            error_section += """
IMPORTANT: Analyze the errors above carefully. Common mistakes to avoid:
- apply_table(name) is P4-14 — use name.apply() in P4-16
- Using type names (metadata, headers) instead of parameter names (meta, hdr) in control bodies
- Placing statements outside of apply { } in control blocks
- NEVER call ControlName.apply() (e.g. MyIngress.apply()) — .apply() is ONLY for tables, not controls
- Do NOT create extra control blocks beyond the 6 required by V1Switch (Parser, VerifyChecksum, Ingress, Egress, ComputeChecksum, Deparser)
- Put ALL logic inside MyIngress/MyEgress, not in separate controls
Generate a COMPLETE, corrected P4-16 program that fixes ALL errors above. Start with the code directly."""
            prompt = create_detailed_prompt(intent, yang_model, yang_data, error_section)

        # Generate P4 code
        p4_code = generate_p4_code(prompt)
        if p4_code is None:
            print("\n❌ Failed to generate P4 code. Please try again with a different intent.")
            return

        generated_p4_code = p4_code
        cleaned_code = clean_p4_code(p4_code)
        with open("test.p4", "w") as f:
            f.write(cleaned_code)

        # VRF A: Compilation check
        print("\n[VRF A] Validating compilation...")
        compilation_success, compile_errors = validate_p4_compilation(cleaned_code, "test.p4", attempt)
        if not compilation_success:
            print(f"\nCompilation failed on attempt {attempt}. Errors found:")
            print(compile_errors or "")
            if attempt < max_attempts:
                print("\nRetrying with error feedback...")
            attempt += 1
            continue

        print("  ✓ Code compiles successfully")

        # VRF A.5: Intent validation
        print("\n[VRF A.5] Validating intent alignment...")
        intent_passed, intent_feedback, match_score, detailed_scores = run_vrf_a5(
            cleaned_code,
            expected_behavior_path="expected_behavior.json",
            actual_behavior_path="actual_behavior.json",
        )
        print(f"  Intent Match Score: {match_score:.2%}")
        if detailed_scores:
            print(f"  - Required Behaviors: {detailed_scores.get('required_behaviors', 0):.2%}")
            print(f"  - Headers: {detailed_scores.get('headers', 0):.2%}")
            print(f"  - Control Blocks: {detailed_scores.get('control_blocks', 0):.2%}")
            print(f"  - Prohibited Checks: {detailed_scores.get('prohibited_check', 0):.2%}")

        if not intent_passed:
            print("  ❌ INTENT MISMATCH - Regenerating code...")
            attempt += 1
            continue
        if match_score < 0.85:
            print("  ⚠️  PARTIAL MATCH - Proceeding (consider human review).")
        else:
            print("  ✅ INTENT VALIDATED")

        # All verification steps passed (VRF A + VRF A.5)
        print("\n✅ Successfully generated valid P4 code (compilation + intent validated).")
        break

    if attempt > max_attempts:
        print("\n❌ Failed to generate valid P4 code after", max_attempts, "attempts.")
        print("Please refine your intent or check the error feedback for more details.")

if __name__ == "__main__":
    main() 
