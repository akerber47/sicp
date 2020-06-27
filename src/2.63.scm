(include "lib/2.algebra.scm")

(define (/terms l1 l2)
  (if (empty-termlist? l1)
      (list (the-empty-termlist) (the-empty-termlist))
      (let ((t1 (first-term l1))
            (t2 (first-term l2)))
        (if (> (order t2) (order t1))
            (list (the-empty-termlist) l1)
            (let ((new-c (div (coeff t1) (coeff t2)))
                  (new-o (- (order t1) (order t2))))
              (let ((rest-of-result
                      (/terms
                        (+terms l1
                                (*-term-by-all-terms
                                  (make-term new-o (* -1 new-c))
                                  l2))
                        l2)))
                (list
                  (adjoin-term (make-term new-o new-c)
                             (car rest-of-result))
                  (cadr rest-of-result))))))))

(define (/poly p1 p2)
  (if (eq? (variable p1) (variable p2))
      (let ((qr (/terms (term-list p1) (term-list p2))))
        (list (make-polynomial (variable p1) (car qr))
              (make-polynomial (variable p1) (cadr qr))))
      (error "Polynomials not in same variable!" (list p1 p2))))

(put 'polynomial 'div /poly)
