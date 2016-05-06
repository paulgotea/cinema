-- MySQL Script generated by MySQL Workbench
-- 05/05/16 09:28:57
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema cinemaDatabase
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cinemaDatabase
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cinemaDatabase` DEFAULT CHARACTER SET utf8 ;
USE `cinemaDatabase` ;

-- -----------------------------------------------------
-- Table `cinemaDatabase`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinemaDatabase`.`users` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `active` boolean NOT NULL,
  `role` TINYINT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemaDatabase`.`movies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinemaDatabase`.`movies` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `year` YEAR NOT NULL,
  `cast` VARCHAR(512) NOT NULL,
  `duration` TINYINT NOT NULL,
  `poster` VARCHAR(128) NOT NULL,
  `link_imdb` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemaDatabase`.`rooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinemaDatabase`.`rooms` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `capacity` SMALLINT(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemaDatabase`.`schedules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinemaDatabase`.`schedules` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `time` TIME NOT NULL,
  `remaining_seats` SMALLINT(3) NOT NULL,
  `ticket_price` FLOAT NOT NULL,
  `rooms_id` SMALLINT(5) UNSIGNED NOT NULL,
  `movies_id` SMALLINT(5) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_schedules_rooms1_idx` (`rooms_id` ASC),
  INDEX `fk_schedules_movies1_idx` (`movies_id` ASC),
  CONSTRAINT `fk_schedules_rooms1`
    FOREIGN KEY (`rooms_id`)
    REFERENCES `cinemaDatabase`.`rooms` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_schedules_movies1`
    FOREIGN KEY (`movies_id`)
    REFERENCES `cinemaDatabase`.`movies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemaDatabase`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinemaDatabase`.`bookings` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `seats` SMALLINT(3) UNSIGNED NOT NULL,
  `users_id` SMALLINT(5) UNSIGNED NOT NULL,
  `schedules_id` SMALLINT(5) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_bookings_users_idx` (`users_id` ASC),
  INDEX `fk_bookings_schedules1_idx` (`schedules_id` ASC),
  CONSTRAINT `fk_bookings_users`
    FOREIGN KEY (`users_id`)
    REFERENCES `cinemaDatabase`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookings_schedules1`
    FOREIGN KEY (`schedules_id`)
    REFERENCES `cinemaDatabase`.`schedules` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemaDatabase`.`genres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinemaDatabase`.`genres` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemaDatabase`.`movie_to_genres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinemaDatabase`.`movie_to_genres` (
  `movies_id` SMALLINT(5) UNSIGNED NOT NULL,
  `genres_id` SMALLINT(5) UNSIGNED NOT NULL,
  INDEX `fk_movie_to_genres_movies1_idx` (`movies_id` ASC),
  INDEX `fk_movie_to_genres_genres1_idx` (`genres_id` ASC),
  CONSTRAINT `fk_movie_to_genres_movies1`
    FOREIGN KEY (`movies_id`)
    REFERENCES `cinemaDatabase`.`movies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_to_genres_genres1`
    FOREIGN KEY (`genres_id`)
    REFERENCES `cinemaDatabase`.`genres` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;