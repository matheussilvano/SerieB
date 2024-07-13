#!/bin/bash

# Substitua YOUR_API_KEY pela sua chave de API
API_KEY="d52171dfc4e36f92e7662d1f99f4ff93"
LEAGUE_ID="72" # ID da Série B do Brasileirão na API

# Função para formatar a data (removendo os segundos)
function format_date() {
  local iso_date="$1"
  if [ -n "$iso_date" ]; then
    local formatted_date=$(date -d "${iso_date/T/ }" +"%d/%m/%Y %H:%M")
    echo "$formatted_date"
  else
    echo "Data não disponível"
  fi
}

# Função para obter informações sobre os próximos jogos
function get_upcoming_matches() {
  curl -s -X GET "https://v3.football.api-sports.io/fixtures?league=${LEAGUE_ID}&season=2024&next=10" \
    -H "x-rapidapi-key: ${API_KEY}" \
    -H "x-rapidapi-host: v3.football.api-sports.io" | jq -r '
    .response[] |
    select(.fixture.date) | 
    "\(.fixture.date) | Time da Casa: \(.teams.home.name) | Time Visitante: \(.teams.away.name)\n"' | while IFS="|" read -r data home away; do
      formatted_date=$(format_date "$data")
      if [ "$formatted_date" != "Data não disponível" ]; then
        echo -e "Data: $formatted_date\nTime da Casa: $home\nTime Visitante: $away\n"
      fi
    done
}

# Função para obter informações sobre jogos em andamento
function get_live_matches() {
  curl -s -X GET "https://v3.football.api-sports.io/fixtures?league=${LEAGUE_ID}&season=2024&live=all" \
    -H "x-rapidapi-key: ${API_KEY}" \
    -H "x-rapidapi-host: v3.football.api-sports.io" | jq -r '
    .response[] |
    select(.fixture.date) |
    "\(.fixture.date) | Time da Casa: \(.teams.home.name) (\(.goals.home // "N/A")) | Time Visitante: \(.teams.away.name) (\(.goals.away // "N/A")) | Status: \(.status.long // "Desconhecido") (\(.status.short // "N/A")) - \(.status.elapsed // "Desconhecido") minutos\n"' | while IFS="|" read -r data home away status; do
      formatted_date=$(format_date "$data")
      if [ "$formatted_date" != "Data não disponível" ]; then
        echo -e "Data: $formatted_date\nTime da Casa: $home\nTime Visitante: $away\n$status\n"
      fi
    done
}

echo "Próximos jogos da Série B do Brasileirão:"
get_upcoming_matches

echo "Jogos em andamento da Série B do Brasileirão:"
get_live_matches
