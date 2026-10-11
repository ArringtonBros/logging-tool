#!/bin/env bash

# Build tests with gcc MC/DC instrumentation, run them, and fail unless every
# line and every condition in src/ (except main.c) is covered.
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$root/flags.sh"

cc="${CC:-gcc}"
gcov="${GCOV:-gcov}"

# -fcondition-coverage (MC/DC) is supported in gcc 14 and up.
cc_major="$("$cc" -dumpversion | cut -d. -f1)"
if ! [ "$cc_major" -ge 14 ] 2>/dev/null; then
  echo "coverage: $cc is version $("$cc" -dumpversion); need gcc 14 or newer" >&2
  echo "coverage: set CC and GCOV to a newer gcc and its gcov" >&2
  exit 1
fi

out="$root/build/cov"

cov_flags="-g -O0 -fcondition-coverage --coverage"

# clean and create outdir
rm -rf "$out"
mkdir -p "$out"

# main.c is excluded: tests supply their own main.
mapfile -t srcs < <(find "$root/src" -name '*.c' ! -name main.c | sort)
mapfile -t tests < <(find "$root/tests" -name 'test_*.c' | sort)

if [ "${#srcs[@]}" -eq 0 ]; then
  echo "coverage: no modules in src/ besides main.c, nothing to cover"
  exit 0
fi
if [ "${#tests[@]}" -eq 0 ]; then
  echo "coverage: FAIL: src/ has modules but tests/ has no test_*.c" >&2
  exit 1
fi

# One instrumented object per module, shared by every test program so that
# coverage data accumulates in the same .gcda files.
objs=()
for s in "${srcs[@]}"; do
  o="$out/$(basename "${s%.c}").o"
  "$cc" $cc_base_flags $cov_flags -I"$root/src" -c "$s" -o "$o"
  objs+=("$o")
done

for t in "${tests[@]}"; do
  name="$(basename "${t%.c}")"
  "$cc" $cc_base_flags $cov_flags -I"$root/src" -I"$root/tests" \
    "$t" "${objs[@]}" -o "$out/$name"
  echo "coverage: run $name"
  "$out/$name"
done

# gcov writes <file>.gcov into the current directory.
fail=0
pushd "$out" >/dev/null
for s in "${srcs[@]}"; do
  "$gcov" --conditions -o . "$s" >/dev/null
  report="$(basename "$s").gcov"
  if grep -En '^ +#####:|^condition +[0-9]+ not covered' "$report" >"$report.missing"; then
    echo "coverage: FAIL: $s"
    sed 's/^/  /' "$report.missing"
    fail=1
  else
    echo "coverage: ok: $s ($(grep -c 'condition outcomes covered' "$report" || true) decisions)"
  fi
done
popd >/dev/null

exit "$fail"
