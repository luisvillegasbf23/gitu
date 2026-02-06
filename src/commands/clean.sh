#!/bin/sh
if git switch master 2>/dev/null || git checkout master 2>/dev/null; then
  echo "Switched to master."
elif git switch main 2>/dev/null || git checkout main 2>/dev/null; then
  echo "Switched to main."
else
  echo "Could not switch to master or main."
  exit 1
fi
current=$(git branch --show-current)
echo "Deleting other local branches..."
for b in $(git branch --format='%(refname:short)' | grep -v "^${current}$"); do
  git branch -D "$b"
done
echo "Done."
