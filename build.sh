#!/bin/env bash

# Build main program
mkdir -p build

pushd build

cc_common_flags="-std=c99 -pedantic-errors"
cc_debug_flags="-g -O0"
cc_warning_flags="-Wall -Wextra -Wc99-c11-compat -Wstrict-prototypes -Wmissing-prototypes -Wshadow -Werror=implicit-function-declaration"
cc_posix_flags="-D_POSIX_C_SOURCE=200112L"
cc_all_flags="$cc_common_flags $cc_debug_flags $cc_warning_flags $cc_posix_flags"

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
