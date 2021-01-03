<?php

$min_id = 0;
if( isset($_GET["id"]) ){
    $min_id = (int) $_GET["id"];
}

require 'db.con.php';

$sql = "SELECT a.alert_id, r.name as restaurant_name, a.table_number, a.time_created 
FROM `Alert` a INNER JOIN `Restaurant` r USING(restaurant_id)
WHERE a.alert_id > ".strval($min_id)."
ORDER BY 1";

$result = $conn->query($sql);


$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

header('Content-type:application/json;charset=utf-8');
echo json_encode($data);

$conn->close();