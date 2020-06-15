; Things SICP assumes to be defined which don't seem to
; be actually defined in this version of MIT scheme.

; Ch 2
(define (atom? x) (or (null? x) (not (list? x))))

(define nil ())
; NOTE:
;   In SICP, bools are assumed to be weakly typed:
;     - 't is true
;     - nil is false
;   in addition to their usual meanings (nil is empty list, 't
;   is a symbol).
;   However, they are strongly typed in this version of MIT
;   Scheme, so just use #t and #f as appropriate.

