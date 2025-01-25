-- indice Composto na Tabela Reservas (id_apartamento, data_reserva) --
-- Este índice é para consultas que envolvam a busca de reservas por apartamento e data --

CREATE INDEX idx_reservas_apartamento_data
ON reservas (id_apartamento, data_reserva);

-- Índice Composto na Tabela Reservas (id_area_comum, data_reserva) --
-- Este índice é para consultas que envolvam a busca de reservas por área comum e data --

CREATE INDEX idx_reservas_area_comum_data
ON reservas (id_area_comum, data_reserva);

-- Índice Composto na Tabela Reservas (id_apartamento, id_area_comum) --
-- Este índice é para consultas que envolvam a busca de reservas por apartamento e área comum --

CREATE INDEX idx_reservas_apartamento_area_comum
ON reservas (id_apartamento, id_area_comum);


-- FUNCTION Obter Nome do Morador por Número do Apartamento--
DELIMITER //

CREATE FUNCTION GetMoradorByNumeroApartamento(numero_apartamento_param INT)
RETURNS VARCHAR(100)
BEGIN
    DECLARE morador_nome VARCHAR(100);
    SELECT moradores.nome INTO morador_nome
    FROM moradores
    JOIN apartamentos ON moradores.id_apartamento = apartamentos.id_apartamento
    WHERE apartamentos.numero_apartamento = numero_apartamento_param;
    RETURN morador_nome;
END //

DELIMITER ;
SELECT GetMoradorByNumeroApartamento(102);

select * from moradores;

DELIMITER //

-- FUNCTION Obter Reservas por Morador --

CREATE FUNCTION GetReservasPorMorador(morador_id_param INT)
RETURNS INT
BEGIN
    DECLARE total_reservas INT;
    SELECT COUNT(reservas.id_reserva) INTO total_reservas
    FROM reservas
    JOIN moradores ON reservas.id_apartamento = moradores.id_apartamento
    WHERE moradores.id_morador = morador_id_param;
    RETURN total_reservas;
END //

DELIMITER ;

SELECT GetReservasPorMorador(5);

-- Listar Moradores por Apartamento--
DELIMITER //

CREATE PROCEDURE ListarMoradoresPorApartamento(apartamento_id_param INT)
BEGIN
    SELECT * FROM moradores
    WHERE id_apartamento = apartamento_id_param;
END //

DELIMITER ;
CALL ListarMoradoresPorApartamento (1);

-- Listar Despesas por Data--
DELIMITER //

CREATE PROCEDURE ListarDespesasPorData(data_despesa_param DATE)
BEGIN
    SELECT * FROM despesas
    WHERE data_despesa = data_despesa_param;
END //

DELIMITER ;
CALL ListarDespesasPorData('2023-02-15');


-- Trigger para Atualizar Disponibilidade de Área Comum após Reserva--
-- Esta trigger é acionada após a inserção de uma nova reserva na tabela reservas, 
-- ela atualiza a disponibilidade da área comum associada à reserva para FALSE.--
DELIMITER //

CREATE TRIGGER AtualizarDisponibilidadeAposReserva
AFTER INSERT ON reservas
FOR EACH ROW
BEGIN
    UPDATE areas_comuns
    SET disponivel = FALSE
    WHERE id_area_comum = NEW.id_area_comum;
END //

DELIMITER ;

-- Trigger para Atualizar Disponibilidade de Área Comum após Cancelamento de Reserva --
-- Essa trigger é acionada após a exclusão de uma reserva na tabela reservas,
-- Ela atualiza a disponibilidade da área comum associada à reserva cancelada para TRUE --
DELIMITER //

CREATE TRIGGER AtualizarDisponibilidadeAposCancelamento
AFTER DELETE ON reservas
FOR EACH ROW
BEGIN
    UPDATE areas_comuns
    SET disponivel = TRUE
    WHERE id_area_comum = OLD.id_area_comum;
END //

DELIMITER ;

-- Trigger para Verificar Pagamento de Cotas Condomínio --
-- Essa trigger é acionada antes da inserção de um novo pagamento na tabela cotas_condominio --
-- Ela verifica se o valor total pago pelas cotas condomínio é suficiente para cobrir as despesas acumuladas até a data do novo pagamento --
-- Se não for, ela gera um erro.
DELIMITER //

CREATE TRIGGER VerificarPagamentoCotas
BEFORE INSERT ON cotas_condominio
FOR EACH ROW
BEGIN
    DECLARE total_pago DECIMAL(10, 2);
    DECLARE total_devido DECIMAL(10, 2);

    SELECT SUM(valor_pago) INTO total_pago
    FROM cotas_condominio
    WHERE id_apartamento = NEW.id_apartamento;

    SELECT SUM(valor) INTO total_devido
    FROM despesas
    WHERE data_despesa <= NEW.data_pagamento;

    IF total_pago < total_devido THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pagamento insuficiente para cobrir as despesas do condomínio';
    END IF;
END //

DELIMITER ;


-- Visão para Saldo de Cotas Condomínio --
CREATE VIEW vw_saldo_cotas_condominio AS
SELECT
    c.id_apartamento,
    SUM(c.valor_pago) AS total_pago,
    (SELECT SUM(valor) FROM despesas) AS total_despesas,
    SUM(c.valor_pago) - (SELECT SUM(valor) FROM despesas) AS saldo
FROM
    cotas_condominio c
GROUP BY
    c.id_apartamento;

SELECT * FROM vw_saldo_cotas_condominio;

-- Visão para Despesas Agrupadas por Mês --
CREATE VIEW vw_despesas_por_mes AS
SELECT
    MONTH(data_despesa) AS mes,
    YEAR(data_despesa) AS ano,
    SUM(valor) AS total_despesas
FROM
    despesas
GROUP BY
    mes, ano;

SELECT * FROM vw_despesas_por_mes;

