<?php
/* Used to test if database connection works (will be removed) */
require("settings.php");
require("db-utils.php");
require("station-data.php");

date_default_timezone_set('America/Los_Angeles'); 

function addQueryParams($url) {
	$time_ms = array_sum(explode(' ', microtime()));
	return "$url?_=$time_ms";
}

function fetchStationData($apiUrl) {
	$json = file_get_contents(addQueryParams($apiUrl));
	$json_data = json_decode($json, true);
	$southSFId = 15549;

	foreach ($json_data as $key => $value) {
		if ($value['node'] && $value['node']['nid'] == $southSFId) {
			$stationData = StationData::fromJSON($value['node']);
			echo($stationData->getSummary());
			$stationData->record();
			break;
		}
	}
}

fetchStationData($API_URL);
?>
<!doctype html>
<html>
<head><title>Test connect</title></head>
<body>
<?php

echo 'Recorded';

?>
</body>
</html>