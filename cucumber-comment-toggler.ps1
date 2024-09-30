# Define parameters to be passed from the command line
param (
    [string]$FilePath,         # Path to the file
    [string]$LineRanges,       # Line ranges (e.g., "3-5,8-13")
    [string]$CommentChar       # Character used to comment out lines (e.g., # or //)
)

# Validate the file path
if (-not (Test-Path $FilePath)) {
    Write-Host "File does not exist. Please provide a valid file path." -ForegroundColor Red
    exit
}

# Read all the lines from the file
$Lines = Get-Content -Path $FilePath

# Parse the line ranges (e.g., "3-5,8-13")
$Ranges = $LineRanges -split ','

foreach ($Range in $Ranges) {
    # Split each range into start and end (e.g., "3-5" becomes 3 and 5)
    $Parts = $Range -split '-'
    
    # Ensure we have exactly two numbers for the range
    if ($Parts.Count -ne 2) {
        Write-Host "Invalid line range: $Range. Please provide valid ranges (e.g., '3-5,8-13')." -ForegroundColor Red
        exit
    }

    $StartLine = [int]$Parts[0]
    $EndLine = [int]$Parts[1]

    # Ensure the start and end lines are within range
    if ($StartLine -lt 1 -or $EndLine -gt $Lines.Count -or $StartLine -gt $EndLine) {
        Write-Host "Invalid line range: $Range. Please ensure the lines are within the file length." -ForegroundColor Red
        exit
    }

    # Toggle comments for lines in the specified range
    for ($i = $StartLine - 1; $i -lt $EndLine; $i++) {
        $CurrentLine = $Lines[$i]
        
        # Check if the line starts with the comment character, remove it if found, else add it
        if ($CurrentLine.TrimStart().StartsWith($CommentChar)) {
            # Remove the comment character from the line
            $Lines[$i] = $CurrentLine -replace "^(\s*)$CommentChar", '$1'
        } else {
            # Add the comment character to the line
            $Lines[$i] = "$CommentChar$($Lines[$i])"
        }
    }
}

# Save the modified lines back to the file
Set-Content -Path $FilePath -Value $Lines

Write-Host "The specified line ranges ($LineRanges) have been toggled with '$CommentChar'."
