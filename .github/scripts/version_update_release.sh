#!/usr/bin/env bash

set -e

function die() {
  echo "$*"
  exit 1
}

function commit_and_push_to_git() {
  local message="$1"
  local path_to_file="$2"
  local branch

  git config --local user.email "action@github.com"
  git config --local user.name "$GITHUB_ACTOR"

  if [ -n "$(git status --porcelain --untracked-files=no)" ]; then
    (git add ${path_to_file} && git commit -m "${message}" ${path_to_file}) || die "Failed to commit changes to git"

    branch=$(git rev-parse --abbrev-ref HEAD)
    git fetch origin "${branch}"
    git rebase origin/"${branch}"
    git push origin "${branch}"
  else
    echo "There is no Changes to commit"
  fi
}

tf_variables_file="${GITHUB_WORKSPACE}/terraform/AWS/serverless-gateway/variables.tf"
new_image_tag="${version}"

sed -i "/variable \"image_tag\"/,/default     =/ s/default     = \".*\"/default     = \"$new_image_tag\"/" "${tf_variables_file}"

commit_and_push_to_git "Updated Serverless-Gateway version to latest: ${version}" "${tf_variables_file}"

