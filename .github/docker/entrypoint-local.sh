#!/usr/bin/env bash

set -Eeuo pipefail
echo "Installing ${GITHUB_REPOSITORY-'dotfiles-zsh'} via LOCAL execution (${GITHUB_SHA-'HEAD'})"
./install.sh -d