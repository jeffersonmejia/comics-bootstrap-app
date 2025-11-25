cls

function Switch-Branch($branch) {
    Write-Host "Switching to branch $branch..." -ForegroundColor Cyan
    git fetch
    git checkout $branch
    Write-Host "Branch ready" -ForegroundColor Green
}

function Stage-Changes {
    Write-Host "Staging changes..." -ForegroundColor Yellow
    git add .
    Write-Host "Files staged" -ForegroundColor Green
}

function Commit-Changes($message) {
    Write-Host "Creating commit..." -ForegroundColor Magenta
    git commit -m $message
    Write-Host "Commit created" -ForegroundColor Green
}

function Push-Changes($branch) {
    Write-Host "Pushing to $branch..." -ForegroundColor Blue
    git push origin $branch
    Write-Host "Push complete" -ForegroundColor Green
}

function Main {
    $branch = "docker"
    
    $message = Read-Host "Commit message"
    Write-Host "Starting process..." -ForegroundColor DarkCyan
    Switch-Branch $branch
    Stage-Changes
    Commit-Changes $message
    Push-Changes $branch
    Write-Host "All done" -ForegroundColor Green
}

Main
