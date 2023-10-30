create database students;
use students;

create table `students` (
  `name` VARCHAR(20) NOT NULL,
  `studentID_last4` INT NOT NULL,
  `admissionYear` INT NOT NULL,
  `major` INT NOT NULL,
  `phonenum` INT NOT NULL,
  `address` VARCHAR(80) NOT NULL,
  `credit` INT DEFAULT 0,
  `gpa` DOUBLE DEFAULT 0.0,
  `is_enroll` TINYINT DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;