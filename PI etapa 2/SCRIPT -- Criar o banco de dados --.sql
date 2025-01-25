-- Criar o banco de dados --

CREATE DATABASE IF NOT EXISTS sistema_condominio;

USE sistema_condominio;

-- Tabela de Apartamentos --
CREATE TABLE IF NOT EXISTS apartamentos (
    id_apartamento INT AUTO_INCREMENT,
    numero_apartamento INT NOT NULL,
    PRIMARY KEY (id_apartamento)
);

-- Tabela de Moradores --
CREATE TABLE IF NOT EXISTS moradores (
    id_morador INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    id_apartamento INT,
    FOREIGN KEY (id_apartamento) REFERENCES apartamentos(id_apartamento),
    PRIMARY KEY (id_morador)
);

-- Tabela de Áreas Comuns --
CREATE TABLE IF NOT EXISTS areas_comuns (
    id_area_comum INT AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    disponivel BOOLEAN NOT NULL,
    PRIMARY KEY (id_area_comum)
    );

-- Tabela de Reservas --
CREATE TABLE IF NOT EXISTS reservas (
    id_reserva INT AUTO_INCREMENT,
    id_apartamento INT,
    id_area_comum INT,
    data_reserva DATE NOT NULL,
    PRIMARY KEY (id_reserva),
    FOREIGN KEY (id_apartamento) REFERENCES apartamentos(id_apartamento),
    FOREIGN KEY (id_area_comum) REFERENCES areas_comuns(id_area_comum)
);

-- Tabela de Despesas --
CREATE TABLE IF NOT EXISTS despesas (
    id_despesa INT AUTO_INCREMENT,
    descricao VARCHAR(255) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    data_despesa DATE NOT NULL,
    PRIMARY KEY (id_despesa)
);

-- Tabela de Pagamentos das Cotas Condominio --
CREATE TABLE IF NOT EXISTS cotas_condominio (
    id_cotascondominio  INT AUTO_INCREMENT,
    valor_pago DECIMAL(10, 2) NOT NULL,
    data_pagamento DATE NOT NULL,
    id_apartamento INT,
    PRIMARY KEY ( id_cotascondominio),
    FOREIGN KEY (id_apartamento) REFERENCES apartamentos(id_apartamento)    
);
