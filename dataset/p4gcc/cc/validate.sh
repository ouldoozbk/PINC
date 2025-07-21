#!/bin/bash
P4_FILE=$1

if [ -z "$P4_FILE" ]; then
  echo "Usage: ./validate.sh <p4 filename>"
  exit 1
fi

if ! command -v docker &> /dev/null; then
    echo "Docker is not installed or not in PATH."
    exit 1
fi

docker run --rm \
  -v "$(pwd)/p4_files:/mnt" \
  cat /etc/os-release \
  p4c /mnt/"$P4_FILE"
