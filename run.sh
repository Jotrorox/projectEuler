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
    echo -e "  ${YELLOW}run${NC} <problem_number> <language> [flags]  - Run a specific problem"
    echo -e "  ${YELLOW}clear${NC}                                   - Clear build directory"
    echo -e "  ${YELLOW}list${NC} [problems|languages]               - List problems or languages"
    echo -e "\n${BOLD}Example:${NC}"
    echo -e "  $0 run 1 c"
    echo -e "  $0 run 1 c \"-lm\""
    exit 1
}

list_languages() {
    print_header
    echo -e "${BOLD}Supported Languages:${NC}"
    echo -e "╔══════════════════════════════════════════════════════════╗"
    
    # Track total problems for statistics
    declare -A language_counts
    total_problems=0
    
    # Count problems per language
    for problem in */; do
        if [[ -d "$problem" && "$problem" =~ ^[0-9]+/$ ]]; then
            ((total_problems++))
            for lang in "${!FILE_PATTERNS[@]}"; do
                if [ -f "${problem}${FILE_PATTERNS[$lang]}" ]; then
                    ((language_counts[$lang]++))
                fi
            done
        fi
    done
    
    # Display languages and their stats
    echo -e "║ ${BOLD}┌─ Language Statistics ─────────────────────────────────┐${NC}"
    for lang in "${!LANGUAGE_CONFIGS[@]}"; do
        count=${language_counts[$lang]:-0}
        percentage=0
        if [ $total_problems -gt 0 ]; then
            percentage=$(( (count * 100) / total_problems ))
        fi
        echo -e "║ │ ${BLUE}$lang${NC}"
        echo -e "║ │ └─ ${GREEN}$count${NC}/${total_problems} problems (${percentage}%)"
        echo -e "║ │"
    done
    echo -e "║ └────────────────────────────────────────────────────────┘"
    echo -e "╚══════════════════════════════════════════════════════════╝"
}

