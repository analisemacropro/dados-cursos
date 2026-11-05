-- =====================================================
-- SCHEMA STAR PARA ANÁLISE DE CHURN - POSTGRESQL
-- =====================================================
-- Caso: Empresa de Streaming de Vídeo (tipo Netflix)
-- Objetivo: Analisar churn, receita e comportamento dos clientes
-- =====================================================

-- Limpeza (caso já exista)
DROP TABLE IF EXISTS fato_assinaturas CASCADE;
DROP TABLE IF EXISTS dim_clientes CASCADE;
DROP TABLE IF EXISTS dim_planos CASCADE;
DROP TABLE IF EXISTS dim_tempo CASCADE;
DROP TABLE IF EXISTS dim_conteudo CASCADE;
DROP TABLE IF EXISTS fato_visualizacoes CASCADE;

-- =====================================================
-- DIMENSÕES
-- =====================================================

-- Dimensão: Clientes
CREATE TABLE dim_clientes (
    cliente_id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    data_nascimento DATE,
    genero VARCHAR(20),
    estado VARCHAR(2),
    cidade VARCHAR(100),
    data_cadastro DATE,
    canal_aquisicao VARCHAR(50), -- Orgânico, Paid Ads, Indicação, etc
    segmento VARCHAR(50) -- Premium, Regular, Trial
);

-- Dimensão: Planos
CREATE TABLE dim_planos (
    plano_id SERIAL PRIMARY KEY,
    nome_plano VARCHAR(50),
    valor_mensal NUMERIC(10,2),
    num_telas INTEGER,
    qualidade VARCHAR(20), -- SD, HD, 4K
    permite_download BOOLEAN
);

-- Dimensão: Tempo
CREATE TABLE dim_tempo (
    data_id SERIAL PRIMARY KEY,
    data_completa DATE UNIQUE,
    ano INTEGER,
    trimestre INTEGER,
    mes INTEGER,
    nome_mes VARCHAR(20),
    semana_ano INTEGER,
    dia_semana INTEGER,
    nome_dia_semana VARCHAR(20),
    dia_mes INTEGER,
    eh_feriado BOOLEAN,
    eh_fim_semana BOOLEAN
);

-- Dimensão: Conteúdo
CREATE TABLE dim_conteudo (
    conteudo_id SERIAL PRIMARY KEY,
    titulo VARCHAR(200),
    tipo VARCHAR(50), -- Filme, Série, Documentário
    genero VARCHAR(100), -- Ação, Drama, Comédia, etc
    ano_lancamento INTEGER,
    classificacao_etaria VARCHAR(10),
    duracao_minutos INTEGER
);

-- =====================================================
-- TABELAS FATO
-- =====================================================

-- Fato: Assinaturas (histórico completo de cada período de assinatura)
CREATE TABLE fato_assinaturas (
    assinatura_id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES dim_clientes(cliente_id),
    plano_id INTEGER REFERENCES dim_planos(plano_id),
    data_inicio_id INTEGER REFERENCES dim_tempo(data_id),
    data_fim_id INTEGER REFERENCES dim_tempo(data_id), -- NULL se ainda ativo
    status VARCHAR(20), -- Ativo, Cancelado, Pausado
    motivo_cancelamento VARCHAR(100),
    valor_pago NUMERIC(10,2),
    dias_assinatura INTEGER,
    churned BOOLEAN -- Flag se houve churn
);

-- Fato: Visualizações (eventos de consumo de conteúdo)
CREATE TABLE fato_visualizacoes (
    visualizacao_id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES dim_clientes(cliente_id),
    conteudo_id INTEGER REFERENCES dim_conteudo(conteudo_id),
    data_id INTEGER REFERENCES dim_tempo(data_id),
    minutos_assistidos INTEGER,
    concluiu_conteudo BOOLEAN,
    dispositivo VARCHAR(50), -- TV, Mobile, Desktop
    horario TIME
);

-- =====================================================
-- POPULAR DIMENSÃO TEMPO (2023-2024)
-- =====================================================

INSERT INTO dim_tempo (data_completa, ano, trimestre, mes, nome_mes, semana_ano, 
                       dia_semana, nome_dia_semana, dia_mes, eh_feriado, eh_fim_semana)
SELECT 
    data::DATE,
    EXTRACT(YEAR FROM data) AS ano,
    EXTRACT(QUARTER FROM data) AS trimestre,
    EXTRACT(MONTH FROM data) AS mes,
    TO_CHAR(data, 'Month') AS nome_mes,
    EXTRACT(WEEK FROM data) AS semana_ano,
    EXTRACT(DOW FROM data) AS dia_semana,
    TO_CHAR(data, 'Day') AS nome_dia_semana,
    EXTRACT(DAY FROM data) AS dia_mes,
    FALSE AS eh_feriado, -- simplificado
    CASE WHEN EXTRACT(DOW FROM data) IN (0, 6) THEN TRUE ELSE FALSE END AS eh_fim_semana
FROM generate_series('2023-01-01'::DATE, '2024-12-31'::DATE, '1 day'::INTERVAL) AS data;

