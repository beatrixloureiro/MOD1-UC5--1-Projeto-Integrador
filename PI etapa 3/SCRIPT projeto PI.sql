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


SELECT * FROM mysql.user; 

CREATE USER 'user_morador'@'localhost' IDENTIFIED by 'user_morador';

GRANT SELECT ON *.* to 'user_morador'@'localhost';

CREATE USER 'user_administrador'@'localhost' IDENTIFIED by 'user_administrador';

GRANT ALL PRIVILEGES ON *.* TO 'user_administrador'@'localhost';

CREATE USER 'user_sindico'@'localhost' IDENTIFIED by 'user_sindico';

GRANT ALL PRIVILEGES ON *.* TO 'user_sindico'@'localhost';

-- Inserir moradores -- 

INSERT INTO moradores (nome, email, telefone, id_morador) VALUES
('João Silva', 'joao.silva@email.com', '8188888888', 1),
('Maria Oliveira', 'maria.oliveira@email.com', '8199999999', 2),
('Pedro Santos', 'pedro.santos@email.com', '8112345678', 3),
('Ana Costa', 'ana.costa@email.com', '8123456789', 4),
('Carlos Pereira', 'carlos.pereira@email.com', '8134567890', 5),
('Amanda Rocha', 'amanda.rocha@email.com', '8145678901', 6),
('Lucas Lima', 'lucas.lima@email.com', '8156789012', 7),
('Isabela Almeida', 'isabela.almeida@email.com', '8167890123', 8),
('Gabriel Oliveira', 'gabriel.oliveira@email.com', '8178901234', 9),
('Larissa Souza', 'larissa.souza@email.com', '8189012345', 10),
('Rafael Martins', 'rafael.martins@email.com', '8190123456', 11),
('Beatriz Costa', 'beatriz.costa@email.com', '8191234567', 12),
('Vinícius Pereira', 'vinicius.pereira@email.com', '8192345678', 13),
('Juliana Santos', 'juliana.santos@email.com', '8193456789', 14),
('Bruno Oliveira', 'bruno.oliveira@email.com', '8194567890', 15),
('Fernanda Lima', 'fernanda.lima@email.com', '8195678901', 16),
('Gustavo Almeida', 'gustavo.almeida@email.com', '8196789012', 17),
('Mariana Rocha', 'mariana.rocha@email.com', '8197890123', 18),
('Rodrigo Costa', 'rodrigo.costa@email.com', '8198901234', 19),
('Camila Silva', 'camila.silva@email.com', '8199012345', 20),
('Felipe Oliveira', 'felipe.oliveira@email.com', '8190123456', 21),
('Isadora Santos', 'isadora.santos@email.com', '8191234567', 22),
('Thiago Lima', 'thiago.lima@email.com', '8192345678', 23),
('Vitória Pereira', 'vitoria.pereira@email.com', '8193456789', 24),
('Eduardo Costa', 'eduardo.costa@email.com', '8194567890', 25),
('Luana Oliveira', 'luana.oliveira@email.com', '8195678901', 26),
('Fernando Almeida', 'fernando.almeida@email.com', '8196789012', 27),
('Natália Rocha', 'natalia.rocha@email.com', '8197890123', 28),
('Ricardo Santos', 'ricardo.santos@email.com', '8198901234', 29),
('Patrícia Silva', 'patricia.silva@email.com', '8199012345', 30);

-- Areas comuns --
INSERT INTO areas_comuns (nome, disponivel) VALUES
('Salao de Festas', TRUE),
('Churrasqueira', TRUE),
('Piscina', TRUE);

-- Inserir tabela de Apartamentos --
INSERT INTO apartamentos (numero_apartamento, id_apartamento)
VALUES
(101, 1),
(102, 2),
(201, 3),
(202, 4),
(301, 5),
(302, 6),
(401, 7),
(402, 8),
(501, 9),
(502, 10),
(601, 11),
(602, 12),
(701, 13),
(702, 14),
(801, 15),
(802, 16),
(901, 17),
(902, 18),
(1001, 19),
(1002, 20),
(1101, 21),
(1102, 22),
(1201, 23),
(1202, 24),
(1301, 25),
(1302, 26),
(1401, 27),
(1402, 28),
(1501, 29),
(1502, 30);

