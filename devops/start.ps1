function Show-Info {
    param([string]$Message)
    Write-Host $Message -ForegroundColor Cyan
}

function Wait-ForRunningContainers {
    param([string]$ProjectName)

    Show-Info "[STATUS] Waiting for all project containers to reach running state..."

    do {
        Start-Sleep -Seconds 2
        $running = docker ps --filter "label=com.docker.compose.project=$ProjectName" --filter "status=running" -q | Measure-Object | Select-Object -ExpandProperty Count
        $total = docker ps --filter "label=com.docker.compose.project=$ProjectName" -q | Measure-Object | Select-Object -ExpandProperty Count
    } while ($running -lt $total)

    Write-Host "[STATUS] All containers are running." -ForegroundColor Green
}

function Start-ProjectContainers {
    Show-Info "[RUN] Starting containers..."
    docker compose up -d | Out-Null
}

function Main {
    cls
    $PROJECT_NAME = "p2lab1mejiajefferson_aso"

    Start-ProjectContainers
    Wait-ForRunningContainers -ProjectName $PROJECT_NAME
}

Main
