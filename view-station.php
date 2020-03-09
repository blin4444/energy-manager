<?php
/* Used to test if database connection works (will be removed) */
require("settings.php");
require("db-utils.php");
require("table.php");

$mysqli = db_connect();
if ($mysqli->connect_errno) {
	if ($mysqli->connect_error) {
		die('Connect Error (' . $mysqli->connect_errno . ') '
				. $mysqli->connect_error);
	}
}

$station = $_REQUEST['station'];
$stationId = 0;
switch($station) {
    case 'Fremont':
        $stationId = 15280;
        break;
    case 'SSF';
    case 'South San Francisco';
        $stationId = 15032;
        break;
    case 'MV':
    case 'Mountain View':
        $stationId = 15010;
        break;
    break;
}


$stationResult = $mysqli->query("SELECT * FROM `StationStatus` WHERE `stationID` = $stationId AND `recordedAt` > DATE_SUB(CURRENT_TIMESTAMP, INTERVAL (3*60 + 60*1) MINUTE) ORDER BY `recordedAt` DESC");
?>
<!doctype html>
<html>
<head><title>Station List</title></head>
<body>
<?php

echo create_table_from_query_result($stationResult);

?>
</body>
</html>