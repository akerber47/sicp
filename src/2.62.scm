; standard polynomial code
; (we will override a lot of it!)
(include "lib/2.algebra.scm")

(define (operate-1param op obj param)
  (let ((proc (get (type obj) op)))
    (if (not (null? proc))
        (proc param (contents obj))
        (error "Operator not found!" (list op obj)))))

(define (first-term tl) (operate 'first-term tl))
(define (rest-terms tl) (operate 'rest-terms tl))
(define (empty-termlist? tl) (operate 'empty-termlist? tl))
(define (adjoin-term t tl) (operate-1param 'adjoin-term tl t))

(define (make-termlist-dense term-list)
  (attach-type 'termlist-dense term-list))

(define (make-termlist-sparse term-list)
  (attach-type 'termlist-sparse term-list))

(define (the-empty-termlist-dense) (make-termlist-dense '()))

(define (first-term-dense term-list)
  (make-term (- (length term-list) 1)
             (car term-list)))
(define (rest-terms-dense term-list)
  (let ((rt (cdr term-list)))
    (if (and (not (null? rt)) (=zero? (car rt)))
        (rest-terms-dense rt)
        (make-termlist-dense rt))))
(define (empty-termlist?-dense term-list) (null? term-list))

(define (adjoin-term-dense term term-list)
  (cond
    ((=zero? (coeff term))
     (make-termlist-dense term-list))
    ((= (order term) (length term-list))
     (make-termlist-dense (cons (coeff term) term-list)))
    (else
      (adjoin-term-dense term (cons 0 term-list)))))


(define (adjoin-term-sparse term term-list)
  (if (=zero? (coeff term))
      (make-termlist-sparse term-list)
      (make-termlist-sparse (cons term term-list))))

(define (the-empty-termlist-sparse) (make-termlist-sparse '()))
(define (first-term-sparse term-list) (car term-list))
(define (rest-terms-sparse term-list) (make-termlist-sparse (cdr term-list)))
(define (empty-termlist?-sparse term-list) (null? term-list))

(put 'termlist-dense 'first-term first-term-dense)
(put 'termlist-dense 'rest-terms rest-terms-dense)
(put 'termlist-dense 'empty-termlist? empty-termlist?-dense)
(put 'termlist-dense 'adjoin-term adjoin-term-dense)

(put 'termlist-sparse 'first-term first-term-sparse)
(put 'termlist-sparse 'rest-terms rest-terms-sparse)
(put 'termlist-sparse 'empty-termlist? empty-termlist?-sparse)
(put 'termlist-sparse 'adjoin-term adjoin-term-sparse)


; sparse by default
(define (the-empty-termlist)
  (the-empty-termlist-sparse))
