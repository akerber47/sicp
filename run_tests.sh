#!/bin/bash

# Retrieve test to run
if [[ -n "$1" ]]; then
  mit-scheme --load "prelude.scm" "src/$1.scm" "test/$1.scm" --eval '(run)' </dev/null
else
  # Run all tests, one at a time
  for f in $(ls src/*.scm); do
    fn=$(basename $f)
    if [[ -f "test/$fn" ]]; then
      mit-scheme --load "prelude.scm" "src/$fn" "test/$fn" --eval '(run)' </dev/null
    fi
  done
fi
