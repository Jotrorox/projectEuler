import os
import sys

def calculate_name_score(name, position):
    return sum(ord(c) - ord('A') + 1 for c in name.upper()) * position

script_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
input_path = os.path.join(script_dir, 'input.txt')

file = open(input_path, 'r')
names = sorted([name.strip('"') for name in file.read().strip().split(',')])
total_score = sum(calculate_name_score(name, i+1) for i, name in enumerate(names))
print(f"Total name scores: {total_score}")