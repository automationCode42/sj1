# Configuration
$TargetRepoPath = "C:\Users\qa\Desktop\sj1\"
$IntervalSeconds = 120 # 2 minutes

# Move into the repository directory
Set-Location -Path $TargetRepoPath

Write-Host "Starting Auto-Push script. Press Ctrl+C to stop." -ForegroundColor Cyan

while ($true) {
    # 1. Create a new file with a unique timestamped name
    $Timestamp = Get-Date -Format "yyyyMMdd-HHmm"
    $FileName = "Log_$Timestamp.txt"
    "This file was automatically generated at $(Get-Date)" | Out-File -FilePath $FileName
    
    Write-Host "Created file: $FileName" -ForegroundColor Green

    # 2. Git Operations
    try {
        git add .
        git commit -m "Auto-commit: $Timestamp"
        git push
        Write-Host "Successfully pushed to repository at $(Get-Date)" -ForegroundColor Magentat
    }
    catch {
        Write-Error "An error occurred during the Git process."
    }

    # 3. Wait for the next interval
    Write-Host "Waiting for $IntervalSeconds seconds..." -ForegroundColor Gray
    Start-Sleep -Seconds $IntervalSeconds
}