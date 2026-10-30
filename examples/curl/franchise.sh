#!/usr/bin/env bash
# Franchise Direct Franchise API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./franchise.sh
set -euo pipefail

curl -sS -G "https://api.piloterr.com/v2/franchisedirect/franchise" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=https://www.franchisedirect.com/coffee-franchises/coffeenow
