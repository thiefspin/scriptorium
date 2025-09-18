#!/usr/bin/env bash
# Shows commits, lines added, lines deleted, and churn (added+deleted) per author.

set -euo pipefail

git -c core.quotepath=off log --no-merges --numstat --format='author:%aN' -- "$@" |
awk '
  /^author:/ { a = substr($0,8); authors[a]=1; commits[a]++; next }
  NF==3 {
    add = $1; del = $2;
    if (add == "-") add = 0;
    if (del == "-") del = 0;
    added[a]  += add;
    deleted[a]+= del;
    churn[a]  += add + del;
  }
  END {
    for (a in authors) {
      printf "%-28s %10d %12d %12d %12d\n", a, commits[a]+0, added[a]+0, deleted[a]+0, churn[a]+0;
    }
  }
' | sort -k5,5nr | awk '
  BEGIN {
    printf "%-28s %10s %12s %12s %12s\n", "Author", "Commits", "Added", "Deleted", "Churn";
  }
  { print }
'
