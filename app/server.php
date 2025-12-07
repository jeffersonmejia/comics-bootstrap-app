<?php
include 'db.php';

$message = '';
$hostname = '';
$ip = '';

function checkDb() {
    global $message;
    $pdo = db();
    $message = $pdo ? "Conectada" : "Desconectada";
}

function serverInfo() {
    global $hostname, $ip;
    $hostname = $_SERVER['NGINX_HOST'] ?? gethostname();
    $ip = $_SERVER['NGINX_IP'] ?? trim(shell_exec("hostname -i"));
}

checkDb();
serverInfo();

echo json_encode([
    'hostname' => $hostname,
    'ip' => $ip,
    'db' => $message
]);
?>
