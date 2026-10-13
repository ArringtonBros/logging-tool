#!/bin/env bash
set -euo pipefail

# shellcheck source=flags.sh
source "$(dirname "${BASH_SOURCE[0]}")/flags.sh"

# Build main program
mkdir -p build

pushd build >/dev/null

cc_all_flags="$cc_base_flags $cc_debug_flags"

cc_sources="../src/main.c ../src/frobnicate.c"
cc_libs=""
cc_includes="-I../src"

gcc $cc_all_flags $cc_includes $cc_sources $cc_libs -o logging-tool

# Generate compile_commands.json for clangd
{
  echo "["
  sep=""
  for src in $cc_sources; do
    printf '%s  {\n    "directory": "%s",\n    "file": "%s",\n    "command": "gcc %s %s -c %s"\n  }' \
      "$sep" "$(pwd)" "$src" "$cc_all_flags" "$cc_includes" "$src"
    sep=$',\n'
  done
  printf '\n]\n'
} >compile_commands.json

popd >/dev/null
