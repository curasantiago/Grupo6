-- MySQL Script generated by MySQL Workbench
-- Wed Nov 25 15:46:51 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema riwicervezas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema riwicervezas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `riwicervezas` DEFAULT CHARACTER SET utf8 ;
USE `riwicervezas` ;

-- -----------------------------------------------------
-- Table `riwicervezas`.`admins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `riwicervezas`.`admins` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `username` VARCHAR(45) NULL DEFAULT NULL,
  `password` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `riwicervezas`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `riwicervezas`.`users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `birthdate` DATE NULL DEFAULT NULL,
  `address` VARCHAR(200) NULL DEFAULT NULL,
  `password` VARCHAR(100) NULL DEFAULT NULL,
  `image` VARCHAR(500) NULL DEFAULT NULL,
  `deleted_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `riwicervezas`.`cards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `riwicervezas`.`cards` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `owner_card` VARCHAR(100) NULL DEFAULT NULL,
  `number` INT(11) NULL DEFAULT NULL,
  `expire_date` DATE NULL DEFAULT NULL,
  `security_code` VARCHAR(45) NULL DEFAULT NULL,
  `purchase_address` VARCHAR(200) NULL DEFAULT NULL,
  `card_type` TINYINT(1) NULL DEFAULT NULL,
  `id_user` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_card_idx` (`id_user` ASC),
  CONSTRAINT `user_card`
    FOREIGN KEY (`id_user`)
    REFERENCES `riwicervezas`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `riwicervezas`.`carts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `riwicervezas`.`carts` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `user_id` INT(11) NULL DEFAULT NULL,
  `total` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_cart_idx` (`user_id` ASC),
  CONSTRAINT `user_cart`
    FOREIGN KEY (`user_id`)
    REFERENCES `riwicervezas`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `riwicervezas`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `riwicervezas`.`categories` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `name` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `riwicervezas`.`sizes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `riwicervezas`.`sizes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `value` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `riwicervezas`.`subcategories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `riwicervezas`.`subcategories` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `name` VARCHAR(20) NULL DEFAULT NULL,
  `id_category` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `category_idx` (`id_category` ASC),
  CONSTRAINT `id_category`
    FOREIGN KEY (`id_category`)
    REFERENCES `riwicervezas`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `riwicervezas`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `riwicervezas`.`products` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `info` VARCHAR(500) NULL DEFAULT NULL,
  `price` INT(11) NULL DEFAULT NULL,
  `image` VARCHAR(500) NULL DEFAULT NULL,
  `id_size` INT(11) NULL DEFAULT NULL,
  `id_subcategory` INT(11) NULL DEFAULT NULL,
  `deleted_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `product_size_idx` (`id_size` ASC),
  INDEX `product_subcategory_idx` (`id_subcategory` ASC),
  CONSTRAINT `product_size`
    FOREIGN KEY (`id_size`)
    REFERENCES `riwicervezas`.`sizes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `product_subcategory`
    FOREIGN KEY (`id_subcategory`)
    REFERENCES `riwicervezas`.`subcategories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `riwicervezas`.`purchase_histories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `riwicervezas`.`purchase_histories` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `id_cart` INT(11) NULL DEFAULT NULL,
  `id_product` INT(11) NULL DEFAULT NULL,
  `quantity` INT(11) NULL DEFAULT NULL,
  `subtotal` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `history_cart_idx` (`id_cart` ASC),
  INDEX `history_product_idx` (`id_product` ASC),
  CONSTRAINT `history_cart`
    FOREIGN KEY (`id_cart`)
    REFERENCES `riwicervezas`.`carts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `history_product`
    FOREIGN KEY (`id_product`)
    REFERENCES `riwicervezas`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `riwicervezas`.`purchases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `riwicervezas`.`purchases` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `id_user` INT(11) NULL DEFAULT NULL,
  `id_cart` INT(11) NULL DEFAULT NULL,
  `id_card` INT(11) NULL DEFAULT NULL,
  `total` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `purchase_user_idx` (`id_user` ASC),
  INDEX `purchase_cart_idx` (`id_cart` ASC),
  INDEX `purchase_card_idx` (`id_card` ASC),
  CONSTRAINT `purchase_card`
    FOREIGN KEY (`id_card`)
    REFERENCES `riwicervezas`.`cards` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `purchase_cart`
    FOREIGN KEY (`id_cart`)
    REFERENCES `riwicervezas`.`carts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `purchase_user`
    FOREIGN KEY (`id_user`)
    REFERENCES `riwicervezas`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
