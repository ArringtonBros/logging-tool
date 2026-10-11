#!/bin/env bash
set -euo pipefail

# Build main program
mkdir -p build

pushd build

cc_common_flags="-std=c99 -pedantic-errors"
cc_debug_flags="-g -O0"
cc_warning_flags="-Wall -Wextra -Wc99-c11-compat -Wstrict-prototypes -Wmissing-prototypes -Wshadow -Werror=implicit-function-declaration"
cc_posix_flags="-D_POSIX_C_SOURCE=200112L"
cc_all_flags="$cc_common_flags $cc_debug_flags $cc_warning_flags $cc_posix_flags"

cc_sources="../src/main.c ../src/logging_tool.c"
cc_libs=""
cc_includes="-I../src"

gcc $cc_all_flags $cc_includes $cc_sources $cc_libs -o logging-tool

# Generate compile_commands.json for clangd
{
  echo "["
  sep=""
  for src in $cc_sources; do
    printf '%s {\n    "directory": "%s",\n    "file": "%s",\n    "command": "gcc %s %s -c %s"\n  }' \
      "$sep" "$(pwd)" "$src" "$cc_all_flags" "$cc_includes" "$src"
    sep=$',\n'
  done
  printf '\n]\n'
} >compile_commands.json

popd
