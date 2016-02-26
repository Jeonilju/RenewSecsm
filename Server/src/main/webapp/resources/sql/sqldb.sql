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

INSERT INTO `secsm`.`account` (`Name`, `Email`, `Pw`, `Px_amount`, `Phone`, `Grade`, `gender`) VALUES ('교육부장', '교육부장', '1234', '10000', '0000', '3', '1');
INSERT INTO `secsm`.`account` (`Name`, `Email`, `Pw`, `Px_amount`, `Phone`, `Grade`, `gender`) VALUES ('자치회장', '자치회상', '1234', '0', '0000', '1', '1');
INSERT INTO `secsm`.`account` (`Name`, `Email`, `Pw`, `Px_amount`, `Phone`, `Grade`, `gender`) VALUES ('생활부장', '생활부장', '1234', '0', '0000', '2', '0');
INSERT INTO `secsm`.`account` (`Name`, `Email`, `Pw`, `Px_amount`, `Phone`, `Grade`, `gender`) VALUES ('PX부장', 'PX부장', '1234', '999999', '0000', '4', '1');
INSERT INTO `secsm`.`account` (`Name`, `Email`, `Pw`, `Px_amount`, `Phone`, `Grade`, `gender`) VALUES ('자산관리부장', '자산관리부장', '1234', '0', '0000', '5', '1');
INSERT INTO `secsm`.`account` (`Name`, `Email`, `Pw`, `Px_amount`, `Phone`, `Grade`, `gender`) VALUES ('기획부장', '기획부장', '1234', '0', '0000', '6', '1');
INSERT INTO `secsm`.`account` (`Name`, `Email`, `Pw`, `Px_amount`, `Phone`, `Grade`, `gender`) VALUES ('기존회원', '기존회원', '1234', '0', '0000', '8', '1');

INSERT INTO `secsm`.`book_category` (`id`, `name`) VALUES ('1', 'ALL');
INSERT INTO `secsm`.`book_category` (`id`, `name`) VALUES ('2', '소프트웨어');
INSERT INTO `secsm`.`book_category` (`id`, `name`) VALUES ('3', '하드웨어');
INSERT INTO `secsm`.`book_category` (`id`, `name`) VALUES ('4', '디자인');
INSERT INTO `secsm`.`book_category` (`id`, `name`) VALUES ('5', '기타');

