-- --------------------------------------------------------
-- Host:                         192.168.0.2
-- Server version:               5.5.47-0+deb7u1 - (Debian)
-- Server OS:                    debian-linux-gnu
-- HeidiSQL Version:             9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for csg-revamp
CREATE DATABASE IF NOT EXISTS `csg-revamp` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `csg-revamp`;


-- Dumping structure for table csg-revamp.accounts
CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(12) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(512) NOT NULL,
  `email` varchar(225) NOT NULL,
  `serial` varchar(225) NOT NULL,
  `IP` varchar(16) NOT NULL DEFAULT '000.000.000.000',
  `score` double NOT NULL DEFAULT '0',
  `wanted` tinyint(1) NOT NULL DEFAULT '0',
  `money` bigint(10) NOT NULL DEFAULT '20000',
  `health` tinyint(3) NOT NULL DEFAULT '100',
  `armor` tinyint(3) NOT NULL DEFAULT '0',
  `fightstyle` int(2) NOT NULL DEFAULT '4',
  `occupation` varchar(225) NOT NULL,
  `team` varchar(225) NOT NULL DEFAULT 'Unemployed',
  `skin` int(10) NOT NULL,
  `cjskin` varchar(225) NOT NULL DEFAULT '[{"1":0,"2":5,"3":6,"0":1}]',
  `jobskin` int(10) NOT NULL,
  `x` float NOT NULL DEFAULT '1537.56',
  `y` float NOT NULL DEFAULT '-1655.19',
  `z` float NOT NULL DEFAULT '13.55',
  `rotation` float NOT NULL DEFAULT '182',
  `interior` tinyint(3) NOT NULL DEFAULT '0',
  `dimension` int(10) NOT NULL DEFAULT '0',
  `weapons` varchar(225) NOT NULL,
  `banned` enum('0','1') NOT NULL DEFAULT '0',
  `banReason` varchar(255) NOT NULL,
  `carlicence` smallint(1) NOT NULL DEFAULT '1',
  `planelicence` smallint(1) NOT NULL DEFAULT '1',
  `chopperlicence` smallint(1) NOT NULL DEFAULT '1',
  `bikelicence` smallint(1) NOT NULL DEFAULT '1',
  `boatlicence` smallint(1) NOT NULL DEFAULT '1',
  `premium` mediumint(12) NOT NULL DEFAULT '0',
  `premiumType` int(1) NOT NULL,
  `playtime` int(12) NOT NULL DEFAULT '0',
  `dateofbirth` varchar(255) NOT NULL,
  `phoneNumber` varchar(255) NOT NULL,
  `gender` enum('0','1') NOT NULL DEFAULT '0',
  `rpgAmount` int(11) NOT NULL,
  `mail` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.achievements
CREATE TABLE IF NOT EXISTS `achievements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `achievementName` varchar(255) NOT NULL,
  `achievementDesc` varchar(255) NOT NULL,
  `howToEarn` text NOT NULL,
  `achievementPicture` text NOT NULL,
  `earnPoints` varchar(255) NOT NULL DEFAULT '1',
  `code` text NOT NULL,
  `autocheck` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.achievements_earned
CREATE TABLE IF NOT EXISTS `achievements_earned` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountID` int(10) NOT NULL,
  `achievementID` int(11) NOT NULL,
  `dateCollected` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.achievements_list
