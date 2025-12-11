#!/bin/bash

set -e

GIT_OWNER="csellers85"
GIT_REPO="media-expansion"
GIT_BRANCH="main"
GIT_PATH="./k3s-ansible-gitops/gitops"

echo "=== Flux GitHub Bootstrap ==="
echo "Owner:      $GIT_OWNER"
echo "Repository: $GIT_REPO"
echo "Branch:     $GIT_BRANCH"
echo "Path:       $GIT_PATH"
echo "--------------------------------------"

# Prompt for token
read -s -p "Enter your GitHub Personal Access Token (PAT): " GITHUB_TOKEN
echo ""

if [[ -z "$GITHUB_TOKEN" ]]; then
  echo "ERROR: No GitHub token provided."
  exit 1
fi

export GITHUB_TOKEN

# Check repo path exists locally
if [[ ! -d "$GIT_PATH" ]]; then
  echo "ERROR: The path '$GIT_PATH' does not exist locally."
  echo "Make sure your GitOps repo contains that directory."
  exit 1
fi

echo "Bootstrapping Flux with token authentication..."
flux bootstrap github \
  --token-auth \
  --owner="$GIT_OWNER" \
  --repository="$GIT_REPO" \
  --branch="$GIT_BRANCH" \
  --path="$GIT_PATH" \
  --personal

echo "--------------------------------------"
echo "✔ Flux bootstrap completed successfully!"
echo "✔ Your cluster is now managed by GitOps."
echo "--------------------------------------"
