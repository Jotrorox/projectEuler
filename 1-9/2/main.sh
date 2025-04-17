#!/bin/bash

sum=0
current=1
previous=0
temp=0

while [ $current -le 4000000 ]; do
    if [ $((current % 2)) -eq 0 ]; then
        sum=$((sum + current))
    fi

    temp=$current
    current=$((current + previous))
    previous=$temp
done

echo "Sum of even Fibonacci numbers: $sum"