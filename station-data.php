<?php

// https://stackoverflow.com/a/834355
function endsWith($haystack, $needle)
{
    $length = strlen($needle);
    if ($length == 0) {
        return true;
    }

    return (substr($haystack, -$length) === $needle);
}

class StationData {
    // constructor
    public function __construct($stationId, $recordedAt, $status35, $status70, $statusHi, $capacity35, $capacity70, $capacityHi) {
        $this->stationId = $stationId;
        $this->recordedAt = $recordedAt;

        $this->status35 = $status35;
        $this->status70 = $status70;
        $this->statusHi = $statusHi;

        $this->capacity35 = $capacity35;
        $this->capacity70 = $capacity70;
        $this->capacityHi = $capacityHi;
    }

    private static function getCapacity($strCapacity) {
        return endsWith($strCapacity, ' kg') ? intval(substr(strCapacity, 0, -3)) : 0;
    }

    public static function fromJSON($obj) {
        $strOffline = 'offline';
        $is35Available = $obj['status35'] !== $strOffline;
        $is70Available = $obj['status70'] !== $strOffline;
        $isHiAvailable = false;

        $int35 = $obj['capacity35'];
        $int70 = $obj['capacity70'];
        $intHi = 0;

        return new self(
            intval($obj['station']),
            intval($obj['modified']),
            $is35Available,
            $is70Available,
            $isHiAvailable,
            $int35,
            $int70,
            $intHi
        );
    }

    public function record($mysqli) {
        $recordedAt = $this->recordedAt;
        $dateStr = date("Y:m:d H:i:s", $recordedAt);

        $statement = "INSERT IGNORE INTO `StationStatus`(`stationID`, `recordedAt`, `capacity35MPa`, `capacity70MPa`, `status35MPa`, `status70MPa`) VALUES (?, ?, ?, ?, ?, ?)";
        $addItemQuery = $mysqli->prepare($statement);
        $addItemQuery->bind_param(
            "isiiii",
            $this->stationId,
            $dateStr,
            $this->capacity35,
            $this->capacity70,
            $this->status35,
            $this->status70
        );
        
        if(!$addItemQuery->execute()) { // Error
            die("<p>{$addItemQuery->error}</p>");
        }
        $addItemQuery->close();
    }

    public function getSummary() {
        return '70 MPa: ' . $this->capacity70 . ' Status: ' . $this->status70 . ' At: ' . date('m/d/Y H:i:s', $this->recordedAt);
    }
}

?>


