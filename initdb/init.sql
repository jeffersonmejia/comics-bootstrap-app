CREATE USER IF NOT EXISTS 'haproxy'@'%' IDENTIFIED WITH mysql_native_password BY '';
GRANT ALL PRIVILEGES ON *.* TO 'haproxy'@'%';
FLUSH PRIVILEGES;
