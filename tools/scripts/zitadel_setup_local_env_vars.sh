#!/usr/bin/env bash
set -euo pipefail

ZITADEL_URL="${1:-}"
TOKEN="${2:-}"

if [ -z "$ZITADEL_URL" ] || [ -z "$TOKEN" ]; then
  echo "❌ Error: missing arguments."
  echo "❌ Usage: pnpm run local:env <zitadel_url> <token>"
  exit 1
fi

# Write login-client.pat
echo "$TOKEN" > login-client.pat
echo "✅  login-client.pat created"

# Write apps/login/.env.local
cat > apps/login/.env.local <<EOF
ZITADEL_API_URL=$ZITADEL_URL
NEXT_PUBLIC_BASE_PATH=""
EMAIL_VERIFICATION=true
DEBUG=true
EOF

echo "✅  apps/login/.env.local created"