#ifndef TEST_H
#define TEST_H

#include <stdio.h>

// Minimal test harness. Each tests/test_*.c is its own program:
//
//   #include "test.h"
//   int main(void) {
//     CHECK(add(1, 2) == 3);
//     return test_failed;
//   }

static int test_failed = 0;

#define CHECK(cond)                                                            \
  do {                                                                         \
    if (!(cond)) {                                                             \
      fprintf(stderr, "%s:%d: CHECK failed: %s\n", __FILE__, __LINE__, #cond); \
      test_failed = 1;                                                         \
    }                                                                          \
  } while (0)

#endif  // TEST_H
