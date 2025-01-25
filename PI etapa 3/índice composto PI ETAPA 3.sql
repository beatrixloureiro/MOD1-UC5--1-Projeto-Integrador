-- Crie ao menos um índice composto para uma das tabelas --
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