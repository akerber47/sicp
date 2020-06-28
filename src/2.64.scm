(include "lib/2.algebra.scm")
; =zero? for polynomials
(include "src/2.59.scm")

; stateful variable ordering
(define variable-order-list '())
(define (add-variable! v)
  (if (not (memv v variable-order-list))
      (set! variable-order-list
        (cons v variable-order-list))))

(define (variable-< v1 v2)
  (variable-<-iter v1 v2 variable-order-list))

(define (variable-<-iter v1 v2 l)
  (cond ((null? l)
         (error "Variables missing from order list!" (list v1 v2)))
        ((eq? (car l) v1) #t)
        ((eq? (car l) v2) #f)
        (else (variable-<-iter v1 v2 (cdr l)))))

; operate-2 copied from src/2.56.scm
; cannot include due to awkward mutual overrides etc

(define (operate-2 op obj1 obj2)
  (let ((t1 (type obj1))
        (t2 (type obj2)))
    (cond ((eq? t1 t2)
           (let ((proc (get t1 op)))
             (if (not (null? proc))
                 (proc (contents obj1) (contents obj2))
                 (error
                   "Operator not found!"
                   (list op obj1 obj2)))))
          ((< (get-type-height t1)
              (get-type-height t2))
           (operate-2 op (raise obj1) obj2))
          ((> (get-type-height t1)
              (get-type-height t2))
           (operate-2 op obj1 (raise obj2)))
          (else (error
                  "Operand types not in hierarchy"
                  (list op obj1 obj2))))))

; hack up type height hierarchy for polynomial purposes
(define (get-type-height t)
  (if (eq? 'polynomial t)
      1
      0))

(define (raise x) (operate 'raise x))

(define (raise-number x) (make-polynomial
                           'x
                           (adjoin-term (make-term 0 x)
                                        (the-empty-termlist))))
(put 'number 'raise raise-number)

; new polynomial functions to make use of variable ordering

(define (in-terms-of v p)
  (contents
    (make-polynomial
      v
      (adjoin-term (make-term 0 (attach-type 'polynomial p))
                   (the-empty-termlist)))))

(define (+poly p1 p2)
  (let ((v1 (variable p1))
        (v2 (variable p2)))
    (cond
      ((eq? v1 v2)
       (make-polynomial (variable p1)
                        (+terms (term-list p1)
                                (term-list p2))))
      ((variable-< v1 v2)
       (+poly p1 (in-terms-of v1 p2)))
      (else
       (+poly (in-terms-of v2 p1) p2)))))

(define (*poly p1 p2)
  (let ((v1 (variable p1))
        (v2 (variable p2)))
    (cond
      ((eq? v1 v2)
       (make-polynomial (variable p1)
                        (*terms (term-list p1)
                                (term-list p2))))
      ((variable-< v1 v2)
       (*poly p1 (in-terms-of v1 p2)))
      (else
       (*poly (in-terms-of v2 p1) p2)))))

(put 'polynomial 'add +poly)
(put 'polynomial 'mul *poly)

; be sure to track symbols in ordered list
(define (make-polynomial variable term-list)
  (add-variable! variable)
  (attach-type 'polynomial (cons variable term-list)))




; the section below is not strictly speaking required by the
; assignment. However, this extra check provides the extra
; feature of recovering correctly if the user uses make-polynomial
; to construct polynomials not nested in the "canonical" order.

(define (polynomial? x)
  (and (list? x)
       (not (null? x))
       (eq? (car x) 'polynomial)))

(define (all-greater-variables? v term-list)
  (if (empty-termlist? term-list)
      #t
      (let ((c1 (coeff (first-term term-list))))
        (if (and (polynomial? c1)
                 (variable-< (cadr c1) v))
            #f
            (all-greater-variables? v (rest-terms term-list))))))

(define (term-to-product v t)
  (mul
    (make-polynomial v (adjoin-term (make-term (order t) 1)
                                    (the-empty-termlist)))
    (coeff t)))

(define (make-polynomial variable term-list)
  (add-variable! variable)
  (if (all-greater-variables? variable term-list)
      (attach-type 'polynomial (cons variable term-list))
      (add
        (term-to-product variable (first-term term-list))
        (make-polynomial variable (rest-terms term-list)))))