-- Populando a tabela de Despesas --
INSERT INTO despesas (descricao, valor, data_despesa) VALUES
('Manutenção Elevadores', 1500.00, '2023-01-15'),
('Limpeza Áreas Comuns', 800.00, '2023-01-20'),
('Seguro Condomínio', 1200.00, '2023-02-05'),
('Pintura Fachada', 2000.00, '2023-02-10'),
('Água e Esgoto', 600.00, '2023-02-15'),
('Manutenção Portaria Eletrônica', 1000.00, '2023-03-01'),
('Jardinagem', 500.00, '2023-03-05'),
('Desinsetização', 300.00, '2023-03-10'),
('Manutenção Interfones', 700.00, '2023-01-25'),
('Energia Áreas Comuns', 900.00, '2023-01-30'),
('Limpeza Caixa Dágua', 400.00, '2023-02-20'),
('Manutenção Extintores', 800.00, '2023-02-25'),
('Coleta de Lixo', 300.00, '2023-03-15'),
('Manutenção Câmeras Segurança', 1200.00, '2023-03-20'),
('Reparos Portões', 600.00, '2023-01-10'),
('Despesas Administrativas', 1000.00, '2023-01-05'),
('Manutenção Telhado', 1500.00, '2023-02-15'),
('Limpeza Caixa de Gordura', 400.00, '2023-02-28'),
('Manutenção Bombas Hidráulicas', 700.00, '2023-03-05'),
('Recarga Extintores', 200.00, '2023-03-10');

-- Populando a tabela cotas_condominio --
INSERT INTO cotas_condominio (valor_pago, data_pagamento, id_apartamento) VALUES
(500.00, '2023-01-01', 1),
(500.00, '2023-01-01', 2),
(500.00, '2023-01-01', 3),
(500.00, '2023-01-01', 4),
(500.00, '2023-01-01', 5),
(500.00, '2023-01-01', 6),
(500.00, '2023-01-01', 7),
(500.00, '2023-01-01', 8),
(500.00, '2023-01-01', 9),
(500.00, '2023-01-01', 10),
(500.00, '2023-01-01', 11),
(500.00, '2023-01-01', 12),
(500.00, '2023-01-01', 13),
(500.00, '2023-01-01', 14),
(500.00, '2023-01-01', 15),
(500.00, '2023-01-01', 16),
(500.00, '2023-01-01', 17),
(500.00, '2023-01-01', 18),
(500.00, '2023-01-01', 19),
(500.00, '2023-01-01', 20),
(500.00, '2023-01-01', 21),
(500.00, '2023-01-01', 22),
(500.00, '2023-01-01', 23),
(500.00, '2023-01-01', 24),
(500.00, '2023-01-01', 25),
(500.00, '2023-01-01', 26),
(500.00, '2023-01-01', 27),
(500.00, '2023-01-01', 28),
(500.00, '2023-01-01', 29),
(500.00, '2023-01-01', 30);

-- Populando a tabela de Reservas --
INSERT INTO reservas (id_apartamento, id_area_comum, data_reserva) VALUES
(1, 1, '2023-01-05'),
(2, 2, '2023-01-10'),
(3, 3, '2023-01-15'),
(4, 1, '2023-01-20'),
(5, 2, '2023-01-25'),
(6, 3, '2023-01-30'),
(7, 1, '2023-02-05'),
(8, 2, '2023-02-10'),
(9, 3, '2023-02-15'),
(10, 1, '2023-02-20'),
(11, 2, '2023-02-25'),
(12, 3, '2023-03-05'),
(13, 1, '2023-03-10'),
(14, 2, '2023-03-15'),
(15, 3, '2023-03-20'),
(16, 1, '2023-03-25'),
(17, 2, '2023-04-01'),
(18, 3, '2023-04-05'),
(19, 1, '2023-04-10'),
(20, 2, '2023-04-15'),
(21, 3, '2023-04-20'),
(22, 1, '2023-04-25'),
(23, 2, '2023-05-01'),
(24, 3, '2023-05-05'),
(25, 1, '2023-05-10'),
(26, 2, '2023-05-15'),
(27, 3, '2023-05-20'),
(28, 1, '2023-05-25'),
(29, 2, '2023-06-01'),
(30, 3, '2023-06-05');
