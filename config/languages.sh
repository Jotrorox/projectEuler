#!/bin/bash

# Define language configurations
declare -A LANGUAGE_CONFIGS=(
    # Format: [extension]="compile_command:run_command"
    ["c"]="gcc {source} -o {output} {flags}:./{output}"
    ["cpp"]="g++ {source} -o {output} {flags}:./{output}"
    ["sh"]=":bash {source}"
    ["java"]="javac -d {dir} {source}:java -cp {dir} Main"
    ["js"]=":node {source}"
    ["kt"]="kotlinc {source} -d {output}.jar {flags}:kotlin -classpath {output}.jar MainKt"
    ["swift"]="swiftc {source} -o {output} {flags}:./{output}"
    ["go"]="go build -o {output} {flags} {source}:./{output}"
    ["zig"]="zig build-exe {source} -o {output} {flags}:./{output}"
    ["py"]=":python3 {source}"
)

# Define file name patterns
declare -A FILE_PATTERNS=(
    ["c"]="main.c"
    ["cpp"]="main.cpp"
    ["sh"]="main.sh"
    ["java"]="Main.java"
    ["js"]="main.js"
    ["kt"]="Main.kt"
    ["swift"]="main.swift"
    ["go"]="main.go"
    ["zig"]="main.zig"
    ["py"]="main.py"
)

# Define default compilation flags
declare -A DEFAULT_FLAGS=(
    ["c"]=""
    ["cpp"]=""
    ["sh"]=""
    ["java"]=""
    ["js"]=""
    ["kt"]=""
    ["swift"]=""
    ["go"]=""
    ["zig"]=""
    ["py"]=""
)
