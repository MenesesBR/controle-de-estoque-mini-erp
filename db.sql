-- MySQL Workbench Forward Engineering

DROP DATABASE doces_gourmet;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema doces_gourmet
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema doces_gourmet
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `doces_gourmet` DEFAULT CHARACTER SET utf8 ;
USE `doces_gourmet` ;

-- -----------------------------------------------------
-- Table `doces_gourmet`.`ingrediente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doces_gourmet`.`ingrediente` (
  `idingrediente` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `estoque` INT UNSIGNED NULL,
  `valorCompra` FLOAT UNSIGNED NULL,
  PRIMARY KEY (`idingrediente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doces_gourmet`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doces_gourmet`.`produto` (
  `idproduto` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `estoque` INT NULL,
  `valorVenda` FLOAT UNSIGNED NULL,
  `custo` FLOAT UNSIGNED NULL,
  PRIMARY KEY (`idproduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doces_gourmet`.`produto_ingrediente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doces_gourmet`.`produto_ingrediente` (
  `produto_id` INT UNSIGNED NOT NULL,
  `ingrediente_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`produto_id`, `ingrediente_id`),
  INDEX `fk_produto_has_ingrediente_ingrediente1_idx` (`ingrediente_id` ASC),
  INDEX `fk_produto_has_ingrediente_produto_idx` (`produto_id` ASC),
  CONSTRAINT `fk_produto_has_ingrediente_produto`
    FOREIGN KEY (`produto_id`)
    REFERENCES `doces_gourmet`.`produto` (`idproduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_has_ingrediente_ingrediente1`
    FOREIGN KEY (`ingrediente_id`)
    REFERENCES `doces_gourmet`.`ingrediente` (`idingrediente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doces_gourmet`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doces_gourmet`.`cliente` (
  `idcliente` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `rua` VARCHAR(45) NOT NULL,
  `numero` INT(5) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `complemento` VARCHAR(100) NULL,
  `telefone` VARCHAR(20) NULL,
  `celular` VARCHAR(20) NULL,
  PRIMARY KEY (`idcliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doces_gourmet`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doces_gourmet`.`pedido` (
  `idpedido` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dataPedido` DATE NOT NULL,
  `dataEntrega` DATE NOT NULL,
  `valorFrete` FLOAT NOT NULL,
  `valorTotal` FLOAT UNSIGNED NOT NULL,
  `valorLucro` FLOAT NOT NULL,
  `status` INT(1) NOT NULL,
  `cliente_idcliente` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idpedido`),
  INDEX `fk_pedido_cliente1_idx` (`cliente_idcliente` ASC),
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `doces_gourmet`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doces_gourmet`.`pedido_produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doces_gourmet`.`pedido_produto` (
  `pedido_idpedido` INT UNSIGNED NOT NULL,
  `produto_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`pedido_idpedido`, `produto_id`),
  INDEX `fk_pedido_has_produto_produto1_idx` (`produto_id` ASC),
  INDEX `fk_pedido_has_produto_pedido1_idx` (`pedido_idpedido` ASC),
  CONSTRAINT `fk_pedido_has_produto_pedido1`
    FOREIGN KEY (`pedido_idpedido`)
    REFERENCES `doces_gourmet`.`pedido` (`idpedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_has_produto_produto1`
    FOREIGN KEY (`produto_id`)
    REFERENCES `doces_gourmet`.`produto` (`idproduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doces_gourmet`.`custos_fixos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doces_gourmet`.`custos_fixos` (
  `valorAgua` FLOAT NULL,
  `valorLuz` FLOAT NULL,
  `valorInternet` FLOAT NULL,
  `valorTelefone` FLOAT NULL)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



INSERT INTO cliente (nome, rua, numero, bairro, celular)
VALUES ("João Victor Meneses Silva", "Rua Rio Tibre", 254, "Novo Riacho", 31996371744);

INSERT INTO ingrediente (nome, estoque, valorCompra) VALUES ("Ovo", "12", 12.50);
INSERT INTO ingrediente (nome, estoque, valorCompra) VALUES ("Farinha", "1000", 25.68);
INSERT INTO ingrediente (nome, estoque, valorCompra) VALUES ("Morango", "500", 9.50);

INSERT INTO produto (nome, estoque, valorVenda, custo) VALUES ("Bolo de Morango", 1, 75.00, 40.00);
INSERT INTO produto (nome, estoque, valorVenda, custo) VALUES ("Biscoito de Natal", 1, 2.00, 0.90);
INSERT INTO produto (nome, estoque, valorVenda, custo) VALUES ("Panetone Trufado", 1, 130.00, 70.00);

INSERT INTO produto_ingrediente (produto_id, ingrediente_id) VALUES (1, 1);
INSERT INTO produto_ingrediente (produto_id, ingrediente_id) VALUES (1, 3);
INSERT INTO produto_ingrediente (produto_id, ingrediente_id) VALUES (1, 2);

SELECT * FROM cliente;
SELECT * FROM ingrediente;
SELECT * FROM produto;
SELECT * FROM produto_ingrediente;