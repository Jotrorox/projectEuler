#!/bin/bash

is_palindrome() {
    local num=$1
    local original=$num
    local reversed=0

    while [ $num -gt 0 ]; do
        remainder=$((num % 10))
        reversed=$((reversed * 10 + remainder))
        num=$((num / 10))
    done

    if [ $original -eq $reversed ]; then
        return 0
    else
        return 1
    fi
}

current_max=0

for i in {100..999}; do
    for j in {100..999}; do
        product=$((i * j))
        if [ $product -gt $current_max ] && is_palindrome $product; then
            current_max=$product
        fi
    done
done

echo $current_max
