# dados-cursos

Conjuntos de dados reutilizados nos cursos da **Análise Macro** (páginas de aula, exercícios e projetos guiados), hospedados aqui para acesso estável via URL *raw* — sem depender de contas ou links de terceiros.

## Arquivos

### Raiz — comuns a mais de um curso

- **`dados.xml`** — IPCA (variação mensal, IBGE/SIDRA) em formato XML, para as aulas de leitura de dados (ex.: "Arquivos XML"). Uso:
  ```python
  import pandas as pd
  pd.read_xml("https://raw.githubusercontent.com/analisemacropro/dados-cursos/main/dados.xml")
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
