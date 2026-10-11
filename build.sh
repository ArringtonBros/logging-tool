#!/bin/env bash
set -euo pipefail

# shellcheck source=flags.sh
source "$(dirname "${BASH_SOURCE[0]}")/flags.sh"

# Build main program
mkdir -p build

pushd build

cc_all_flags="$cc_base_flags $cc_debug_flags"

cc_libs=""
cc_includes=""

gcc $cc_all_flags $cc_includes ../src/main.c $cc_libs -o logging-tool

# Generate compile_commands.json for clangd
cat >compile_commands.json <<EOF
[
  {
    "directory": "$(pwd)",
    "file": "../src/main.c",
    "command": "gcc $cc_all_flags $cc_includes ../src/main.c $cc_libs -o logging-tool"
  }
]
EOF

popd
