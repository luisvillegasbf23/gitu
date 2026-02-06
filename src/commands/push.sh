#!/bin/sh
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "Usage: gitu push <branch> <message> <file> [file2 ...]"
  exit 1
fi
branch="$1"
message="$2"
shift 2
for f in "$@"; do
  git add "$f"
done
git commit -m "$message"
git push origin "$branch"
