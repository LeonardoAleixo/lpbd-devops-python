DROP SCHEMA IF EXISTS lpbd;

CREATE SCHEMA `lpbd` ;

CREATE TABLE `lpbd`.`user` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `sobrenome` VARCHAR(45) NULL,
  `data_nascimento` DATETIME NULL,
  `cpf` VARCHAR(20) NULL,
  `telefone` VARCHAR(15) NULL,
  PRIMARY KEY (`id_user`));