list_problems() {
    print_header
    echo -e "${BOLD}Available Problems:${NC}"
    echo -e "╔══════════════════════════════════════════════════════════╗"
    
    total_problems=0
    total_implementations=0
    declare -A language_totals
    
    # Get sorted problem list
    problems=($(find . -maxdepth 1 -type d -name "[0-9]*" | sort -n))
    
    # First pass to collect statistics
    for problem in "${problems[@]}"; do
        if [[ -d "$problem" && "$problem" =~ ^./[0-9]+$ ]]; then
            ((total_problems++))
            for lang in "${!FILE_PATTERNS[@]}"; do
                if [ -f "${problem}/${FILE_PATTERNS[$lang]}" ]; then
                    ((total_implementations++))
                    ((language_totals[$lang]++))
                fi
            done
        fi
    done
    
    # Display overall statistics
    echo -e "║ ${BOLD}┌─ Statistics ────────────────────────────────────────┐${NC}"
    echo -e "║ │ • Total Problems: ${GREEN}$total_problems${NC}"
    echo -e "║ │ • Total Implementations: ${GREEN}$total_implementations${NC}"
    avg=$(( (total_implementations * 100 + total_problems / 2) / total_problems ))
    avg_int=$((avg / 100))
    avg_dec=$((avg % 100))
    echo -e "║ │ • Average Implementations: ${GREEN}${avg_int}.${avg_dec}${NC} per problem"
    echo -e "║ └────────────────────────────────────────────────────────┘"
    echo -e "║"
    echo -e "║ ${BOLD}┌─ Problems ──────────────────────────────────────────┐${NC}"
    
    # Display individual problems
    for problem in "${problems[@]}"; do
        if [[ -d "$problem" && "$problem" =~ ^./[0-9]+$ ]]; then
            problem_num=${problem#./}
            implementation_count=0
            declare -a available_langs=()
            
            # Collect available languages
            for lang in "${!FILE_PATTERNS[@]}"; do
                if [ -f "${problem}/${FILE_PATTERNS[$lang]}" ]; then
                    ((implementation_count++))
                    available_langs+=("$lang")
                fi
            done
            
            # Format problem header
            echo -e "║ │ ${BOLD}Problem ${BLUE}${problem_num}${NC}${BOLD}${NC}"
            echo -e "║ │ ├─ ${YELLOW}$implementation_count${NC} implementation(s)"
            
            # Format languages with proper alignment
            echo -ne "║ │ └─ Languages: "
            first_lang=true
            for lang in "${available_langs[@]}"; do
                if [ "$first_lang" = true ]; then
                    echo -ne "${GREEN}$lang${NC}"
                    first_lang=false
                else
                    echo -ne ", ${GREEN}$lang${NC}"
                fi
            done
            echo
            echo -e "║ │"
        fi
    done
    echo -e "║ └────────────────────────────────────────────────────────┘"
    echo -e "╚══════════════════════════════════════════════════════════╝"
}

clear_build() {
    echo -e "${YELLOW}Clearing build directory...${NC}"
    rm -rf "$BUILD_DIR"/*
    print_success "Build directory cleared."
}

read_problem_config() {
    local problem_number=$1
    local language=$2
    local config_file="${problem_number}/config.sh"
    
    # Initialize with default flags
    local problem_flags="${DEFAULT_FLAGS[$language]}"
    
    # Check if config file exists and source it
    if [ -f "$config_file" ]; then
        # Source the config file to get COMPILE_FLAGS
        source "$config_file"
        if [ ! -z "${COMPILE_FLAGS[$language]}" ]; then
            problem_flags="${COMPILE_FLAGS[$language]}"
        fi
    fi
    
    echo "$problem_flags"
}

copy_input_file() {
    local problem_number=$1
    local build_dir=$2
    
    local input_file="$problem_number/input.txt"
    if [ -f "$input_file" ]; then
        cp "$input_file" "$build_dir"
        print_success "Copied input file to build directory"
    fi
}

run_problem() {
    if [ $# -lt 2 ]; then
        usage
    fi

    problem_number=$1
    language=$(echo "$2" | tr '[:upper:]' '[:lower:]')
    
    # First check for problem-specific config
    local problem_flags=$(read_problem_config "$problem_number" "$language")
    
    # Command-line flags override problem-specific config
    flags="${3:-$problem_flags}"

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

    # Copy input file if it exists
    copy_input_file "$problem_number" "$problem_build_dir"

    # Get compile and run commands
    IFS=':' read -r compile_cmd run_cmd <<< "${LANGUAGE_CONFIGS[$language]}"
    
    # Replace placeholders in commands
    output_file="$problem_build_dir/program"
    compile_cmd="${compile_cmd//\{source\}/$source_file}"
    compile_cmd="${compile_cmd//\{output\}/$output_file}"
    compile_cmd="${compile_cmd//\{dir\}/$problem_build_dir}"
    compile_cmd="${compile_cmd//\{flags\}/$flags}"
    
    run_cmd="${run_cmd//\{source\}/$source_file}"
    run_cmd="${run_cmd//\{output\}/$output_file}"
    run_cmd="${run_cmd//\{dir\}/$problem_build_dir}"

    # Print problem header
    header_text=" Problem $problem_number - $language Implementation "
    padding_length=$((58 - ${#header_text}))  # 58 is the width between ║ chars
    right_padding=$(printf '%*s' $padding_length '')
    
    echo -e "\n${BOLD}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}║${BLUE}$header_text${NC}${BOLD}${right_padding}║${NC}"
    echo -e "${BOLD}╚══════════════════════════════════════════════════════════╝${NC}\n"

    # Execute commands
    if [ ! -z "$compile_cmd" ]; then
        echo -e "${BOLD}┌─ Compilation ────────────────────────────────────────────┐${NC}"
        echo -e "│ Source: ${BLUE}$source_file${NC}"
        echo -e "│ Flags:  ${YELLOW}$flags${NC}"
        echo -e "├──────────────────────────────────────────────────────────┤"
        echo -e "│ ${BOLD}Output:${NC}"
        echo -e "│"
        
        # Capture compilation output and error
        output=$(eval "$compile_cmd" 2>&1)
        compile_status=$?
        
        if [ ! -z "$output" ]; then
            echo -e "│ $output" | sed 's/^/│ /'
        fi
        
        echo -e "│"
        if [ $compile_status -eq 0 ]; then
            echo -e "│ ${GREEN}✔ Compilation successful${NC}"
        else
            echo -e "│ ${RED}✖ Compilation failed${NC}"
            echo -e "└──────────────────────────────────────────────────────────┘"
            exit 1
        fi
        echo -e "└──────────────────────────────────────────────────────────┘"
    fi

    echo -e "\n${BOLD}┌─ Execution ──────────────────────────────────────────────┐${NC}"
    echo -e "│ Command: ${BLUE}${run_cmd}${NC}"
    echo -e "├──────────────────────────────────────────────────────────┤"
    echo -e "│ ${BOLD}Output:${NC}"
    echo -e "│"
    
    # Capture and format program output
    output=$(eval "$run_cmd" 2>&1)
    run_status=$?
    
    if [ ! -z "$output" ]; then
        echo -e "│ $output" | sed 's/^/│ /'
    fi
    
    echo -e "│"
    if [ $run_status -eq 0 ]; then
        echo -e "│ ${GREEN}✔ Program completed successfully${NC}"
    else
        echo -e "│ ${RED}✖ Program failed with exit code $run_status${NC}"
    fi
    echo -e "└──────────────────────────────────────────────────────────┘"
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