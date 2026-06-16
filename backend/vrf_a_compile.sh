#!/bin/bash

# Clean up per-run files (NOT error_summary.txt — that accumulates across attempts
# and is cleaned by the Python pipeline at startup via cleanup_files()).
# Remove ir.json whether it is a file or a stale directory from a previous failed run.
rm -rf ir.json
rm -f validation_status.txt p4_validation_errors.txt temp_errors.txt

# Function to clean up P4 code (remove markdown formatting)
cleanup_p4_code() {
    local p4_file=$1
    local temp_file="${p4_file}.tmp"
    
    # Remove markdown code block markers and clean up the file
    sed -e 's/^```P4$//' -e 's/^```$//' -e '/^$/d' "$p4_file" > "$temp_file"
    mv "$temp_file" "$p4_file"
}

# Function to validate P4 code and return error messages
validate_p4() {
    local p4_file=$1
    local attempt="$2"
    echo "Validating $p4_file..."
    
    # Clean up the P4 code first
    cleanup_p4_code "$p4_file"
    
    # Create a temporary file for error output
    local error_file="p4_validation_errors.txt"
    
    # Run p4c compiler using Docker with backend validation (install missing Boost library).
    # This produces test.json (BMV2) as the primary compile artifact.
    docker run --rm --platform linux/amd64 -v "$PWD":/workspace -w /workspace p4lang/p4c \
      bash -c "apt update && apt install -y libboost-iostreams1.71.0 && p4c --target bmv2 --arch v1model $p4_file" 2>&1 | tee $error_file
    local validation_status=${PIPESTATUS[0]}

    if [ $validation_status -eq 0 ]; then
        echo "✅ Validation successful: $p4_file"
        echo "SUCCESS" > validation_status.txt

        # Produce ir.json for VRF A.5 AST-based bucket classification.
        # p4test runs the full frontend + midend without a backend and supports --toJSON.
        echo "Generating IR JSON for VRF A.5 (p4test --toJSON)..."
        local ir_error_file="p4test_ir_errors.txt"
        docker run --rm --platform linux/amd64 -v "$PWD":/workspace -w /workspace p4lang/p4c \
          bash -c "apt update -qq && apt install -y -qq libboost-iostreams1.71.0 2>/dev/null && p4test --toJSON ir.json $p4_file" \
          > "$ir_error_file" 2>&1
        if [ -f "ir.json" ]; then
            echo "✅ IR JSON generated: ir.json"
            rm -f "$ir_error_file"
        else
            echo "⚠️  p4test --toJSON did not produce ir.json — output:"
            cat "$ir_error_file"
            echo "⚠️  VRF A.5 bucket classification will be skipped for this attempt."
        fi

        return 0
    else
        echo "❌ Validation failed: $p4_file"
        echo "VALIDATION_ERROR" > validation_status.txt
        extract_error_info "$attempt"
        return 1
    fi
}

# Function to extract relevant error information
extract_error_info() {
    local attempt="$1"
    local error_file="p4_validation_errors.txt"
    local error_history="error_summary.txt"
    
    # Create new error_summary.txt for this run
    if [ ! -f "$error_history" ]; then
        echo "=== P4 Code Validation Error History ===" > "$error_history"
    fi
    
    if [ -f "$error_file" ]; then
        # Append new error section with the current attempt number
        echo -e "\n=== Attempt $attempt Errors ===" >> "$error_history"
        echo "Timestamp: $(date)" >> "$error_history"
        echo "----------------------------------------" >> "$error_history"
        
        # Include full compiler error output (with failing-line context such as ^^^^)
        # so the LLM can see exact line numbers, messages, and the offending source.
        # Filter out ALL apt/package-manager noise, keep only p4c compiler lines.
        grep -v -E "^(Get:|Fetched |Hit:|Ign:|Reading package|Building dependency|WARNING: apt|Need to get|After this|Selecting |Preparing |Unpacking |Setting up |Processing |debconf:|\(Reading database|[0-9]+ packages can|[0-9]+ upgraded|Reading state|The following|libboost|^$|0 upgraded)" "$error_file" | grep -v -E "^\s*$" > temp_errors.txt
        if [ -s temp_errors.txt ]; then
            cat temp_errors.txt >> "$error_history"
        else
            echo "Full compiler output:" >> "$error_history"
            cat "$error_file" >> "$error_history"
        fi
        rm -f temp_errors.txt
    fi
}

# Main script
# Note: VRF A.5 (intent validation) is run from the Python pipeline (network_intent_to_p4.py)
# after this script succeeds. This script performs VRF A (compilation only).
echo "P4 Code Validator"
echo "----------------"

# Get the attempt number from command line argument, default to 1
attempt="${1:-1}"

# Validate only test.p4 file
if [ -f "test.p4" ]; then
    validate_p4 "test.p4" "$attempt"
else
    echo "Error: test.p4 file not found"
    echo "VALIDATION_ERROR" > validation_status.txt
    exit 1
fi 