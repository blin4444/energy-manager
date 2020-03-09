<?php
require("settings.php");

/* A collection of (hopefully) useful functions for database access */
$DB_IS_INIT = false;
$mysqli = null;

function db_init()
{
  $mysqli = mysqli_init();
  $DB_IS_INIT = true;
  return $mysqli;
}

// Input: None
// Output: a mysqli object
function db_connect() {
	global $DB_IS_INIT, $mysqli;
	if (!$DB_IS_INIT)
	{
		$mysqli = db_init();
	}
	global $DB_ADDRESS, $DB_USERNAME, $DB_PASSWORD, $DB_NAME, $DB_PORT;
	$mysqli->real_connect($DB_ADDRESS, $DB_USERNAME, $DB_PASSWORD, $DB_NAME, $DB_PORT);
	return $mysqli;
}

// Input: None
// Output: a pdo object
function dbPdoConnect() {
	global $DB_ADDRESS, $DB_USERNAME, $DB_PASSWORD, $DB_NAME, $DB_PORT;
	$pdo = new PDO("mysql:host=$DB_ADDRESS;port=$DB_PORT;dbname=$DB_NAME", $DB_USERNAME, $DB_PASSWORD);
	$pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
	$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	return $pdo;
}

// Input: $pds - a PDO statement
// Output: an array of associative arrays for a given query
function pdoFetchAllAssoc($pds) {
	$rows = array();
	while ($row = $pds->fetch(PDO::FETCH_ASSOC)) {
		$rows[] = $row;
	}
	return $rows;
}

// Input: $pds - a PDO statement
// Output: an array of key value pairs
function pdoFetchKeyVal($pds) {
	$output = array();
	while ($row = $pds->fetch(PDO::FETCH_NUM)) {
		if (count($row) != 2) {
			throw new Exception("Invalid number of columns");
		}
		$output[$row[0]] = $row[1];
	}
	return $output;
}

?>