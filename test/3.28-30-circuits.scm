; library
(define the-agenda (make-agenda))
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)


; ... TODO
;

(define (run)
  ; library
  (let ((input-1 (make-wire))
        (input-2 (make-wire))
        (sum (make-wire))
        (carry (make-wire)))
    (probe 'sum sum)
    (probe 'carry carry)
    (and-gate input-1 input-2 sum)
    (set-signal! input-1 1)
    (propagate)
    (set-signal! input-2 1)
    (propagate))
  "All tests passed!")
