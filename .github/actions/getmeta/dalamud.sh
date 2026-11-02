#!/usr/bin/env bash
set -euo pipefail

say() {
    echo "$@" | tee -a $GITHUB_OUTPUT
}

schema="$(curl -f https://kamori.goats.dev/Dalamud/Release/meta)"

if [ -z "$DALAMUD_VERSION" ]; then
    DALAMUD_VERSION=$(jq -er .release.assemblyVersion <<< $schema | cut -d. -f1)
fi

if [ -z "$DOTNET_VERSION" ]; then
    DOTNET_VERSION=$(jq -er .release.runtimeVersion <<< $schema | cut -d. -f1-2)
fi

say "dalamud_version=$DALAMUD_VERSION"
say "dotnet_version=$DOTNET_VERSION"
