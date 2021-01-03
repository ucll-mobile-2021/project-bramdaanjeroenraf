<?php
/*
ronaresto.raf-zegers.sb.uclllabs.be/sql/
de username, databank en het wachtwoord is hetzelfde gebleven:
db/username: ZdZsbXqf4M
ww: Rf1I4vFY8P
 */


//$servername = "raf-zegers.sb.uclllabs.be:3306";
$servername = "193.191.177.194:4001";
//$servername = "remotemysql.com:3306";
$username = "ZdZsbXqf4M";
$password = "Rf1I4vFY8P";
$dbName = "ZdZsbXqf4M";

$conn = new mysqli($servername, $username, $password, $dbName);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
