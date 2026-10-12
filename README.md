# logging-tool

## Ideology

- 100% MC/DC test coverage
- Zero dependencies
- Simplicity
- [tigerstyle](https://tigerstyle.dev/)

## Coding Standards

1. C99 only
2. clang-format for code style

## Build System

- Bash script

## Development Environment

Tools needed:

- gcc 14 or newer (older gcc cannot measure MC/DC), with its `gcov`
- git, gdb, valgrind
- clang-format and clangd
- pre-commit

Commands:

```
./build.sh && build/logging-tool   # build and run
./coverage.sh                      # build tests, fail below 100% MC/DC
```

`coverage.sh` uses `gcc` and `gcov` from `PATH`. Set `CC` and `GCOV` to use
others, for example `CC=gcc-14 GCOV=gcov-14 ./coverage.sh`.

CI builds with gcc 14, so a newer local gcc may accept code that CI
rejects. Treat the CI build as the reference.

### Fedora (distrobox)

```
distrobox create --name logging-tool --image registry.fedoraproject.org/fedora:44
distrobox enter logging-tool
sudo dnf install git gcc gdb valgrind clang-tools-extra neovim pre-commit
```
