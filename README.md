# dados-cursos

Conjuntos de dados reutilizados nos cursos da **Análise Macro** (páginas de aula, exercícios e projetos guiados), hospedados aqui para acesso estável via URL *raw* — sem depender de contas ou links de terceiros.

## Arquivos

### Raiz — comuns a mais de um curso

- **`dados.xml`** — IPCA (variação mensal, IBGE/SIDRA) em formato XML, para as aulas de leitura de dados (ex.: "Arquivos XML"). Uso:
  ```python
  import pandas as pd
  pd.read_xml("https://raw.githubusercontent.com/analisemacropro/dados-cursos/main/dados.xml")
  ```

### `fad/` — Fundamentos de Análise de Dados

| Arquivo | Conteúdo | Aula |
|---|---|---|
| `weather_stations.db` | Banco SQLite com a tabela `station_data` (registros diários de estações meteorológicas) | FAD09 — Introdução à linguagem SQL |
| `dados.csv` | PIB trimestral (índice, IBGE tabela 1621, com ajuste sazonal, média 1995 = 100) | FAD14 — Regressão linear |
| `pib_potencial.xlsx` | Planilha com o cálculo manual da regressão (tendência do PIB) | FAD14 — Regressão linear |

Uso no R (o banco SQLite precisa ser baixado antes de conectar):

```r
db <- tempfile(fileext = ".db")
download.file("https://raw.githubusercontent.com/analisemacropro/dados-cursos/main/fad/weather_stations.db", db, mode = "wb")
con <- DBI::dbConnect(RSQLite::SQLite(), dbname = db)
```

### `pyi/` — Python para Investimentos

| Arquivo | Conteúdo | Aula |
|---|---|---|
| `iris.csv` | Base iris em CSV | PYI04 — Importação de dados |
| `iris.xlsx` | Base iris em planilha Excel | PYI04 — Importação de dados |
| `olympics.dta` | Base de atletas olímpicos em formato Stata | PYI04 — Importação de dados |
| `exemplo.pdf` | PDF de texto para extração | PYI04 — Importação de dados |
| `exemplo_tabela.pdf` | PDF com a tabela mtcars | PYI04 — Importação de dados |
| `casas_ponta_grossa.csv` | Anúncios de casas em Ponta Grossa (PR) | PYI06 — Visualização de dados |
| `auxilio_rj_2020.csv` | Auxílio emergencial no RJ, total por mês e município (abr–dez/2020, CGU) | PYI09 — Microdados |

Uso no Python:

```python
import pandas as pd
casas = pd.read_csv("https://raw.githubusercontent.com/analisemacropro/dados-cursos/main/pyi/casas_ponta_grossa.csv")
```

### `rad/` — Programação em R para Análise de Dados

| Arquivo | Conteúdo | Aula |
|---|---|---|
| `dados.csv` | PIB trimestral (índice), separado por vírgula | 13 — Arquivos CSV |
| `dados_pv.csv` | O mesmo PIB, separado por ponto e vírgula | 13 — Arquivos CSV |
| `votacao_secao_2022_AC_amostra.csv` | Votação por seção no Acre, eleições 2022 (TSE), amostra | 13 — Arquivos CSV |
| `dados.xlsx` | Série econômica em planilha Excel | 14 — Arquivos Excel |
| `PcambBCp.xlsx` | Câmbio (BCB), planilha com várias abas | 14 — Arquivos Excel |
| `tse.csv` | Votação por seção no Acre, eleições 2022 (TSE) | 17 — SQL |
| `dados.json` | Série do Banco Central em formato JSON | 20 — Arquivos JSON |

Uso no R:

```r
tabela <- readr::read_csv("https://raw.githubusercontent.com/analisemacropro/dados-cursos/main/rad/dados.csv")
```

Os arquivos do TSE são dados públicos de votação agregada por seção eleitoral, sem identificação de eleitores.


### `str/` — Séries Temporais usando o R

| Arquivo | Conteúdo | Aula |
|---|---|---|
| `cenarios.csv` | Matriz de cenários dos regressores (produção industrial, desemprego, Selic, câmbio e expectativa de IPCA) para fev/2025–jan/2026. Focus TOP5 coletado em 02–10/01/2025; demais séries por ETS. Coluna `periodo` em `AAAA-MM-DD` | 03 — Regressão de Séries Temporais |

Uso no R:

```r
cenarios <- readr::read_csv("https://raw.githubusercontent.com/analisemacropro/dados-cursos/main/str/cenarios.csv")
```


### `conjuntura/` — Análise de Conjuntura

