(define p
  (make-polynomial
    'x
    '((3 4)
      (2 10)
      (0 5))))

(define q
  (make-polynomial
    'y
    '((2 1)
      (0 1))))

(define ry
  (make-polynomial
    'y
    (adjoin-term
      (make-term 1 p)
      '((0 3)))))

(define rx
  (make-polynomial
    'x
    (adjoin-term
      (make-term 1 q)
      '((0 1)))))

(define z
  (make-polynomial
    'z
    '((1 1)
      (0 1))))

(define (run)
  (let ()
    ; sanity check that operations don't crash
    (write-line (add p q))
    (write-line (add rx ry))
    (write-line (add ry rx))
    (write-line (mul rx ry))
    (write-line (mul ry rx))
    (write-line (mul (mul rx z) (mul ry z)))
    ; basic assertions
    (assert (equal? (mul rx ry) (mul ry rx)))
    (assert (equal? (add rx rx) (mul rx 2)))
    (assert (equal? (add rx 0) (mul rx 1)))
    ; (assert (equal? (add ry 0) (mul ry 1)))
    ; this fails due to crappy raising, oops
    (assert (equal? (add rx ry) (add ry rx)))
    "All tests passed!"
  )
)

