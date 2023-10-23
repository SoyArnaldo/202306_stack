-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema band_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `band_db` ;

-- -----------------------------------------------------
-- Schema band_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `band_db` DEFAULT CHARACTER SET utf8 ;
USE `band_db` ;

-- -----------------------------------------------------
-- Table `band_db`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `band_db`.`users` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(125) NOT NULL,
  `last_name` VARCHAR(125) NOT NULL,
  `email` VARCHAR(125) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `band_db`.`bands`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `band_db`.`bands` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `genre` VARCHAR(255) NOT NULL,
  `city` VARCHAR(255) NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_bands_users_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_bands_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `band_db`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `band_db`.`users_bands`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `band_db`.`users_bands` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NOT NULL,
  `band_id` INT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `user_id`, `band_id`),
  INDEX `fk_users_has_bands_bands1_idx` (`band_id` ASC) VISIBLE,
  INDEX `fk_users_has_bands_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_bands_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `band_db`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_has_bands_bands1`
    FOREIGN KEY (`band_id`)
    REFERENCES `band_db`.`bands` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
