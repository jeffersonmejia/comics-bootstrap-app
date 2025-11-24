$startTime = Get-Date
cls

$REMOVE_OLD_CONTAINERS = $true
$PROJECT_NAME = "p2lab1mejiajefferson_aso"
$global:phase = 0
$totalPhases = 7 

function Show-Phase {
    param([string]$Message)
    $global:phase++
    Write-Host "`n[PHASE $global:phase/$totalPhases] $Message" -ForegroundColor Cyan
}

function Load-EnvFile {
    param([string]$Path)
    Show-Phase "Loading environment file..."
    if (-Not (Test-Path $Path)) {
        Write-Host "[ENVIRONMENT]" -ForegroundColor Red " Environment file not found: $Path"
        exit 1
    }
    Get-Content $Path | ForEach-Object {
        if ($_ -match "^\s*([^=]+)=(.+)$") {
            $name = $matches[1].Trim()
            $value = $matches[2].Trim('"')
            Set-Variable -Name $name -Value $value -Scope Script
        }
    }
    Write-Host "[ENVIRONMENT]" -ForegroundColor Blue " Variables loaded successfully"
}

function Reset-Docker {
    Show-Phase "Resetting Docker services..."
    $dockerProcs = Get-Process *docker* -ErrorAction SilentlyContinue
    if ($dockerProcs) {
        $dockerProcs | Stop-Process -Force
        Write-Host "[DOCKER]" -ForegroundColor Blue " Docker processes stopped"
        wsl --shutdown
        Write-Host "[WSL]" -ForegroundColor Blue " WSL shutdown completed"
    } else {
        Write-Host "[DOCKER]" -ForegroundColor Blue " Docker not running"
    }
}

function Start-DockerDesktop {
    param([string]$DockerPath)
    Show-Phase "Starting Docker Desktop..."
    Start-Process "wsl.exe" -WindowStyle Hidden
    do { Start-Sleep -Seconds 2 } while (-not (wsl --list --quiet 2>$null))

    Start-Process $DockerPath -WindowStyle Hidden
    do { 
        Start-Sleep -Seconds 2
        $version = docker version --format '{{.Server.Version}}' 2>$null
    } while (-not $version)
    Write-Host "[DOCKER]" -ForegroundColor Green " Docker Desktop running"
}

function Cleanup-ProjectContainers {
    param([string]$ProjectName)
    if (-not $REMOVE_OLD_CONTAINERS) { return }
    Show-Phase "Removing old containers for project '$ProjectName'..."
    $containers = docker ps -aq --filter "label=com.docker.compose.project=$ProjectName"
    foreach ($c in $containers) {
        docker rm -f $c | Out-Null
    }
    docker system prune -f --volumes | Out-Null
    Write-Host "[DOCKER]" -ForegroundColor Green " Old containers and unused volumes removed"
}

function Start-Compose {
    Show-Phase "Running docker compose up..."
    docker compose up -d
    Write-Host "[COMPOSE]" -ForegroundColor Green " Docker containers started"

    # Espera activa: todos los contenedores del proyecto en estado running
    Write-Host "[COMPOSE]" -ForegroundColor Cyan " Waiting for all project containers to be running..."
    do {
        Start-Sleep -Seconds 2
        $runningCount = docker ps --filter "label=com.docker.compose.project=$PROJECT_NAME" --filter "status=running" -q | Measure-Object | Select-Object -ExpandProperty Count
        $totalCount = docker ps --filter "label=com.docker.compose.project=$PROJECT_NAME" -q | Measure-Object | Select-Object -ExpandProperty Count
    } while ($runningCount -lt $totalCount)
    Write-Host "[COMPOSE]" -ForegroundColor Green " All project containers are running"
}

function Print-FinalStats {
    Show-Phase "Active Services..."
    $containers = docker ps --filter "label=com.docker.compose.project=$PROJECT_NAME" --format "{{.Names}}|{{.Ports}}"
    foreach ($c in $containers) {
        $parts = $c -split "\|"
        $name = $parts[0]
        $portsInfo = $parts[1] -split ","
        foreach ($p in $portsInfo) {
            if ($p -match "0\.0\.0\.0:(\d+)->") { $hostPort = [int]$matches[1] } else { $hostPort = 0 }
            if ($hostPort -eq 0) { continue }
            $status = Test-NetConnection -ComputerName "localhost" -Port $hostPort -InformationLevel Quiet
            $statusText = if ($status) { "Online" } else { "Offline" }
            Write-Host "[SERVICE] $name ($hostPort) - $statusText" -ForegroundColor Yellow
        }
    }
}

function Main {
    Load-EnvFile -Path (Join-Path $PSScriptRoot "../.env")
    Reset-Docker
    Start-DockerDesktop -DockerPath $DOCKER_DESKTOP
    Cleanup-ProjectContainers -ProjectName $PROJECT_NAME
    Start-Compose
    Print-FinalStats
}

Main
