(include "lib/3.circuits.scm")

; 3.28
(define (or-gate a1 a2 output)
  (define (or-action-procedure)
    (let ((new-value (logical-or (get-signal a1) (get-signal a2))))
      (after-delay or-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure))

(define (logical-or x y)
  (cond ((or (= x 1) (= y 1)) 1)
        (else 0)))

; 3.29
(define (compound-or-gate a b o)
  (let ((c (make-wire))
        (d (make-wire))
        (e (make-wire)))
    (inverter a c)
    (inverter b d)
    (and-gate c d e)
    (inverter e o)))

; 3.30
(define (ripple-carry-adder as bs ss c)
  (cond
    ((or (null? as) (null? bs) (null? ss))
     'done)
    ((or (null? (cdr as)) (null? (cdr bs)) (null? (cdr ss)))
     (half-adder (car as) (car bs) (car ss) c))
    (else
      (let ((c-next (make-wire)))
        (half-adder (car as) (car bs) (car ss) c-next)
        (ripple-carry-adder-full (cdr as) (cdr bs) c-next (cdr ss) c)))))

(define (ripple-carry-adder-full as bs c-in ss c-out)
  (cond
    ((or (null? as) (null? bs) (null? ss))
     'done)
    ((or (null? (cdr as)) (null? (cdr bs)) (null? (cdr ss)))
     (full-adder (car as) (car bs) c-in (car ss) c-out))
    (else
      (let ((c-next (make-wire)))
        (full-adder (car as) (car bs) c-in (car ss) c-next)
        (ripple-carry-adder-full (cdr as) (cdr bs) c-next (cdr ss) c-out)))))

