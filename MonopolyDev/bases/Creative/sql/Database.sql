-- Copiando estrutura do banco de dados para vrpx
CREATE DATABASE IF NOT EXISTS `creative` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `creative`;

DROP TABLE IF EXISTS `accounts`;
CREATE TABLE IF NOT EXISTS `accounts` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `Whitelist` tinyint(1) NOT NULL DEFAULT 0,
    `Characters` int(10) NOT NULL DEFAULT 1,
    `Gemstone` int(20) NOT NULL DEFAULT 0,
    `Premium` int(20) NOT NULL DEFAULT 0,
    `Rolepass` int(20) NOT NULL DEFAULT 0,
    `Discord` varchar(50) NOT NULL DEFAULT '0',
    `License` varchar(50) NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `License` (`License`),
    KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `banneds`;
CREATE TABLE IF NOT EXISTS `banneds` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `License` varchar(50) NOT NULL,
    `Token` varchar(255) NOT NULL,
    `Time` int(20) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `characters`;
CREATE TABLE IF NOT EXISTS `characters` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `License` varchar(50) DEFAULT NULL,
    `Phone` varchar(10) DEFAULT NULL,
    `Name` varchar(50) DEFAULT 'Individuo',
    `Lastname` varchar(50) DEFAULT 'Indigente',
    `Sex` varchar(1) NOT NULL DEFAULT 'M',
    `Bank` int(20) NOT NULL DEFAULT 5000,
    `Fines` int(20) NOT NULL DEFAULT 0,
    `Taxs` int(20) NOT NULL DEFAULT 0,
    `Blood` int(1) NOT NULL DEFAULT 1,
    `Prison` int(10) NOT NULL DEFAULT 0,
    `Gun` int(1) NOT NULL DEFAULT 0,
    `Likes` int(20) NOT NULL DEFAULT 0,
    `Unlikes` int(20) NOT NULL DEFAULT 0,
    `Medic` int(20) NOT NULL DEFAULT 0,
    `Driver` int(20) NOT NULL DEFAULT 0,
    `Created` int(20) NOT NULL DEFAULT 0,
    `Deleted` int(1) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `license` (`License`),
    KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `chests`;
CREATE TABLE IF NOT EXISTS `chests` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `Name` varchar(50) NOT NULL,
    `Weight` int(10) NOT NULL DEFAULT 500,
    `Slots` int(20) NOT NULL DEFAULT 50,
    `Permission` varchar(50) NOT NULL DEFAULT 'Admin',
    `Premium` int(20) NOT NULL DEFAULT 0,
    `Bank` int(20) NOT NULL DEFAULT 0,
    `Logs` tinyint(1) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `entitydata`;
