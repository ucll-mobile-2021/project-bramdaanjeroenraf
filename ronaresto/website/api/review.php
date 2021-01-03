<?php

$min_id = 0;
if( isset($_GET["id"]) ){
    $min_id = (int) $_GET["id"];
}

require '../include/db.con.php';

$sql = "SELECT rev.review_id, rev.stars, rev.text, r.name as restaurant_name, u.name as user_name
FROM `Review` rev INNER JOIN `Restaurant` r USING(restaurant_id)
INNER JOIN `User` u USING(user_id)
WHERE rev.review_id > ".strval($min_id)."
ORDER BY 1;";

$result = $conn->query($sql);


$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

header('Content-type:application/json;charset=utf-8');
echo json_encode($data);

$conn->close();