CREATE TABLE IF NOT EXISTS `achievements_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `achievementName` varchar(255) NOT NULL,
  `achievementPoint` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.adminlog
CREATE TABLE IF NOT EXISTS `adminlog` (
  `player` varchar(225) NOT NULL,
  `account` varchar(225) NOT NULL,
  `serial` varchar(225) NOT NULL,
  `action` text NOT NULL,
  `timestamp` varchar(225) NOT NULL,
  `time` varchar(225) NOT NULL,
  `date` varchar(225) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.banking
CREATE TABLE IF NOT EXISTS `banking` (
  `userid` int(10) NOT NULL,
  `balance` bigint(12) NOT NULL DEFAULT '2000',
  `creditcard` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.banking_transactions
CREATE TABLE IF NOT EXISTS `banking_transactions` (
  `userid` int(11) NOT NULL,
  `datum` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `transaction` varchar(225) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.bans
CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `serial` varchar(32) DEFAULT NULL,
  `account` varchar(225) DEFAULT NULL,
  `reason` varchar(225) NOT NULL,
  `banstamp` int(255) NOT NULL,
  `bannedby` varchar(225) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `serial` (`serial`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.christmas
CREATE TABLE IF NOT EXISTS `christmas` (
  `userid` varchar(225) NOT NULL,
  `day` varchar(225) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.cities
CREATE TABLE IF NOT EXISTS `cities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `x` varchar(255) NOT NULL,
  `y` varchar(255) NOT NULL,
  `z` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.class
