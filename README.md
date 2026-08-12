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

---
© Análise Macro — https://analisemacro.com.br
