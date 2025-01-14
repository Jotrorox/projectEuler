# Define platform-specific settings
$IS_WINDOWS = $PSVersionTable.Platform -eq 'Win32NT' -or (-not (Get-Variable -Name "IsWindows" -ErrorAction "Ignore")) -or $IsWindows
$EXE_EXT = if ($IS_WINDOWS) { ".exe" } else { "" }

# Define language configurations
$LANGUAGE_CONFIGS = @{
    # Format: [extension]="compile_command:run_command"
    "c" = "gcc {source} -o {output}$EXE_EXT {flags}:{output}$EXE_EXT"
    "cpp" = "g++ {source} -o {output}$EXE_EXT {flags}:{output}$EXE_EXT"
    "java" = "javac -d {dir} {source}:java -cp {dir} Main"
    "js" = ":node {source}"
    "kt" = "kotlinc {source} -d {output}.jar {flags}:kotlin -classpath {output}.jar MainKt"
    "swift" = "swiftc {source} -o {output}$EXE_EXT {flags}:{output}$EXE_EXT"
    "go" = "go build -o {output}$EXE_EXT {flags} {source}:{output}$EXE_EXT"
    "zig" = "zig build-exe {source} -o {output}$EXE_EXT {flags}:{output}$EXE_EXT"
    "py" = ":python3 {source}"
}

# Define file name patterns
$FILE_PATTERNS = @{
    "c" = "main.c"
    "cpp" = "main.cpp"
    "java" = "Main.java"
    "js" = "main.js"
    "kt" = "Main.kt"
    "swift" = "main.swift"
    "go" = "main.go"
    "zig" = "main.zig"
    "py" = "main.py"
}

# Define default compilation flags
$DEFAULT_FLAGS = @{
    "c" = ""
    "cpp" = ""
    "java" = ""
    "js" = ""
    "kt" = ""
    "swift" = ""
    "go" = ""
    "zig" = ""
    "py" = ""
} 
