#!/bin/bash

# Substitua YOUR_API_KEY pela sua chave de API
API_KEY="d52171dfc4e36f92e7662d1f99f4ff93"
LEAGUE_ID="72" # ID da Série B do Brasileirão na API

# Função para formatar a data
function format_date() {
  date -d "$1" +"%d/%m/%Y %H:%M:%S"
}

# Função para obter informações sobre os próximos jogos
function get_upcoming_matches() {
  curl -s -X GET "https://v3.football.api-sports.io/fixtures?league=${LEAGUE_ID}&season=2024&next=10" \
    -H "x-rapidapi-key: ${API_KEY}" \
    -H "x-rapidapi-host: v3.football.api-sports.io" | jq -r '
    .response[] | 
    "Data: \(.fixture.date | fromdateiso8601 | strftime("%d/%m/%Y %H:%M:%S"))\nTime da Casa: \(.teams.home.name)\nTime Visitante: \(.teams.away.name)\n"'
}

# Função para obter informações sobre jogos em andamento
function get_live_matches() {
  curl -s -X GET "https://v3.football.api-sports.io/fixtures?league=${LEAGUE_ID}&season=2024&live=all" \
    -H "x-rapidapi-key: ${API_KEY}" \
    -H "x-rapidapi-host: v3.football.api-sports.io" | jq -r '
    .response[] | 
    "Data: \(.fixture.date | fromdateiso8601 | strftime("%d/%m/%Y %H:%M:%S"))\nTime da Casa: \(.teams.home.name) (\(.goals.home // "N/A"))\nTime Visitante: \(.teams.away.name) (\(.goals.away // "N/A"))\nStatus: \(.status.long // "N/A") (\(.status.short // "N/A")) - \(.status.elapsed // "N/A") minutos\n"'
}

echo "Próximos jogos da Série B do Brasileirão:"
get_upcoming_matches

echo "Jogos em andamento da Série B do Brasileirão:"
get_live_matches
