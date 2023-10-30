create database messenger;
use messenger;

CREATE TABLE `users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `userID` VARCHAR(15) NOT NULL,
  `password` VARCHAR(15) NOT NULL,
  `nickname` VARCHAR(10) NOT NULL,
  `profile_pic_url` VARCHAR(2048),
  `profile_message` VARCHAR(2048),
  `is_withdrawal` TINYINT DEFAULT 0,
  `signup_date` DATE,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `channels` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(20) NOT NULL,
  `generator` INT NOT NULL,
  `channel_url` VARCHAR(2048) NOT NULL,
  `max_capacity` INT NOT NULL,
  `is_withdrawal` TINYINT DEFAULT 0,
  `create_data` DATE NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`generator`)
  REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `chats` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(2048) NOT NULL,
  `author` INT NOT NULL,
  `channel` INT NOT NULL,
  `create_date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`author`)
  REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`channel`)
  REFERENCES `channels`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `blocks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `blocker` INT NOT NULL,
  `blockee` INT NOT NULL,
  `block_date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`blocker`)
  REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`blockee`)
  REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `follows` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `follower` INT NOT NULL,
  `followee` INT NOT NULL,
  `follow_date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`follower`)
  REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`followee`)
  REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
