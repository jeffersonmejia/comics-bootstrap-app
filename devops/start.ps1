function Show-Info {
    param([string]$Message)
    Write-Host $Message -ForegroundColor Cyan
}

function Start-WSL {
    Show-Info "[WSL] Starting WSL..."
    Start-Process "wsl.exe" -WindowStyle Hidden

    do {
        Start-Sleep -Seconds 2
        $wslReady = (wsl --list --quiet 2>$null)
    } while (-not $wslReady)

    Write-Host "[WSL] WSL is ready." -ForegroundColor Green
}

function Start-DockerDesktop {
    param([string]$DockerPath)

    Show-Info "[DOCKER] Starting Docker Desktop..."
    Start-Process $DockerPath -WindowStyle Hidden

    do {
        Start-Sleep -Seconds 2
        $version = docker version --format '{{.Server.Version}}' 2>$null
    } while (-not $version)

    Write-Host "[DOCKER] Docker Desktop is running." -ForegroundColor Green
}

function Start-ProjectContainers {
    Show-Info "[RUN] Starting containers..."
    docker compose up -d
}

function Wait-ForRunningContainers {
    param([string]$ProjectName)

    Show-Info "[STATUS] Waiting for all project containers to reach running state..."

    do {
        Start-Sleep -Seconds 2

        $running = docker ps `
            --filter "label=com.docker.compose.project=$ProjectName" `
            --filter "status=running" -q | Measure-Object | Select-Object -ExpandProperty Count

        $total = docker ps `
            --filter "label=com.docker.compose.project=$ProjectName" -q | Measure-Object | Select-Object -ExpandProperty Count

    } while ($running -lt $total)

    Write-Host "[STATUS] All containers are running." -ForegroundColor Green
}

function Main {
    cls

    $PROJECT_NAME = "p2lab1mejiajefferson_aso"
    $DOCKER_DESKTOP_PATH = "C:\Program Files\Docker\Docker\Docker Desktop.exe"

    Start-WSL
    Start-DockerDesktop -DockerPath $DOCKER_DESKTOP_PATH
    Start-ProjectContainers
    Wait-ForRunningContainers -ProjectName $PROJECT_NAME
}

Main
