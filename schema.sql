-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema caiadoapp
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema caiadoapp
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `caiadoapp` DEFAULT CHARACTER SET utf8 ;
USE `caiadoapp` ;

-- -----------------------------------------------------
-- Table `caiadoapp`.`administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`administrador` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `administrador_nome` VARCHAR(45) NOT NULL,
  `administrador_cpf` VARCHAR(14) NOT NULL,
  `administrador_datanascimento` DATE NOT NULL,
  `administrador_sexo` CHAR(1) NOT NULL,
  `administrador_telefone` VARCHAR(15) NOT NULL,
  `administrador_celular` VARCHAR(15) NOT NULL,
  `administrador_email` VARCHAR(45) NOT NULL,
  `administrador_createdAt` DATETIME NOT NULL,
  `administrador_updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 58
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`estado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `estado_nome` VARCHAR(45) NOT NULL,
  `estado_uf` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 28
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`cidade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cidade_nome` VARCHAR(60) NOT NULL,
  `estado_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cidade_estado1_idx` (`estado_id` ASC),
  CONSTRAINT `fk_cidade_estado1`
    FOREIGN KEY (`estado_id`)
    REFERENCES `caiadoapp`.`estado` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`endereco` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `endereco_logradouro` VARCHAR(70) NOT NULL,
  `endereco_bairro` VARCHAR(60) NOT NULL,
  `endereco_numero` INT NOT NULL,
  `endereco_cep` VARCHAR(10) NOT NULL,
  `cidade_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_endereco_cidade1_idx` (`cidade_id` ASC),
  CONSTRAINT `fk_endereco_cidade1`
    FOREIGN KEY (`cidade_id`)
    REFERENCES `caiadoapp`.`cidade` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`administrador_endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`administrador_endereco` (
  `administrador_id` INT NOT NULL,
  `endereco_id` INT NOT NULL,
  INDEX `fk_administrador_has_endereco_endereco1_idx` (`endereco_id` ASC),
  INDEX `fk_administrador_has_endereco_administrador1_idx` (`administrador_id` ASC),
  CONSTRAINT `fk_administrador_has_endereco_administrador1`
    FOREIGN KEY (`administrador_id`)
    REFERENCES `caiadoapp`.`administrador` (`id`),
  CONSTRAINT `fk_administrador_has_endereco_endereco1`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `caiadoapp`.`endereco` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`loja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`loja` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `loja_cpnj` VARCHAR(17) NOT NULL,
  `loja_realizaservico` TINYINT NOT NULL,
  `loja_numero` INT NOT NULL,
  `endereco_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Loja_endereco1_idx` (`endereco_id` ASC),
  CONSTRAINT `fk_Loja_endereco1`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `caiadoapp`.`endereco` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cliente_nome` VARCHAR(90) NOT NULL,
  `cliente_cpf` VARCHAR(14) NOT NULL,
  `cliente_datanascimento` DATETIME NOT NULL,
  `cliente_sexo` CHAR(1) NOT NULL,
  `cliente_telefone` VARCHAR(13) NOT NULL,
  `cliente_celular` VARCHAR(14) NULL DEFAULT NULL,
  `cliente_dataatualizacao` DATETIME NULL DEFAULT NULL,
  `cliente_dataregistro` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 55
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`metodo_entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`metodo_entrega` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `metodp_entrega_nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`pedido` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `endereco_id` INT NOT NULL,
  `metodo_entrega_id` INT NOT NULL,
  `status_pedido` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pedido_endereco1_idx` (`endereco_id` ASC),
  INDEX `fk_pedido_metodo_entrega1_idx` (`metodo_entrega_id` ASC),
  CONSTRAINT `fk_pedido_endereco1`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `caiadoapp`.`endereco` (`id`),
  CONSTRAINT `fk_pedido_metodo_entrega1`
    FOREIGN KEY (`metodo_entrega_id`)
    REFERENCES `caiadoapp`.`metodo_entrega` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`venda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `venda_valortotal` DOUBLE NOT NULL,
  `venda_notafiscal` INT NOT NULL,
  `venda_data` DATETIME NOT NULL,
  `venda_totaldesconto` DOUBLE NOT NULL,
  `venda_valor_entrega` DOUBLE NOT NULL,
  `venda_icms` DOUBLE NULL DEFAULT NULL,
  `venda_ipi` DOUBLE NULL DEFAULT NULL,
  `venda_iss` DOUBLE NULL DEFAULT NULL,
  `venda_pagamento` VARCHAR(45) NOT NULL,
  `cliente_id` INT NOT NULL,
  `pedido_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_venda_cliente1_idx` (`cliente_id` ASC),
  INDEX `fk_venda_pedido1_idx` (`pedido_id` ASC),
  CONSTRAINT `fk_venda_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `caiadoapp`.`cliente` (`id`),
  CONSTRAINT `fk_venda_pedido1`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `caiadoapp`.`pedido` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`tarefa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`tarefa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tarefa_data_inicio` DATETIME NOT NULL,
  `tarefa_data_fim` DATETIME NOT NULL,
  `tarefa_nfs` INT NOT NULL,
  `venda_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tarefa_venda1_idx` (`venda_id` ASC),
  CONSTRAINT `fk_tarefa_venda1`
    FOREIGN KEY (`venda_id`)
    REFERENCES `caiadoapp`.`venda` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`agenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`agenda` (
  `Loja_id` INT NOT NULL,
  `tarefa_id` INT NOT NULL,
  INDEX `fk_agenda_Loja1_idx` (`Loja_id` ASC),
  INDEX `fk_agenda_tarefa1_idx` (`tarefa_id` ASC),
  CONSTRAINT `fk_agenda_Loja1`
    FOREIGN KEY (`Loja_id`)
    REFERENCES `caiadoapp`.`loja` (`id`),
  CONSTRAINT `fk_agenda_tarefa1`
    FOREIGN KEY (`tarefa_id`)
    REFERENCES `caiadoapp`.`tarefa` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`api_tokens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`api_tokens` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NOT NULL,
  `expires_at` VARCHAR(75) NOT NULL,
  `name` VARCHAR(75) NOT NULL,
  `token` VARCHAR(185) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`, `user_id`),
  INDEX `user_id_idx` (`user_id` ASC),
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `caiadoapp`.`cliente` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 61
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`carrinho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`carrinho` (
  `cliente_id` INT NOT NULL,
  `carrinho_valortotal` DOUBLE NOT NULL,
  `carrinho_valorentrega` DOUBLE NOT NULL,
  `carrinho_valor_produtos` DOUBLE NOT NULL,
  `carrinho_observacoes` VARCHAR(455) NULL DEFAULT NULL,
  `metodo_entrega_id` INT NOT NULL,
  INDEX `fk_carrinho_metodo_entrega1_idx` (`metodo_entrega_id` ASC),
  INDEX `fk_carrinho_cliente2` (`cliente_id` ASC),
  CONSTRAINT `fk_carrinho_cliente2`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `caiadoapp`.`cliente` (`id`),
  CONSTRAINT `fk_carrinho_metodo_entrega1`
    FOREIGN KEY (`metodo_entrega_id`)
    REFERENCES `caiadoapp`.`metodo_entrega` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`servico` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `servico_nome` VARCHAR(45) NOT NULL,
  `servico_preco` DOUBLE NOT NULL,
  `servico_duracao` TIME NOT NULL,
  `tarefa_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_servico_tarefa1_idx` (`tarefa_id` ASC),
  CONSTRAINT `fk_servico_tarefa1`
    FOREIGN KEY (`tarefa_id`)
    REFERENCES `caiadoapp`.`tarefa` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`carrinho_servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`carrinho_servico` (
  `carrinho_cliente_id` INT NOT NULL,
  `servico_id` INT NOT NULL,
  INDEX `fk_carrinho_has_servico_servico1_idx` (`servico_id` ASC),
  INDEX `fk_carrinho_has_servico_carrinho1_idx` (`carrinho_cliente_id` ASC),
  CONSTRAINT `fk_carrinho_has_servico_carrinho1`
    FOREIGN KEY (`carrinho_cliente_id`)
    REFERENCES `caiadoapp`.`carrinho` (`cliente_id`),
  CONSTRAINT `fk_carrinho_has_servico_servico1`
    FOREIGN KEY (`servico_id`)
    REFERENCES `caiadoapp`.`servico` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`fornecedor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fornecedor_nome` VARCHAR(45) NOT NULL,
  `fornecedor_cnpj` VARCHAR(17) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`ordem_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`ordem_compra` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pedido_id` INT NOT NULL,
  `ordem_compra_notafiscal` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ordem_compra_pedido1_idx` (`pedido_id` ASC),
  CONSTRAINT `fk_ordem_compra_pedido1`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `caiadoapp`.`pedido` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`compra` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ordem_compra_id` INT NOT NULL,
  `compra_valortotal` DOUBLE NOT NULL,
  `compra_notafiscal` INT NOT NULL,
  `compra_icms` INT NOT NULL,
  `fornecedor_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_compra_ordem_compra1_idx` (`ordem_compra_id` ASC),
  INDEX `fk_compra_fornecedor1_idx` (`fornecedor_id` ASC),
  CONSTRAINT `fk_compra_fornecedor1`
    FOREIGN KEY (`fornecedor_id`)
    REFERENCES `caiadoapp`.`fornecedor` (`id`),
  CONSTRAINT `fk_compra_ordem_compra1`
    FOREIGN KEY (`ordem_compra_id`)
    REFERENCES `caiadoapp`.`ordem_compra` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`endereco_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`endereco_cliente` (
  `cliente_id` INT NOT NULL,
  `endereco_id` INT NOT NULL,
  `endereco_principal` TINYINT NOT NULL,
  INDEX `fk_endereco_cliente_endereco1_idx` (`endereco_id` ASC),
  INDEX `fk_endereco_cliente_cliente1` (`cliente_id` ASC),
  CONSTRAINT `fk_endereco_cliente_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `caiadoapp`.`cliente` (`id`),
  CONSTRAINT `fk_endereco_cliente_endereco1`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `caiadoapp`.`endereco` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`produto` (
  `produto_id` INT NOT NULL AUTO_INCREMENT,
  `produto_nome` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `produto_preco` DOUBLE UNSIGNED NOT NULL,
  `fornecedor_id` INT NOT NULL,
  PRIMARY KEY (`produto_id`),
  INDEX `fk_produto_fornecedor1_idx` (`fornecedor_id` ASC),
  CONSTRAINT `fk_produto_fornecedor1`
    FOREIGN KEY (`fornecedor_id`)
    REFERENCES `caiadoapp`.`fornecedor` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`estoque` (
  `Loja_id` INT NOT NULL,
  `recurso_recurso_id` INT NOT NULL,
  `loja_estoque_quantidade` INT NOT NULL,
  INDEX `fk_Estoque_recurso1_idx` (`recurso_recurso_id` ASC),
  INDEX `fk_Estoque_Loja1` (`Loja_id` ASC),
  CONSTRAINT `fk_Estoque_Loja1`
    FOREIGN KEY (`Loja_id`)
    REFERENCES `caiadoapp`.`loja` (`id`),
  CONSTRAINT `fk_Estoque_recurso1`
    FOREIGN KEY (`recurso_recurso_id`)
    REFERENCES `caiadoapp`.`produto` (`produto_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`fatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`fatura` (
  `fatura_valor` DOUBLE NOT NULL,
  `venda_id` INT NULL DEFAULT NULL,
  `compra_id` INT NULL DEFAULT NULL,
  INDEX `fk_fatura_venda1_idx` (`venda_id` ASC),
  INDEX `fk_fatura_compra1_idx` (`compra_id` ASC),
  CONSTRAINT `fk_fatura_compra1`
    FOREIGN KEY (`compra_id`)
    REFERENCES `caiadoapp`.`compra` (`id`),
  CONSTRAINT `fk_fatura_venda1`
    FOREIGN KEY (`venda_id`)
    REFERENCES `caiadoapp`.`venda` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`favoritos_produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`favoritos_produto` (
  `cliente_id` INT NOT NULL,
  `produto_produto_id` INT NOT NULL,
  INDEX `fk_cliente_has_produto_produto1_idx` (`produto_produto_id` ASC),
  INDEX `fk_cliente_has_produto_cliente1_idx` (`cliente_id` ASC),
  CONSTRAINT `fk_cliente_has_produto_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `caiadoapp`.`cliente` (`id`),
  CONSTRAINT `fk_cliente_has_produto_produto1`
    FOREIGN KEY (`produto_produto_id`)
    REFERENCES `caiadoapp`.`produto` (`produto_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`favoritos_servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`favoritos_servico` (
  `cliente_id` INT NOT NULL,
  `servico_id` INT NOT NULL,
  INDEX `fk_cliente_has_servico_servico1_idx` (`servico_id` ASC),
  INDEX `fk_cliente_has_servico_cliente1_idx` (`cliente_id` ASC),
  CONSTRAINT `fk_cliente_has_servico_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `caiadoapp`.`cliente` (`id`),
  CONSTRAINT `fk_cliente_has_servico_servico1`
    FOREIGN KEY (`servico_id`)
    REFERENCES `caiadoapp`.`servico` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`historico_administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`historico_administrador` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `historico_administradordescricao` VARCHAR(45) NOT NULL,
  `administrador_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_historico_administrador_administrador1_idx` (`administrador_id` ASC),
  CONSTRAINT `fk_historico_administrador_administrador1`
    FOREIGN KEY (`administrador_id`)
    REFERENCES `caiadoapp`.`administrador` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`historico_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`historico_cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `historico_clientedescricao` VARCHAR(45) NOT NULL,
  `cliente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_historico_cliente_cliente1_idx` (`cliente_id` ASC),
  CONSTRAINT `fk_historico_cliente_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `caiadoapp`.`cliente` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`imagem_produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`imagem_produto` (
  `imagem_produto_1` LONGBLOB NOT NULL,
  `imagem_produto_2` LONGBLOB NOT NULL,
  `produto_produto_id` INT NOT NULL,
  INDEX `fk_imagem_produto_produto_idx` (`produto_produto_id` ASC),
  CONSTRAINT `fk_imagem_produto_produto1`
    FOREIGN KEY (`produto_produto_id`)
    REFERENCES `caiadoapp`.`produto` (`produto_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`imagem_servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`imagem_servico` (
  `imagem_servico_1` LONGBLOB NOT NULL,
  `imagem_servico_2` LONGBLOB NOT NULL,
  `servico_id` INT NOT NULL,
  INDEX `fk_imagem_servico_servico1_id` (`servico_id` ASC),
  CONSTRAINT `fk_imagem_servico_servico1`
    FOREIGN KEY (`servico_id`)
    REFERENCES `caiadoapp`.`servico` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`marca` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `marca_nome` VARCHAR(45) NOT NULL,
  `marca_datacriacao` DATETIME NULL DEFAULT NULL,
  `marca_dataatualizacao` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 20
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`usuario_administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`usuario_administrador` (
  `administrador_id` INT NOT NULL,
  `usuario_administrador_ativo` TINYINT NOT NULL,
  `usuario_administrador_usuario` VARCHAR(45) NOT NULL,
  `usuario_administrador_senha` VARCHAR(45) NOT NULL,
  `usuario_administrador_nivel` INT NOT NULL,
  PRIMARY KEY (`administrador_id`, `usuario_administrador_usuario`),
  UNIQUE INDEX `usuario_administrador_usuario_UNIQUE` (`usuario_administrador_usuario` ASC),
  CONSTRAINT `fk_usuario_administrador_administrador1`
    FOREIGN KEY (`administrador_id`)
    REFERENCES `caiadoapp`.`administrador` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`sac`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`sac` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sac_titulo` VARCHAR(45) NOT NULL,
  `cliente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sac_cliente1_idx` (`cliente_id` ASC),
  CONSTRAINT `fk_sac_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `caiadoapp`.`cliente` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`mensagem_administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`mensagem_administrador` (
  `mensagem_id` VARCHAR(45) NOT NULL,
  `sac_id` INT NOT NULL,
  `mensagem_conteudo` VARCHAR(455) NOT NULL,
  `mensagem_datahora` DATETIME NOT NULL,
  `usuario_administrador_administrador_id` INT NOT NULL,
  PRIMARY KEY (`mensagem_id`),
  INDEX `fk_mensagem_sac1_idx` (`sac_id` ASC),
  INDEX `fk_mensagem_administrador_usuario_administrador1_idx` (`usuario_administrador_administrador_id` ASC),
  CONSTRAINT `fk_mensagem_administrador_usuario_administrador1`
    FOREIGN KEY (`usuario_administrador_administrador_id`)
    REFERENCES `caiadoapp`.`usuario_administrador` (`administrador_id`),
  CONSTRAINT `fk_mensagem_sac1`
    FOREIGN KEY (`sac_id`)
    REFERENCES `caiadoapp`.`sac` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`mensagem_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`mensagem_cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `mensagemcliente_conteudo` VARCHAR(455) NOT NULL,
  `mensagemcliente_datahora` VARCHAR(45) NOT NULL,
  `sac_id` INT NOT NULL,
  `cliente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_mensagem_cliente_sac1_idx` (`sac_id` ASC),
  INDEX `fk_mensagem_cliente_cliente1_idx` (`cliente_id` ASC),
  CONSTRAINT `fk_mensagem_cliente_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `caiadoapp`.`cliente` (`id`),
  CONSTRAINT `fk_mensagem_cliente_sac1`
    FOREIGN KEY (`sac_id`)
    REFERENCES `caiadoapp`.`sac` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`produto_carrinho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`produto_carrinho` (
  `carrinho_cliente_id` INT NOT NULL,
  `produto_produto_id` INT NOT NULL,
  `qtde` INT NOT NULL,
  INDEX `fk_produto_carrinho_produto1_idx` (`produto_produto_id` ASC),
  INDEX `fk_produto_carrinho_carrinho1` (`carrinho_cliente_id` ASC),
  CONSTRAINT `fk_produto_carrinho_carrinho1`
    FOREIGN KEY (`carrinho_cliente_id`)
    REFERENCES `caiadoapp`.`carrinho` (`cliente_id`),
  CONSTRAINT `fk_produto_carrinho_produto1`
    FOREIGN KEY (`produto_produto_id`)
    REFERENCES `caiadoapp`.`produto` (`produto_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`produto_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`produto_compra` (
  `produto_produto_id` INT NOT NULL,
  `compra_id` INT NOT NULL,
  `produto_compra_qtde` INT NOT NULL,
  INDEX `fk_produto_has_compra_compra1_idx` (`compra_id` ASC),
  INDEX `fk_produto_has_compra_produto1_idx` (`produto_produto_id` ASC),
  CONSTRAINT `fk_produto_has_compra_compra1`
    FOREIGN KEY (`compra_id`)
    REFERENCES `caiadoapp`.`compra` (`id`),
  CONSTRAINT `fk_produto_has_compra_produto1`
    FOREIGN KEY (`produto_produto_id`)
    REFERENCES `caiadoapp`.`produto` (`produto_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`usuario_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`usuario_cliente` (
  `cliente_id` INT NOT NULL,
  `usuario_cliente_email` VARCHAR(45) NOT NULL,
  `usuario_cliente_senha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cliente_id`),
  UNIQUE INDEX `usuario_cliente_email_UNIQUE` (`usuario_cliente_email` ASC),
  CONSTRAINT `fk_usuario_cliente_cliente`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `caiadoapp`.`cliente` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`veiculo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `veiculo_nome` VARCHAR(45) NOT NULL,
  `veiculo_anofabricacao` INT NOT NULL,
  `veiculo_quilometragem` INT NOT NULL,
  `marca_id` INT NOT NULL,
  `veiculo_ativo` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_veiculo_marca1_idx` (`marca_id` ASC),
  CONSTRAINT `fk_veiculo_marca1`
    FOREIGN KEY (`marca_id`)
    REFERENCES `caiadoapp`.`marca` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`veiculo_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`veiculo_cliente` (
  `veiculo_id` INT NOT NULL,
  `cliente_id` INT NOT NULL,
  INDEX `fk_veiculo_has_cliente_cliente1_idx` (`cliente_id` ASC),
  INDEX `fk_veiculo_has_cliente_veiculo1_idx` (`veiculo_id` ASC),
  CONSTRAINT `fk_veiculo_has_cliente_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `caiadoapp`.`cliente` (`id`),
  CONSTRAINT `fk_veiculo_has_cliente_veiculo1`
    FOREIGN KEY (`veiculo_id`)
    REFERENCES `caiadoapp`.`veiculo` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`venda_produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`venda_produto` (
  `venda_id` INT NOT NULL,
  `produto_produto_id` INT NOT NULL,
  INDEX `fk_venda_servico_produto1_idx` (`produto_produto_id` ASC),
  INDEX `fk_venda_servico_venda2` (`venda_id` ASC),
  CONSTRAINT `fk_venda_servico_produto1`
    FOREIGN KEY (`produto_produto_id`)
    REFERENCES `caiadoapp`.`produto` (`produto_id`),
  CONSTRAINT `fk_venda_servico_venda2`
    FOREIGN KEY (`venda_id`)
    REFERENCES `caiadoapp`.`venda` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `caiadoapp`.`venda_servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caiadoapp`.`venda_servico` (
  `venda_id` INT NOT NULL,
  `servico_id` INT NOT NULL,
  INDEX `fk_venda_servico_servico1_idx` (`servico_id` ASC),
  INDEX `fk_venda_servico_venda1` (`venda_id` ASC),
  CONSTRAINT `fk_venda_servico_servico1`
    FOREIGN KEY (`servico_id`)
    REFERENCES `caiadoapp`.`servico` (`id`),
  CONSTRAINT `fk_venda_servico_venda1`
    FOREIGN KEY (`venda_id`)
    REFERENCES `caiadoapp`.`venda` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
