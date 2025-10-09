#!/usr/bin/env bash
set -euo pipefail

os=linux
arch=amd64

# Get latest version (e.g., go1.25.1)
latest=$(curl -fsSL "https://go.dev/VERSION?m=text" | head -n1 | tr -d '\r')
if [[ -z "$latest" ]]; then
  echo "❌ Failed to fetch latest Go version" >&2
  exit 1
fi
echo "➡️  Latest Go version: $latest"

file="${latest}.${os}-${arch}.tar.gz"
url="https://go.dev/dl/${file}"

echo "⬇️  Downloading ${url} ..."
curl -LO "$url"

# Remove old Go installation
if [ -d /usr/local/go ]; then
  echo "🧹 Removing old /usr/local/go ..."
  sudo rm -rf /usr/local/go
fi

# Extract to /usr/local
echo "📦 Extracting to /usr/local ..."
sudo tar -C /usr/local -xzf "$file"
rm "$file"