Séries macroeconômicas usadas nos **exercícios interativos** do curso (páginas
`quarto-live`, que rodam Python/R no navegador). São recortes congelados das
fontes oficiais: como o WASM do navegador não faz coleta ao vivo, o exercício
lê o arquivo pronto. As **aulas** coletam direto da fonte — estes arquivos não
substituem a coleta que o curso ensina.

| Arquivo | Conteúdo | Fonte | Aula |
|---|---|---|---|
| `precos.csv` | IPCA, INPC e salário mínimo nominal, desde 2000 | IBGE/SIDRA, Ipeadata | 02 — Fundamentos |
| `pmc.csv` | Comércio varejista ampliado: número-índice e taxas | IBGE/SIDRA 8881 | 05 — PMC |
| `pms.csv` | Serviços: volume e receita nominal, por taxa | IBGE/SIDRA 8688 | 06 — PMS |
| `pim.csv` | Produção industrial por categoria econômica | IBGE/SIDRA 8887 | 07 — PIM-PF |
| `pnadc.csv` | Força de trabalho, ocupação e desocupação | IBGE/SIDRA 6318 | 08 — PNADC |
| `pib.csv` | PIB trimestral: número-índice com e sem ajuste sazonal | IBGE/SIDRA 1620 e 1621 | 04 — PIB |
| `caged.csv` | Admissões, desligamentos e saldo de emprego formal | Ipeadata (Novo CAGED) | 09 — CAGED |
| `ipca.csv` | IPCA: número-índice e variações | IBGE/SIDRA | 10 e 12 — Inflação |
| `ipca_grupos.csv` | IPCA por grupo, com peso e variação mensal | IBGE/SIDRA | 11 — Desvendando o IPCA |
| `nucleos.csv` | Núcleos de inflação (EX0, EX3, MS, DP, P55) e difusão | BCB/SGS | 13 — Núcleos |
| `credito.csv` | Concessões, saldos, juros, spread e inadimplência | BCB/SGS | 14 — Crédito |
| `focus.csv` | Expectativas de mercado (IPCA, Selic, câmbio, PIB) | BCB/Focus | 16 — Expectativas |
| `fiscal.csv` | Arrecadação por imposto (União e estados), em 2024 | Tesouro/SICONFI (DCA) | 17 — Dados fiscais |
| `internacional.csv` | Inflação, desemprego e PIB de vários países | FMI/IFS | 18 — Internacional |

Todos têm uma coluna `data` no formato `AAAA-MM-DD`. Uso:

```python
import pandas as pd
pd.read_csv("https://raw.githubusercontent.com/analisemacropro/dados-cursos/main/conjuntura/precos.csv")
```

```r
precos <- read.csv("https://raw.githubusercontent.com/analisemacropro/dados-cursos/main/conjuntura/precos.csv")
```

> A série do **Novo CAGED** começa em jan/2020: a anterior foi descontinuada
> na reformulação de 2020 e não é comparável com esta.

### `teoria-macro/` — Teoria Macroeconômica (R e Python)

Recortes congelados usados nos **projetos guiados** do curso (notebooks do Colab).
Os notebooks baixam daqui quando o arquivo não está na pasta `data/`.

| Arquivo | Conteúdo | Fonte | Projeto |
|---|---|---|---|
| `secao1_salario_minimo.csv` | Salário mínimo nominal e INPC (número-índice), mensal, 2000–2021 | IBGE, Ipeadata | Seção 1 — Salário mínimo |
| `secao2_pib_trimestral.csv` | PIB trimestral: número-índice sem e com ajuste sazonal, 1996T1–2026T2 | IBGE/SIDRA 1620 e 1621 | Seção 2 — Ciclo econômico |
| `secao3_pwt_solow.csv` | Brasil, Coreia do Sul e EUA, 1960–2019: PIB, população, emprego, investimento, depreciação e capital humano | Penn World Table 10.0 | Seção 3 — Convergência e Solow |
| `secao4_pnadc_renda.csv` | Amostra de 30 mil ocupados da PNADC (1º tri/2022): UF, peso reescalado, renda e deflator | IBGE/PNADC (microdados) | Seção 4 — Renda e consumo |
| `secao4_cnt_consumo.csv` | PIB, consumo das famílias e do governo e poupança bruta, trimestral, 2000–2026 | IBGE/SIDRA 1846 e 2072 | Seção 4 — Renda e consumo |
| `secao5_selic.csv` | Meta da Selic, mensal, 1999–2026 | BCB/SGS 432 | Seção 5 (R e Python) |
| `secao5_copom_sentimento.csv` | Índice de sentimento por ata do Copom (62ª à 281ª), com a data da reunião | Atas do Copom (BCB), dicionário Loughran-McDonald | Seção 5 — O tom do Copom (R) |
| `secao5_inflacao.csv` | IPCA acumulado em 12 meses e meta de inflação, mensal | BCB/SGS 13522 e 13521 | Seção 5 — Regra de Taylor (Python) |
| `secao5_pib.csv` | PIB trimestral com ajuste sazonal (número-índice) | IBGE/SIDRA 1621 | Seção 5 — Regra de Taylor (Python) |

