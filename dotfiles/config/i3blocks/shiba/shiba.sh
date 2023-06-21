#!/bin/sh
curl -s "https://api.binance.com/api/v3/avgPrice?symbol=SHIBEUR" | jq '.price' | bc | awk '{ printf("SHIB/EUR  %s\n"), $1 }'

