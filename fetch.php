<?php
require("settings.php");
require("db-utils.php");
require("station-data.php");

date_default_timezone_set('America/Los_Angeles'); 

function addQueryParams($url) {
	$time_ms = array_sum(explode(' ', microtime()));
	return "$url?_=$time_ms";
}

function getStationIds($mysqli) {
	$stationResult = $mysqli->query("SELECT `id` FROM Station");

	$stationIdsDict = [];
	while ($resultRow = $stationResult->fetch_array()) {
		$stationIdsDict[$resultRow[0]] = true;
	}

	return $stationIdsDict;
}

function fetchStationData($apiUrl) {
	$mysqli = db_connect();
	if ($mysqli->connect_errno && $mysqli->connect_error) {
		die("Connect Error ($mysqli->connect_errno) $mysqli->connect_error");
	}

	$json = file_get_contents(addQueryParams($apiUrl));
	$json_data = json_decode($json, true);
	$stationIds = getStationIds($mysqli);

	foreach ($json_data as $key => $value) {
		if ($value['node'] && $value['node']['station']) {
			if (array_key_exists(intval($value['node']['station']), $stationIds)) {
				$stationData = StationData::fromJSON($value['node']);
				$stationData->getSummary();
				$stationData->record($mysqli);
			}
		}
	}
}

fetchStationData($API_URL);
?>
