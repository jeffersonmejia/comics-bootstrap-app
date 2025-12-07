<?php
include 'db.php';
$conn = db();
if ($conn) {
    $conn->exec("CREATE TABLE IF NOT EXISTS messages (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100),
        email VARCHAR(100),
        message TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )");

    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['name'], $_POST['email'], $_POST['message'])) {
        $stmt = $conn->prepare("INSERT INTO messages (name, email, message) VALUES (?, ?, ?)");
        $stmt->execute([$_POST['name'], $_POST['email'], $_POST['message']]);
    }

    if (isset($_GET['delete'])) {
        $stmt = $conn->prepare("DELETE FROM messages WHERE id = ?");
        $stmt->execute([$_GET['delete']]);
    }

    $messages = $conn->query("SELECT * FROM messages ORDER BY created_at DESC")->fetchAll(PDO::FETCH_ASSOC);
} else {
    $messages = [];
}
?>
