#include <stdio.h>
#include "logging_tool.h"

// Global failure count
static int failures = 0;

// Global pass count
static int passes = 0;

#define CHECK(expr)                                                       \
  do {                                                                    \
    if (!(expr)) {                                                        \
      fprintf(stderr, "Failed: %s (%s:%d)\n", #expr, __FILE__, __LINE__); \
      ++failures;                                                         \
    } else {                                                              \
      ++passes;                                                           \
    }                                                                     \
  } while (0)

static void test_add(void) {
  int add_result = add(2, 3);
  CHECK(add_result == 5);
}

static void test_frobnicate_less_than_multiplies(void) {
  int result = frobnicate(3, 5);
  CHECK(result == 15);
}

static void test_frobnicate_greater_than_subtracts(void) {
  int result = frobnicate(5, 3);
  CHECK(result == 2);
}

static void test_frobnicate_equal_adds(void) {
  int result = frobnicate(4, 4);
  CHECK(result == 8);
}

int main(void) {
  test_add();
  test_frobnicate_less_than_multiplies();
  test_frobnicate_greater_than_subtracts();
  test_frobnicate_equal_adds();

  printf("%d of %d check(s) failed!\n", failures, failures + passes);
  return failures == 0 ? 0 : 1;
}
