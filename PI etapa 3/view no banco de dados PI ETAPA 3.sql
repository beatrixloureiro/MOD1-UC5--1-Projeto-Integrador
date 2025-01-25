-- Crie visões no banco de dados para consultas mais frequentes--
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

