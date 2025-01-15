#!/bin/bash

# Compute 2^1000 using bc and remove line continuations
number=$(echo "2^1000" | bc | tr -d '\\\n')

# Initialize sum to 0
sum=0

# Loop through each digit of the number
for (( i=0; i<${#number}; i++ )); do
  digit="${number:i:1}"  # Extract digit at position i
  sum=$((sum + digit))   # Add digit to sum
done

# Print the sum of the digits
echo "The sum of the digits of 2^1000 is: $sum"

