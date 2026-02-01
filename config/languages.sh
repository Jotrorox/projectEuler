#!/bin/bash

declare -A LANGUAGE_CONFIGS=(
    # Format: [extension]="compile_command:run_command"
    ["c"]="gcc {source} -o {output} {flags}:./{output}"
    ["cpp"]="g++ {source} -o {output} {flags}:./{output}"
    ["sh"]=":bash {source}"
    ["java"]="javac -d {dir} {source}:java -cp {dir} Main"
    ["js"]=":node {source}"
    ["kt"]="kotlinc {source} -d {output}.jar {flags}:kotlin -classpath {output}.jar MainKt"
    ["swift"]=":swift {source}"
    ["go"]="go build -o {output} {flags} {source}:./{output}"
    ["py"]=":python3 {source}"
    ["pl"]=":perl {source}"
    ["ha"]=":hare run {source}"
)

declare -A FILE_PATTERNS=(
    ["c"]="main.c"
    ["cpp"]="main.cpp"
    ["sh"]="main.sh"
    ["java"]="Main.java"
    ["js"]="main.js"
    ["kt"]="Main.kt"
    ["swift"]="main.swift"
    ["go"]="main.go"
    ["py"]="main.py"
    ["pl"]="main.pl"
    ["ha"]="main.ha"
)

declare -A DEFAULT_FLAGS=(
    ["c"]=""
    ["cpp"]=""
    ["sh"]=""
    ["java"]=""
    ["js"]=""
    ["kt"]=""
    ["swift"]=""
    ["go"]=""
    ["py"]=""
    ["pl"]=""
    ["ha"]=""
)
