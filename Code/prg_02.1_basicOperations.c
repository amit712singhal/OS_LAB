#include <stdio.h>

// Function to find the greatest number among three numbers
int findGreatest(int a, int b, int c)
{
  if (a > b && a > c)
  {
    return a;
  }
  else if (b > c)
  {
    return b;
  }
  else
  {
    return c;
  }
}

// Function to check if a number is even or odd
void evenOdd(int num)
{
  if (num % 2 == 0)
  {
    printf("%d is Even\n", num);
  }
  else
  {
    printf("%d is Odd\n", num);
  }
}

// Function to check if a number is prime
void checkPrime(int num)
{
  int i, flag = 0;
  if (num <= 1)
  {
    printf("%d is not a Prime number\n", num);
    return;
  }
  for (i = 2; i <= num / 2; ++i)
  {
    if (num % i == 0)
    {
      flag = 1;
      break;
    }
  }
  if (flag == 0)
  {
    printf("%d is a Prime number\n", num);
  }
  else
  {
    printf("%d is not a Prime number\n", num);
  }
}

// Function to calculate the average of three numbers
double calculateAverage(int a, int b, int c) { return (a + b + c) / 3.0; }

int main()
{
  printf("\n5C6 - Amit Singhal (11614802722)\n");

  int num1, num2, num3;
  int choice;

  printf("\nChoose an operation:\n");
  printf("1. Find Greatest of Three Numbers\n");
  printf("2. Check Even or Odd\n");
  printf("3. Check Prime Number\n");
  printf("4. Calculate Average of Three Numbers\n");
  printf("5. Exit\n");

  while (1)
  {

    printf("\nEnter your choice: ");
    scanf("%d", &choice);

    switch (choice)
    {
    case 1:
      printf("\nEnter three numbers: ");
      scanf("%d %d %d", &num1, &num2, &num3);
      printf("Greatest Number: %d\n", findGreatest(num1, num2, num3));
      break;
    case 2:
      printf("\nEnter a number: ");
      scanf("%d", &num1);
      evenOdd(num1);
      break;
    case 3:
      printf("\nEnter a number: ");
      scanf("%d", &num1);
      checkPrime(num1);
      break;
    case 4:
      printf("\nEnter three numbers: ");
      scanf("%d %d %d", &num1, &num2, &num3);
      printf("Average: %.2f\n", calculateAverage(num1, num2, num3));
      break;
    case 5:
      printf("\n");
      return 0;
    default:
      printf("\nInvalid choice! Please choose again.\n");
    }
  }
  return 0;
}
