#!/bin/bash

# Define language configurations
declare -A LANGUAGE_CONFIGS=(
    # Format: [extension]="compile_command:run_command"
    ["c"]="gcc {source} -o {output} {flags}:./{output}"
    ["cpp"]="g++ {source} -o {output} {flags}:./{output}"
    ["python"]=":./{source}"
    ["py"]=":./{source}"
    ["java"]="javac {source}:java -cp {dir} Main"
)

# Define file name patterns
declare -A FILE_PATTERNS=(
    ["c"]="main.c"
    ["cpp"]="main.cpp"
    ["python"]="main.py"
    ["py"]="main.py"
    ["java"]="Main.java"
)

# Define default compilation flags
declare -A DEFAULT_FLAGS=(
    ["c"]=""
    ["cpp"]=""
    ["python"]=""
    ["py"]=""
    ["java"]=""
) 