#!/bin/bash

# Substitua YOUR_API_KEY pela sua chave de API da https://dashboard.api-football.com/
API_KEY="d52171dfc4e36f92e7662d1f99f4ff93"
LEAGUE_ID="71" # ID da Série B do Brasileirão na API de Futebol (verifique o ID correto na documentação da API)

# Função para obter informações sobre os próximos jogos
function get_upcoming_matches() {
  curl -s -X GET "https://v3.football.api-sports.io/fixtures?league=${LEAGUE_ID}&season=2024&next=10" \
    -H "x-rapidapi-key: ${API_KEY}" \
    -H "x-rapidapi-host: v3.football.api-sports.io" | jq '.response[] | {date: .fixture.date, teams: .teams, status: .fixture.status}'
}

# Função para obter informações sobre jogos em andamento
function get_live_matches() {
  curl -s -X GET "https://v3.football.api-sports.io/fixtures?league=${LEAGUE_ID}&season=2024&live=all" \
    -H "x-rapidapi-key: ${API_KEY}" \
    -H "x-rapidapi-host: v3.football.api-sports.io" | jq '.response[] | {date: .fixture.date, teams: .teams, goals: .goals, status: .fixture.status}'
}

echo "Próximos jogos da Série B do Brasileirão:"
get_upcoming_matches

echo "Jogos em andamento da Série B do Brasileirão:"
get_live_matches
