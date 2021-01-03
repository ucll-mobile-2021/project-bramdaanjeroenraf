<?php

$min_id = 0;
if( isset($_GET["id"]) ){
    $min_id = (int) $_GET["id"];
}

require '../include/db.con.php';

$sql = "SELECT user_id,email,telephonenumber,name 
FROM `User`
WHERE user_id > ".strval($min_id)."
ORDER BY 1;";

$result = $conn->query($sql);


$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

header('Content-type:application/json;charset=utf-8');
echo json_encode($data);

$conn->close();