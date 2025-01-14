#!/bin/bash

# Define arrays for the unique words used in number construction
ones=("one" "two" "three" "four" "five" "six" "seven" "eight" "nine")
teens=("ten" "eleven" "twelve" "thirteen" "fourteen" "fifteen" "sixteen" "seventeen" "eighteen" "nineteen")
tens=("twenty" "thirty" "forty" "fifty" "sixty" "seventy" "eighty" "ninety")

# Function to count the letters in a number
count_letters() {
    num=$1
    letters=0

    if [ $num -eq 1000 ]; then
        # "one thousand" has 11 letters
        echo 11
        return
    fi

    if [ $num -ge 100 ]; then
        # Handle hundreds (e.g., "one hundred")
        hundreds=$((num / 100))
        letters=$((letters + ${#ones[$hundreds-1]})) # Add the hundreds part
        num=$((num % 100)) # Remove the hundreds part
        if [ $num -gt 0 ]; then
            letters=$((letters + 3)) # Add "and"
        fi
    fi

    if [ $num -ge 20 ]; then
        # Handle tens (e.g., "twenty", "thirty")
        tens_place=$((num / 10))
        letters=$((letters + ${#tens[$tens_place-2]})) # Add the tens part
        num=$((num % 10)) # Remove the tens part
    fi

    if [ $num -gt 0 ]; then
        # Handle ones (1-9)
        letters=$((letters + ${#ones[$num-1]})) # Add the ones part
    elif [ $num -eq 0 ] && [ $letters -eq 0 ]; then
        # Handle the case of zero (although we don't need this in our range)
        letters=0
    fi

    echo $letters
}

# Total letters counter
total=0

# Loop over numbers from 1 to 1000
for i in {1..999}; do
    total=$((total + $(count_letters $i)))
done

# Add "one thousand"
total=$((total + 11))

# Output the total number of letters
echo "Total letters used: $total"

