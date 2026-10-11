#include <stdio.h>
#include "logging_tool.h"

int main(int argc, char* argv[]) {
  // Unused
  (void)argc;
  (void)argv;

  int a = 10;
  int b = 16;
  printf("a + b = %d\n", add(a, b));
  printf("a frobnicate b = %d\n", frobnicate(a, b));
  return 0;
}
