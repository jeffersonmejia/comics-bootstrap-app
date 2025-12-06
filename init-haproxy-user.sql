CREATE USER 'haproxy'@'%' IDENTIFIED WITH mysql_native_password BY 'haproxy123';
GRANT SELECT ON *.* TO 'haproxy'@'%';
FLUSH PRIVILEGES;

