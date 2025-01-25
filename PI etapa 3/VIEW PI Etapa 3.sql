-- VIEW para somar despesas totais --

CREATE VIEW vw_despesas AS
SELECT
    SUM(d.valor) AS total_despesas
FROM despesas d;

SELECT * FROM vw_despesas;

-- Visão para listar as despesas por data mais recente --
CREATE VIEW vw_despesas_recentes AS
SELECT
    id_despesa,
    descricao,
    valor,
    data_despesa
FROM despesas
ORDER BY data_despesa DESC;

SELECT * FROM vw_despesas_recentes;