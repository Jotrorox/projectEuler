#!/bin/bash

# Source the language configurations
source "$(dirname "$0")/config/languages.sh"

# Create build directory if it doesn't exist
BUILD_DIR="build"
mkdir -p "$BUILD_DIR"

# ASCII styling
BOLD='\033[1m'
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_header() {
    echo -e "\n${BOLD}╔════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}║${BLUE} Project Runner                         ${BOLD}${NC}║"
    echo -e "${BOLD}╚════════════════════════════════════════╝${NC}\n"
}

print_error() {
    echo -e "${RED}✖ Error: $1${NC}"
}

print_success() {
    echo -e "${GREEN}✔ $1${NC}"
}

usage() {
    print_header
    echo -e "${BOLD}Usage:${NC} $0 <command> [arguments]"
    echo -e "\n${BOLD}Commands:${NC}"
    echo -e "  ${YELLOW}run${NC} <problem_number> <language>  - Run a specific problem"
    echo -e "  ${YELLOW}clear${NC}                           - Clear build directory"
    echo -e "  ${YELLOW}list${NC} [problems|languages]       - List problems or languages"
    echo -e "\n${BOLD}Example:${NC} $0 run 1 c"
    exit 1
}

list_languages() {
    print_header
    echo -e "${BOLD}Supported Languages:${NC}"
    echo -e "╔════════════════╗"
    for lang in "${!LANGUAGE_CONFIGS[@]}"; do
        echo -e "║ • ${BLUE}$lang${NC}${spaces:${#lang}}"
    done
    echo -e "╚════════════════╝"
}

list_problems() {
    print_header
    echo -e "${BOLD}Available Problems:${NC}"
    echo -e "╔════════════════╗"
    for problem in */; do
        if [[ -d "$problem" && "$problem" =~ ^[0-9]+/$ ]]; then
            problem_num=${problem%/}
            echo -e "║ • Problem ${BLUE}$problem_num${NC}"
        fi
    done
    echo -e "╚════════════════╝"
}

clear_build() {
    echo -e "${YELLOW}Clearing build directory...${NC}"
    rm -rf "$BUILD_DIR"/*
    print_success "Build directory cleared."
}

run_problem() {
    if [ $# -ne 2 ]; then
        usage
    fi

    problem_number=$1
    language=$(echo "$2" | tr '[:upper:]' '[:lower:]')

    # Check if language is supported
    if [ -z "${LANGUAGE_CONFIGS[$language]}" ]; then
        print_error "Unsupported language: $language"
        echo -e "Use '${YELLOW}$0 list languages${NC}' to see supported languages"
        exit 1
    fi

    # Get file pattern for the language
    file_pattern="${FILE_PATTERNS[$language]}"
    source_file="${problem_number}/${file_pattern}"

    # Check if source file exists
    if [ ! -f "$source_file" ]; then
        print_error "Source file not found: $source_file"
        exit 1
    fi

    # Prepare build directory for this problem
    problem_build_dir="$BUILD_DIR/$problem_number"
    mkdir -p "$problem_build_dir"

    # Get compile and run commands
    IFS=':' read -r compile_cmd run_cmd <<< "${LANGUAGE_CONFIGS[$language]}"
    
    # Replace placeholders in commands
    output_file="$problem_build_dir/program"
    compile_cmd="${compile_cmd//\{source\}/$source_file}"
    compile_cmd="${compile_cmd//\{output\}/$output_file}"
    compile_cmd="${compile_cmd//\{dir\}/$problem_build_dir}"
    
    run_cmd="${run_cmd//\{source\}/$source_file}"
    run_cmd="${run_cmd//\{output\}/$output_file}"
    run_cmd="${run_cmd//\{dir\}/$problem_build_dir}"

    # Execute commands
    if [ ! -z "$compile_cmd" ]; then
        echo -e "\n${BOLD}[Compiling]${NC}"
        echo -e "╔════════════════════════════════════════╗"
        eval "$compile_cmd"
        if [ $? -ne 0 ]; then
            print_error "Compilation failed!"
            exit 1
        fi
        echo -e "╚════════════════════════════════════════╝"
        print_success "Compilation successful"
    fi

    echo -e "\n${BOLD}[Running Problem $problem_number]${NC}"
    echo -e "╔════════════════════════════════════════╗"
    eval "$run_cmd"
    echo -e "╚════════════════════════════════════════╝"
}

# Main command processing
case $1 in
    "run")
        shift
        run_problem "$@"
        ;;
    "clear")
        clear_build
        ;;
    "list")
        case $2 in
            "languages")
                list_languages
                ;;
            "problems")
                list_problems
                ;;
            *)
                echo -e "${BOLD}Available list commands:${NC}"
                echo -e "  ${YELLOW}list languages${NC} - Show supported languages"
                echo -e "  ${YELLOW}list problems${NC}  - Show available problems"
                ;;
        esac
        ;;
    *)
        usage
        ;;
esac