# ================== CONFIG ==================
$stackName   = "p2lab"
$composeFile = "docker-compose.yaml"
$networkName = "frontend_net"

# ================== CHECK SWARM ==================
$swarmStatus = docker info --format "{{.Swarm.LocalNodeState}}"

if ($swarmStatus -ne "active") {
    Write-Host "ERROR: This node is NOT in a Swarm cluster." -ForegroundColor Red
    Write-Host "Run this first: docker swarm init --advertise-addr <your-ip>"
    exit 1
}

Write-Host "Swarm is active."

# ================== CREATE NETWORK (idempotent) ==================
$networkExists = docker network ls --format "{{.Name}}" | Select-String "^$networkName$"

if (-not $networkExists) {
    Write-Host "Creating overlay network ($networkName)..."
    docker network create -d overlay $networkName | Out-Null
} else {
    Write-Host "Overlay network ($networkName) already exists."
}

# ================== DEPLOY STACK ==================
Write-Host "Deploying stack $stackName..."
docker stack deploy -c $composeFile $stackName

# ================== STATUS OUTPUT ==================
Start-Sleep -Seconds 3

Write-Host "`nActive services:"
docker stack services $stackName

Write-Host "`nRunning tasks/containers:"
docker stack ps $stackName

Write-Host "`nTo follow HAProxy logs:"
Write-Host "docker service logs ${stackName}_haproxy -f"
