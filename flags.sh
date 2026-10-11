# Compiler flags shared by build.sh and coverage.sh. Source it, do not run it.
cc_common_flags="-std=c99 -pedantic-errors"
cc_debug_flags="-g -O0"
cc_warning_flags="-Wall -Wextra -Wc99-c11-compat -Wstrict-prototypes -Wmissing-prototypes -Wshadow -Werror=implicit-function-declaration"
cc_posix_flags="-D_POSIX_C_SOURCE=200112L"
# Everything except the debug/optimization choice.
cc_base_flags="$cc_common_flags $cc_warning_flags $cc_posix_flags"
