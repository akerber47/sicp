; Things SICP assumes to be defined which don't seem to
; be actually defined in this version of MIT scheme.

; Ch 2
(define princ write)
(define print write-line)
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

; data-directed programming
(define type-operator-table '())

(define (put type op item)
  (set!
    type-operator-table
    (cons (list type op item) type-operator-table)))

(define (get type op)
  (get-from type op type-operator-table))
(define (get-from type op tbl)
  (cond ((null? tbl) '())
        ((and (eq? type (caar tbl))
              (eq? op (cadar tbl)))
         (caddar tbl))
        (else (get-from type op (cdr tbl)))))

; Ch 3
(define-syntax sequence
  (syntax-rules ()
    ((sequence stmt1 stmt2 ...)
     (begin stmt1 stmt2 ...))))

; (list? x) evaluates to #f if x is not properly list-shaped
; (circular, etc)
; to follow the books's usage, need to redefine it.
(define (atom? x) (not (pair? x)))
