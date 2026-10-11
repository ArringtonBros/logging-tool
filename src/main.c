#include <stdio.h>

int main(int argc, char* argv[]) {
  // Unused
  (void)argc;
  (void)argv;

  printf("Hello World!\n");
    int number = 0;
  while (number < 42) {

    number += 5; 
  }
  printf("The number is: %d", number);
  return 0;
}