-- =====================================================
-- POPULAR DIMENSÃO PLANOS
-- =====================================================

INSERT INTO dim_planos (nome_plano, valor_mensal, num_telas, qualidade, permite_download)
VALUES 
    ('Básico', 19.90, 1, 'SD', FALSE),
    ('Padrão', 39.90, 2, 'HD', TRUE),
    ('Premium', 59.90, 4, '4K', TRUE),
    ('Trial', 0.00, 1, 'HD', FALSE);

-- =====================================================
-- POPULAR DIMENSÃO CLIENTES (500 clientes)
-- =====================================================

INSERT INTO dim_clientes (nome, email, data_nascimento, genero, estado, cidade, 
                          data_cadastro, canal_aquisicao, segmento)
SELECT 
    'Cliente ' || i,
    'cliente' || i || '@email.com',
    DATE '1970-01-01' + (RANDOM() * 18000)::INTEGER,
    CASE WHEN RANDOM() < 0.5 THEN 'Masculino' ELSE 'Feminino' END,
    (ARRAY['SP', 'RJ', 'MG', 'RS', 'BA', 'PR', 'SC'])[FLOOR(RANDOM() * 7 + 1)],
    (ARRAY['São Paulo', 'Rio de Janeiro', 'Belo Horizonte', 'Porto Alegre', 'Salvador', 
           'Curitiba', 'Florianópolis'])[FLOOR(RANDOM() * 7 + 1)],
    DATE '2023-01-01' + (RANDOM() * 365)::INTEGER,
    (ARRAY['Orgânico', 'Paid Ads', 'Indicação', 'Social Media', 'Email Marketing'])[FLOOR(RANDOM() * 5 + 1)],
    (ARRAY['Premium', 'Regular', 'Trial'])[FLOOR(RANDOM() * 3 + 1)]
FROM generate_series(1, 500) AS i;

-- =====================================================
-- POPULAR DIMENSÃO CONTEÚDO (100 títulos)
-- =====================================================

INSERT INTO dim_conteudo (titulo, tipo, genero, ano_lancamento, classificacao_etaria, duracao_minutos)
SELECT 
    CASE tipo_num
        WHEN 1 THEN 'Filme ' || i
        WHEN 2 THEN 'Série ' || i
        ELSE 'Documentário ' || i
    END,
    CASE tipo_num
        WHEN 1 THEN 'Filme'
        WHEN 2 THEN 'Série'
        ELSE 'Documentário'
    END,
    (ARRAY['Ação', 'Drama', 'Comédia', 'Terror', 'Ficção Científica', 'Romance', 'Suspense'])[FLOOR(RANDOM() * 7 + 1)],
    2018 + FLOOR(RANDOM() * 6)::INTEGER,
    (ARRAY['Livre', '10', '12', '14', '16', '18'])[FLOOR(RANDOM() * 6 + 1)],
    CASE tipo_num
        WHEN 1 THEN 90 + FLOOR(RANDOM() * 90)::INTEGER  -- Filmes: 90-180 min
        WHEN 2 THEN 40 + FLOOR(RANDOM() * 20)::INTEGER  -- Séries: 40-60 min por ep
        ELSE 60 + FLOOR(RANDOM() * 120)::INTEGER         -- Docs: 60-180 min
    END
FROM generate_series(1, 100) AS i,
     LATERAL (SELECT FLOOR(RANDOM() * 3 + 1)::INTEGER AS tipo_num) t;

-- =====================================================
-- POPULAR FATO ASSINATURAS (histórico realista)
-- =====================================================

-- Cenário realista de churn:
-- - 60% dos clientes permanecem ativos
-- - 40% cancelaram em algum momento
-- - Diferentes períodos de permanência

WITH assinaturas_base AS (
    SELECT 
        c.cliente_id,
        -- Plano inicial (muitos começam com Trial)
        CASE 
            WHEN RANDOM() < 0.3 THEN 4  -- 30% começam com Trial
            WHEN RANDOM() < 0.5 THEN 1  -- 20% Básico
            WHEN RANDOM() < 0.8 THEN 2  -- 30% Padrão
            ELSE 3                       -- 20% Premium
        END as plano_id,
        c.data_cadastro,
        -- Simular se vai cancelar ou não
        CASE WHEN RANDOM() < 0.40 THEN TRUE ELSE FALSE END as vai_cancelar,
        -- Tempo até cancelamento (se cancelar)
        FLOOR(RANDOM() * 365 + 30)::INTEGER as dias_ate_cancelamento
    FROM dim_clientes c
)
INSERT INTO fato_assinaturas (cliente_id, plano_id, data_inicio_id, data_fim_id, 
                              status, motivo_cancelamento, valor_pago, dias_assinatura, churned)
