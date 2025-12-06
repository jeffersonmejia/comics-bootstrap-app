tartTime = Get-Date
cls

$REMOVE_OLD_CONTAINERS = $true
$REMOVE_OLD_VOLUMES = $true
$PROJECT_NAME = "comics-bootstrap-app"
$global:phase = 0
$totalPhases = 6

function Show-Phase {
    param([string]$Message)
    $global:phase++
    Write-Host "`n[PHASE $global:phase/$totalPhases] $Message" -ForegroundColor Cyan
}

function Reset-Docker {
    Show-Phase "Checking Docker Desktop..."
    $version = docker version --format '{{.Server.Version}}' 2>$null
    if (-not $version) {
        Write-Host "[DOCKER] Docker Desktop is not running. Starting..." -ForegroundColor Yellow
        Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"
        do {
            Start-Sleep -Seconds 2
            $version = docker version --format '{{.Server.Version}}' 2>$null
        } while (-not $version)
    }
    Write-Host "[DOCKER] Docker Desktop is running" -ForegroundColor Green
}

function Cleanup-ProjectContainers {
    if (-not $REMOVE_OLD_CONTAINERS) { return }
    Show-Phase "Removing old containers..."
    $containers = docker ps -aq --filter "label=com.docker.compose.project=$PROJECT_NAME"
    foreach ($c in $containers) {
        docker rm -f $c | Out-Null
    }
    Write-Host "[DOCKER] Old containers removed." -ForegroundColor Green
}

function Cleanup-ProjectVolumes {
    if (-not $REMOVE_OLD_VOLUMES) { return }
    Show-Phase "Removing old volumes..."
    $volumes = docker volume ls -q --filter "label=com.docker.compose.project=$PROJECT_NAME"
    foreach ($v in $volumes) {
        docker volume rm $v | Out-Null
    }
    Write-Host "[DOCKER] Old volumes removed." -ForegroundColor Green
}

function Start-Compose {
    Show-Phase "Starting docker-compose (DB cluster)..."
    docker compose up -d db1 db2 db3 haproxy_db
    Write-Host "[COMPOSE] Database cluster started." -ForegroundColor Green
}

function Wait-MySQL {
    Show-Phase "Waiting for MySQL to be ready..."
    foreach ($db in "db1","db2","db3") {
        do {
            Start-Sleep -Seconds 2
            $result = docker exec $db mysqladmin ping -uroot -pnoe123 2>$null
        } while ($result -ne "mysqld is alive")
        Write-Host "[$db] MySQL is ready." -ForegroundColor Green
    }
}

function Print-Status {
    Show-Phase "Active services:"
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
}

Reset-Docker
Cleanup-ProjectContainers
Cleanup-ProjectVolumes
Start-Compose
Wait-MySQL
Print-Status

