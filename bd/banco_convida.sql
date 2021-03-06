-- MySQL Script generated by MySQL Workbench
-- Sun Nov  2 22:24:37 2014
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ufbaconvida
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ufbaconvida
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ufbaconvida` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `ufbaconvida` ;

-- -----------------------------------------------------
-- Table `ufbaconvida`.`localidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ufbaconvida`.`localidade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `endereco` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ufbaconvida`.`departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ufbaconvida`.`departamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `localidade_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_departamento_localidade1_idx` (`localidade_id` ASC),
  CONSTRAINT `fk_departamento_localidade1`
    FOREIGN KEY (`localidade_id`)
    REFERENCES `ufbaconvida`.`localidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ufbaconvida`.`academico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ufbaconvida`.`academico` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `endereco` VARCHAR(100) NOT NULL,
  `data_nascimento` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(45) NULL,
  `departamento_id` INT NOT NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_academico_departamento1_idx` (`departamento_id` ASC),
  CONSTRAINT `fk_academico_departamento1`
    FOREIGN KEY (`departamento_id`)
    REFERENCES `ufbaconvida`.`departamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ufbaconvida`.`evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ufbaconvida`.`evento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `cartaz` VARCHAR(45) NOT NULL,
  `inicio` DATETIME NOT NULL,
  `fim` DATETIME NOT NULL,
  `descricao` TINYTEXT NOT NULL,
  `academico_id` INT NOT NULL,
  `link` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_evento_academico1_idx` (`academico_id` ASC),
  CONSTRAINT `fk_evento_academico1`
    FOREIGN KEY (`academico_id`)
    REFERENCES `ufbaconvida`.`academico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ufbaconvida`.`apoio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ufbaconvida`.`apoio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `img` VARCHAR(45) NULL,
  `evento_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_apoio_evento1_idx` (`evento_id` ASC),
  CONSTRAINT `fk_apoio_evento1`
    FOREIGN KEY (`evento_id`)
    REFERENCES `ufbaconvida`.`evento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ufbaconvida`.`atividade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ufbaconvida`.`atividade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `horario` TIME NOT NULL,
  `descricao` TINYTEXT NOT NULL,
  `cronograma_id` INT NOT NULL,
  `evento_id` INT NOT NULL,
  `data` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_atividade_evento1_idx` (`evento_id` ASC),
  CONSTRAINT `fk_atividade_evento1`
    FOREIGN KEY (`evento_id`)
    REFERENCES `ufbaconvida`.`evento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ufbaconvida`.`aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ufbaconvida`.`aluno` (
  `academico_id` INT NOT NULL,
  `matricula` VARCHAR(20) NOT NULL,
  `curso` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `matricula_UNIQUE` (`matricula` ASC),
  PRIMARY KEY (`academico_id`),
  CONSTRAINT `fk_aluno_academico1`
    FOREIGN KEY (`academico_id`)
    REFERENCES `ufbaconvida`.`academico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ufbaconvida`.`professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ufbaconvida`.`professor` (
  `academico_id` INT NOT NULL,
  `siape` INT UNSIGNED NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`academico_id`),
  CONSTRAINT `fk_professor_academico1`
    FOREIGN KEY (`academico_id`)
    REFERENCES `ufbaconvida`.`academico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ufbaconvida`.`departamento_has_evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ufbaconvida`.`departamento_has_evento` (
  `departamento_id` INT NOT NULL,
  `evento_id` INT NOT NULL,
  PRIMARY KEY (`departamento_id`, `evento_id`),
  INDEX `fk_departamento_has_evento_evento1_idx` (`evento_id` ASC),
  INDEX `fk_departamento_has_evento_departamento1_idx` (`departamento_id` ASC),
  CONSTRAINT `fk_departamento_has_evento_departamento1`
    FOREIGN KEY (`departamento_id`)
    REFERENCES `ufbaconvida`.`departamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_departamento_has_evento_evento1`
    FOREIGN KEY (`evento_id`)
    REFERENCES `ufbaconvida`.`evento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ufbaconvida`.`campus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ufbaconvida`.`campus` (
  `nome` VARCHAR(45) NOT NULL,
  `localidade_id` INT NOT NULL,
  `codigo` VARCHAR(5) NOT NULL,
  INDEX `fk_campus_localidade1_idx` (`localidade_id` ASC),
  PRIMARY KEY (`codigo`),
  CONSTRAINT `fk_campus_localidade1`
    FOREIGN KEY (`localidade_id`)
    REFERENCES `ufbaconvida`.`localidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ufbaconvida`.`instalacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ufbaconvida`.`instalacao` (
  `predio` VARCHAR(45) NOT NULL,
  `localidade_id` INT NOT NULL,
  `campus_codigo` VARCHAR(5) NOT NULL,
  INDEX `fk_instalacao_localidade1_idx` (`localidade_id` ASC),
  INDEX `fk_instalacao_campus1_idx` (`campus_codigo` ASC),
  CONSTRAINT `fk_instalacao_localidade1`
    FOREIGN KEY (`localidade_id`)
    REFERENCES `ufbaconvida`.`localidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_instalacao_campus1`
    FOREIGN KEY (`campus_codigo`)
    REFERENCES `ufbaconvida`.`campus` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ufbaconvida`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ufbaconvida`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ufbaconvida`.`atividade_has_localidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ufbaconvida`.`atividade_has_localidade` (
  `atividade_id` INT NOT NULL,
  `localidade_id` INT NOT NULL,
  PRIMARY KEY (`atividade_id`, `localidade_id`),
  INDEX `fk_atividade_has_localidade_localidade1_idx` (`localidade_id` ASC),
  INDEX `fk_atividade_has_localidade_atividade1_idx` (`atividade_id` ASC),
  CONSTRAINT `fk_atividade_has_localidade_atividade1`
    FOREIGN KEY (`atividade_id`)
    REFERENCES `ufbaconvida`.`atividade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_atividade_has_localidade_localidade1`
    FOREIGN KEY (`localidade_id`)
    REFERENCES `ufbaconvida`.`localidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;






INSERT INTO ufbaconvida.localidade (id, endereco) VALUES
(1, "Ondina"),
(2, "Canela"),
(3, "Piedade"),
(4, "São Lázaro"),
(5, "Federação");

--
-- População da tabela departamento
--
INSERT INTO ufbaconvida.departamento (id, nome, localidade_id) VALUES
(1, "Computacao", 1),
(2, "Sistema de Informacao", 1),
(3, "Estatistica", 1),
(4, "Matematica", 1),
(5, "Medicina", 2),
(6, "Odontologia", 2),
(7, "Direito", 2),
(8, "Sociologia", 4),
(9, "Economia", 3),
(10, "Engenharia Civil", 5),
(11, "Arquitetura", 5);

--
-- Populaçao da tabela academico
--
INSERT INTO ufbaconvida.academico (id, nome, endereco, data_nascimento, telefone, email, departamento_id) VALUES
(1, 'DENNIS LESSA', 'CAMPO GRANDE', '0000-00-00', '00 0000 0000', 'dennislessa@dcc.ufba.br', 1),
(2, 'EULER SANTANNA', 'ITAPUA', '0000-00-00', '00 0000 0000', 'eulersantanna@dcc.ufba.br', 1),
(3, 'AMANDA SOTERO', 'RIBEIRA', '0000-00-00', '00 0000 0000', 'amandasotero@dcc.ufba.br', 1);

--
-- População da tabela aluno
--
INSERT INTO ufbaconvida.aluno (academico_id, matricula, curso, senha) VALUES
(1,'11111111111111', 'computação', MD5('123')),
(2,'22222222222222', 'computação', MD5('456'));

--
-- Populaçao da tabela professor
--
INSERT INTO ufbaconvida.professor (academico_id, siape, senha) VALUES
(3, '33333333333333', MD5('789'));
