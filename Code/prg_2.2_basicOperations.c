#include <stdbool.h>
#include <stdio.h>
#include <string.h>

// Function to print the Fibonacci series up to n terms
void fibonacci(int n)
{
  int first = 0, second = 1, next;

  if (n <= 0)
  {
    printf("Please enter a positive integer.\n");
    return;
  }

  printf("Fibonacci Series: ");
  for (int i = 1; i <= n; i++)
  {
    if (i == 1)
    {
      printf("%d ", first);
      continue;
    }
    if (i == 2)
    {
      printf("%d ", second);
      continue;
    }
    next = first + second;
    first = second;
    second = next;
    printf("%d ", next);
  }
  printf("\n");
}

// Function to calculate the factorial of a number
int factorial(int n)
{
  if (n == 0)
  {
    return 1;
  }
  return n * factorial(n - 1);
}

// Function to calculate the sum of digits of a number
int digitsSum(int num)
{
  int sum = 0;
  while (num != 0)
  {
    sum += num % 10;
    num /= 10;
  }
  return sum;
}

// Function to check if a string is a palindrome
bool isPalindrome(char str[])
{
  int length = strlen(str);
  int start = 0;
  int end = length - 1;

  while (start < end)
  {
    if (str[start] != str[end])
    {
      return false;
    }
    start++;
    end--;
  }
  return true;
}

// Function to count the occurrences of a character in a string
int countChar(char *str, char ch)
{
  int count = 0;
  for (int i = 0; str[i] != '\0'; i++)
  {
    if (str[i] == ch)
    {
      count++;
    }
  }
  return count;
}

int main()
{

  int choice, num1, num2, num3;
  char str[100], ch;

  printf("\n5C6 - Amit Singhal (11614802722)\n");

  // Display the menu
  printf("\nMenu:\n");
  printf("1. Print Fibonacci Series\n");
  printf("2. Calculate Factorial\n");
  printf("3. Calculate Sum of Digits\n");
  printf("4. Check Palindrome\n");
  printf("5. Count Character Occurrences\n");
  printf("6. Exit\n");

  while (1)
  {
    printf("\nEnter your choice (1-6): ");
    scanf("%d", &choice);

    switch (choice)
    {

    case 1:
      printf("\nEnter the number of terms for Fibonacci series: ");
      scanf("%d", &num1);
      fibonacci(num1);
      break;
    case 2:
      printf("\nEnter a number to calculate its factorial: ");
      scanf("%d", &num1);
      printf("Factorial: %d\n", factorial(num1));
      break;
    case 3:
      printf("\nEnter a number to calculate the sum of its digits: ");
      scanf("%d", &num1);
      printf("Sum of Digits: %d\n", digitsSum(num1));
      break;
    case 4:
      printf("Enter a string to check if it is a palindrome: ");
      scanf("%s", str);

      if (isPalindrome(str))
      {
        printf("%s is a Palindrome\n", str);
      }
      else
      {
        printf("%s is not a Palindrome\n", str);
      }
      break;
    case 5:
      printf("\nEnter a string: ");
      scanf("%s", str);
      printf("Enter a character to count its occurrences: ");
      scanf(" %c", &ch);
      printf("Count of '%c': %d\n", ch, countChar(str, ch));
      break;
    case 6:
      printf("\nExiting the program. Have a great day!\n");
      return 0;
    default:
      printf(
          "\nInvalid choice! Please select a number between 1 and 6.\n");
    }
  }

  return 0;
}
