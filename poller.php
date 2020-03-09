<?php
/* Used to test if database connection works (will be removed) */
require("settings.php");
require("dbutils.php");

$mysqli = db_connect();
if ($mysqli->connect_errno) {
	if ($mysqli->connect_error) {
		die('Connect Error (' . $mysqli->connect_errno . ') '
				. $mysqli->connect_error);
	}
}
echo $mysqli->host_info . "\n";

$custresult = $mysqli->query("SELECT * FROM Station");
?>
<!doctype html>
<html>
<head><title>Test connect</title></head>
<body>
<?php

echo create_table_from_query_result($custresult);

?>
</body>
</html>