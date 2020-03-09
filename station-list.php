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

$stationResult = $mysqli->query("SELECT * FROM Station");
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