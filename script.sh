#!/bin/bash

# Substitua YOUR_API_KEY pela sua chave de API
API_KEY="d52171dfc4e36f92e7662d1f99f4ff93"
LEAGUE_ID="72" # ID da Série B do Brasileirão na API

# Função para formatar a data
function format_date() {
  local iso_date="$1"
  local formatted_date=$(date -d "${iso_date/T/ }" +"%d/%m/%Y %H:%M:%S")
  echo "$formatted_date"
}

# Função para obter informações sobre os próximos jogos
function get_upcoming_matches() {
  curl -s -X GET "https://v3.football.api-sports.io/fixtures?league=${LEAGUE_ID}&season=2024&next=10" \
    -H "x-rapidapi-key: ${API_KEY}" \
    -H "x-rapidapi-host: v3.football.api-sports.io" | jq -r '
    .response[] | 
    "Data: \(.fixture.date) | Time da Casa: \(.teams.home.name) | Time Visitante: \(.teams.away.name)\n"' | while IFS="|" read -r date home away; do
      formatted_date=$(format_date "$date")
      echo -e "Data: $formatted_date\n$home\n$away\n"
    done
}

# Função para obter informações sobre jogos em andamento
function get_live_matches() {
  curl -s -X GET "https://v3.football.api-sports.io/fixtures?league=${LEAGUE_ID}&season=2024&live=all" \
    -H "x-rapidapi-key: ${API_KEY}" \
    -H "x-rapidapi-host: v3.football.api-sports.io" | jq -r '
    .response[] | 
    "Data: \(.fixture.date) | Time da Casa: \(.teams.home.name) (\(.goals.home // "N/A")) | Time Visitante: \(.teams.away.name) (\(.goals.away // "N/A")) | Status: \(.status.long // "N/A") (\(.status.short // "N/A")) - \(.status.elapsed // "N/A") minutos\n"' | while IFS="|" read -r date home away status; do
      formatted_date=$(format_date "$date")
      echo -e "Data: $formatted_date\n$home\n$away\n$status\n"
    done
}

echo "Próximos jogos da Série B do Brasileirão:"
get_upcoming_matches

echo "Jogos em andamento da Série B do Brasileirão:"
get_live_matches
