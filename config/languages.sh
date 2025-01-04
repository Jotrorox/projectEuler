#!/bin/bash

# Define language configurations
declare -A LANGUAGE_CONFIGS=(
    # Format: [extension]="compile_command:run_command"
    ["c"]="gcc {source} -o {output} {flags}:./{output}"
    ["java"]="javac -d {dir} {source}:java -cp {dir} Main"
    ["js"]=":node {source}"
)

# Define file name patterns
declare -A FILE_PATTERNS=(
    ["c"]="main.c"
    ["java"]="Main.java"
    ["js"]="main.js"
)

# Define default compilation flags
declare -A DEFAULT_FLAGS=(
    ["c"]=""
    ["java"]=""
    ["js"]=""
) 