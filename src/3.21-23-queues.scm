; 3.21
; needed from original queue implementation
(define (front-ptr q) (car q))
(define (rear-ptr q) (cdr q))
(define (print-queue q)
  (define (print-queue-iter next)
    (write (car next))
    (if (not (eq? next (rear-ptr q)))
        (print-queue-iter (cdr next))))
  (write #\()
  (print-queue-iter (front-ptr q))
  (write #\)))

; 3.22
(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))
    (define (empty-queue?) (null? front-ptr))
    (define (front)
      (if (empty-queue?)
          (error "front: empty queue!" dispatch)
          (car front-ptr)))
    (define (insert-queue! item)
      (let ((new-pair (cons item '())))
        (cond
          ((empty-queue?)
           (set! front-ptr new-pair)
           (set! rear-ptr new-pair)
           dispatch)
          (else
            (set-cdr! rear-ptr new-pair)
            (set! rear-ptr new-pair)
            dispatch))))
    (define (delete-queue!)
      (cond
        ((empty-queue?)
         (error "delete-queue!: empty queue!" dispatch))
        (else
          (set! front-ptr (cdr front-ptr))
          dispatch)))
    (define (dispatch m)
      (cond
        ((eq? m 'empty-queue?) empty-queue?)
        ((eq? m 'front) front)
        ((eq? m 'insert-queue!) insert-queue!)
        ((eq? m 'delete-queue!) delete-queue!)
        (else (error "Unknown operation" m))))
    dispatch))

(define (empty-queue? q) ((q 'empty-queue?)))
(define (front q) ((q 'front)))
(define (insert-queue! q item) ((q 'insert-queue!) item))
(define (delete-queue! q) ((q 'delete-queue!)))

; 3.23
; represent as doubly linked list
; each node stores value, left and right in a structure
(define (make-deque-node) (list '() '() '()))
(define (node-value n) (car n))
(define (node-prev n) (cadr n))
(define (node-next n) (caddr n))
(define (set-node-value! n v) (set-car! n v))
(define (set-node-prev! n v) (set-car! (cdr n) v))
(define (set-node-next! n v) (set-car! (cddr n) v))
; deque itself stores front and rear pointers, just like queue
(define (make-deque) (cons '() '()))
(define (empty-deque? dq) (or (null? (car dq)) (null? (cdr dq))))
(define (front-deque dq)
  (if (empty-deque? dq)
      (error "front-deque: empty deque!" dq)
      (node-value (car dq))))
(define (rear-deque dq)
  (if (empty-deque? dq)
      (error "rear-deque: empty deque!" dq)
      (node-value (cdr dq))))
(define (front-insert-deque! dq item)
  (let ((nn (make-deque-node)))
    (set-node-value! nn item)
    (cond
      ((empty-deque? dq)
       (set-car! dq nn)
       (set-cdr! dq nn)
       dq)
      (else
        (set-node-prev! (car dq) nn)
        (set-node-next! nn (car dq))
        (set-car! dq nn)
        dq))))
(define (rear-insert-deque! dq item)
  (let ((nn (make-deque-node)))
    (set-node-value! nn item)
    (cond
      ((empty-deque? dq)
       (set-car! dq nn)
       (set-cdr! dq nn)
       dq)
      (else
        (set-node-next! (cdr dq) nn)
        (set-node-prev! nn (cdr dq))
        (set-cdr! dq nn)
        dq))))
(define (front-delete-deque! dq)
  (cond
    ((empty-deque? dq)
     (error "front-delete-deque!: empty deque!" dq))
    (else
      (set-car! dq (node-next (car dq)))
      (if (not (null? (car dq)))
          (set-node-prev! (car dq) '())))))
(define (rear-delete-deque! dq)
  (cond
    ((empty-deque? dq)
     (error "rear-delete-deque!: empty deque!" dq))
    (else
      (set-cdr! dq (node-prev (cdr dq)))
      (if (not (null? (cdr dq)))
          (set-node-next! (cdr dq) '())))))