CREATE TABLE IF NOT EXISTS `entitydata` (
    `Name` varchar(100) NOT NULL,
    `Information` longtext DEFAULT NULL,
    PRIMARY KEY (`Name`),
    KEY `Information` (`Name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `entitydata` (`Name`, `Information`) VALUES
('Permissions:Admin', '{\"1\":1}');

DROP TABLE IF EXISTS `fidentity`;
CREATE TABLE IF NOT EXISTS `fidentity` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `Name` varchar(50) NOT NULL DEFAULT '',
    `Lastname` varchar(50) NOT NULL DEFAULT '',
    `Gun` int(1) NOT NULL DEFAULT 1,
    `Blood` int(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (`id`),
    KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `playerdata`;
CREATE TABLE IF NOT EXISTS `playerdata` (
    `Passport` int(10) NOT NULL,
    `Name` varchar(100) NOT NULL,
    `Information` longtext DEFAULT NULL,
    PRIMARY KEY (`Passport`,`Name`),
    KEY `Passport` (`Passport`),
    KEY `Information` (`Name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `propertys`;
CREATE TABLE IF NOT EXISTS `propertys` (
    `id` int(20) NOT NULL AUTO_INCREMENT,
    `Name` varchar(20) NOT NULL DEFAULT 'Homes0001',
    `Interior` varchar(20) NOT NULL DEFAULT 'Middle',
    `Item` int(3) NOT NULL DEFAULT 3,
    `Tax` int(20) NOT NULL DEFAULT 0,
    `Passport` int(11) NOT NULL DEFAULT 0,
    `Serial` varchar(10) NOT NULL,
    `Vault` int(6) NOT NULL DEFAULT 1,
    `Fridge` int(6) NOT NULL DEFAULT 1,
    `Garage` longtext DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `id` (`id`),
    KEY `Passport` (`Passport`),
    KEY `Name` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `races`;
CREATE TABLE IF NOT EXISTS `races` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `Race` int(3) NOT NULL DEFAULT 0,
    `Passport` int(5) NOT NULL DEFAULT 0,
    `Name` varchar(100) NOT NULL DEFAULT 'Individuo Indigente',
    `Vehicle` varchar(50) NOT NULL DEFAULT 'Sultan RS',
    `Points` int(20) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `Passport` (`Passport`),
    KEY `Race` (`Race`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE IF NOT EXISTS `vehicles` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `Passport` int(11) NOT NULL,
    `vehicle` varchar(100) NOT NULL,
    `tax` int(20) NOT NULL DEFAULT 0,
    `plate` varchar(10) DEFAULT NULL,
    `rental` int(20) NOT NULL DEFAULT 0,
    `arrest` int(20) NOT NULL DEFAULT 0,
    `dismantle` int(20) NOT NULL DEFAULT 0,
    `engine` int(4) NOT NULL DEFAULT 1000,
    `body` int(4) NOT NULL DEFAULT 1000,
    `health` int(4) NOT NULL DEFAULT 1000,
    `fuel` int(3) NOT NULL DEFAULT 100,
    `nitro` int(5) NOT NULL DEFAULT 0,
    `work` varchar(5) NOT NULL DEFAULT 'false',
    `mode` varchar(9) NOT NULL DEFAULT 'normal',
    `doors` longtext NOT NULL,
    `windows` longtext NOT NULL,
    `tyres` longtext NOT NULL,
    `brakes` longtext NOT NULL,
    `drift` tinyint(1) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `Passport` (`Passport`),
    KEY `vehicle` (`vehicle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `warehouse`;
CREATE TABLE IF NOT EXISTS `warehouse` (
    `id` int(20) NOT NULL AUTO_INCREMENT,
    `Name` varchar(50) NOT NULL,
    `Weight` int(20) NOT NULL DEFAULT 100,
    `Password` varchar(50) NOT NULL,
    `Passport` int(10) NOT NULL DEFAULT 0,
    `Tax` int(20) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `Passport` (`Passport`),
    KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `fines`;
CREATE TABLE IF NOT EXISTS `fines` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `Passport` int(10) NOT NULL DEFAULT 0,
    `Name` varchar(50) NOT NULL,
    `Date` varchar(50) NOT NULL,
    `Hour` varchar(50) NOT NULL,
    `Value` int(11) NOT NULL,
    `Message` longtext DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `Passport` (`Passport`),
    KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `investments`;
CREATE TABLE IF NOT EXISTS `investments` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `Passport` int(10) NOT NULL DEFAULT 0,
    `Liquid` int(20) NOT NULL DEFAULT 0,
    `Monthly` int(20) NOT NULL DEFAULT 0,
    `Deposit` int(20) NOT NULL DEFAULT 0,
    `Last` int(20) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `Passport` (`Passport`),
    KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `invoices`;
CREATE TABLE IF NOT EXISTS `invoices` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `Passport` int(10) NOT NULL DEFAULT 0,
    `Received` int(10) NOT NULL DEFAULT 0,
    `Type` varchar(50) NOT NULL,
    `Reason` longtext NOT NULL,
    `Holder` varchar(50) NOT NULL,
    `Value` int(11) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `Passport` (`Passport`),
    KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `taxs`;
CREATE TABLE IF NOT EXISTS `taxs` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `Passport` int(10) NOT NULL DEFAULT 0,
    `Name` varchar(50) NOT NULL,
    `Date` varchar(50) NOT NULL,
    `Hour` varchar(50) NOT NULL,
    `Value` int(11) NOT NULL,
    `Message` longtext DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `Passport` (`Passport`),
    KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE IF NOT EXISTS `transactions` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `Passport` int(10) NOT NULL DEFAULT 0,
    `Type` varchar(50) NOT NULL,
    `Date` varchar(50) NOT NULL,
    `Value` int(11) NOT NULL,
    `Balance` int(11) NOT NULL,
    `Timeset` int(20) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `Passport` (`Passport`),
    KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `painel`;
CREATE TABLE IF NOT EXISTS `painel` (
    `id` int(20) NOT NULL AUTO_INCREMENT,
    `Passport` int(10) NOT NULL DEFAULT 0,
    `Permission` varchar(50) NOT NULL,
    `Type` varchar(50) NOT NULL,
    `Price` int(20) NOT NULL,
    `Timeset` int(20) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `Permission` (`Permission`),
    KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `police_prison` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `police` varchar(255) DEFAULT '0',
    `nuser_id` int(11) NOT NULL DEFAULT '0',
    `services` int(11) NOT NULL DEFAULT '0',
    `fines` int(20) NOT NULL DEFAULT '0',
    `text` longtext,
    `date` text,
    `cops` longtext NOT NULL DEFAULT '0',
    `association` longtext NOT NULL DEFAULT '0',
    `residual` text,
    `url` longtext,
    PRIMARY KEY (`id`),
    KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `police_gunlicense` (
    `portId` int(11) NOT NULL AUTO_INCREMENT,
    `identity` longtext,
    `user_id` text,
    `portType` longtext,
    `serial` longtext,
    `nidentity` longtext,
    `weapon` longtext,
    `exam` longtext,
    `date` text,
    PRIMARY KEY (`portId`),
    KEY `portId` (`portId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `police_reports` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `victim_id` text,
    `police_name` text,
    `solved` text,
    `victim_name` text,
    `created_at` text,
    `victim_report` text,
    `updated_at` text,
    PRIMARY KEY (`id`),
    KEY `portId` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `police_warrants` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `user_id` text,
    `identity` text,
    `status` text,
    `nidentity` text,
    `timeStamp` text,
    `reason` text,
    PRIMARY KEY (`id`),
    KEY `portId` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;