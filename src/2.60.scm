(include "lib/2.algebra.scm")

(define (-poly p1 p2)
  (if (eq? (variable p1) (variable p2))
      (let ((termlist-negative-1
              (adjoin-term
                (make-term 0 -1)
                (the-empty-termlist))))
        (make-polynomial (variable p1)
                         (+terms (term-list p1)
                                 (*terms termlist-negative-1
                                         (term-list p2)))))
      (error "Polynomials not in same variable!" (list p1 p2))))

(put 'polynomial 'sub -poly)
