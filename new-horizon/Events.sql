-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `testdb` DEFAULT CHARACTER SET utf8 ;
USE `testdb` ;

-- -----------------------------------------------------
-- Table `mydb`.`event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testdb`.`event` (
  `id_event` INT NOT NULL AUTO_INCREMENT,
  `event_name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NULL,
  `venue_name` VARCHAR(100) NOT NULL,
  `attire` VARCHAR(45) NOT NULL,
  `event_image` VARCHAR(255) NOT NULL,
  `capacity` INT NOT NULL,
  `revenue_generation` VARCHAR(100) NULL,
  `start_date` DATETIME NOT NULL,
  `end_date` DATETIME NOT NULL,
  `latitude` DECIMAL(15) NULL,
  `longitude` DECIMAL(15) NULL,
  `event_type` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `published` TINYINT NOT NULL,
  `event_price` INT NOT NULL,
  PRIMARY KEY (`id_event`),
  UNIQUE INDEX `idevent_UNIQUE` (`id_event` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testdb`.`address` (
  `id_address` INT NOT NULL AUTO_INCREMENT,
  `event_id` INT NOT NULL,
  `line_address1` VARCHAR(120) NOT NULL,
  `line_address2` VARCHAR(120) NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_address`),
  UNIQUE INDEX `id_address_UNIQUE` (`id_address` ASC),
  INDEX `fk_address_event_idx` (`event_id` ASC),
  CONSTRAINT `fk_address_event`
    FOREIGN KEY (`event_id`)
    REFERENCES `testdb`.`event` (`id_event`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`event_note`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testdb`.`event_note` (
  `id_event_note` INT NOT NULL AUTO_INCREMENT,
  `event_id` INT NOT NULL,
  `text` VARCHAR(120) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `time_stamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_event_note`),
  UNIQUE INDEX `id_event_notes_UNIQUE` (`id_event_note` ASC),
  INDEX `fk_event_notes_event1_idx` (`event_id` ASC),
  CONSTRAINT `fk_event_notes_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `testdb`.`event` (`id_event`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`event_image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testdb`.`event_image` (
  `id_event_image` INT NOT NULL AUTO_INCREMENT,
  `event_id` INT NOT NULL,
  `source` VARCHAR(250) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_event_image`),
  UNIQUE INDEX `id_event_images_UNIQUE` (`id_event_image` ASC),
  INDEX `fk_event_images_event1_idx` (`event_id` ASC),
  CONSTRAINT `fk_event_images_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `testdb`.`event` (`id_event`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`social_link`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testdb`.`social_link` (
  `id_social_link` INT NOT NULL AUTO_INCREMENT,
  `event_id` INT NOT NULL,
  `social_network` VARCHAR(45) NOT NULL,
  `source` VARCHAR(120) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_social_link`),
  UNIQUE INDEX `id_social_link_UNIQUE` (`id_social_link` ASC),
  INDEX `fk_social_link_event1_idx` (`event_id` ASC),
  CONSTRAINT `fk_social_link_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `testdb`.`event` (`id_event`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`organizer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testdb`.`organizer` (
  `id_organizer` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_organizer`),
  UNIQUE INDEX `id_collaborator_UNIQUE` (`id_organizer` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`event_organizer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testdb`.`event_organizer` (
  `id_event_organizer` INT NOT NULL AUTO_INCREMENT,
  `organizer_id` INT NOT NULL,
  `event_id` INT NOT NULL,
  `permission` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_event_organizer`),
  UNIQUE INDEX `id_event_organizer_UNIQUE` (`id_event_organizer` ASC),
  INDEX `fk_event_organizer_organizer1_idx` (`organizer_id` ASC),
  INDEX `fk_event_organizer_event1_idx` (`event_id` ASC),
  CONSTRAINT `fk_event_organizer_organizer1`
    FOREIGN KEY (`organizer_id`)
    REFERENCES `testdb`.`organizer` (`id_organizer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_organizer_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `testdb`.`event` (`id_event`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`event_attendance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testdb`.`event_attendance` (
  `id_event_attendance` INT NOT NULL AUTO_INCREMENT,
  `event_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `customer_name` VARCHAR(45) NOT NULL,
  `last_modified` DATETIME NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` VARCHAR(45) NOT NULL,
  INDEX `fk_event_attendance_event1_idx` (`event_id` ASC),
  PRIMARY KEY (`id_event_attendance`),
  CONSTRAINT `fk_event_attendance_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `testdb`.`event` (`id_event`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testdb`.`user` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP);


-- -----------------------------------------------------
-- Table `mydb`.`activity_schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testdb`.`activity_schedule` (
  `id_activity_schedule` INT NOT NULL,
  `event_id` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NOT NULL,
  `description` VARCHAR(256) NULL,
  `access_type` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `price` INT NOT NULL,
  PRIMARY KEY (`id_activity_schedule`),
  UNIQUE INDEX `id_event_schedule_UNIQUE` (`id_activity_schedule` ASC),
  INDEX `fk_event_schedule_event1_idx` (`event_id` ASC),
  CONSTRAINT `fk_event_schedule_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `testdb`.`event` (`id_event`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`activity_attendance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testdb`.`activity_attendance` (
  `id_activity_attendance` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `activity_schedule_id` INT NOT NULL,
  PRIMARY KEY (`id_activity_attendance`),
  INDEX `fk_activity_attendance_activity_schedule1_idx` (`activity_schedule_id` ASC),
  UNIQUE INDEX `id_activity_attendance_UNIQUE` (`id_activity_attendance` ASC),
  CONSTRAINT `fk_activity_attendance_activity_schedule1`
    FOREIGN KEY (`activity_schedule_id`)
    REFERENCES `testdb`.`activity_schedule` (`id_activity_schedule`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
