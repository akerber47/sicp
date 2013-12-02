Solutions to exercises in Abelson and Sussman's [Structure and Interpretation
of Computer Programs (SICP)](http://mitpress.mit.edu/sicp/).

## Language

Unfortunately, the Scheme dialect SICP uses is a bit of an oddball. It's mostly
[R5RS](http://www.schemers.org/Documents/Standards/R5RS/), but not quite, and
there are a fair number of additional definitions - in particular, a picture
library and a stream library. Neil Van Dyke has an
[implementation](http://www.neilvandyke.org/racket-sicp/) of this dialect, but
it suffers from a few serious flaws. In particular, it fails to implement many
of the necessary procedures relied upon by the book's exercises.

I chose to use a custom implementation of the SICP dialect built on top of
[Racket](http://racket-lang.org/) (formerly PLT Scheme). Following the lead of
the HtDP designers, I've also built a few "student languages" which restrict
the possible language elements to a small subset. Maybe these will be useful
someday.

To simply pull in the definitions:

	#lang r5rs ; or racket, etc.
	(require "sicp.scm")

To use a teaching languages:

	#lang sicp-ch2

This language restricts the student to the bindings and textbook code available
by the end of Ch 2.

## Installation

Someday I'll write some actual installation scripts, or put this up on PLaneT.
For now, you probably want to run

	raco link sicp-ch2 <path-to-install>/lang/sicp-ch2

so that your copy of racket will be able to find a teaching language that
you're using. There's probably also a way to do this through the menu system in
DrRacket, but I don't use DrRacket.

## Organization

- `src/` Solutions to programming exercises
- `txt/` Solutions to other exercises (in plaintext)
- `lang/` Implementation of the teaching languages

TODO: Where to put test cases?
