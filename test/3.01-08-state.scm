; 3.03
(define acct (make-account 5 'swordfish))

; 3.05
(define new-acct (make-joint acct 'swordfish 'password))

; 3.07

(define (run)
  (let ((a (make-accumulator 5))
        (s (make-monitored sqrt)))
    ; 3.01
    (assert (= (a 10) 15))
    (assert (= (a 10) 25))
    ; 3.02
    (assert (= (s 100) 10))
    (assert (= (s 'how-many-calls?) 1))
    ; 3.03-04
    (assert (= ((acct 'deposit) 5 'swordfish) 10))
    (assert (equal? ((acct 'deposit) 5 'tuna)
                    "Incorrect password"))
    (assert (= ((acct 'withdraw) 10 'swordfish) 0))
    ; call the cops
    ((acct 'withdraw) 500 'tuna)
    ((acct 'withdraw) 500 'salmon)
    ((acct 'withdraw) 500 'xyzzy)
    ((acct 'withdraw) 500 'secret)
    ((acct 'withdraw) 500 'abcdef)
    ((acct 'withdraw) 500 'password)
    ((acct 'withdraw) 500 'abc123)
    ((acct 'withdraw) 500 'foo)

    ; 3.05
    (assert (= ((new-acct 'deposit) 10 'password) 10))
    (assert (equal? ((new-acct 'deposit) 5 'swordfish)
                    "Incorrect password"))
    (assert (= ((new-acct 'withdraw) 10 'password) 0))

    ; 3.06
    (write-line (+ (f 0) (f 1)))
    (write-line (+ (f 1) (f 0)))

    ; 3.07
    (let ((p (lambda (x y) (< (+ (square x) (square y)) 1))))
      (write-line (* 4.0 (estimate-integral p 0 1 0 1 10000))))

    ; 3.08
    (write-line ((rand 'generate) 10))
    (write-line ((rand 'generate) 100))
    ((rand 'reset) (make-random-state))

    "All tests passed!"))
