(include "lib/2.number.scm")
(include "src/2.52.scm")
(include "src/2.53.scm")
(include "src/2.55.scm")
(include "src/2.56.scm")

; Note: we never actually defined an integer type.
; So this part will be awkward to test
(define (project-complex c)
  (real-part c))

(define (project-rational q)
  (floor (/ (numer q) (denom q))))

; oops! hard to convert integer => rational
(define (project-number x)
  (make-rational (make-rat (floor x) 1)))

(put 'number 'project project-number)
(put 'rational 'project project-rational)
(put 'complex 'project project-complex)

(define (project x) (operate 'project x))

; Cannot test this due to ill-defined integer
; portion of hierarchy, but it's ok!
(define (drop x)
  (cond ((eq? (type (project x)) (type x))
         x)
        ((equ? (raise (project x)) x)
         (drop (project x)))
        (else
         x)))

(define (operate-2 op obj1 obj2)
  (let ((t1 (type obj1))
        (t2 (type obj2)))
    (cond ((eq? t1 t2)
           (let ((proc (get t1 op)))
             (if (not (null? proc))
                 (drop (proc (contents obj1) (contents obj2)))
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
