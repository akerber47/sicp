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
    (half-adder input-1 input-2 sum carry)
    (set-signal! input-1 1)
    (propagate)
    (set-signal! input-2 1)
    (propagate))
  ; 3.24
  (let ((t (make-table-comp =)))
    ((t 'insert!) 2 'a)
    ((t 'insert!) 3 'b)
    (assert (eq? ((t 'lookup) 3) 'b))
    ((t 'insert!) 3 'c)
    (assert (eq? ((t 'lookup) 2) 'a))
    (assert (eq? ((t 'lookup) 3) 'c)))

  ; 3.25
  (let ((t (make-table)))
    (insert! '(a) 3 t)
    (insert! '(b c d) 4 t)
    (insert! '(b c e) 5 t)
    (assert (= (lookup '(a) t) 3))
    (assert (= (lookup '(b c d) t) 4))
    (assert (= (lookup '(b c e) t) 5)))

  ; 3.26
  (let ((t (make-tree-table)))
    (tree-insert!  5 'a t)
    (tree-insert! 10 'b t)
    (tree-insert!  7 'c t)
    (tree-insert! 15 'd t)
    (tree-insert!  3 'e t)
    (tree-insert!  1 'f t)
    (tree-insert! 25 'g t)
    (assert (eq? (tree-lookup  5 t)  'a))
    (assert (eq? (tree-lookup 10 t)  'b))
    (assert (eq? (tree-lookup  7 t)  'c))
    (assert (eq? (tree-lookup 15 t)  'd))
    (assert (eq? (tree-lookup  3 t)  'e))
    (assert (eq? (tree-lookup  1 t)  'f))
    (assert (eq? (tree-lookup 25 t)  'g)))
  "All tests passed!")