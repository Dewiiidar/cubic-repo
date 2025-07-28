

CREATE DATABASE IF NOT EXISTS `i-queuedatabase`;
USE `i-queuedatabase`;

DROP TABLE IF EXISTS `act`;
CREATE TABLE `act` (
  `ActivationKey` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `IsActivated` varchar(50) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40000 ALTER TABLE `act` DISABLE KEYS */;
INSERT INTO `act` (`ActivationKey`,`IsActivated`) VALUES
 ('3K-1S00000-13854J4307G35G35G2IS3I093A28193A28193AJ','U1B73');
/*!40000 ALTER TABLE `act` ENABLE KEYS */;


DROP TABLE IF EXISTS `agentstatus`;
CREATE TABLE `agentstatus` (
  `StatusName` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '-',
  `Flag` int(11) unsigned NOT NULL DEFAULT '0',
  `Id` int(11) unsigned NOT NULL,
  `Deleted` int(10) unsigned NOT NULL DEFAULT '0',
  `comment` varchar(45) DEFAULT ' ',
  `MaxDuration` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `i-queuedatabase`.`agents`;
CREATE TABLE  `i-queuedatabase`.`agents` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT 'Name',
  `LoginId` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `Password` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `Extension` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `Status` int(11) unsigned NOT NULL DEFAULT '0',
  `StatusTime` varchar(100) NOT NULL DEFAULT '1900-01-01 00:00:00',
  `LastLiveTime` varchar(100) NOT NULL DEFAULT '1900-01-01 00:00:00',
  `HelpProvider` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT ' ',
  `LoginType` int(11) NOT NULL DEFAULT '0',
  `Agentlogs` varchar(45) NOT NULL DEFAULT '1',
  `ACWenabled` int(10) unsigned NOT NULL DEFAULT '0',
  `Active` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `UnLimitedLoginTime` int(10) unsigned NOT NULL DEFAULT '0',
  `StartLoginTime` varchar(45) NOT NULL DEFAULT '0',
  `EndLoginTime` varchar(45) NOT NULL DEFAULT '0',
  `VoiceMail` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `VoiceMailDel` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `Report` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `AllQueuesLogin` int(10) unsigned NOT NULL DEFAULT '1',
  `lastcomment` varchar(1000) DEFAULT NULL,
  `callerid` varchar(45) NOT NULL DEFAULT '',
  `CallSearch` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `AgentMonitor` tinyint(4) unsigned NOT NULL DEFAULT '0',
  KEY `Id` (`Id`),
  KEY `FK_agents_1` (`Status`),
  CONSTRAINT `FK_agents_1` FOREIGN KEY (`Status`) REFERENCES `agentstatus` (`Id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=latin1;


/*!40000 ALTER TABLE `agentstatus` DISABLE KEYS */;
INSERT INTO `agentstatus` (`StatusName`,`Flag`,`Id`,`Deleted`,`comment`,`MaxDuration`) VALUES 
('Logout', 0, 0, 0, '', 60),
('Ready', 0, 1, 0, '', 60),
('Active', 0, 2, 0, '', 60),
('Not Ready', 0, 3, 0, '', 60),
('ActiveOutBound', 0, 4, 0, '', 60),
('Away', 0, 5, 0, '', 60),
('Ringing', 0, 6, 0, '', 60),
('Need Help', 0, 7, 0, '', 60),
('Busy', 0, 8, 0, '', 60),
('Waiting', 0, 9, 0, '', 60),
('Login', 0, 10, 0, '', 60),
('Out Bound', 0, 11, 0, '', 60),
('ACW', 0, 12, 0, '', 60),
('Break', 1, 13, 0, '', 60),
('Supervision', 1, 14, 0, '', 60),
('OffBoard', 1, 15, 0, '', 60),
('Internal', 0, 999, 0, '', 60),
('Next Status Logout', 5, 1113, 0, '', 60),
('Next Status ACW', 5, 1114, 0, '', 60),
('Next Status OutBound', 5, 1115, 0, '', 60),
('Next Status NotReady', 5, 1116, 0, '', 60);
/*!40000 ALTER TABLE `agentstatus` ENABLE KEYS */;


DROP TABLE IF EXISTS `agentstatuslog`;
CREATE TABLE `agentstatuslog` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `AgentId` int(11) NOT NULL DEFAULT '0',
  `Status` int(11) unsigned NOT NULL DEFAULT '0',
  `StatusTime` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `StatusDuration` int(10) unsigned NOT NULL DEFAULT '0',
  `ShortCall` tinyint(1) NOT NULL DEFAULT '0',
  `comment` varchar(45) DEFAULT ' ',
  `Day` date DEFAULT NULL,
  `Time` time DEFAULT NULL,
  `QueueID` int(10) unsigned NOT NULL,
  `ByAgent` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_agentstatuslog_1` (`AgentId`),
  KEY `FK_agentstatuslog_2` (`Status`)
) ENGINE=InnoDB AUTO_INCREMENT=2402679 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `agentstatuslog_backup`;
CREATE TABLE `agentstatuslog_backup` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `AgentId` int(11) NOT NULL DEFAULT '0',
  `Status` int(11) unsigned NOT NULL DEFAULT '0',
  `StatusTime` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `StatusDuration` int(10) unsigned NOT NULL DEFAULT '0',
  `ShortCall` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  KEY `FK_agentstatuslog_backup_1` (`AgentId`),
  KEY `FK_agentstatuslog_backup_2` (`Status`),
  CONSTRAINT `FK_agentstatuslog_backup_1` FOREIGN KEY (`AgentId`) REFERENCES `agents` (`Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_agentstatuslog_backup_2` FOREIGN KEY (`Status`) REFERENCES `agentstatus` (`Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


/*!40000 ALTER TABLE `agentstatuslog_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `agentstatuslog_backup` ENABLE KEYS */;


DROP TABLE IF EXISTS `blacklist`;
CREATE TABLE `blacklist` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  `CallerID` varchar(45) NOT NULL,
  `Note` varchar(250) NOT NULL,
  `ProjectID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40000 ALTER TABLE `blacklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `blacklist` ENABLE KEYS */;



DROP TABLE IF EXISTS `callflow`;
CREATE TABLE `callflow` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ToNo` bigint(20) NOT NULL,
  `CallFlowPath` varchar(255) NOT NULL,
  `Name` longtext NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Id` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


/*!40000 ALTER TABLE `callflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `callflow` ENABLE KEYS */;


DROP TABLE IF EXISTS `callstatus`;
CREATE TABLE `callstatus` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Status` varchar(45) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*!40000 ALTER TABLE `callstatus` DISABLE KEYS */;
INSERT INTO `callstatus` (`Id`,`Status`) VALUES 
(1, 'Waiting'),
(2, 'Answered'),
(3, 'Abandoned'),
(4, 'Ended'),
(5, 'NightMode'),
(6, 'ShortEnded'),
(7, 'ShortAbandoned'),
(8, 'OutBound'),
(9, 'Recalled'),
(10, 'Failed'),
(11, 'NoAnswer'),
(12, 'Busy'),
(13, 'Dialing'),
(14, 'OutBoundDialer'),
(15, 'OutBoundAbandoned'),
(16, 'OutBoundWaiting'),
(17, 'OutBoundAnswered');
/*!40000 ALTER TABLE `callstatus` ENABLE KEYS */;


DROP TABLE IF EXISTS `campaign`;
CREATE TABLE `campaign` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  `StartTime` time NOT NULL,
  `EndTime` time NOT NULL,
  `BusyTrials` bigint(20) NOT NULL,
  `StartDate` datetime NOT NULL,
  `EndDate` datetime NOT NULL,
  `NoAnswerTrials` bigint(20) NOT NULL,
  `BusyWaitTime` bigint(20) NOT NULL,
  `NoAnswerWaitTime` bigint(20) NOT NULL,
  `ConcurrentCalls` bigint(20) NOT NULL,
  `Status` bigint(20) NOT NULL,
  `CallerId` varchar(45) NOT NULL,
  `FailTrials` bigint(20) NOT NULL,
  `FailWaitTime` bigint(20) NOT NULL,
  `CallFlowPath` varchar(255) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Id` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `chatmessage`;
CREATE TABLE `chatmessage` (
  `ID` double NOT NULL AUTO_INCREMENT,
  `OwnerID` int(10) unsigned DEFAULT NULL,
  `ChatWithID` int(10) unsigned DEFAULT NULL,
  `Conversation` text NOT NULL,
  `Chat_Date` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


/*!40000 ALTER TABLE `chatmessage` DISABLE KEYS */;
/*!40000 ALTER TABLE `chatmessage` ENABLE KEYS */;



DROP TABLE IF EXISTS `dashboard`;
CREATE TABLE `dashboard` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `UserID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `dashboarddetails`;
CREATE TABLE `dashboarddetails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `QueueIDs` varchar(100) NOT NULL,
  `Chart` tinyint(1) NOT NULL,
  `Agent` tinyint(1) NOT NULL,
  `Statistics` tinyint(1) unsigned NOT NULL,
  `ActiveCalls` tinyint(1) unsigned NOT NULL,
  `UserID` int(10) unsigned NOT NULL,
  `DashboardID` int(10) unsigned NOT NULL,
  `QueueNames` varchar(500) NOT NULL,
  `Disposition` tinyint(1) unsigned NOT NULL,
  `DispositionIDs` varchar(100) DEFAULT NULL,
  `DispostionNames` varchar(1000) DEFAULT NULL,
  `OutBoundActiveCalls` tinyint(1) unsigned NOT NULL,
  `OutBoundChart` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `disposition`;
CREATE TABLE `disposition` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Type` tinyint(3) unsigned NOT NULL,
  `dispositiontype` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `extensions`;
CREATE TABLE `extensions` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Extension` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


/*!40000 ALTER TABLE `extensions` DISABLE KEYS */;
/*!40000 ALTER TABLE `extensions` ENABLE KEYS */;


DROP TABLE IF EXISTS `groupmonitor`;
CREATE TABLE `groupmonitor` (
  `GroupId` int(10) unsigned NOT NULL,
  `MonitorId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`GroupId`,`MonitorId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `i-queuedatabase`.`agentgroups`;
CREATE TABLE  `i-queuedatabase`.`agentgroups` (
  `AgentId` int(11) NOT NULL,
  `GroupId` int(11) NOT NULL,
  PRIMARY KEY (`AgentId`,`GroupId`),
  KEY `FK_agentgroups_2` (`GroupId`),
  CONSTRAINT `FK_agentgroups_1` FOREIGN KEY (`AgentId`) REFERENCES `agents` (`Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_agentgroups_2` FOREIGN KEY (`GroupId`) REFERENCES `groups` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `ivr`;
CREATE TABLE `ivr` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `CardType` int(11) NOT NULL DEFAULT '5',
  `CardsNumber` int(11) NOT NULL DEFAULT '1',
  `PromptPath` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT ' ',
  `TransferString` varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT '&',
  `NoAnswerRings` int(11) NOT NULL DEFAULT '2',
  `AnswerRings` int(11) NOT NULL DEFAULT '1',
  `EntryFieldTimeOut` int(11) NOT NULL DEFAULT '5',
  `MaxTimeOnQueue` int(11) NOT NULL DEFAULT '5',
  `Logging` tinyint(4) NOT NULL DEFAULT '0',
  `VoiceMessagePath` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT ' ',
  `VoiceMail` tinyint(4) NOT NULL DEFAULT '0',
  `IsBackupEnable` tinyint(4) NOT NULL DEFAULT '0',
  `BackupTime` datetime NOT NULL DEFAULT '1900-01-01 20:00:00',
  `RubberTime` int(11) NOT NULL DEFAULT '5',
  `LocalIp` varchar(45) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  KEY `IX_IVR` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*!40000 ALTER TABLE `ivr` DISABLE KEYS */;
INSERT INTO `ivr` (`Id`,`CardType`,`CardsNumber`,`PromptPath`,`TransferString`,`NoAnswerRings`,`AnswerRings`,`EntryFieldTimeOut`,`MaxTimeOnQueue`,`Logging`,`VoiceMessagePath`,`VoiceMail`,`IsBackupEnable`,`BackupTime`,`RubberTime`,`LocalIp`) VALUES 
 (1,5,1,'D:\\Prompts\\','&',3,1,1,30,-1,'D:\\Recordings\\',0,-1,'1900-01-01 23:00:00',10,'10.0.0.89');
/*!40000 ALTER TABLE `ivr` ENABLE KEYS */;


DROP TABLE IF EXISTS `languages`;
CREATE TABLE `languages` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `LangPrefix` varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT 'Ar_',
  `Name` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '''''',
  `ProjectID` int(11) unsigned DEFAULT '1',
  `DigitPressed` varchar(45) DEFAULT '1',
  `Deleted` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs` (
  `Id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `UserId` int(4) NOT NULL DEFAULT '0',
  `Time` varchar(255) NOT NULL,
  `Date` varchar(255) NOT NULL,
  `Action` varchar(100) NOT NULL,
  `Description` varchar(255) NOT NULL,
  `FileName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=367947 DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `Content` text,
  `ToNames` varchar(1000) NOT NULL,
  `Subject` varchar(1000) DEFAULT NULL,
  `Date` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` (`ID`,`Content`,`ToNames`,`Subject`,`Date`) VALUES 
 (11,'<p>Dear ,</p>\r\n\r\n<p><span style=\"background-color:rgb(251, 251, 251); font-family:open sans,arial,helvetica,sans-serif\">At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.&nbsp;</span><br />\r\n<br />\r\n<span style=\"background-color:rgb(251, 251, 251); font-family:open sans,arial,helvetica,sans-serif\">Et harum quidem rerum facilis est et expedita distinctio lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut non libero consectetur adipiscing elit magna. Sed et quam lacus. Fusce condimentum eleifend enim a feugiat. Pellentesque viverra vehicula sem ut volutpat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut non libero magna. Sed et quam lacus. Fusce condimentum eleifend enim a feugiat.&nbsp;</span></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>yours ahmed</p>\r\n','Hesham Abd Allah,Sherif Ashraf,Admin,hoda,Ahmed mansour,Ahmed Tawfek,Islam Hanafy,Mohamed Abd Allah,Osama Sary','Hi IQUEUE for TEst','2016-03-10 14:35:13');
/*!40000 ALTER TABLE `message` ENABLE KEYS */;


DROP TABLE IF EXISTS `message_user`;
CREATE TABLE `message_user` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `Owner` int(10) unsigned DEFAULT NULL,
  `Receiver` int(10) unsigned NOT NULL,
  `Read` tinyint(3) unsigned NOT NULL,
  `DeletedByReceiver` tinyint(3) unsigned NOT NULL,
  `Subject` varchar(1000) DEFAULT NULL,
  `Date` date NOT NULL,
  `MessageID` bigint(20) unsigned NOT NULL,
  `ToNames` varchar(1000) NOT NULL,
  `DeletedByOwner` tinyint(3) unsigned NOT NULL,
  `Time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `FK_message_user_1` (`MessageID`),
  CONSTRAINT `FK_message_user_1` FOREIGN KEY (`MessageID`) REFERENCES `message` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `parser`;
CREATE TABLE `parser` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `LineLength` int(11) NOT NULL DEFAULT '0',
  `LineEnd` varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT '\\\\r',
  `Start` int(11) NOT NULL DEFAULT '0',
  `Length` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;


/*!40000 ALTER TABLE `parser` DISABLE KEYS */;
INSERT INTO `parser` (`Id`,`LineLength`,`LineEnd`,`Start`,`Length`) VALUES 
 (1,80,'\\r\\n      ',18,4);
/*!40000 ALTER TABLE `parser` ENABLE KEYS */;



DROP TABLE IF EXISTS `ports`;
CREATE TABLE `ports` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Extension` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `Logging` tinyint(4) NOT NULL DEFAULT '0',
  `PortType` int(11) unsigned NOT NULL DEFAULT '0',
  `ProjectID` int(11) unsigned DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7778 DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Deleted` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `queue_disposition`;
CREATE TABLE `queue_disposition` (
  `QueueID` int(10) unsigned NOT NULL,
  `DispositionID` int(10) unsigned NOT NULL,
  `CreationDate` datetime DEFAULT NULL,
  PRIMARY KEY (`QueueID`,`DispositionID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `queueagents`;
CREATE TABLE `queueagents` (
  `QueueId` int(11) NOT NULL DEFAULT '0',
  `AgentId` int(11) NOT NULL DEFAULT '0',
  `Agentpriority` int(11) unsigned DEFAULT '1',
  `QueuePriority` int(11) unsigned DEFAULT '1',
  PRIMARY KEY (`QueueId`,`AgentId`),
  KEY `FK_queueagents_2` (`AgentId`),
  CONSTRAINT `FK_queueagents_2` FOREIGN KEY (`AgentId`) REFERENCES `agents` (`Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `queues`;
CREATE TABLE `queues` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `LangId` varchar(45) DEFAULT NULL,
  `DigitPressed` varchar(45) NOT NULL DEFAULT '1',
  `Name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `SubQueue` tinyint(4) DEFAULT '-1',
  `ProjectID` int(11) unsigned DEFAULT '1',
  `Type` int(11) unsigned DEFAULT '0',
  `wrapuptime` int(11) unsigned DEFAULT '0',
  `Timeout` int(11) unsigned DEFAULT '0',
  `HuntGroupNo` varchar(255) NOT NULL,
  `Default` tinyint(4) unsigned DEFAULT '0',
  `MainQueueID` int(11) unsigned DEFAULT NULL,
  `MaxCallsOnHold` int(11) unsigned DEFAULT '0',
  `Deleted` int(10) unsigned NOT NULL DEFAULT '0',
  `ACW` int(10) unsigned NOT NULL DEFAULT '0',
  `DirectNO` varchar(45) DEFAULT NULL,
  `maxholdtransfer` varchar(45) NOT NULL DEFAULT '0',
  `ext` varchar(45) NOT NULL DEFAULT '0',
  `actionmodeto` varchar(45) NOT NULL DEFAULT '0',
  `actionmodemc` varchar(45) NOT NULL DEFAULT '0',
  `transferto` varchar(45) NOT NULL DEFAULT '0',
  `transfertomc` varchar(45) NOT NULL DEFAULT '0',
  `servicelevel` varchar(45) NOT NULL DEFAULT '0',
  `shortcallduration` varchar(45) NOT NULL DEFAULT '0',
  `Announce` int(10) unsigned NOT NULL DEFAULT '0',
  `TransfertoTO` varchar(45) NOT NULL DEFAULT '',
  `CampaignId` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_queues_2` (`ProjectID`),
  CONSTRAINT `FK_queues_2` FOREIGN KEY (`ProjectID`) REFERENCES `projects` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `periodssettings`;
CREATE TABLE `periodssettings` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `QueueId` int(11) NOT NULL DEFAULT '1',
  `Day` varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT 'Fri',
  `OperationMode` int(11) NOT NULL DEFAULT '1',
  `From1` varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT '09:00:00',
  `To1` varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT '17:00:00',
  `From2` varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT '09:00:00',
  `To2` varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT '17:00:00',
  `From3` varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT '09:00:00',
  `To3` varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT '17:00:00',
  `Actionmode` tinyint(4) unsigned DEFAULT '0',
  `TransferTo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_periodssettings_1` (`QueueId`),
  CONSTRAINT `FK_periodssettings_1` FOREIGN KEY (`QueueId`) REFERENCES `queues` (`Id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `queuemonitor`;
CREATE TABLE `queuemonitor` (
  `QueueId` int(11) NOT NULL DEFAULT '0',
  `AgentId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`QueueId`,`AgentId`),
  KEY `FK_queuemonitor_2` (`AgentId`),
  CONSTRAINT `FK_queuemonitor_1` FOREIGN KEY (`QueueId`) REFERENCES `queues` (`Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_queuemonitor_2` FOREIGN KEY (`AgentId`) REFERENCES `agents` (`Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `schedulegroup`;
CREATE TABLE `schedulegroup` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `schedulegroupagents`;
CREATE TABLE `schedulegroupagents` (
  `AgentId` int(11) unsigned NOT NULL,
  `GroupId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`AgentId`,`GroupId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


/*!40000 ALTER TABLE `schedulegroupagents` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedulegroupagents` ENABLE KEYS */;



DROP TABLE IF EXISTS `schedulegroupdetails`;
CREATE TABLE `schedulegroupdetails` (
  `GroupId` int(11) unsigned NOT NULL,
  `StatusId` int(11) unsigned NOT NULL,
  `Details` varchar(45) NOT NULL,
  PRIMARY KEY (`GroupId`,`StatusId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `scripts`;
CREATE TABLE `scripts` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Script` varchar(1024) NOT NULL,
  `QueueId` int(10) NOT NULL,
  `StartTime` varchar(45) NOT NULL,
  `EndTime` varchar(45) NOT NULL,
  `IsURL` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  KEY `FK_scripts_1` (`QueueId`),
  CONSTRAINT `FK_scripts_1` FOREIGN KEY (`QueueId`) REFERENCES `queues` (`Id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `serialport`;
CREATE TABLE `serialport` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ComPort` varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT 'COM1',
  `BoudRate` int(11) NOT NULL DEFAULT '9600',
  `Parity` varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT 'None',
  `DataBits` int(11) NOT NULL DEFAULT '8',
  `StopBits` varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT 'N''One''',
  `FlowControl` varchar(15) CHARACTER SET utf8 NOT NULL DEFAULT 'None',
  `Logging` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;



/*!40000 ALTER TABLE `serialport` DISABLE KEYS */;
INSERT INTO `serialport` (`Id`,`ComPort`,`BoudRate`,`Parity`,`DataBits`,`StopBits`,`FlowControl`,`Logging`) VALUES 
 (1,'COM1',19200,'None',8,'1','None',0);
/*!40000 ALTER TABLE `serialport` ENABLE KEYS */;



DROP TABLE IF EXISTS `sheets`;
CREATE TABLE `sheets` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` longtext NOT NULL,
  `Prefix` longtext,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Id` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


/*!40000 ALTER TABLE `sheets` DISABLE KEYS */;
/*!40000 ALTER TABLE `sheets` ENABLE KEYS */;


DROP TABLE IF EXISTS `smdroutboundcalls`;
CREATE TABLE `smdroutboundcalls` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `AgentId` int(11) NOT NULL DEFAULT '0',
  `Extension` varchar(5) CHARACTER SET utf8 NOT NULL DEFAULT ' ',
  `PhoneNumber` varchar(15) CHARACTER SET utf8 NOT NULL DEFAULT ' ',
  `DialTime` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `Duration` int(11) NOT NULL DEFAULT '0',
  `Quarter` varchar(45) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `Id` (`Id`),
  KEY `FK_outboundcalls_1` (`AgentId`),
  CONSTRAINT `FK_outboundcalls_1` FOREIGN KEY (`AgentId`) REFERENCES `agents` (`Id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45192 DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `outboundcalls`;
CREATE TABLE `outboundcalls` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `CalledId` varchar(45) NOT NULL,
  `Status` varchar(45) DEFAULT NULL,
  `BusyTrials` bigint(20) DEFAULT NULL,
  `NoAnswerTrials` bigint(20) DEFAULT NULL,
  `ToCallTime` datetime DEFAULT NULL,
  `FailedTrials` bigint(20) DEFAULT NULL,
  `campaignId` int(11) NOT NULL,
  `SheetsId` int(11) NOT NULL,
  `statustime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CustomerId` int(11) NOT NULL DEFAULT '0',
  `AgentId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Id` (`Id`),
  KEY `IX_FK_outboundcallcampaign` (`campaignId`),
  KEY `IX_FK_outboundcallSheets` (`SheetsId`),
  CONSTRAINT `FK_outboundcallSheets` FOREIGN KEY (`SheetsId`) REFERENCES `sheets` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_outboundcallcampaign` FOREIGN KEY (`campaignId`) REFERENCES `campaign` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `outboundcalls` DISABLE KEYS */;
/*!40000 ALTER TABLE `outboundcalls` ENABLE KEYS */;
--
-- Definition of table `todaycalls`
--

DROP TABLE IF EXISTS `todaycalls`;
CREATE TABLE `todaycalls` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `PortId` int(11) NOT NULL DEFAULT '0',
  `ReceivingTime` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `StartTime` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `EndTime` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `WaitingTime` int(10) unsigned NOT NULL DEFAULT '0',
  `TalkingTime` int(10) unsigned NOT NULL DEFAULT '0',
  `TotalTime` int(10) unsigned NOT NULL DEFAULT '0',
  `AgentId` int(11) DEFAULT '0',
  `Extension` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `CallerId` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `QueueId` int(11) NOT NULL DEFAULT '0',
  `NightMode` int(11) NOT NULL DEFAULT '0',
  `ProjectId` int(10) unsigned NOT NULL DEFAULT '0',
  `CallId` varchar(255) NOT NULL DEFAULT '0',
  `Status` int(10) unsigned NOT NULL,
  `HoursInterval` int(11) unsigned NOT NULL,
  `QuarterInterval` varchar(45) NOT NULL,
  `OldStatus` int(11) unsigned NOT NULL DEFAULT '0',
  `Day` datetime NOT NULL,
  `Time` time NOT NULL,
  `dispositionId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_todaycalls_1` (`PortId`),
  KEY `FK_todaycalls_2` (`AgentId`),
  KEY `FK_todaycalls_3` (`QueueId`),
  KEY `FK_todaycalls_4` (`ProjectId`),
  KEY `FK_todaycalls_5` (`Status`),
  CONSTRAINT `FK_todaycalls_1` FOREIGN KEY (`PortId`) REFERENCES `ports` (`Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_todaycalls_2` FOREIGN KEY (`AgentId`) REFERENCES `agents` (`Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_todaycalls_3` FOREIGN KEY (`QueueId`) REFERENCES `queues` (`Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_todaycalls_4` FOREIGN KEY (`ProjectId`) REFERENCES `projects` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `FK_todaycalls_5` FOREIGN KEY (`Status`) REFERENCES `callstatus` (`Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `todaycalls`
--

/*!40000 ALTER TABLE `todaycalls` DISABLE KEYS */;
/*!40000 ALTER TABLE `todaycalls` ENABLE KEYS */;


--
-- Definition of table `usertype`
--

DROP TABLE IF EXISTS `usertype`;
CREATE TABLE `usertype` (
  `Id` int(10) unsigned NOT NULL,
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usertype`
--

/*!40000 ALTER TABLE `usertype` DISABLE KEYS */;
INSERT INTO `usertype` (`Id`,`Name`) VALUES 
 (1,'admin'),
 (2,'supervisor'),
 (3,'agent'),
 (4,'Reporter');
/*!40000 ALTER TABLE `usertype` ENABLE KEYS */;


--
-- Definition of table `viplist`
--

DROP TABLE IF EXISTS `viplist`;
CREATE TABLE `viplist` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  `CallerID` varchar(45) NOT NULL,
  `Note` varchar(250) NOT NULL,
  `ProjectID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `voicemail`;
CREATE TABLE `voicemail` (
  `Date` datetime NOT NULL,
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `FilePath` varchar(100) NOT NULL,
  `QueueId` int(10) unsigned NOT NULL,
  `ProjectId` int(10) unsigned NOT NULL,
  `LangId` int(10) unsigned NOT NULL,
  `Comment` varchar(100) NOT NULL DEFAULT '0',
  `CallerId` varchar(100) DEFAULT NULL,
  `TelphoneNumber` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=255 DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `calls`;
CREATE TABLE `calls` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `PortId` int(11) NOT NULL DEFAULT '0',
  `ReceivingTime` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `StartTime` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `EndTime` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `WaitingTime` int(10) unsigned NOT NULL DEFAULT '0',
  `TalkingTime` int(10) unsigned NOT NULL DEFAULT '0',
  `TotalTime` int(10) unsigned NOT NULL DEFAULT '0',
  `AgentId` int(11) DEFAULT '0',
  `Extension` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `CallerId` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `QueueId` int(11) NOT NULL DEFAULT '0',
  `NightMode` int(11) NOT NULL DEFAULT '0',
  `ProjectId` int(11) unsigned NOT NULL DEFAULT '0',
  `CallId` varchar(255) NOT NULL DEFAULT '0',
  `Status` int(11) unsigned NOT NULL,
  `HoursInterval` int(11) unsigned NOT NULL,
  `QuarterInterval` varchar(45) NOT NULL,
  `oldstatus` int(11) unsigned NOT NULL,
  `Day` date DEFAULT NULL,
  `Time` time DEFAULT NULL,
  `dispositionId` int(10) unsigned NOT NULL DEFAULT '0',
  `outboundcallid` int(11) DEFAULT NULL,
  `DialingTime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  KEY `FK_calls_1` (`PortId`),
  KEY `FK_calls_2` (`AgentId`),
  KEY `FK_calls_3` (`QueueId`),
  KEY `FK_calls_4` (`ProjectId`),
  KEY `FK_calls_5` (`Status`),
  KEY `Index_7` (`Day`),
  KEY `Index_8` (`Time`),
  KEY `Index_9` (`ReceivingTime`),
  KEY `Index_10` (`WaitingTime`),
  KEY `Index_11` (`TalkingTime`),
  KEY `FK_calls_6` (`dispositionId`),
  KEY `FK_calls_7` (`outboundcallid`),
  CONSTRAINT `FK_calls_1` FOREIGN KEY (`PortId`) REFERENCES `ports` (`Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_calls_2` FOREIGN KEY (`AgentId`) REFERENCES `agents` (`Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_calls_3` FOREIGN KEY (`QueueId`) REFERENCES `queues` (`Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_calls_4` FOREIGN KEY (`ProjectId`) REFERENCES `projects` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `FK_calls_5` FOREIGN KEY (`Status`) REFERENCES `callstatus` (`Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_calls_6` FOREIGN KEY (`dispositionId`) REFERENCES `disposition` (`Id`),
  CONSTRAINT `FK_calls_7` FOREIGN KEY (`outboundcallid`) REFERENCES `outboundcalls` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=937923 DEFAULT CHARSET=latin1;
--
-- Dumping data for table `voicemail`
--

