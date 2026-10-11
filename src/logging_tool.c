#include "logging_tool.h"

int add(int a, int b) { return a + b; }

int frobnicate(int a, int b) {
  if (a < b) {
    return a * b;
  } else if (a > b) {
    return a - b;
  } else {
    return a + b;
  }
}
