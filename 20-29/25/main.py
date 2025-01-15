import math

# Constants
phi = (1 + math.sqrt(5)) / 2  # Golden ratio
log_phi = math.log10(phi)
log_sqrt5 = math.log10(math.sqrt(5))

# Calculate the index n
n = math.ceil((999 + log_sqrt5) / log_phi)

# Print the result
print(f"The index of the first Fibonacci number with 1000 digits is: {n}")