CREATE TABLE IF NOT EXISTS `class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `team` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `skinID` int(11) NOT NULL,
  `matrix` varchar(255) NOT NULL,
  `x` varchar(255) NOT NULL,
  `y` varchar(255) NOT NULL,
  `z` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.credits
CREATE TABLE IF NOT EXISTS `credits` (
  `userid` int(11) NOT NULL,
  `credits` int(11) NOT NULL DEFAULT '0',
  `creditsSpent` int(11) NOT NULL DEFAULT '0',
  `moneySpent` varchar(11) NOT NULL DEFAULT '0',
  `itemsBought` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.crimes
CREATE TABLE IF NOT EXISTS `crimes` (
  `userid` int(12) NOT NULL,
  `crime` varchar(1225) NOT NULL,
  `timestamp` int(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.developer
CREATE TABLE IF NOT EXISTS `developer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.exp
CREATE TABLE IF NOT EXISTS `exp` (
  `id` int(11) NOT NULL,
  `exp` varchar(255) NOT NULL,
  `expNeeded` varchar(255) NOT NULL,
  `level` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.groups
CREATE TABLE IF NOT EXISTS `groups` (
  `groupid` int(11) NOT NULL AUTO_INCREMENT,
  `groupname` varchar(225) NOT NULL,
  `groupleader` varchar(225) NOT NULL,
  `groupinfo` text NOT NULL,
  `datecreated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `groupbalance` int(12) NOT NULL DEFAULT '0',
  `membercount` int(3) NOT NULL DEFAULT '1',
  `turfcolor` varchar(225) NOT NULL DEFAULT '225,225,225',
  PRIMARY KEY (`groupid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.groups_blacklist
CREATE TABLE IF NOT EXISTS `groups_blacklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupname` varchar(255) NOT NULL,
  `reason` text NOT NULL,
  `blacklistBy` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.groups_invites
CREATE TABLE IF NOT EXISTS `groups_invites` (
  `inviteid` int(11) NOT NULL AUTO_INCREMENT,
  `memberid` int(12) NOT NULL,
  `groupid` int(11) NOT NULL,
  `groupname` varchar(225) NOT NULL,
  `invitedby` varchar(225) NOT NULL,
  PRIMARY KEY (`inviteid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.groups_logs
CREATE TABLE IF NOT EXISTS `groups_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupid` int(11) NOT NULL,
  `log` text NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.groups_members
CREATE TABLE IF NOT EXISTS `groups_members` (
  `uniqueid` int(11) NOT NULL AUTO_INCREMENT,
  `groupid` int(11) NOT NULL,
  `memberid` int(11) NOT NULL,
  `membername` varchar(225) NOT NULL,
  `groupname` varchar(225) NOT NULL,
  `grouprank` varchar(225) NOT NULL,
  `lastonline` bigint(15) NOT NULL DEFAULT '0',
  `joindate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uniqueid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.groups_transactions
CREATE TABLE IF NOT EXISTS `groups_transactions` (
  `groupid` int(10) NOT NULL,
  `memberid` int(10) NOT NULL,
  `transaction` varchar(225) NOT NULL,
  `datum` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.housing
CREATE TABLE IF NOT EXISTS `housing` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ownerid` int(11) NOT NULL DEFAULT '0',
  `interiorid` int(3) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `sale` int(11) NOT NULL,
  `houseprice` bigint(20) NOT NULL,
  `boughtprice` bigint(20) NOT NULL,
  `originalPrice` int(11) NOT NULL,
  `housename` varchar(225) NOT NULL,
  `locked` int(11) NOT NULL,
  `passwordlocked` int(11) NOT NULL,
  `password` varchar(4) NOT NULL,
  `createdBy` varchar(225) NOT NULL,
  `weaponsStorage` text NOT NULL,
  `drugsStorage` text NOT NULL,
  `moneyStorage` text NOT NULL,
  `perms` text NOT NULL,
  `music` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.jail
CREATE TABLE IF NOT EXISTS `jail` (
  `userid` int(11) NOT NULL,
  `jailtime` int(11) NOT NULL,
  `jailplace` varchar(225) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.loadup
CREATE TABLE IF NOT EXISTS `loadup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.logins
CREATE TABLE IF NOT EXISTS `logins` (
  `loginid` int(12) NOT NULL AUTO_INCREMENT,
  `serial` varchar(225) NOT NULL,
  `nickname` varchar(225) NOT NULL,
  `accountname` varchar(225) NOT NULL,
  `datum` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` varchar(225) NOT NULL,
  PRIMARY KEY (`loginid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.logs
CREATE TABLE IF NOT EXISTS `logs` (
  `player` varchar(225) NOT NULL,
  `account` varchar(225) NOT NULL,
  `type` varchar(225) NOT NULL,
  `type2` varchar(225) NOT NULL,
  `timestamp` varchar(225) NOT NULL,
  `date` varchar(225) NOT NULL,
  `time` varchar(225) NOT NULL,
  `action` text NOT NULL,
  `serial` varchar(225) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.playerstats
CREATE TABLE IF NOT EXISTS `playerstats` (
  `userid` int(11) NOT NULL,
  `paramedic` varchar(255) NOT NULL,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `userid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.punishlog
CREATE TABLE IF NOT EXISTS `punishlog` (
  `uniqueid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `datum` date NOT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  `serial` varchar(32) NOT NULL,
  `punishment` text NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `uniqueid` (`uniqueid`),
  KEY `uniqueid_2` (`uniqueid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.settings
CREATE TABLE IF NOT EXISTS `settings` (
  `settingName` text NOT NULL,
  `value` varchar(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.ssa_alerts
CREATE TABLE IF NOT EXISTS `ssa_alerts` (
  `text` tinytext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.ssa_data
CREATE TABLE IF NOT EXISTS `ssa_data` (
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `text` tinytext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.staff
CREATE TABLE IF NOT EXISTS `staff` (
  `userid` int(11) NOT NULL,
  `nickname` varchar(255) NOT NULL,
  `rank` int(11) NOT NULL,
  `developer` int(11) NOT NULL,
  `eventmanager` int(11) NOT NULL,
  `active` int(11) NOT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table csg-revamp.vehicles
CREATE TABLE IF NOT EXISTS `vehicles` (
  `uniqueid` int(11) NOT NULL AUTO_INCREMENT,
  `ownerid` int(11) NOT NULL,
  `vehicleid` int(11) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rotation` int(11) NOT NULL,
  `locked` int(11) NOT NULL,
  `vehiclehealth` int(11) NOT NULL,
  `paintjob` int(11) NOT NULL,
  `color1` varchar(11) NOT NULL,
  `color2` varchar(11) NOT NULL,
  `wheelstates` int(11) NOT NULL,
  `fuel` int(11) NOT NULL,
  `vehiclemods` varchar(11) NOT NULL,
  `spawned` int(11) NOT NULL,
  `boughtprice` int(11) NOT NULL,
  `licenseplate` varchar(11) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `uniqueid` (`uniqueid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
