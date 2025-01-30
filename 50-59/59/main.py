from itertools import product
import string
import sys
import os

script_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
input_path = os.path.join(script_dir, 'input.txt')

try:
    with open(input_path, "r") as file:
        encrypted_data = list(map(int, file.read().strip().split(",")))
except FileNotFoundError:
    encrypted_data = []

def decrypt_with_key(data, key):
    key_length = len(key)
    return "".join(chr(data[i] ^ key[i % key_length]) for i in range(len(data)))

possible_keys = (bytes(key, "ascii") for key in map("".join, product(string.ascii_lowercase, repeat=3)))

correct_decryption = ""
correct_key = None

for key in possible_keys:
    decrypted_text = decrypt_with_key(encrypted_data, key)
    if " the " in decrypted_text and " and " in decrypted_text:
        correct_decryption = decrypted_text
        correct_key = key.decode()
        break

ascii_sum = sum(ord(char) for char in correct_decryption) if correct_decryption else None

correct_key, ascii_sum, correct_decryption[:500]

print(ascii_sum)