<?php
header('Content-Type: application/json');
include 'db.php';

$message = '';
$hostname = '';
$ip = '';

$pdo = db();
$message = $pdo ? "Conectada" : "Desconectada";

$hostname = gethostname();
$ip = trim(shell_exec("hostname -i"));

echo json_encode([
    'hostname' => $hostname,
    'ip' => $ip,
    'db' => $message
]);

