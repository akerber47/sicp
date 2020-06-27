(include "lib/2.algebra.scm")

(define (=zero?-poly p)
  (=zero?-termlist (term-list p)))

(define (=zero?-termlist t)
  (if (empty-termlist? t)
      #t
      (and (=zero? (coeff (first-term t)))
           (=zero?-termlist (rest-terms t)))))

(put 'polynomial '=zero? =zero?-poly)
