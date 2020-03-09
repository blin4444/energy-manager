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
echo $mysqli->host_info . "\n";

$custresult = $mysqli->query("SELECT * FROM Station");
$stationResult = $mysqli->query("SELECT `id` FROM Station");

$validIdsDict = [];
while ($resultRow = $stationResult->fetch_array()) {
	$validIdsDict[$resultRow[0]] = true;
}
?>
<!doctype html>
<html>
<head><title>Station List</title></head>
<body>
<?php

echo create_table_from_query_result($custresult);
print_r($validIdsDict);

?>
</body>
</html>