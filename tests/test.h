#ifndef TEST_H
#define TEST_H

#include <stdio.h>

// Minimal test harness. Each tests/test_*.c is its own program:
//
//   #include "test.h"
//   int main(void) {
//     CHECK(add(1, 2) == 3);
//     return test_failures == 0 ? 0 : 1;
//   }

// Global test failures count
static int test_failures = 0;

// Global test pass count
static int test_passes = 0;

#define CHECK(cond)                                                            \
  do {                                                                         \
    if (!(cond)) {                                                             \
      fprintf(stderr, "%s:%d: CHECK failed: %s\n", __FILE__, __LINE__, #cond); \
      ++test_failures;                                                         \
    } else {                                                                   \
      ++test_passes;                                                           \
    }                                                                          \
  } while (0)

#endif  // TEST_H
