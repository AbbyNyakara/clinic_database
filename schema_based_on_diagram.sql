SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema clinic_database
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema clinic_database
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `clinic_database` DEFAULT CHARACTER SET utf8 ;
USE `clinic_database` ;

-- -----------------------------------------------------
-- Table `clinic_database`.`patients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_database`.`patients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_database`.`medical_histories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_database`.`medical_histories` (
  `id` INT NOT NULL,
  `admitted_at` TIMESTAMP NOT NULL,
  `patient_id` INT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_medical_histories_patients1_idx` (`patient_id` ASC) VISIBLE,
  CONSTRAINT `fk_medical_histories_patients1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `clinic_database`.`patients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_database`.`treatments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_database`.`treatments` (
  `id` INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_database`.`invoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_database`.`invoices` (
  `id` INT NOT NULL,
  `total_amount` DECIMAL NOT NULL,
  `generated_at` TIMESTAMP NOT NULL,
  `payed_at` TIMESTAMP NOT NULL,
  `medical_history_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_invoices_medical_histories1_idx` (`medical_history_id` ASC) VISIBLE,
  CONSTRAINT `fk_invoices_medical_histories1`
    FOREIGN KEY (`medical_history_id`)
    REFERENCES `clinic_database`.`medical_histories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_database`.`invoice_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_database`.`invoice_items` (
  `id` INT NOT NULL,
  `unit_price` DECIMAL NOT NULL,
  `quantity` INT NOT NULL,
  `total_price` DECIMAL NOT NULL,
  `invoice_id` INT NOT NULL,
  `treatment_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_invoice_items_invoices1_idx` (`invoice_id` ASC) VISIBLE,
  INDEX `fk_invoice_items_treatments1_idx` (`treatment_id` ASC) VISIBLE,
  CONSTRAINT `fk_invoice_items_invoices1`
    FOREIGN KEY (`invoice_id`)
    REFERENCES `clinic_database`.`invoices` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_invoice_items_treatments1`
    FOREIGN KEY (`treatment_id`)
    REFERENCES `clinic_database`.`treatments` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_database`.`medical_histories_has_treatments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_database`.`medical_histories_has_treatments` (
  `medical_histories_id` INT NOT NULL,
  `treatments_id` INT NOT NULL,
  PRIMARY KEY (`medical_histories_id`, `treatments_id`),
  INDEX `fk_medical_histories_has_treatments_treatments1_idx` (`treatments_id` ASC) VISIBLE,
  CONSTRAINT `fk_medical_histories_has_treatments_medical_histories1`
    FOREIGN KEY (`medical_histories_id`)
    REFERENCES `clinic_database`.`medical_histories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medical_histories_has_treatments_treatments1`
    FOREIGN KEY (`treatments_id`)
    REFERENCES `clinic_database`.`treatments` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
