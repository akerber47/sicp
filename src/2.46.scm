(define (operate op obj)
  (let ((proc (get (type obj) op)))
    (if (not (null? proc))
        (proc (contents obj))
        (error "Operator undefined for this type --operate"
               (list op obj)))))

(define (operate-with-1 op obj arg)
  (let ((proc (get (type obj) op)))
    (if (not (null? proc))
        (proc (contents obj) arg)
        (error "Operator undefined for this type --operate-with-1"
               (list op obj arg)))))

; Individual divisions specify type information for each file

(define (get-record file employee)
  (operate-with-1 'get-record file employee))

; Individual divisions must include type information within
; each employee record also

(define (get-salary employee-record)
  (operate 'get-salary employee-record))

(define (find-employee-record employee all-files)
  (if (null? all-files)
      (error "Employee record not found" employee)
      (let ((next-record (get-record (car all-files) employee)))
        (if (not (null? next-record))
            next-record
            (find-employee-record employee (cdr all-files))))))

