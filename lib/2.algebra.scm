; include numbers, types, etc
(include "lib/2.number.scm")
; include =zero?
(include "src/2.54.scm")

(define (+poly p1 p2)
  (if (eq? (variable p1) (variable p2))
      (make-polynomial (variable p1)
                       (+terms (term-list p1)
                               (term-list p2)))
      (error "Polynomials not in same variable!" (list p1 p2))))

(define (*poly p1 p2)
  (if (eq? (variable p1) (variable p2))
      (make-polynomial (variable p1)
                       (*terms (term-list p1)
                               (term-list p2)))
      (error "Polynomials not in same variable!" (list p1 p2))))

(put 'polynomial 'add +poly)
(put 'polynomial 'mul *poly)

(define (+terms l1 l2)
  (cond ((empty-termlist? l1) l2)
        ((empty-termlist? l2) l1)
        (else
          (let ((t1 (first-term l1))
                (t2 (first-term l2)))
            (cond ((> (order t1) (order t2))
                   (adjoin-term t1
                                (+terms (rest-terms l1) l2)))
                  ((< (order t1) (order t2))
                   (adjoin-term t2
                                (+terms l1 (rest-terms l2))))
                  (else
                    (adjoin-term (make-term (order t1)
                                            (add (coeff t1)
                                                 (coeff t2)))
                                 (+terms (rest-terms l1)
                                         (rest-terms l2)))))))))

(define (*terms l1 l2)
  (if (empty-termlist? l1)
      (the-empty-termlist)
      (+terms (*-term-by-all-terms (first-term l1) l2)
              (*terms (rest-terms l1) l2))))

(define (*-term-by-all-terms t1 l)
  (if (empty-termlist? l)
      (the-empty-termlist)
      (let ((t2 (first-term l)))
        (adjoin-term (make-term (+ (order t1) (order t2))
                                (mul (coeff t1) (coeff t2)))
                     (*-term-by-all-terms t1 (rest-terms l))))))

(define (adjoin-term term term-list)
  (if (=zero? (coeff term))
      term-list
      (cons term term-list)))

(define (the-empty-termlist) '())
(define (first-term term-list) (car term-list))
(define (rest-terms term-list) (cdr term-list))
(define (empty-termlist? term-list) (null? term-list))

(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cdr term))

(define (make-polynomial variable term-list)
  (attach-type 'polynomial (cons variable term-list)))
(define (variable p) (car p))
(define (term-list p) (cdr p))