Uso:

```python
import pandas as pd
pd.read_csv("https://raw.githubusercontent.com/analisemacropro/dados-cursos/main/teoria-macro/secao5_selic.csv")
```

```r
selic <- read.csv("https://raw.githubusercontent.com/analisemacropro/dados-cursos/main/teoria-macro/secao5_selic.csv")
```

---
© Análise Macro — https://analisemacro.com.br

### `modelagem-previsao/` — Modelagem e Previsão (R e Python)

Dados do curso **Modelagem e Previsão usando R e Python** (Análise Macro), lidos pelas
aulas e pelos projetos guiados. Nos notebooks, cada arquivo é baixado para a pasta
`dados/` (ou `data/`, no projeto) com o nome local indicado entre parênteses.

| Arquivo | O que é | Aula |
|---|---|---|
| `pnadc202204.csv` | Microdados da PNAD Contínua, 4º trimestre de 2022 (IBGE), só com as colunas usadas nas aulas | mpr18, mpr19, mppy18, mppy19 (`dados/pnadc202204.csv`) |
| `mp24_dados.csv` | Demanda horária por eletricidade em Victoria, Austrália, em MWh (AEMO) | mpr24, mppy24 (`dados/dados.csv`) |
| `Youtube04-Eminem.csv` | Comentários de um vídeo da YouTube Spam Collection (UCI), com a marcação de spam | mpr26, mppy26 (`dados/Youtube04-Eminem.csv`) |
| `mp26_dados_treino.csv` | Amostra de treino dos comentários, já tokenizada (matriz de termos) | mpr26, mppy26 (`dados/dados_treino.csv`) |
| `mp26_dados_teste.csv` | Amostra de teste dos comentários, já tokenizada (matriz de termos) | mpr26, mppy26 (`dados/dados_teste.csv`) |
| `Heart.csv` | Pacientes com e sem doença cardíaca (*An Introduction to Statistical Learning*) | mpr29, mppy29 (`dados/Heart.csv`) |
| `mppy21_dados.csv` | Preço de venda (`Y`) e área do lote (`X`) dos imóveis de Ames, Iowa (De Cock, 2011) | mppy21 (`dados/dados.csv`) |
| `mppy21_treino.csv` | Amostra de treino dos imóveis de Ames | mppy21 (`dados/treino.csv`) |
| `mppy21_teste.csv` | Amostra de teste dos imóveis de Ames | mppy21 (`dados/teste.csv`) |
| `mppy29_dados.csv` | Preços de carros usados da GM de 2005 (car_prices) | mppy29 (`dados/dados.csv`) |
| `mppy30_dados.csv` | Empréstimos do Lending Club no 1º trimestre de 2016 (lending_club) | mppy30 (`dados/dados.csv`) |
| `ames.csv` | Imóveis de Ames, Iowa: preço de venda e área do lote | mppy32 (`dados/ames.csv`) |
| `secao6_credit_data.csv` | Ficha de 4.454 clientes de crédito com a classificação bom/mau pagador (credit_data) | mppy28, mppy31 (`dados/dados.csv`); projeto da seção 6 em Python (`data/secao6_credit_data.csv`) |

Os arquivos de mesmo conteúdo nas duas trilhas (conferidos por MD5) aparecem uma vez só.
Nomes genéricos (`dados.csv`, `treino.csv`) levam o prefixo da aula para não colidir.


### `mfgp/` — Mercado Financeiro e Gestão de Portfólios

Arquivos lidos pelos notebooks das aulas e dos projetos guiados do curso (Python). Os projetos guiados são os notebooks do fim de cada seção.

