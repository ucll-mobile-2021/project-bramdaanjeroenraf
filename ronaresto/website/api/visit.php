<?php

$min_id = 0;
if( isset($_GET["id"]) ){
    $min_id = (int) $_GET["id"];
}

require '../include/db.con.php';

$sql = "SELECT v.visit_id, v.date, v.timeslot, v.name, v.telephone, v.email, r.name as restaurant 
FROM `Visit` v INNER JOIN `Restaurant` r USING(restaurant_id)
WHERE v.visit_id > ".strval($min_id)."
ORDER BY 1,2;";

$result = $conn->query($sql);


$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

header('Content-type:application/json;charset=utf-8');
echo json_encode($data);

$conn->close();