#!/bin/sh
current_branch=$(git branch --show-current)

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: gitu push <message> <file> [file2 ...]"
  echo "       (pushes to current branch: $current_branch)"
  exit 1
fi

shift 1
for f in "$@"; do
  git add "$f"
done
git commit -m "$1"
git push origin "$current_branch"
