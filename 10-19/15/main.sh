#!/bin/bash

factorial() {
    n=$1
    result=1
    for (( i=2; i<=n; i++ ))
    do
        result=$(echo "$result * $i" | bc)
    done
    echo $result
}

n=20
numerator=$(factorial $((2 * n)))
denominator=$(echo "$(factorial $n) * $(factorial $n)" | bc)
result=$(echo "$numerator / $denominator" | bc)

echo "Number of routes through a 20x20 grid: $result"

