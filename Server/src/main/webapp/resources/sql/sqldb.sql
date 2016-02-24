drop database secsm;
create database secsm;

use secsm;

CREATE TABLE `account` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Pw` varchar(50) NOT NULL,
  `Px_amount` int(11) DEFAULT '0',
  `Phone` varchar(45) NOT NULL,
  `Grade` int(11) DEFAULT NULL,
  `gender` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='사용자 정보';

CREATE TABLE `attendance` (
  `Account_id` int(11) DEFAULT NULL,
  `RegDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `attendance_account_id_idx` (`Account_id`),
  CONSTRAINT `attendance_account_id` FOREIGN KEY (`Account_id`) REFERENCES `account` (`ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='출석 관리';

CREATE TABLE `duty` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DutyDate` timestamp NULL DEFAULT NULL,
  `Account_id1` int(11) DEFAULT NULL,
  `Account_id2` int(11) DEFAULT NULL,
  `Account_id3` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `duty_account_id1_idx` (`Account_id1`),
  KEY `duty_account_id2_idx` (`Account_id2`),
  KEY `duty_account_id3_idx` (`Account_id3`),
  CONSTRAINT `duty_account_id1` FOREIGN KEY (`Account_id1`) REFERENCES `account` (`ID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `duty_account_id2` FOREIGN KEY (`Account_id2`) REFERENCES `account` (`ID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `duty_account_id3` FOREIGN KEY (`Account_id3`) REFERENCES `account` (`ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='당직';

CREATE TABLE `notice` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RegDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Title` varchar(50) DEFAULT NULL,
  `Context` text,
  `Account_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `notice_account_id_idx` (`Account_id`),
  CONSTRAINT `notice_account_id` FOREIGN KEY (`Account_id`) REFERENCES `account` (`ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='공지사항';

CREATE TABLE `project` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `StartDate` timestamp NULL DEFAULT NULL,
  `EndDate` timestamp NULL DEFAULT NULL,
  `PL` varchar(50) DEFAULT NULL,
  `Team1` varchar(50) DEFAULT NULL,
  `Team2` varchar(50) DEFAULT NULL,
  `Team3` varchar(50) DEFAULT NULL,
  `Team4` varchar(50) DEFAULT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Summary` varchar(100) DEFAULT NULL,
  `Description` varchar(200) DEFAULT NULL,
  `RegDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='프로젝트';

CREATE TABLE `px_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `px_items` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL,
  `Code` varchar(100) DEFAULT NULL,
  `Price` int(11) DEFAULT NULL,
  `Description` varchar(200) DEFAULT NULL,
  `Count` int(11) DEFAULT NULL,
  UNIQUE KEY (`Code`),
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='PX 상품';

CREATE TABLE `px_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Account_id` int(11) DEFAULT NULL,
  `Px_Items_id` int(11) DEFAULT NULL,
  `RegDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Type` int(11) DEFAULT NULL,
  `Count` int(11) DEFAULT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Price` int(11) DEFAULT NULL,
  
  PRIMARY KEY (`ID`),
  KEY `px_log_px_items_id_idx` (`Px_Items_id`),
  KEY `px_log_account_id_idx` (`Account_id`),
  CONSTRAINT `px_log_account_id` FOREIGN KEY (`Account_id`) REFERENCES `account` (`ID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `px_log_px_items_id` FOREIGN KEY (`Px_Items_id`) REFERENCES `px_items` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='PX 상품 구매 기록';


CREATE TABLE `px_req` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Account_id` int(11) DEFAULT NULL,
  `Title` varchar(50) DEFAULT NULL,
  `Context` varchar(200) DEFAULT NULL,
  `RegDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Status` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `px_req_account_id_idx` (`Account_id`),
  CONSTRAINT `px_req_account_id` FOREIGN KEY (`Account_id`) REFERENCES `account` (`ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='px 상품 요청';

CREATE TABLE `question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `regDate` timestamp NULL DEFAULT NULL,
  `accountId` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `endDate` timestamp NULL DEFAULT NULL,
  `startDate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_question_id_idx` (`accountId`),
  CONSTRAINT `account_question_id` FOREIGN KEY (`accountId`) REFERENCES `account` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='설문지';

CREATE TABLE `question_choice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) DEFAULT NULL,
  `p1` text,
  `p2` text,
  `p3` text,
  `p4` text,
  `p5` text,
  `problom` text,
  `regDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `question_choice_idx` (`question_id`),
  CONSTRAINT `question_choice` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='객관식';

CREATE TABLE `question_date` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) DEFAULT NULL,
  `problom` text,
  `regDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `question_date_id_idx` (`question_id`),
  CONSTRAINT `question_date_id` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='날짜';

CREATE TABLE `question_essay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) DEFAULT NULL,
  `problom` text,
  `regDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `question_essay_id_idx` (`question_id`),
  CONSTRAINT `question_essay_id` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='주관식';

CREATE TABLE `question_score` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) DEFAULT NULL,
  `problom` text,
  `regDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `question_score_id_idx` (`question_id`),
  CONSTRAINT `question_score_id` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='점수 평가';

CREATE TABLE `question_time` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) DEFAULT NULL,
  `problom` text,
  `regDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `question_time_id_idx` (`question_id`),
  CONSTRAINT `question_time_id` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='시간';

CREATE TABLE `book_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='도서 카테고리';

CREATE TABLE `book_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `publisher` varchar(50) DEFAULT NULL,
  `author` varchar(50) DEFAULT NULL,
  `imageURL` varchar(100) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `regDate` timestamp NULL DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `totalCount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `book_category_items_idx` (`type`),
  CONSTRAINT `book_category_items` FOREIGN KEY (`type`) REFERENCES `book_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='도서';

CREATE TABLE `book_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `book_items_id` int(11) DEFAULT NULL,
  `startDate` timestamp NULL DEFAULT NULL,
  `endDate` timestamp NULL DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_book_id_idx` (`account_id`),
  KEY `book_items_id_idx` (`book_items_id`),
  CONSTRAINT `account_book_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `book_items_id` FOREIGN KEY (`book_items_id`) REFERENCES `book_items` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `book_req` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `publisher` varchar(50) DEFAULT NULL,
  `author` varchar(50) DEFAULT NULL,
  `link` varchar(100) DEFAULT NULL,
  `imageURL` varchar(100) DEFAULT NULL,
  `pay` int(20) DEFAULT NULL,
  `regdate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_book_log_id_idx` (`account_id`),
  CONSTRAINT `account_book_log_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `equipment_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='장비 분류 카테고리';

CREATE TABLE `equipment_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `manufacturer` varchar(50) DEFAULT NULL,
  `imageURL` varchar(100) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `regDate` timestamp NULL DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `totalCount` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `equipment_category_items_idx` (`type`),
  CONSTRAINT `equipment_category_items` FOREIGN KEY (`type`) REFERENCES `equipment_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='장비';

CREATE TABLE `equipment_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Account_id` int(11) DEFAULT NULL,
  `Equipment_items_id` int(11) DEFAULT NULL,
  `StartDate` timestamp NULL DEFAULT NULL,
  `EndDate` timestamp NULL DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `equipment_log_account_id_idx` (`Account_id`),
  KEY `equipment_log_equipment_items_id_idx` (`Equipment_items_id`),
  CONSTRAINT `equipment_log_account_id` FOREIGN KEY (`Account_id`) REFERENCES `account` (`ID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `equipment_log_equipment_items_id` FOREIGN KEY (`Equipment_items_id`) REFERENCES `equipment_items` (`ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='장비 대여 기록';

CREATE TABLE `equipment_req` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `typeKr` varchar(50) DEFAULT NULL,
  `typeEn` varchar(50) DEFAULT NULL,
  `titleKr` varchar(100) DEFAULT NULL,
  `titleEn` varchar(100) DEFAULT NULL,
  `brand` varchar(50) DEFAULT NULL,
  `link` varchar(100) DEFAULT NULL,
  `pay` int(20) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `content` varchar(150) DEFAULT NULL,
  `regdate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `equipment_req_account_id_idx` (`account_id`),
  KEY `equipment_req_project_id_idx` (`project_id`),
  CONSTRAINT `equipment_req_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`ID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `equipment_req_project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='장비 신청';

CREATE TABLE `secsm`.`attach` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `projectId` INT NULL,
  `path` VARCHAR(256) NULL,
  PRIMARY KEY (`id`),
  INDEX `project_attach_id_idx` (`projectId` ASC),
  CONSTRAINT `project_attach_id`
    FOREIGN KEY (`projectId`)
    REFERENCES `secsm`.`project` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
COMMENT = '첨부파일 목록';

CREATE TABLE `answer_choice` (
  `id` int(11) NOT NULL,
  `question_id` int(11) DEFAULT NULL,
  `answer` int(11) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `answer_choice_id_idx` (`question_id`),
  KEY `account_choice_id_idx` (`account_id`),
  CONSTRAINT `account_choice_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `answer_choice_id` FOREIGN KEY (`question_id`) REFERENCES `question_choice` (`question_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='객관식 답';


CREATE TABLE `answer_date` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `answer` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_date_id_idx` (`account_id`),
  KEY `answer_date_id_idx` (`question_id`),
  CONSTRAINT `account_date_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `answer_date_id` FOREIGN KEY (`question_id`) REFERENCES `question_date` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='날짜 답';

CREATE TABLE `answer_essay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) DEFAULT NULL,
  `answer` text,
  `account_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `answer_essay_id_idx` (`question_id`),
  KEY `account_essay_id_idx` (`account_id`),
  CONSTRAINT `account_essay_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `answer_essay_id` FOREIGN KEY (`question_id`) REFERENCES `question_essay` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='주관식 답';

CREATE TABLE `answer_score` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `answer` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_score_id_idx` (`account_id`),
  KEY `answer_score_id_idx` (`question_id`),
  CONSTRAINT `account_score_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `answer_score_id` FOREIGN KEY (`question_id`) REFERENCES `question_score` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='점수 답';

CREATE TABLE `answer_time` (
  `id` int(11) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `answer` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_answer_time_idx` (`account_id`),
  KEY `question_time_id_idx` (`question_id`),
  CONSTRAINT `account_answer_time` FOREIGN KEY (`account_id`) REFERENCES `account` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `answer_time_id` FOREIGN KEY (`question_id`) REFERENCES `question_time` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='시간 답';


ALTER TABLE `secsm`.`attach` 
ADD COLUMN `name` VARCHAR(100) NULL AFTER `path`;

ALTER TABLE `secsm`.`attach` 
ADD COLUMN `tag` VARCHAR(100) NULL AFTER `name`;

ALTER TABLE `secsm`.`attach` 
DROP FOREIGN KEY `project_attach_id`;
ALTER TABLE `secsm`.`attach` 
CHANGE COLUMN `projectId` `project_id` INT(11) NULL DEFAULT NULL ;
ALTER TABLE `secsm`.`attach` 
ADD CONSTRAINT `project_attach_id`
  FOREIGN KEY (`project_id`)
  REFERENCES `secsm`.`project` (`ID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `secsm`.`question_choice` 
CHANGE COLUMN `p1` `q1` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `p2` `q2` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `p3` `q3` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `p4` `q4` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `p5` `q5` TEXT NULL DEFAULT NULL ;

ALTER TABLE `secsm`.`project` 
ADD COLUMN `account_id` INT NULL AFTER `status`,
ADD INDEX `project_account_id_idx` (`account_id` ASC);
ALTER TABLE `secsm`.`project` 
ADD CONSTRAINT `project_account_id`
  FOREIGN KEY (`account_id`)
  REFERENCES `secsm`.`account` (`ID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `secsm`.`answer_time` 
CHANGE COLUMN `answer` `answer` VARCHAR(100) NULL DEFAULT NULL ;

ALTER TABLE `secsm`.`answer_date` 
CHANGE COLUMN `answer` `answer` VARCHAR(100) NULL DEFAULT NULL ;

ALTER TABLE `secsm`.`answer_time` 
CHANGE COLUMN `id` `id` INT(11) NOT NULL AUTO_INCREMENT ;
ALTER TABLE `secsm`.`answer_choice` 
CHANGE COLUMN `id` `id` INT(11) NOT NULL AUTO_INCREMENT ;

ALTER TABLE `secsm`.`project` 
CHANGE COLUMN `Summary` `Summary` VARCHAR(400) NULL DEFAULT NULL COMMENT '' ,
CHANGE COLUMN `Description` `Description` TEXT NULL DEFAULT NULL COMMENT '' ;

INSERT INTO `secsm`.`account` (`Name`, `Email`, `Pw`, `Px_amount`, `Phone`, `Grade`, `gender`) VALUES ('교육부장', '교육부장', '1234', '10000', '0000', '3', '0');
INSERT INTO `secsm`.`account` (`Name`, `Email`, `Pw`, `Px_amount`, `Phone`, `Grade`, `gender`) VALUES ('자치회장', '자치회상', '1234', '0', '0000', '1', '0');
INSERT INTO `secsm`.`account` (`Name`, `Email`, `Pw`, `Px_amount`, `Phone`, `Grade`, `gender`) VALUES ('생활부장', '생활부장', '1234', '0', '0000', '2', '0');
INSERT INTO `secsm`.`account` (`Name`, `Email`, `Pw`, `Px_amount`, `Phone`, `Grade`, `gender`) VALUES ('PX부장', 'PX부장', '1234', '999999', '0000', '4', '0');
INSERT INTO `secsm`.`account` (`Name`, `Email`, `Pw`, `Px_amount`, `Phone`, `Grade`, `gender`) VALUES ('자산관리부장', '자산관리부장', '1234', '0', '0000', '5', '0');
INSERT INTO `secsm`.`account` (`Name`, `Email`, `Pw`, `Px_amount`, `Phone`, `Grade`, `gender`) VALUES ('기획부장', '기획부장', '1234', '0', '0000', '6', '0');


ALTER TABLE `secsm`.`attendance` 
ADD COLUMN `id` INT NOT NULL AUTO_INCREMENT AFTER `RegDate`,
ADD PRIMARY KEY (`id`);
