function Show-Info {
    param([string]$Message)
    Write-Host $Message -ForegroundColor Cyan
}

function Stop-ProjectContainers {
    param([string]$ProjectName)

    Show-Info "[STOP] Stopping containers..."
    $containers = docker ps --filter "label=com.docker.compose.project=$ProjectName" -q

    foreach ($c in $containers) {
        docker stop $c | Out-Null
    }

    Write-Host "[STOP] Containers stopped." -ForegroundColor Green
}

function Main {
    cls
    $PROJECT_NAME = "p2lab1mejiajefferson_aso"
    Stop-ProjectContainers -ProjectName $PROJECT_NAME
}

Main
