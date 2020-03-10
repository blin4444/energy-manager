SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;

-- --------------------------------------------------------

--
-- Table structure for table `Company`
--

CREATE TABLE `Company` (
  `name` char(16) NOT NULL,
  `description` char(64) NOT NULL,
  `website` char(64) NOT NULL,
  `isStation` tinyint(1) NOT NULL DEFAULT '1',
  `isSupplier` tinyint(1) NOT NULL DEFAULT '0',
  `isNozzle` tinyint(1) NOT NULL DEFAULT '0',
  `logo` char(128) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Nozzle`
--

CREATE TABLE `Nozzle` (
  `name` char(32) NOT NULL,
  `description` varchar(128) NOT NULL,
  `company` char(16) NOT NULL,
  `dataInterface` char(32) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `StationPlanningStatus`
--

CREATE TABLE `StationPlanningStatus` (
  `name` char(32) NOT NULL,
  `description` varchar(128) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Station`
--

CREATE TABLE `Station` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `name` char(32) NOT NULL,
  `company` char(16) NOT NULL,
  `supplier` char(16) DEFAULT NULL,
  `location` point NOT NULL,
  `address` char(128) NOT NULL,
  `city` char(32) NOT NULL,
  `state` char(2) NOT NULL DEFAULT 'CA',
  `zipCode` char(9) NOT NULL,
  `num35MPa` tinyint(1) NOT NULL DEFAULT '1',
  `num70MPa` tinyint(1) NOT NULL DEFAULT '1',
  `numHiMPa` tinyint(1) NOT NULL DEFAULT '0',
  `nozzle` char(32) COLLATE utf8mb4_unicode_ci DEFAULT 'Generic',
  `dateOpened` date NOT NULL,
  `planningStatus` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`),
  CONSTRAINT `fk_Station_company_Company` FOREIGN KEY (`company`) REFERENCES `Company` (`name`),
  CONSTRAINT `fk_Station_nozzle_Nozzle` FOREIGN KEY (`nozzle`) REFERENCES `Nozzle` (`name`),
  CONSTRAINT `fk_Station_supplier_Company` FOREIGN KEY (`supplier`) REFERENCES `Company` (`name`),
  CONSTRAINT `fk_Station_planningStatus_StationPlanningStatus` FOREIGN KEY (`planningStatus`) REFERENCES `StationPlanningStatus` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `StationStatus`
--

CREATE TABLE `StationStatus` (
  `stationID` mediumint(9) NOT NULL,
  `recordedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `capacity35MPa` smallint(6) NOT NULL,
  `capacity70MPa` smallint(6) NOT NULL,
  `capacityHiMPa` smallint(6) NOT NULL DEFAULT '0',
  `status35MPa` tinyint(1) NOT NULL,
  `status70MPa` tinyint(1) NOT NULL,
  `statusHiMPa` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`stationID`, `recordedAt`),
  CONSTRAINT `fk_StationStatus_stationID_Station` FOREIGN KEY (`stationID`) REFERENCES `Station` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `StationOpenPeriods`
--

CREATE TABLE `StationOpenPeriods` (
  `stationID` mediumint(9) NOT NULL,
  `day` enum('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') NOT NULL,
  `start` char(4) NOT NULL DEFAULT '000',
  `end` char(4) NOT NULL DEFAULT '2359',
  `comments` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`stationID`, `day`),
  CONSTRAINT `fk_StationOpenPeriods_stationID_Station` FOREIGN KEY (`stationID`) REFERENCES `Station`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