| Arquivo | Conteúdo | Aula |
|---|---|---|
| `acoes_yf.csv` | Preços diários de ações do Yahoo Finance (Adj Close, Close, High, Low, Open, Volume) | Projeto Seção 1 |
| `agregados.csv` | Agregados monetários M1 a M4 (BCB/SGS) | Projeto Seção 2 |
| `cdi-diario.csv` | CDI diário (BCB/SGS) | Projeto Seção 4 |
| `cdi-mensal.csv` | CDI mensal (BCB/SGS) | Projeto Seção 5 |
| `credito.csv` | Concessões, saldos, taxas e inadimplência do crédito (BCB/SGS) | Projeto Seção 2 |
| `ettj_pre.csv` | Curva de juros prefixada DI x pré (B3) | Projeto Seção 3 |
| `focus_ipca_2023.csv` | Expectativas do Focus para o IPCA de 2023 (BCB) | Projeto Seção 1 |
| `focus_selic.csv` | Selic esperada pelo Focus, por data da pesquisa e reunião do Copom (BCB) | Projeto Seção 2 |
| `fundamentus.csv` | Indicadores fundamentalistas das ações (Fundamentus) | Projeto Seção 3 |
| `google_stock.csv` | Retornos diários do Google e do S&P 500 em 2015 (pacote causaldata) | Projeto Seção 5 |
| `ibovespa-diario.csv` | Ibovespa diário (Yahoo Finance) | Projeto Seção 4 |
| `ibovespa-mensal.csv` | Ibovespa mensal (Yahoo Finance) | Projeto Seção 5 |
| `ibovespa.csv` | Ibovespa diário com abertura, máxima, mínima, fechamento e volume (Yahoo Finance) | Projeto Seção 4 |
| `ipca.csv` | IPCA, variação mensal (BCB/SGS) | Projeto Seção 1 |
| `ipca_exp_12m.csv` | IPCA esperado para 12 meses à frente, Focus (BCB) | Projeto Seção 2 |
| `ipca_sidra.csv` | IPCA do IBGE/SIDRA | Projeto Seção 2 |
| `nefin_factors.csv` | Fatores de risco diários do NEFIN (mercado, SMB, HML, WML, IML, taxa livre de risco) | Projeto Seção 5 |
| `precos-diarios.csv` | Preços diários de BBDC4, ITSA4, GGBR4 e WEGE3 (Yahoo Finance) | Projetos Seções 4 e 5 |
| `precos-mensais-4acoes.csv` | Preços mensais de BBDC4, ITSA4, GGBR4 e WEGE3 (Yahoo Finance) | Projeto Seção 4 |
| `precos-mensais-capm.csv` | Preços mensais de BBDC4, ITSA4, VALE3 e WEGE3 (Yahoo Finance) | Projeto Seção 5 |
| `precotaxatesourodireto.csv` | Preços e taxas do Tesouro Direto, todos os títulos, 12/2004 a 08/2026 (planilhas históricas do Tesouro), separado por ponto e vírgula | Projeto Seção 3 |
| `retornos_itub4.csv` | Retornos diários da ITUB4, em % | Projeto Seção 1 |
| `sgs-mensais.csv` | Selic, CDB pré e pós, CDI, TJLP e TLP mensais (BCB/SGS; CDB até 01/2024) | Projeto Seção 3 |
| `treasuries.csv` | Treasuries de 10 e 3 anos (FRED) | Projeto Seção 1 |
| `IBOVDia_30-10-23.csv` | Carteira teórica do Ibovespa de 30/10/2023 (B3), separado por ponto e vírgula, latin1 | MFGP21 — Fama-French |
| `famafrench.csv` | Fatores de Fama-French dos EUA (Kenneth French), diários | MFGP22 — Estudo de eventos |
| `returns_GAFAM.csv` | Retornos diários de AAPL, AMZN, FB, GOOG, MSFT e SPY | MFGP22 — Estudo de eventos |

Uso no Python:

```python
import pandas as pd
retornos = pd.read_csv("https://raw.githubusercontent.com/analisemacropro/dados-cursos/main/mfgp/retornos_itub4.csv")
```

### `sql/` — SQL para Negócios e Tomada de Decisão

| Arquivo | Conteúdo | Uso |
|---|---|---|
| `rexon_metals.db` | Banco SQLite da Rexon Metals (tabelas `CUSTOMER`, `PRODUCT`, `CUSTOMER_ORDER`) | Projeto guiado do Módulo 4 |
| `dataset_star_schema_churn.sql` | Script PostgreSQL do esquema estrela de churn da StreamFlix (fato_assinaturas e dimensões; dados gerados com `random()`) | Projeto guiado do Módulo 5 |
| `backup_completo.sql` | Dump PostgreSQL do data warehouse da CVM (DFP 2019–2022: `dim_empresas`, contas, tempo e a tabela fato) | Aula 17 (indicadores financeiros) |

O banco `weather_stations.db` usado no Módulo 3 é o mesmo de `fad/`.

Uso no Python:

```python
import urllib.request, sqlite3
urllib.request.urlretrieve("https://raw.githubusercontent.com/analisemacropro/dados-cursos/main/sql/rexon_metals.db", "rexon_metals.db")
con = sqlite3.connect("rexon_metals.db")
```
