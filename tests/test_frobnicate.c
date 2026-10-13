#include <stdio.h>
#include "test.h"
#include "frobnicate.h"

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
  test_frobnicate_less_than_multiplies();
  test_frobnicate_greater_than_subtracts();
  test_frobnicate_equal_adds();
  printf("%d of %d check(s) failed!\n", test_failures,
         test_failures + test_passes);
  return test_failures == 0 ? 0 : 1;
}
