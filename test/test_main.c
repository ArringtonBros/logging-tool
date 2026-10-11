#include <stdio.h>
#include "logging_tool.h"

// Global failure count
static int failures = 0;

#define CHECK(expr)                                                       \
  do {                                                                    \
    if (!(expr)) {                                                        \
      fprintf(stderr, "Failed: %s (%s:%d)\n", #expr, __FILE__, __LINE__); \
      failures++;                                                         \
    }                                                                     \
  } while (0)

static void test_add(void) {
  int add_result = add(1, 2);
  CHECK(add_result == 3);
}

static void test_frobnicate_one(void) {
  int result = frobnicate(1, 2);
  CHECK(result == 2);
}

static void test_frobnicate_two(void) {
  int result = frobnicate(2, 1);
  CHECK(result == 1);
}

static void test_frobnicate_three(void) {
  int result = frobnicate(1, 1);
  CHECK(result == 2);
}

int main(int argc, char* argv[]) {
  (void)argc;
  (void)argv;

  test_add();
  test_frobnicate_one();
  test_frobnicate_two();
  test_frobnicate_three();
  return failures == 0 ? 0 : 1;
}
