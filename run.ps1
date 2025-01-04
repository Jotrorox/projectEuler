# Source the language configurations
. (Join-Path $PSScriptRoot "config/languages.ps1")

# Create build directory if it doesn't exist
$BUILD_DIR = "build"
New-Item -ItemType Directory -Force -Path $BUILD_DIR | Out-Null

# Color definitions for PowerShell
$BOLD = ""  # PowerShell doesn't support bold directly
$RED = "`e[31m"
$GREEN = "`e[32m"
$BLUE = "`e[34m"
$YELLOW = "`e[33m"
$NC = "`e[0m"

function Print-Header {
    Write-Host "`n╔════════════════════════════════════════╗"
    Write-Host "║$BLUE Project Runner                         $NC║"
    Write-Host "╚════════════════════════════════════════╝`n"
}

function Print-Error {
    param($message)
    Write-Host "$RED✖ Error: $message$NC"
}

function Print-Success {
    param($message)
    Write-Host "$GREEN✔ $message$NC"
}

function Show-Usage {
    Print-Header
    Write-Host "Usage: .\run.ps1 <command> [arguments]"
    Write-Host "`nCommands:"
    Write-Host "  ${YELLOW}run${NC} <problem_number> <language> [flags]  - Run a specific problem"
    Write-Host "  ${YELLOW}clear${NC}                                   - Clear build directory"
    Write-Host "  ${YELLOW}list${NC} [problems|languages]               - List problems or languages"
    Write-Host "`nExample:"
    Write-Host "  .\run.ps1 run 1 c"
    Write-Host "  .\run.ps1 run 1 c `"-lm`""
    exit 1
}

function Read-ProblemConfig {
    param(
        [string]$problem_number,
        [string]$language
    )
    
    $config_file = Join-Path $problem_number "config.ps1"
    
    # Initialize with default flags
    $problem_flags = $DEFAULT_FLAGS[$language]
    
    # Check if config file exists and load it
    if (Test-Path $config_file) {
        # Load the config file to get COMPILE_FLAGS
        . $config_file
        if ($COMPILE_FLAGS[$language]) {
            $problem_flags = $COMPILE_FLAGS[$language]
        }
    }
    
    return $problem_flags
}

function List-Languages {
    Print-Header
    Write-Host "${BOLD}Supported Languages:${NC}"
    Write-Host "╔══════════════════════════════════════════════════════════╗"
    
    # Track total problems for statistics
    $language_counts = @{}
    $total_problems = 0
    
    # Count problems per language
    Get-ChildItem -Directory | Where-Object { $_.Name -match '^\d+$' } | ForEach-Object {
        $total_problems++
        foreach ($lang in $FILE_PATTERNS.Keys) {
            $pattern = Join-Path $_.FullName $FILE_PATTERNS[$lang]
            if (Test-Path $pattern) {
                $language_counts[$lang] = ($language_counts[$lang] ?? 0) + 1
            }
        }
    }
    
    # Display languages and their stats
    Write-Host "║ ${BOLD}┌─ Language Statistics ─────────────────────────────────┐${NC}"
    foreach ($lang in $LANGUAGE_CONFIGS.Keys) {
        $count = $language_counts[$lang] ?? 0
        $percentage = if ($total_problems -gt 0) { [math]::Floor(($count * 100) / $total_problems) } else { 0 }
        Write-Host "║ │ ${BLUE}$lang${NC}"
        Write-Host "║ │ └─ ${GREEN}$count${NC}/$total_problems problems ($percentage%)"
        Write-Host "║ │"
    }
    Write-Host "║ └────────────────────────────────────────────────────────┘"
    Write-Host "╚══════════════════════════════════════════════════════════╝"
}

function List-Problems {
    Print-Header
    Write-Host "${BOLD}Available Problems:${NC}"
    Write-Host "╔══════════════════════════════════════════════════════════╗"
    
    $total_problems = 0
    $total_implementations = 0
    $language_totals = @{}
    
    # Get sorted problem list
    $problems = Get-ChildItem -Directory | Where-Object { $_.Name -match '^\d+$' } | Sort-Object Name
    
    # First pass to collect statistics
    foreach ($problem in $problems) {
        $total_problems++
        foreach ($lang in $FILE_PATTERNS.Keys) {
            $pattern = Join-Path $problem.FullName $FILE_PATTERNS[$lang]
            if (Test-Path $pattern) {
                $total_implementations++
                $language_totals[$lang] = ($language_totals[$lang] ?? 0) + 1
            }
        }
    }
    
    # Display overall statistics
    Write-Host "║ ${BOLD}┌─ Statistics ────────────────────────────────────────┐${NC}"
    Write-Host "║ │ • Total Problems: ${GREEN}$total_problems${NC}"
    Write-Host "║ │ • Total Implementations: ${GREEN}$total_implementations${NC}"
    
    $avg = if ($total_problems -gt 0) {
        [math]::Round($total_implementations / $total_problems, 2)
    } else { 0 }
    
    Write-Host "║ │ • Average Implementations: ${GREEN}$avg${NC} per problem"
    Write-Host "║ └────────────────────────────────────────────────────────┘"
    Write-Host "║"
    Write-Host "║ ${BOLD}┌─ Problems ──────────────────────────────────────────┐${NC}"
    
    # Display individual problems
    foreach ($problem in $problems) {
        $problem_num = $problem.Name
        $implementation_count = 0
        $available_langs = @()
        
        # Collect available languages
        foreach ($lang in $FILE_PATTERNS.Keys) {
            $pattern = Join-Path $problem.FullName $FILE_PATTERNS[$lang]
            if (Test-Path $pattern) {
                $implementation_count++
                $available_langs += $lang
            }
        }
        
        # Format problem header
        Write-Host "║ │ ${BOLD}Problem ${BLUE}$problem_num${NC}${BOLD}${NC}"
        Write-Host "║ │ ├─ ${YELLOW}$implementation_count${NC} implementation(s)"
        
        # Format languages with proper alignment
        $langs_str = $available_langs | ForEach-Object { "${GREEN}$_${NC}" }
        Write-Host "║ │ └─ Languages: $($langs_str -join ', ')"
        Write-Host "║ │"
    }
    Write-Host "║ └────────────────────────────────────────────────────────┘"
    Write-Host "╚══════════════════════════════════════════════════════════╝"
}

function Get-IsWindows {
    return $PSVersionTable.Platform -eq 'Win32NT' -or (-not (Get-Variable -Name "IsWindows" -ErrorAction "Ignore")) -or $IsWindows
}

function Invoke-Command {
    param(
        [string]$command
    )
    
    if (Get-IsWindows) {
        $output = & cmd /c $command 2>&1
        $exit_code = $LASTEXITCODE
    } else {
        $output = & /bin/bash -c $command 2>&1
        $exit_code = $LASTEXITCODE
    }
    
    # Return both the output and exit code as a custom object
    return @{
        Output = $output
        ExitCode = $exit_code
    }
}

function Run-Problem {
    param(
        [Parameter(Mandatory=$true)]
        [string]$problem_number,
        
        [Parameter(Mandatory=$true)]
        [string]$language,
        
        [string]$flags
    )

    $language = $language.ToLower()
    
    # Get problem-specific config
    $problem_flags = Read-ProblemConfig $problem_number $language
    
    # Command-line flags override problem-specific config
    if (-not $flags) {
        $flags = $problem_flags
    }

    # Check if language is supported
    if (-not $LANGUAGE_CONFIGS.ContainsKey($language)) {
        Print-Error "Unsupported language: $language"
        Write-Host "Use '${YELLOW}.\run.ps1 list languages${NC}' to see supported languages"
        exit 1
    }

    # Get file pattern for the language
    $file_pattern = $FILE_PATTERNS[$language]
    $source_file = Join-Path $problem_number $file_pattern

    # Check if source file exists
    if (-not (Test-Path $source_file)) {
        Print-Error "Source file not found: $source_file"
        exit 1
    }

    # Prepare build directory for this problem
    $problem_build_dir = Join-Path $BUILD_DIR $problem_number
    New-Item -ItemType Directory -Force -Path $problem_build_dir | Out-Null

    # Get compile and run commands
    $commands = $LANGUAGE_CONFIGS[$language] -split ":"
    $compile_cmd = $commands[0]
    $run_cmd = $commands[1]
    
    # Replace placeholders in commands
    $output_file = Join-Path $problem_build_dir "program"
    $compile_cmd = $compile_cmd.Replace("{source}", $source_file)
    $compile_cmd = $compile_cmd.Replace("{output}", $output_file)
    $compile_cmd = $compile_cmd.Replace("{dir}", $problem_build_dir)
    $compile_cmd = $compile_cmd.Replace("{flags}", $flags)
    
    $run_cmd = $run_cmd.Replace("{source}", $source_file)
    $run_cmd = $run_cmd.Replace("{output}", $output_file)
    $run_cmd = $run_cmd.Replace("{dir}", $problem_build_dir)

    # Print problem header
    $header_text = " Problem $problem_number - $language Implementation "
    $padding_length = 58 - $header_text.Length
    $right_padding = " " * $padding_length
    
    Write-Host "`n${BOLD}╔══════════════════════════════════════════════════════════╗${NC}"
    Write-Host "${BOLD}║${BLUE}$header_text${NC}${BOLD}${right_padding}║${NC}"
    Write-Host "${BOLD}╚══════════════════════════════════════════════════════════╝${NC}`n"

    # Execute commands
    if ($compile_cmd) {
        Write-Host "${BOLD}┌─ Compilation ────────────────────────────────────────────┐${NC}"
        Write-Host "│ Source: ${BLUE}$source_file${NC}"
        Write-Host "│ Flags:  ${YELLOW}$flags${NC}"
        Write-Host "├──────────────────────────────────────────────────────────┤"
        Write-Host "│ ${BOLD}Output:${NC}"
        Write-Host "│"
        
        # Capture compilation output and error
        $result = Invoke-Command $compile_cmd
        
        if ($result.Output) {
            $result.Output -split "`n" | ForEach-Object {
                Write-Host "│ $_"
            }
        }
        
        Write-Host "│"
        if ($result.ExitCode -eq 0) {
            Write-Host "│ ${GREEN}✔ Compilation successful${NC}"
        } else {
            Write-Host "│ ${RED}✖ Compilation failed${NC}"
            Write-Host "└──────────────────────────────────────────────────────────┘"
            exit 1
        }
        Write-Host "└──────────────────────────────────────────────────────────┘"
    }

    Write-Host "`n${BOLD}┌─ Execution ──────────────────────────────────────────────┐${NC}"
    Write-Host "│ Command: ${BLUE}${run_cmd}${NC}"
    Write-Host "├──────────────────────────────────────────────────────────┤"
    Write-Host "│ ${BOLD}Output:${NC}"
    Write-Host "│"
    
    # Capture and format program output
    $result = Invoke-Command $run_cmd
    
    if ($result.Output) {
        $result.Output -split "`n" | ForEach-Object {
            Write-Host "│ $_"
        }
    }
    
    Write-Host "│"
    if ($result.ExitCode -eq 0) {
        Write-Host "│ ${GREEN}✔ Program completed successfully${NC}"
    } else {
        Write-Host "│ ${RED}✖ Program failed with exit code $($result.ExitCode)${NC}"
    }
    Write-Host "└──────────────────────────────────────────────────────────┘"
}

# Main command processing
$command = $args[0]
switch ($command) {
    "run" {
        if ($args.Count -lt 3) {
            Show-Usage
        }
        Run-Problem $args[1] $args[2] $args[3]
    }
    "clear" {
        Write-Host "${YELLOW}Clearing build directory...$NC"
        Remove-Item -Path "$BUILD_DIR\*" -Recurse -Force
        Print-Success "Build directory cleared."
    }
    "list" {
        switch ($args[1]) {
            "languages" { List-Languages }
            "problems" { List-Problems }
            default {
                Write-Host "Available list commands:"
                Write-Host "  ${YELLOW}list languages${NC} - Show supported languages"
                Write-Host "  ${YELLOW}list problems${NC}  - Show available problems"
            }
        }
    }
    default {
        Show-Usage
    }
} 