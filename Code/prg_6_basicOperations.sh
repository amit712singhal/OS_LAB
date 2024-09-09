#!/bin/bash

# 1. Greatest of Three Numbers
echo "Program 1: Greatest of Three Numbers"
echo "Enter three numbers:"
read a b c

if [ $a -ge $b ] && [ $a -ge $c ]; then
  echo "$a is the greatest"
elif [ $b -ge $a ] && [ $b -ge $c ]; then
  echo "$b is the greatest"
else
  echo "$c is the greatest"
fi
echo

# 2. Even or Odd Number
echo "Program 2: Even or Odd Number"
echo "Enter a number:"
read num

if [ $((num % 2)) -eq 0 ]; then
  echo "$num is Even"
else
  echo "$num is Odd"
fi
echo

# 3. Average of Three Numbers
echo "Program 3: Average of Three Numbers"
echo "Enter three numbers:"
read a b c

avg=$(echo "scale=2; ($a + $b + $c) / 3" | bc)
echo "The average is $avg"
echo

# 4. Prime or Not
echo "Program 4: Prime or Not"
echo "Enter a number:"
read num
flag=0

for ((i=2; i<=$((num / 2)); i++)); do
  if [ $((num % i)) -eq 0 ]; then
    flag=1
    break
  fi
done

if [ $num -eq 1 ]; then
  echo "1 is neither prime nor composite"
elif [ $flag -eq 0 ]; then
  echo "$num is a prime number"
else
  echo "$num is not a prime number"
fi
echo

# 5. Factorial of a Number
echo "Program 5: Factorial of a Number"
echo "Enter a number:"
read num
fact=1

for ((i=1; i<=num; i++)); do
  fact=$((fact * i))
done

echo "Factorial of $num is $fact"
echo

# 6. Fibonacci Sequence
echo "Program 6: Fibonacci Sequence"
echo "Enter the number of terms:"
read terms
a=0
b=1

echo "Fibonacci sequence up to $terms terms:"
for ((i=0; i<terms; i++)); do
  echo -n "$a "
  fib=$((a + b))
  a=$b
  b=$fib
done
echo
echo

# 7. Sum of Digits
echo "Program 7: Sum of Digits"
echo "Enter a number:"
read num
sum=0

while [ $num -gt 0 ]; do
  digit=$((num % 10))
  sum=$((sum + digit))
  num=$((num / 10))
done

echo "Sum of digits is $sum"
echo

# 8. String Validation (Empty or Not)
echo "Program 8: String Validation (Empty or Not)"
echo "Enter a string:"
read str

if [ -z "$str" ]; then
  echo "String is not valid (empty)"
else
  echo "String is valid"
fi
echo

# 9. Count Number of Words and Characters in a String
echo "Program 9: Count Number of Words and Characters in a String"
echo "Enter a string:"
read str

word_count=$(echo $str | wc -w)
char_count=$(echo $str | wc -c)

echo "Number of words: $word_count"
echo "Number of characters: $char_count"
echo

# 10. Palindrome or Not (String)
echo "Program 10: Palindrome or Not (String)"
echo "Enter a string:"
read str
rev=$(echo $str | rev)

if [ "$str" == "$rev" ]; then
  echo "$str is a palindrome"
else
  echo "$str is not a palindrome"
fi
echo
