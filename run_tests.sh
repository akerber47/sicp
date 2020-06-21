#!/bin/bash

if [[ "$1" == "--no-eval" ]]; then
  evalstr=""
else
  evalstr="--eval '(run)' </dev/null"
fi

# Retrieve test to run
if [[ -n "$1" ]]; then
  if [[ "$2" == "--no-eval" ]]; then
    mit-scheme --load "prelude.scm" "src/$1.scm" "test/$1.scm"
  elif [[ "$2" == "--no-tests" ]]; then
    mit-scheme --load "prelude.scm" "src/$1.scm"
  else
    mit-scheme --load "prelude.scm" "src/$1.scm" "test/$1.scm" --eval '(run)' </dev/null
  fi
else
  # Run all tests, one at a time
  for f in $(ls src/*.scm); do
    fn=$(basename $f)
    if [[ -f "test/$fn" ]]; then
      mit-scheme --load "prelude.scm" "src/$fn" "test/$fn" $evalstr
    fi
  done
fi