INSERT INTO `secsm`.`book_req` (`id`, `account_id`, `title`, `publisher`, `author`, `link`, `imageURL`, `pay`, `regdate`) VALUES ('1', '8', 'Cocos2d-x 3 모바일 게임 프로그래밍', '에이콘', '인자건', 'http://www.yes24.com/24/Goods/13212007?Acode=101', 'http://image.yes24.com/momo/TopCate369/MidCate001/36808474.jpg', '27000', '2016-02-25 00:53:37');
INSERT INTO `secsm`.`book_req` (`id`, `account_id`, `title`, `publisher`, `author`, `link`, `imageURL`, `pay`, `regdate`) VALUES ('2', '8', '오라클 SQL과 PL/SQL을 다루는 기술', '길벗', '홍형경', 'http://www.yes24.com/24/goods/18077084', 'http://image.yes24.com/momo/TopCate505/MidCate010/50496006.jpg', '25200', '2016-02-25 01:08:52');
INSERT INTO `secsm`.`book_req` (`id`, `account_id`, `title`, `publisher`, `author`, `link`, `imageURL`, `pay`, `regdate`) VALUES ('3', '5', '후니의 쉽게 쓴 시스코 네트워킹', '성인당', '진강훈', 'http://www.yes24.com/24/goods/4747319', 'http://image.yes24.com/momo/TopCate108/MidCate05/10740226.jpg', '28800', '2016-02-25 01:12:14');
INSERT INTO `secsm`.`book_req` (`id`, `account_id`, `title`, `publisher`, `author`, `link`, `imageURL`, `pay`, `regdate`) VALUES ('4', '5', '실무로 배우는 시스템 성능 최적화 : 시스템 동작 분석부터 성능 개선까지', '위키북스', '권문수', 'http://www.yes24.com/24/goods/24206399', 'http://image.yes24.com/momo/TopCate701/MidCate005/70040630.jpg', '37800', '2016-02-25 01:13:31');
INSERT INTO `secsm`.`book_req` (`id`, `account_id`, `title`, `publisher`, `author`, `link`, `imageURL`, `pay`, `regdate`) VALUES ('5', '5', '인프라 엔지니어의 교과서', '길벗', '사노 유카타', 'http://www.yes24.com/24/goods/13486433', 'http://image.yes24.com/momo/TopCate380/MidCate006/37954316.jpg', '12420', '2016-02-25 01:15:41');
INSERT INTO `secsm`.`book_req` (`id`, `account_id`, `title`, `publisher`, `author`, `link`, `imageURL`, `pay`, `regdate`) VALUES ('6', '4', 'Gradle 그레이들 철저 입문 : 안드로이드 공식 빌드 시스템', '길벗', '와타비키 타쿠마 외', 'http://www.yes24.com/24/goods/23449551', 'http://image.yes24.com/momo/TopCate673/MidCate006/67254730.jpg', '38700', '2016-02-25 01:19:16');
INSERT INTO `secsm`.`book_req` (`id`, `account_id`, `title`, `publisher`, `author`, `link`, `imageURL`, `pay`, `regdate`) VALUES ('7', '4', '초보자를 위한 안드로이드 스튜디오 : Hello World부터 채팅 앱과 벽돌깨기 게임까지', '한빛미디어', '마츠오카 겐지', 'http://www.yes24.com/24/goods/24089785', 'http://image.yes24.com/momo/TopCate697/MidCate003/69625843.jpg', '25200', '2016-02-25 01:20:14');
INSERT INTO `secsm`.`book_req` (`id`, `account_id`, `title`, `publisher`, `author`, `link`, `imageURL`, `pay`, `regdate`) VALUES ('8', '4', '저전력 블루투스(BLE) : 저전력 무선 네트워킹을 위한 툴과 테크닉', 'BJ퍼블릭', '케빈 타운젠드 외', 'http://www.yes24.com/24/goods/24315270', 'http://image.yes24.com/momo/TopCate704/MidCate007/70365771.jpg', '19800', '2016-02-25 01:22:20');

INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('1', '9791155321379', '3D 프린팅 스타트업', '라온북', '김영준', 'http://image.yes24.com/momo/TopCate450/MidCate010/44990644.jpg', '3', '2016-02-25 01:42:45', '1', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('2', '9788962620719', '한권으로 끝내는 실전 활용과 성공 창업 3D 프린터의 모든것', '라온북', '김영준', 'http://image.yes24.com/momo/TopCate403/MidCate006/29402430.jpg', '3', '2016-02-25 01:43:44', '2', '2');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('3', '9791185553085', '무한상상 DIY 아두이노와 안드로이드로 45개 프로젝트 만들기', '앤써북', '서민우', 'http://image.yes24.com/momo/TopCate402/MidCate006/40151645.jpg', '3', '2016-02-25 01:45:01', '1', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('4', '9788960777743', '일러스트레이터로 배우는 UI 디자인', '에이콘', '럭 무어', 'http://image.yes24.com/momo/TopCate647/MidCate010/64106118.jpg', '4', '2016-02-25 01:45:50', '1', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('5', '9780763782504', 'Foundations of Algorithms', 'jbpub', 'Richard Neapolitan 외', 'http://image.yes24.com/momo/TopCate12/MidCate09/1180823.jpg', '2', '2016-02-25 01:46:49', '1', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('6', '9788960778092', 'The C++ Programming Language Fourth Edition ', '에이콘', '박지유 옮김', 'http://image.yes24.com/momo/TopCate673/MidCate003/67221580.jpg', '2', '2016-02-25 01:48:56', '2', '2');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('7', '9788997390755', 'DO IT! 웹 표준 코딩으로 시작하는 프런트엔드 웹 디자인 입문', '이지스퍼블리싱', '고경희', 'http://image.yes24.com/momo/TopCate593/MidCate008/59271795.jpg', '4', '2016-02-25 01:50:25', '2', '2');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('8', '9788989975861', '리눅스 디버깅과 성능 튜닝', '에이콘', '스티브 베스트', 'http://image.yes24.com/momo/TopCate48/MidCate08/4771580.jpg', '2', '2016-02-25 01:51:04', '1', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('9', '9791158390044', 'DBA를 위한 MySQL 운영 기술', '위키북스', '조영재', 'http://image.yes24.com/momo/TopCate542/MidCate010/54193035.jpg', '2', '2016-02-25 02:01:30', '1', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('10', '9788997390144', 'DO IT! 직접 해보는 하둡 프로그래밍', '이지스퍼블리싱', '한기용', 'http://image.yes24.com/momo/TopCate236/MidCate001/23508215.jpg', '2', '2016-02-25 02:33:13', '1', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('11', '9788996276586', '실전 SQL Server MVP 53', 'Manning', 'MVP 커뮤니티', 'http://image.yes24.com/momo/TopCate95/MidCate03/9426932.jpg', '2', '2016-02-25 02:34:09', '2', '2');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('12', '9788997945016', '이장래와 함께하는 SQL Server 2012', 'ITForum', '이장래', 'http://image.yes24.com/momo/TopCate205/MidCate002/20198638.jpg', '2', '2016-02-25 02:34:52', '1', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('13', '9788965400783', 'D3.js 입문', '프리렉', '후루하타 카즈히로', 'http://image.yes24.com/momo/TopCate401/MidCate010/40093394.jpg', '2', '2016-02-25 02:35:30', '1', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('14', '9788960772960', '윈도우폰 7 게임 프로그래밍', '에이콘', '애덤 도즈', 'http://image.yes24.com/momo/TopCate180/MidCate03/17922994.jpg', '2', '2016-02-25 02:36:10', '1', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('15', '9788991268494', '컴퓨터 프로그램의 구조와 해석 1', '인사이트', '해럴드 애빌슨 외', 'http://image.yes24.com/momo/TopCate81/MidCate09/8083552.jpg', '2', '2016-02-25 02:36:50', '1', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('16', '9788991268500', '컴퓨터 프로그램의 구조와 해석 2', '인사이트', '해럴드 애빌슨 외', 'http://image.yes24.com/momo/TopCate81/MidCate09/8083552.jpg', '2', '2016-02-25 02:37:27', '1', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('17', '9788956743998', 'More Effective C++', '정보문화사', '스캇 마이어스', 'http://image.yes24.com/momo/TopCate59/MidCate06/5854056.jpg', '2', '2016-02-25 02:38:00', '1', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('18', '9788960773202', '리눅스 API의 모든 것 고급 리눅스 API', '에이콘', '마이클 커리스크', 'http://image.yes24.com/momo/TopCate192/MidCate002/19112330.jpg', '2', '2016-02-25 02:39:07', '2', '2');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('19', '9788968481796', '자바 8 인 액션', 'Manning', '라울-게이브리얼 우르마 외', 'http://image.yes24.com/momo/TopCate479/MidCate007/47865434.jpg', '2', '2016-02-25 02:40:40', '2', '2');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('20', '9788966187270', '가장 빨리 만나는 자바 8', '길벗', '카이 호스트만', 'http://image.yes24.com/momo/TopCate357/MidCate010/35692169.jpg', '2', '2016-02-25 02:41:13', '1', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('21', '9788960773318', '리눅스 커널 심층 분석 (개정 3판)', '에이콘', '로버트 러브', 'http://image.yes24.com/momo/TopCate198/MidCate002/19714574.jpg', '2', '2016-02-25 02:41:48', '1', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('22', '9788966189908', '가장 빨리 만나는 GO언어', '길벗', '이재홍', 'http://image.yes24.com/momo/TopCate505/MidCate010/50496034.jpg', '2', '2016-02-25 02:42:17', '1', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('23', '9791185475035', 'UNIX 고급 프로그래밍', '퍼스트북', '리처드 스티븐스 외', 'http://image.yes24.com/momo/TopCate406/MidCate002/40511119.jpg', '2', '2016-02-25 02:43:04', '1', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('24', '9788959134366', '도리언 그레이의 초상', '예담', '오스카 와일드', 'http://image.yes24.com/momo/TopCate530/MidCate002/52913182.jpg', '5', '2016-02-25 02:43:47', '1', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('25', '9788994506449', '모바일 게임 플랫폼, 모바게를 지탱하는 기술', '제이펍', '디엔에이(DeNA)', 'http://image.yes24.com/momo/TopCate239/MidCate004/23835216.jpg', '2', '2016-02-25 02:44:33', '1', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('26', '9788965700036', '아프니까 청춘이다', '썸 앤 파커스', '김난도', 'http://image.yes24.com/momo/TopCate172/MidCate04/17134549.jpg', '5', '2016-02-25 02:52:08', '1', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('27', '9788960771499', '코드로 읽는 리눅스 디바이스 드라이버', '에이콘', '스리크슈난 벤카테스와란', 'http://image.yes24.com/momo/TopCate89/MidCate05/8840994.jpg', '2', '2016-02-25 02:52:43', '0', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('28', '9791185890210', '상세한 설명과 복습으로 마스터하는 Swift 쉽게, 더 쉽게', '제이펍', '마크 소라프 외', 'http://image.yes24.com/momo/TopCate492/MidCate006/49154596.jpg', '2', '2016-02-25 02:53:31', '0', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('29', '9788992561259', '3D 프린터 시스템설계', '도서출판 명진', '양해경', 'http://image.yes24.com/momo/TopCate520/MidCate005/51943097.JPG', '3', '2016-02-25 02:54:02', '0', '1');
INSERT INTO `secsm`.`book_items` (`id`, `code`, `name`, `publisher`, `author`, `imageURL`, `type`, `regDate`, `count`, `totalCount`) VALUES ('30', '9788956744452', 'Microsoft Windows Workflow Foundation', '정보문화사', 'Kenn Scribner', 'http://image.yes24.com/momo/TopCate66/MidCate06/6550139.jpg', '2', '2016-02-25 03:30:09', '1', '2');

INSERT INTO `secsm`.`book_log` (`id`, `account_id`, `book_items_id`, `startDate`, `endDate`, `status`) VALUES ('1', '8', '30', '2016-01-03 00:00:00', '2016-02-02 00:00:00', '1');
INSERT INTO `secsm`.`book_log` (`id`, `account_id`, `book_items_id`, `startDate`, `endDate`, `status`) VALUES ('2', '8', '29', '2016-01-15 00:00:00', '2016-01-25 00:00:00', '1');
INSERT INTO `secsm`.`book_log` (`id`, `account_id`, `book_items_id`, `startDate`, `endDate`, `status`) VALUES ('3', '8', '28', '2016-01-27 00:00:00', '2016-02-13 00:00:00', '1');
INSERT INTO `secsm`.`book_log` (`id`, `account_id`, `book_items_id`, `startDate`, `endDate`, `status`) VALUES ('4', '8', '27', '2016-02-02 00:00:00', '2016-03-12 00:00:00', '1');

INSERT INTO `secsm`.`equipment_category` (`id`, `name`) VALUES ('1', 'ALL');
INSERT INTO `secsm`.`equipment_category` (`id`, `name`) VALUES ('2', '컴퓨터');
INSERT INTO `secsm`.`equipment_category` (`id`, `name`) VALUES ('3', '스마트폰');
INSERT INTO `secsm`.`equipment_category` (`id`, `name`) VALUES ('4', '기타');

INSERT INTO `secsm`.`equipment_req` (`id`, `account_id`, `project_id`, `typeKr`, `typeEn`, `titleKr`, `titleEn`, `brand`, `link`, `pay`, `count`, `content`, `regdate`) VALUES ('1', '8', '2', '개발보드', 'Development_board', '라즈베리파이2_스타트_키트', 'Raspberry_pi2_start_kit', '엘레파츠', 'https://www.eleparts.co.kr/EPXDVLAD', '80740', '3', 'Wallson_몸체에_들어갈_메인보드', '2016-02-25 05:44:53');

INSERT INTO `secsm`.`equipment_items` (`id`, `code`, `name`, `manufacturer`, `type`, `regDate`, `count`, `totalCount`) VALUES ('1', '10001', '컴퓨터1', '삼성', '2', '2016-02-25 05:29:05', '1', '1');
INSERT INTO `secsm`.`equipment_items` (`id`, `code`, `name`, `manufacturer`, `type`, `regDate`, `count`, `totalCount`) VALUES ('2', '10002', '컴퓨터2', '삼성', '2', '2016-02-25 05:30:11', '1', '1');
INSERT INTO `secsm`.`equipment_items` (`id`, `code`, `name`, `manufacturer`, `type`, `regDate`, `count`, `totalCount`) VALUES ('3', '10003', '컴퓨터3', '삼성', '2', '2016-02-25 05:30:19', '1', '1');
INSERT INTO `secsm`.`equipment_items` (`id`, `code`, `name`, `manufacturer`, `type`, `regDate`, `count`, `totalCount`) VALUES ('4', '10004', '컴퓨터4', '삼성', '2', '2016-02-25 05:30:25', '1', '1');
INSERT INTO `secsm`.`equipment_items` (`id`, `code`, `name`, `manufacturer`, `type`, `regDate`, `count`, `totalCount`) VALUES ('5', '10005', '컴퓨터5', '삼성', '2', '2016-02-25 05:30:31', '1', '1');
INSERT INTO `secsm`.`equipment_items` (`id`, `code`, `name`, `manufacturer`, `type`, `regDate`, `count`, `totalCount`) VALUES ('6', '10006', '컴퓨터6', '삼성', '2', '2016-02-25 05:30:36', '1', '1');
INSERT INTO `secsm`.`equipment_items` (`id`, `code`, `name`, `manufacturer`, `type`, `regDate`, `count`, `totalCount`) VALUES ('7', '10007', '컴퓨터7', '삼성', '2', '2016-02-25 05:30:57', '1', '1');
INSERT INTO `secsm`.`equipment_items` (`id`, `code`, `name`, `manufacturer`, `type`, `regDate`, `count`, `totalCount`) VALUES ('8', '10008', '컴퓨터8', '삼성', '2', '2016-02-25 05:31:13', '1', '1');
INSERT INTO `secsm`.`equipment_items` (`id`, `code`, `name`, `manufacturer`, `type`, `regDate`, `count`, `totalCount`) VALUES ('9', '20001', '갤럭시S1', '삼성', '3', '2016-02-25 05:31:52', '1', '1');
INSERT INTO `secsm`.`equipment_items` (`id`, `code`, `name`, `manufacturer`, `type`, `regDate`, `count`, `totalCount`) VALUES ('10', '20002', '갤럭시S2', '삼성', '3', '2016-02-25 05:32:17', '2', '2');
INSERT INTO `secsm`.`equipment_items` (`id`, `code`, `name`, `manufacturer`, `type`, `regDate`, `count`, `totalCount`) VALUES ('11', '20003', '갤럭시S3', '삼성', '3', '2016-02-25 05:32:31', '3', '3');
INSERT INTO `secsm`.`equipment_items` (`id`, `code`, `name`, `manufacturer`, `type`, `regDate`, `count`, `totalCount`) VALUES ('12', '20004', '갤럭시S4', '삼성', '3', '2016-02-25 05:32:44', '2', '2');
INSERT INTO `secsm`.`equipment_items` (`id`, `code`, `name`, `manufacturer`, `type`, `regDate`, `count`, `totalCount`) VALUES ('13', '20005', '갤럭시S6', '삼성', '3', '2016-02-25 05:33:03', '1', '1');
INSERT INTO `secsm`.`equipment_items` (`id`, `code`, `name`, `manufacturer`, `type`, `regDate`, `count`, `totalCount`) VALUES ('14', '20006', '갤럭시 탭 프로', '삼성', '3', '2016-02-25 05:35:55', '1', '1');
INSERT INTO `secsm`.`equipment_items` (`id`, `code`, `name`, `manufacturer`, `type`, `regDate`, `count`, `totalCount`) VALUES ('15', '20007', '갤럭시 노트3', '삼성', '3', '2016-02-25 05:38:58', '2', '2');
INSERT INTO `secsm`.`equipment_items` (`id`, `code`, `name`, `manufacturer`, `type`, `regDate`, `count`, `totalCount`) VALUES ('16', '20008', '갤럭시 노트5', '삼성', '3', '2016-02-25 05:39:07', '1', '1');
INSERT INTO `secsm`.`equipment_items` (`id`, `code`, `name`, `manufacturer`, `type`, `regDate`, `count`, `totalCount`) VALUES ('17', '30001', '오큘러스', '구글', '4', '2016-02-25 05:39:12', '2', '2');
INSERT INTO `secsm`.`equipment_items` (`id`, `code`, `name`, `manufacturer`, `type`, `regDate`, `count`, `totalCount`) VALUES ('18', '30002', 'iptime 공유기', 'iptime', '4', '2016-02-25 05:39:14', '3', '3');

INSERT INTO `secsm`.`equipment_log` (`ID`, `Account_id`, `Equipment_items_id`, `StartDate`, `EndDate`, `status`) VALUES ('1', '8', '16', '2016-01-03 00:00:00', '2016-02-02 00:00:00', '1');
INSERT INTO `secsm`.`equipment_log` (`ID`, `Account_id`, `Equipment_items_id`, `StartDate`, `EndDate`, `status`) VALUES ('2', '8', '14', '2016-01-15 00:00:00', '2016-01-25 00:00:00', '1');
INSERT INTO `secsm`.`equipment_log` (`ID`, `Account_id`, `Equipment_items_id`, `StartDate`, `EndDate`, `status`) VALUES ('3', '8', '18', '2016-01-27 00:00:00', '2016-02-13 00:00:00', '1');
INSERT INTO `secsm`.`equipment_log` (`ID`, `Account_id`, `Equipment_items_id`, `StartDate`, `EndDate`, `status`) VALUES ('4', '8', '17', '2016-02-02 00:00:00', '2016-03-12 00:00:00', '1');

ALTER TABLE `secsm`.`attendance` 
ADD COLUMN `id` INT NOT NULL AUTO_INCREMENT AFTER `RegDate`,
ADD PRIMARY KEY (`id`);

ALTER TABLE `secsm`.`attendance` 
ADD COLUMN `cardnum` INT NULL AFTER `id`;

ALTER TABLE `secsm`.`account` 
ADD COLUMN `cardnum` INT NULL AFTER `gender`;

ALTER TABLE `secsm`.`attendance` 
DROP FOREIGN KEY `attendance_account_id`;

ALTER TABLE `secsm`.`attendance` 
DROP COLUMN `Account_id`,
DROP INDEX `attendance_account_id_idx` ;

ALTER TABLE `secsm`.`px_log` 
ADD COLUMN `with_buy` varchar(100) AFTER `price`;

INSERT INTO `secsm`.`px_items` (`name`,`code`,  `price`, `count`) VALUES ('마가렛트', '8801062518517', '2000', '17');
INSERT INTO `secsm`.`px_items` (`name`,`code`,  `price`, `count`) VALUES ('진짬뽕', '8801045522678', '2000', '12');
INSERT INTO `secsm`.`px_items` (`name`,`code`,  `price`, `count`) VALUES (' Calorie Balance 과일', '8.80102E+12', '2000', '3');
INSERT INTO `secsm`.`px_items` (`name`,`code`,  `price`, `count`) VALUES ('짜왕', '8801043032131', '1500', '10');
INSERT INTO `secsm`.`px_items` (`name`,`code`,  `price`, `count`) VALUES (' 스파클링 사과', '8801056035570', '2000', '20');
INSERT INTO `secsm`.`px_items` (`name`,`code`,  `price`, `count`) VALUES (' 스파클링 오랜지', '8801056035518', '1500', '12');
INSERT INTO `secsm`.`px_items` (`name`,`code`,  `price`, `count`) VALUES (' Calorie Balance', '8801019306396', '2000', '4');
INSERT INTO `secsm`.`px_items` (`name`,`code`,  `price`, `count`) VALUES (' 티.오.피', '8801037040029', '1200', '50');

INSERT INTO `secsm`.`px_items` (`name`,`code`,  `price`, `count`) VALUES (' 스팸 마일드', '8801007029641', '2700', '12');
INSERT INTO `secsm`.`px_items` (`name`,`code`,  `price`, `count`) VALUES (' 스팸 클래식', 'FOOD10000068', '3400', '30');
INSERT INTO `secsm`.`px_items` (`name`,`code`,  `price`, `count`) VALUES (' 동원 마일드 참치', '8801047116295', '3000', '50');

INSERT INTO `secsm`.`px_items` (`name`,`code`,  `price`, `count`) VALUES (' 살코기 오뚜기참치', '8801045640204', '2700', '12');
INSERT INTO `secsm`.`px_items` (`name`,`code`,  `price`, `count`) VALUES ('  동원 참치', 'FOOD10000067', '3400', '30');
INSERT INTO `secsm`.`px_items` (`name`,`code`,  `price`, `count`) VALUES (' 동원 야채참치', '8801047121336', '3000', '50');
INSERT INTO `secsm`.`px_items` (`name`,`code`,  `price`, `count`) VALUES (' 고추 참치', '8801047123736', '3000', '50');
