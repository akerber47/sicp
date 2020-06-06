#!/bin/bash

# this only works if running inside tmux, unfortunately

tmpfile=$(mktemp)
output="$1"
shift
echo "Saving to tempfile $tmpfile..."
"$@"
tmux capture-pane -S '-' -E '-' -p > $tmpfile
ln=$(cat $tmpfile | grep -n "$tmpfile" | cut -d ':' -f 1 | tail -n 1)

ln=$(($ln + 1))
cat $tmpfile | tail -n +$ln > $output
rm -f $tmpfile
