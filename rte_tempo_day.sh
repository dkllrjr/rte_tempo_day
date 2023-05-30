#!/bin/bash

source ./.env

OAUTH=$(curl "https://digital.iservices.rte-france.com/token/oauth/" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -H "Authorization: Basic $OAUTH_KEY")

TOKEN=$(echo $OAUTH | jq '.access_token')
TOKEN="${TOKEN//\"}"

sleep 0.1

DAY=$(curl "https://digital.iservices.rte-france.com/open_api/tempo_like_supply_contract/v1/tempo_like_calendars" \
    -H "Authorization: Bearer $TOKEN")

sleep 0.1

echo $DAY | jq '.tempo_like_calendars.values[0].value'
