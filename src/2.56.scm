(include "lib/2.number.scm")
(include "src/2.52.scm")
(include "src/2.53.scm")
(include "src/2.55.scm")

(define (put-type-height t n)
  (put t 'type-height n))

(define (get-type-height t)
  (get t 'type-height))

(put-type-height 'integer 0)
(put-type-height 'rational 1)
(put-type-height 'number 2)
(put-type-height 'complex 3)

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
