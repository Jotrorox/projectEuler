#!/bin/bash

number=$(echo "2^1000" | bc | tr -d '\\\n')

sum=0

for (( i=0; i<${#number}; i++ )); do
  digit="${number:i:1}"
  sum=$((sum + digit))
done

echo $sum