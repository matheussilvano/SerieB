# Script de Consulta de Jogos da Série B do Brasileirão

Este script em Bash utiliza a API de futebol para consultar e exibir informações sobre os próximos jogos e jogos em andamento da Série B do Brasileirão. Ele utiliza a Api-Football para obter os dados.

## Configuração
1. Obtenha uma Chave de API:
  - Você precisa de uma chave de API válida em https://dashboard.api-football.com/ para fazer as solicitações à API de futebol. Substitua YOUR_API_KEY no script pelo seu próprio.

2. Instale as Dependências:
  - Certifique-se de ter o curl e o jq instalados na sua máquina. Caso não tenha, você pode instalá-los conforme o sistema operacional que estiver utilizando.

## Funcionalidades

1. Próximos jogos da Série B do Brasileirão:
  Lista os próximos 10 jogos da Série B com as seguintes informações:
  Data e hora do jogo (formato dd/mm/YYYY HH:MM)
  Time da casa
  Time visitante
  Jogos em andamento da Série B do Brasileirão:

2. Lista os jogos da Série B que estão atualmente em andamento com as seguintes informações:
  Data e hora do jogo (formato dd/mm/YYYY HH:MM)
  Time da casa com o placar (se disponível)
  Time visitante com o placar (se disponível)
  Status do jogo (ex: "Em andamento - 30 minutos")

## Exemplo de saída
  Próximos jogos da Série B do Brasileirão:
  Data: 14/07/2024 16:00
  Time da Casa: Vila Nova
  Time Visitante: Avai
  
  Data: 14/07/2024 18:30
  Time da Casa: Chapecoense-sc
  Time Visitante: Brusque
  
  ...
  
  Jogos em andamento da Série B do Brasileirão:
  Data: 13/07/2024 18:00
  Time da Casa: CRB (1)
  Time Visitante: Coritiba (1)
  Status: Em andamento - 30 minutos

