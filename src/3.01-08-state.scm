(include "lib/3.state.scm")

; 3.01

(define (make-accumulator x)
  (lambda (k)
    (sequence
      (set! x (+ x k))
      x)))

; 3.02

(define (make-monitored f)
  (let ((count 0))
    (lambda (x)
      (cond
        ((eq? x 'how-many-calls?) count)
        ((eq? x 'reset-count) (set! count 0))
        (else (sequence
                (set! count (+ count 1))
                (f x)))))))

; 3.03-04

(define (call-the-cops)
  (write-line "Cops called!"))

(define (make-account balance password)
  (define password-attempts 0)
  (define (check-password pw)
    (if (eq? pw password)
        (sequence
          (set! password-attempts 0)
          #t)
        (sequence
          (set! password-attempts (+ password-attempts 1))
          (if (> password-attempts 7)
              (call-the-cops))
          #f)))
  (define (withdraw amount pw)
    (if (check-password pw)
        (if (>= balance amount)
            (sequence (set! balance (- balance amount))
                      balance)
            "Insufficient funds")
        "Incorrect password"))
  (define (deposit amount pw)
    (if (check-password pw)
        (sequence (set! balance (+ balance amount))
                  balance)
        "Incorrect password"))
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          ((eq? m 'check-password) check-password)
          (else (error "Unknown request!" m))))
  dispatch)

; 3.05

; instead of directly sharing info, make the joint acct
; into a proxy
(define (make-joint acct acct-password password)
  (define password-attempts 0)
  (define (check-password pw)
    (if (eq? pw password)
        (sequence
          (set! password-attempts 0)
          #t)
        (sequence
          (set! password-attempts (+ password-attempts 1))
          (if (> password-attempts 7)
              (call-the-cops))
          #f)))
  (define (withdraw amount pw)
    (if (check-password pw)
        ((acct 'withdraw) amount acct-password)
        "Incorrect password"))
  (define (deposit amount pw)
    (if (check-password pw)
        ((acct 'deposit) amount acct-password)
        "Incorrect password"))
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          ((eq? m 'check-password) check-password)
          (else (error "Unknown request!" m))))
  (if ((acct 'check-password) acct-password)
      dispatch
      "Incorrect password"))

; 3.06
(define (make-last-box x)
  (lambda (k)
    (sequence
      (let ((old-x x))
        (set! x k)
        old-x))))
(define f (make-last-box 0))

; 3.07
(define (estimate-integral p x1 x2 y1 y2 trials)
  (* (- x2 x1)
     (- y2 y1)
     (monte-carlo
       trials
       (lambda ()
         (p (real-random x1 x2) (real-random y1 y2))))))

; 3.08
(define the-random-state (make-random-state))
(define (rand x)
  (cond ((eq? x 'generate)
         (lambda (n) (random n the-random-state)))
        ((eq? x 'reset)
         (lambda (s) (set! the-random-state s)))
        (else (error "Unknown random command!"))))
