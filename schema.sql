SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nixoumcj_energy_manager`
--

-- --------------------------------------------------------

--
-- Table structure for table `Company`
--

CREATE TABLE `Company` (
  `name` char(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` char(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `website` char(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isStation` tinyint(1) NOT NULL DEFAULT '1',
  `isSupplier` tinyint(1) NOT NULL DEFAULT '0',
  `isNozzle` tinyint(1) NOT NULL DEFAULT '0',
  `logo` char(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`);
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Nozzle`
--

CREATE TABLE `Nozzle` (
  `name` char(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company` char(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dataInterface` char(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Station`
--

CREATE TABLE `Station` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `name` char(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company` char(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `supplier` char(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` point NOT NULL,
  `address` char(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `num35MPa` tinyint(1) NOT NULL DEFAULT '1',
  `num70MPa` tinyint(1) NOT NULL DEFAULT '1',
  `numHiMPa` tinyint(1) NOT NULL DEFAULT '0',
  `nozzle` char(32) COLLATE utf8mb4_unicode_ci DEFAULT 'Generic',
  `dateOpened` date NOT NULL,
  `planningStatus` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`),
  CONSTRAINT `fk_Station_company_Company` FOREIGN KEY (`company`) REFERENCES `Company` (`name`),
  CONSTRAINT `fk_Station_nozzle_Nozzle` FOREIGN KEY (`nozzle`) REFERENCES `Nozzle` (`name`),
  CONSTRAINT `fk_Station_supplier_Company` FOREIGN KEY (`supplier`) REFERENCES `Company` (`name`);
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
  CONSTRAINT `fk_StationStatus_stationID_Station` FOREIGN KEY (`stationID`) REFERENCES `Station` (`id`);
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

