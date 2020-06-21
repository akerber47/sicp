; ---------------
; from 2.1.1: rational numbers
; ---------------

; best make-rat from 2.01
; (define (make-rat n d)
;   (let ((g (gcd (abs n) (abs d))))
;        (cond
;          ((= d 0) (error "Division by 0"))
;          ((< d 0) (cons (- (/ n g)) (- (/ d g))))
;          (else (cons (/ n g) (/ d g))))))
(include "src/2.01.scm")

(define (numer x) (car x))
(define (denom x) (cdr x))

(define (+rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (denom x) (numer y)))
            (* (denom x) (denom y))))

(define (-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (denom x) (numer y)))
            (* (denom x) (denom y))))

(define (*rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (/rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (=rat x y)
  (= (* (numer x) (denom y))
     (* (denom x) (numer y))))

; ---------------
; from 2.3.1: complex numbers
; ---------------
; Note: complex number support is included in scheme
; but we're overwriting the names here

(define (+c z w)
  (make-rectangular (+ (real-part z) (real-part w))
                    (+ (imag-part z) (imag-part w))))

(define (-c z w)
  (make-rectangular (- (real-part z) (real-part w))
                    (- (imag-part z) (imag-part w))))

(define (*c z w)
  (make-polar (* (magnitude z) (magnitude w))
              (+ (angle z) (angle w))))

(define (/c z w)
  (make-polar (/ (magnitude z) (magnitude w))
              (- (angle z) (angle w))))


; ---------------
; from 2.3.2: manifest typed complex representations
; ---------------

; best type, contents, attach-type from 2.49
(include "src/2.49.scm")


(define (make-rectangular x y)
  (attach-type 'rectangular (cons x y)))

(define (make-polar r a)
  (attach-type 'polar (cons r a)))

(define (real-part-rectangular z) (car z))
(define (imag-part-rectangular z) (cdr z))
(define (magnitude-rectangular z)
  (sqrt (+ (square (car z)) (square (cdr z)))))
(define (angle-rectangular z)
  (atan (cdr z) (car z)))

(define (real-part-polar z)
  (* (car z) (cos (cdr z))))
(define (imag-part-polar z)
  (* (car z) (sin (cdr z))))
(define (magnitude-polar z) (car z))
(define (angle-polar z) (cdr z))

; ---------------
; from 2.3.3: data directed programming
; ---------------

(put 'rectangular 'real-part real-part-rectangular)
(put 'rectangular 'imag-part imag-part-rectangular)
(put 'rectangular 'magnitude magnitude-rectangular)
(put 'rectangular 'angle angle-rectangular)
(put 'polar 'real-part real-part-polar)
(put 'polar 'imag-part imag-part-polar)
(put 'polar 'magnitude magnitude-polar)
(put 'polar 'angle angle-polar)

(define (operate op obj)
  (let ((proc (get (type obj) op)))
    (if (not (null? proc))
        (proc (contents obj))
        (error "Operator not found!" (list op obj)))))

(define (real-part obj) (operate 'real-part obj))
(define (imag-part obj) (operate 'imag-part obj))
(define (magnitude obj) (operate 'magnitude obj))
(define (angle obj) (operate 'angle obj))


; ---------------
; from 2.4.1: generic arithmetic operators
; ---------------

(define (+number x y)
  (make-number (+ x y)))

(define (-number x y)
  (make-number (- x y)))

(define (*number x y)
  (make-number (* x y)))

(define (/number x y)
  (make-number (/ x y)))

(define (=number x y)
  (= x y))

(define (make-number x)
  (attach-type 'number x))

(put 'number 'add +number)
(put 'number 'sub -number)
(put 'number 'mul *number)
(put 'number 'div /number)

(define (add x y) (operate-2 'add x y))
(define (sub x y) (operate-2 'sub x y))
(define (mul x y) (operate-2 'mul x y))
(define (div x y) (operate-2 'div x y))

(define (operate-2 op arg1 arg2)
  (let ((t1 (type arg1)))
    (if (eq? t1 (type arg2))
        (let ((proc (get t1 op)))
          (if (not (null? proc))
              (proc (contents arg1) (contents arg2))
              (error "Operator not found!"
                     (list op arg1 arg2))))
        (error "Operands not of the same type!"
               (list op arg1 arg2)))))

(define (make-complex z)
  (attach-type 'complex z))

(define (+complex x y)
  (make-complex (+c x y)))

(define (-complex x y)
  (make-complex (-c x y)))

(define (*complex x y)
  (make-complex (*c x y)))

(define (/complex x y)
  (make-complex (/c x y)))

(put 'complex 'add +complex)
(put 'complex 'sub -complex)
(put 'complex 'mul *complex)
(put 'complex 'div /complex)

