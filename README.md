# dados-cursos

Conjuntos de dados reutilizados nos cursos da **Análise Macro** (páginas de aula, exercícios e projetos guiados), hospedados aqui para acesso estável via URL *raw* — sem depender de contas ou links de terceiros.

## Arquivos

- **`dados.xml`** — IPCA (variação mensal, IBGE/SIDRA) em formato XML, para as aulas de leitura de dados (ex.: "Arquivos XML"). Uso:
  ```python
  import pandas as pd
  pd.read_xml("https://raw.githubusercontent.com/analisemacropro/dados-cursos/main/dados.xml")
  ```

---
© Análise Macro — https://analisemacro.com.br
