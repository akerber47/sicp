Solutions to exercises in Abelson and Sussman's [Structure and Interpretation
of Computer Programs (SICP)](http://mitpress.mit.edu/sicp/).

I'll be doing exercises from the first edition. There are some 2nd edition
exercises also, which are in the 2e/ directory.

## Running

Download and use MIT Scheme. There is an Ubuntu packge.

You can load and run a solution with
```
$ mit-scheme --load <filename>
```
This will drop you directly into a REPL for testing.  For a one-off test, try
```
$ mit-scheme --load <filename> --eval <code>
```

I don't have a formal test framework ready yet so I'm just doing
interactive testing. Logs of test cases I ran are in the `log-test/`
directory.

## Organization

- `src/` Solutions to programming exercises
- `log-test/` Log output for interactive testing of exercises
- `test/` Test cases for programming exercises
- `lib/` Support code from the book
