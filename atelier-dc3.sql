-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema atelier-dc3
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `atelier-dc3` ;

-- -----------------------------------------------------
-- Schema atelier-dc3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `atelier-dc3` DEFAULT CHARACTER SET utf8 ;
USE `atelier-dc3` ;

-- -----------------------------------------------------
-- Table `atelier-dc3`.`utilisateur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `atelier-dc3`.`utilisateur` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `mail` VARCHAR(255) NOT NULL,
  `mdp` VARCHAR(255) NOT NULL,
  `date_inscritpion` DATETIME NOT NULL,
  `avatar` VARCHAR(255) NULL,
  `valide` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `atelier-dc3`.`admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `atelier-dc3`.`admin` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_admin_utilisateur`
    FOREIGN KEY (`id`)
    REFERENCES `atelier-dc3`.`utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `atelier-dc3`.`entreprise`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `atelier-dc3`.`entreprise` (
  `id` INT NOT NULL,
  `nom` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_entreprise_utilisateur1`
    FOREIGN KEY (`id`)
    REFERENCES `atelier-dc3`.`utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `atelier-dc3`.`niveau_etude`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `atelier-dc3`.`niveau_etude` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `label` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `atelier-dc3`.`contrat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `atelier-dc3`.`contrat` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `label` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `atelier-dc3`.`etudiant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `atelier-dc3`.`etudiant` (
  `id` INT NOT NULL,
  `nom` VARCHAR(255) NOT NULL,
  `prenom` VARCHAR(255) NOT NULL,
  `date_naissance` DATE NOT NULL,
  `numero_tel` VARCHAR(255) NOT NULL,
  `cv` VARCHAR(255) NOT NULL,
  `lettre_motivation` VARCHAR(255) NULL,
  `niveau_etude_id` INT NOT NULL,
  `contrat_id` INT NOT NULL,
  `actif` TINYINT NOT NULL DEFAULT 1,
  `date_debut_contrat` DATE NOT NULL,
  `date_fin_contrat` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_etudiant_niveau_etude1_idx` (`niveau_etude_id` ASC),
  INDEX `fk_etudiant_contrat1_idx` (`contrat_id` ASC),
  CONSTRAINT `fk_etudiant_utilisateur1`
    FOREIGN KEY (`id`)
    REFERENCES `atelier-dc3`.`utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_etudiant_niveau_etude1`
    FOREIGN KEY (`niveau_etude_id`)
    REFERENCES `atelier-dc3`.`niveau_etude` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_etudiant_contrat1`
    FOREIGN KEY (`contrat_id`)
    REFERENCES `atelier-dc3`.`contrat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `atelier-dc3`.`departement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `atelier-dc3`.`departement` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `label` VARCHAR(255) NOT NULL,
  `code` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `atelier-dc3`.`specialite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `atelier-dc3`.`specialite` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `label` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `atelier-dc3`.`departement_has_etudiant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `atelier-dc3`.`departement_has_etudiant` (
  `departement_id` INT NOT NULL,
  `etudiant_id` INT NOT NULL,
  PRIMARY KEY (`departement_id`, `etudiant_id`),
  INDEX `fk_departement_has_etudiant_etudiant1_idx` (`etudiant_id` ASC),
  INDEX `fk_departement_has_etudiant_departement1_idx` (`departement_id` ASC),
  CONSTRAINT `fk_departement_has_etudiant_departement1`
    FOREIGN KEY (`departement_id`)
    REFERENCES `atelier-dc3`.`departement` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_departement_has_etudiant_etudiant1`
    FOREIGN KEY (`etudiant_id`)
    REFERENCES `atelier-dc3`.`etudiant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `atelier-dc3`.`etudiant_has_specialite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `atelier-dc3`.`etudiant_has_specialite` (
  `etudiant_id` INT NOT NULL,
  `specialite_id` INT NOT NULL,
  PRIMARY KEY (`etudiant_id`, `specialite_id`),
  INDEX `fk_etudiant_has_specialite_specialite1_idx` (`specialite_id` ASC),
  INDEX `fk_etudiant_has_specialite_etudiant1_idx` (`etudiant_id` ASC),
  CONSTRAINT `fk_etudiant_has_specialite_etudiant1`
    FOREIGN KEY (`etudiant_id`)
    REFERENCES `atelier-dc3`.`etudiant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_etudiant_has_specialite_specialite1`
    FOREIGN KEY (`specialite_id`)
    REFERENCES `atelier-dc3`.`specialite` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `atelier-dc3`.`utilisateur`
-- -----------------------------------------------------
START TRANSACTION;
USE `atelier-dc3`;
INSERT INTO `atelier-dc3`.`utilisateur` (`id`, `mail`, `mdp`, `date_inscritpion`, `avatar`, `valide`) VALUES (1, 'celine.bellamy@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '2017-01-01', 'celine.png', 1);
INSERT INTO `atelier-dc3`.`utilisateur` (`id`, `mail`, `mdp`, `date_inscritpion`, `avatar`, `valide`) VALUES (2, 'coraline.perrot@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '2017-02-01', 'coraline.png', 0);
INSERT INTO `atelier-dc3`.`utilisateur` (`id`, `mail`, `mdp`, `date_inscritpion`, `avatar`, `valide`) VALUES (3, 'admin@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '2016-02-02', NULL, 1);
INSERT INTO `atelier-dc3`.`utilisateur` (`id`, `mail`, `mdp`, `date_inscritpion`, `avatar`, `valide`) VALUES (4, 'contact@entreprise.com', '81dc9bdb52d04dc20036dbd8313ed055', '2015-01-03', NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `atelier-dc3`.`admin`
-- -----------------------------------------------------
START TRANSACTION;
USE `atelier-dc3`;
INSERT INTO `atelier-dc3`.`admin` (`id`) VALUES (3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `atelier-dc3`.`entreprise`
-- -----------------------------------------------------
START TRANSACTION;
USE `atelier-dc3`;
INSERT INTO `atelier-dc3`.`entreprise` (`id`, `nom`) VALUES (4, 'Entreprise1');

COMMIT;


-- -----------------------------------------------------
-- Data for table `atelier-dc3`.`niveau_etude`
-- -----------------------------------------------------
START TRANSACTION;
USE `atelier-dc3`;
INSERT INTO `atelier-dc3`.`niveau_etude` (`id`, `label`) VALUES (1, 'bac +1');
INSERT INTO `atelier-dc3`.`niveau_etude` (`id`, `label`) VALUES (2, 'bac +2');
INSERT INTO `atelier-dc3`.`niveau_etude` (`id`, `label`) VALUES (3, 'bac +3');
INSERT INTO `atelier-dc3`.`niveau_etude` (`id`, `label`) VALUES (4, 'bac +4');
INSERT INTO `atelier-dc3`.`niveau_etude` (`id`, `label`) VALUES (5, 'bac +5');

COMMIT;


-- -----------------------------------------------------
-- Data for table `atelier-dc3`.`contrat`
-- -----------------------------------------------------
START TRANSACTION;
USE `atelier-dc3`;
INSERT INTO `atelier-dc3`.`contrat` (`id`, `label`) VALUES (1, 'stage');
INSERT INTO `atelier-dc3`.`contrat` (`id`, `label`) VALUES (2, 'alternance');

COMMIT;


-- -----------------------------------------------------
-- Data for table `atelier-dc3`.`etudiant`
-- -----------------------------------------------------
START TRANSACTION;
USE `atelier-dc3`;
INSERT INTO `atelier-dc3`.`etudiant` (`id`, `nom`, `prenom`, `date_naissance`, `numero_tel`, `cv`, `lettre_motivation`, `niveau_etude_id`, `contrat_id`, `actif`, `date_debut_contrat`, `date_fin_contrat`) VALUES (1, 'Bellamy', 'Céline', '1996-05-11', '0608197865', 'cv-celine.pdf', 'lettre-celine.pdf', 3, 2, 1, '2018-01-02', '2019-01-31');
INSERT INTO `atelier-dc3`.`etudiant` (`id`, `nom`, `prenom`, `date_naissance`, `numero_tel`, `cv`, `lettre_motivation`, `niveau_etude_id`, `contrat_id`, `actif`, `date_debut_contrat`, `date_fin_contrat`) VALUES (2, 'Perrot', 'Coraline', '1997-01-28', '0605387956', 'cv-coraline.pdf', 'lettre-coraline.pdf', 4, 1, 0, '2018-05-01', '2018-07-31');

COMMIT;


-- -----------------------------------------------------
-- Data for table `atelier-dc3`.`departement`
-- -----------------------------------------------------
START TRANSACTION;
USE `atelier-dc3`;
INSERT INTO `atelier-dc3`.`departement` (`id`, `label`, `code`) VALUES (1, 'Ile-et-vilaine', '35');
INSERT INTO `atelier-dc3`.`departement` (`id`, `label`, `code`) VALUES (2, 'Indre-et-Loire', '37');
INSERT INTO `atelier-dc3`.`departement` (`id`, `label`, `code`) VALUES (3, 'Manche', '50');

COMMIT;


-- -----------------------------------------------------
-- Data for table `atelier-dc3`.`specialite`
-- -----------------------------------------------------
START TRANSACTION;
USE `atelier-dc3`;
INSERT INTO `atelier-dc3`.`specialite` (`id`, `label`) VALUES (1, 'Webmarketing');
INSERT INTO `atelier-dc3`.`specialite` (`id`, `label`) VALUES (2, 'Webdesign');
INSERT INTO `atelier-dc3`.`specialite` (`id`, `label`) VALUES (3, 'Developpement');

COMMIT;


-- -----------------------------------------------------
-- Data for table `atelier-dc3`.`departement_has_etudiant`
-- -----------------------------------------------------
START TRANSACTION;
USE `atelier-dc3`;
INSERT INTO `atelier-dc3`.`departement_has_etudiant` (`departement_id`, `etudiant_id`) VALUES (2, 1);
INSERT INTO `atelier-dc3`.`departement_has_etudiant` (`departement_id`, `etudiant_id`) VALUES (3, 1);
INSERT INTO `atelier-dc3`.`departement_has_etudiant` (`departement_id`, `etudiant_id`) VALUES (1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `atelier-dc3`.`etudiant_has_specialite`
-- -----------------------------------------------------
START TRANSACTION;
USE `atelier-dc3`;
INSERT INTO `atelier-dc3`.`etudiant_has_specialite` (`etudiant_id`, `specialite_id`) VALUES (1, 1);
INSERT INTO `atelier-dc3`.`etudiant_has_specialite` (`etudiant_id`, `specialite_id`) VALUES (1, 2);
INSERT INTO `atelier-dc3`.`etudiant_has_specialite` (`etudiant_id`, `specialite_id`) VALUES (2, 3);

COMMIT;
