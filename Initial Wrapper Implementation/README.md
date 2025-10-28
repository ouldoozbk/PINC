# LLM-Driven P4 Code Generation System

This system uses Large Language Models (LLMs) to generate P4 code based on high-level network intents. It provides an automated way to convert network requirements into valid P4 programs.

## Summary

This project implements an intelligent system that bridges the gap between high-level network intents and low-level P4 programming. Key features include:

- **Intent-Based Programming**: Convert natural language network requirements into P4 code
- **Automated Validation**: Built-in P4 code validation using the official p4c Docker container
- **Error Handling**: Comprehensive error tracking and history maintenance
- **Interactive Interface**: Simple command-line interface for code generation
- **Flexible Architecture**: Easy to extend and modify for different network requirements

The system is designed to simplify P4 programming by allowing network engineers to focus on their intent rather than implementation details, while ensuring the generated code meets P4 specifications and best practices.

## Prerequisites

- Python 3.x
- OpenAI API key
- Git
- **Docker** (for P4 code validation)
- pyang (for YANG model parsing; install with `pip install pyang`)
- *(Optional but recommended)* A YANG model file (e.g., `network-config.yang`) and a YANG data file (e.g., `config.json`) representing your current network configuration.

## Setup Instructions

### 1. Install Docker

Download and install Docker Desktop for your OS:
- [Docker Desktop for Mac/Windows](https://www.docker.com/products/docker-desktop/)
- For Linux, follow the [official Docker install guide](https://docs.docker.com/get-docker/)

Start Docker Desktop before running the system.

### 2. Clone the Repository

```bash
git clone https://github.com/yourusername/LLM-Driven-P4-and-Intent-Based-Network-Control-System.git
cd LLM-Driven-P4-and-Intent-Based-Network-Control-System
```

### 3. Set Up Python Environment

Create and activate a Python virtual environment:

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### 4. Configure OpenAI API Key

Set your OpenAI API key as an environment variable:

```bash
export OPENAI_API_KEY='your-api-key'
```

## Usage

**(Optional but recommended)** Place your YANG model file (e.g., `network-config.yang`) and a YANG data file (e.g., `config.json`) in the project directory before running the script. The script will detect and use them for context. If no YANG file or data file is found or selected, the script will continue without that context.

1. **Run the main script:**
   ```bash
   python3 network_intent_to_p4.py
   ```

2. **When prompted, enter your network intent.** Be as specific as possible, for example:
   - "Drop all packets from port 5"
   - "Create a P4 program for basic packet forwarding"
   - "Generate P4 code for a simple router with ACL"

3. **What happens next:**
   - If a YANG model file is present, its raw content will be shown to you before code generation. You will be asked to confirm before proceeding.
   - If a YANG data file (JSON) is present, its content will also be shown and included in the prompt. You will be asked to confirm before proceeding.
   - The system generates P4 code based on your intent, the YANG model, and the YANG data (if provided).
   - The code is validated using the official p4c Docker image (no local p4c install needed).
   - All validation is performed in Docker, so it works on any OS with Docker.
   - Results and errors are saved to output files.

## Example YANG Data File (config.json)

```
{
  "interfaces": {
    "interface": [
      { "name": "port1", "action": "forward" },
      { "name": "port2", "action": "drop" }
    ]
  },
  "firewall": {
    "rule": [
      { "id": 1, "port": 80, "action": "allow" },
      { "id": 2, "port": 22, "action": "deny" }
    ]
  }
}
```

## Output Files

- `test.p4`: The generated P4 code
- `test.p4i`: Intermediate representation of the P4 code
- `validation_status.txt`: Contains the validation results
- `error_summary.txt`: Contains detailed error information and history
- `p4_validation_errors.txt`: Temporary file for current validation errors

## Troubleshooting

### Common Issues

1. **Docker Not Found**
   - Make sure Docker Desktop is installed and running
   - Verify with `docker --version`

2. **OpenAI API Key Issues**
   - Make sure the API key is set correctly
   - Verify the key is valid and has sufficient credits

3. **Validation Errors**
   - Check `error_summary.txt` for detailed error messages and history
   - The system will attempt to fix common issues automatically

### Cleanup

Every time you run the Python script, all unwanted files will be deleted to avoid any conflicts.
