
<?php
// Global variables created:
// $DB_ADDRESS, $DB_USERNAME, $DB_PASSWORD, $DB_NAME, $DB_PORT, and $SITE_ROOT

$MYSQLI = null;
$DB_USERNAME = "admin";
$DB_PASSWORD = "pass";
$DB_NAME = "energy_manager_db";
$DB_ADDRESS = "127.0.0.1";
$DB_PORT = 3306;

$API_URL = ''; // station data URL

$SITE_ROOT = "/h2/";
$POLLING_INTERVAL_MS = 3 * 60 * 1000; // 3 minutes

// Enable all errors
ini_set('display_errors',1);
ini_set('display_startup_errors',1);
error_reporting(-1);

?>