SELECT 
    ab.cliente_id,
    ab.plano_id,
    dt_inicio.data_id as data_inicio_id,
    CASE 
        WHEN ab.vai_cancelar THEN dt_fim.data_id
        ELSE NULL 
    END as data_fim_id,
    CASE 
        WHEN ab.vai_cancelar THEN 'Cancelado'
        ELSE 'Ativo'
    END as status,
    CASE 
        WHEN ab.vai_cancelar THEN 
            (ARRAY['Preço alto', 'Pouco conteúdo', 'Problemas técnicos', 
                   'Não usa mais', 'Concorrência', 'Qualidade ruim'])[FLOOR(RANDOM() * 6 + 1)]
        ELSE NULL
    END as motivo_cancelamento,
    CASE 
        WHEN ab.vai_cancelar THEN 
            p.valor_mensal * (ab.dias_ate_cancelamento / 30.0)
        ELSE 
            p.valor_mensal * (('2024-12-31'::DATE - ab.data_cadastro) / 30.0)
    END as valor_pago,
    CASE 
        WHEN ab.vai_cancelar THEN ab.dias_ate_cancelamento
        ELSE ('2024-12-31'::DATE - ab.data_cadastro)
    END as dias_assinatura,
    ab.vai_cancelar as churned
FROM assinaturas_base ab
JOIN dim_planos p ON ab.plano_id = p.plano_id
JOIN dim_tempo dt_inicio ON dt_inicio.data_completa = ab.data_cadastro
LEFT JOIN dim_tempo dt_fim ON dt_fim.data_completa = 
    CASE WHEN ab.vai_cancelar THEN ab.data_cadastro + ab.dias_ate_cancelamento ELSE NULL END;

-- =====================================================
-- POPULAR FATO VISUALIZAÇÕES (eventos de consumo)
-- =====================================================

-- Gerar visualizações realistas:
-- Clientes ativos assistem mais
-- Clientes que vão dar churn diminuem uso antes de cancelar

INSERT INTO fato_visualizacoes (cliente_id, conteudo_id, data_id, minutos_assistidos, 
                                concluiu_conteudo, dispositivo, horario)
SELECT 
    fa.cliente_id,
    FLOOR(RANDOM() * 100 + 1)::INTEGER as conteudo_id,
    dt.data_id,
    FLOOR(RANDOM() * 120 + 10)::INTEGER as minutos_assistidos,
    RANDOM() < 0.7 as concluiu_conteudo,
    (ARRAY['TV', 'Mobile', 'Desktop', 'Tablet'])[FLOOR(RANDOM() * 4 + 1)] as dispositivo,
    (TIME '18:00:00' + (RANDOM() * INTERVAL '6 hours'))::TIME as horario
FROM fato_assinaturas fa
-- Gerar entre 5 e 50 visualizações por cliente
CROSS JOIN LATERAL generate_series(1, FLOOR(RANDOM() * 45 + 5)::INTEGER) AS num_views
JOIN dim_tempo dt ON dt.data_completa BETWEEN 
    (SELECT data_completa FROM dim_tempo WHERE data_id = fa.data_inicio_id)
    AND COALESCE(
        (SELECT data_completa FROM dim_tempo WHERE data_id = fa.data_fim_id),
        '2024-12-31'
    )
    AND dt.data_completa >= (SELECT data_completa FROM dim_tempo WHERE data_id = fa.data_inicio_id) + (RANDOM() * 
        CASE WHEN fa.churned THEN fa.dias_assinatura * 0.7 ELSE fa.dias_assinatura END
    )::INTEGER
WHERE RANDOM() < 0.1; -- Limitar volume para performance

-- =====================================================
-- CRIAR ÍNDICES PARA PERFORMANCE
-- =====================================================

CREATE INDEX idx_fato_assinaturas_cliente ON fato_assinaturas(cliente_id);
CREATE INDEX idx_fato_assinaturas_datas ON fato_assinaturas(data_inicio_id, data_fim_id);
CREATE INDEX idx_fato_assinaturas_status ON fato_assinaturas(status);
CREATE INDEX idx_fato_visualizacoes_cliente ON fato_visualizacoes(cliente_id);
CREATE INDEX idx_fato_visualizacoes_data ON fato_visualizacoes(data_id);
CREATE INDEX idx_dim_tempo_data ON dim_tempo(data_completa);

-- =====================================================
-- COMENTÁRIOS E DOCUMENTAÇÃO
-- =====================================================

COMMENT ON TABLE dim_clientes IS 'Dimensão de clientes com dados demográficos e de aquisição';
COMMENT ON TABLE dim_planos IS 'Dimensão de planos de assinatura disponíveis';
COMMENT ON TABLE dim_tempo IS 'Dimensão temporal para análises de série histórica';
COMMENT ON TABLE dim_conteudo IS 'Dimensão de catálogo de conteúdo disponível';
COMMENT ON TABLE fato_assinaturas IS 'Fato de assinaturas com histórico completo e flag de churn';
COMMENT ON TABLE fato_visualizacoes IS 'Fato de consumo de conteúdo pelos clientes';

COMMENT ON COLUMN fato_assinaturas.churned IS 'Flag booleana indicando se o cliente cancelou (TRUE) ou permanece ativo (FALSE)';
COMMENT ON COLUMN fato_assinaturas.dias_assinatura IS 'Número de dias entre início e fim da assinatura (ou até hoje se ativo)';
COMMENT ON COLUMN fato_assinaturas.valor_pago IS 'Valor total pago durante o período de assinatura';