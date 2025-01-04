# Define platform-specific settings
$IS_WINDOWS = $PSVersionTable.Platform -eq 'Win32NT' -or (-not (Get-Variable -Name "IsWindows" -ErrorAction "Ignore")) -or $IsWindows
$EXE_EXT = if ($IS_WINDOWS) { ".exe" } else { "" }

# Define language configurations
$LANGUAGE_CONFIGS = @{
    # Format: [extension]="compile_command:run_command"
    "c" = "gcc {source} -o {output}$EXE_EXT {flags}:{output}$EXE_EXT"
    "java" = "javac -d {dir} {source}:java -cp {dir} Main"
    "js" = ":node {source}"
}

# Define file name patterns
$FILE_PATTERNS = @{
    "c" = "main.c"
    "java" = "Main.java"
    "js" = "main.js"
}

# Define default compilation flags
$DEFAULT_FLAGS = @{
    "c" = ""
    "java" = ""
    "js" = ""
} 