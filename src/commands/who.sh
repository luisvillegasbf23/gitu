#!/bin/sh
echo "Git user (commits):"
printf "  name:  %s\n" "$(git config user.name 2>/dev/null || echo '—')"
printf "  email: %s\n" "$(git config user.email 2>/dev/null || echo '—')"
echo ""
echo "Remote (origin):"
origin=$(git config --get remote.origin.url 2>/dev/null)
if [ -n "$origin" ]; then
  echo "  $origin"
else
  echo "  (no remote origin)"
fi
