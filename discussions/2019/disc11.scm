(define (replicate x n)
  (if (= n 0) nil
    (cons x (replicate x (- n 1)))
  )
)

(define-macro (repeat-n expr n)
  (let ((n (eval n)))
    (cons 'begin (replicate expr n))
  )
)

(repeat-n (print '(resistance is futile)) 3)

(define-macro (or-macro expr1 expr2)
  `(let ((v1 ,expr1))
     (if v1 v1
         ,expr2
     ) 
   )
)

(or-macro (print 'bork) (/ 1 0))
(or-macro (= 1 0) (+ 1 2))

(define (map-stream f s)
  (if (null? s) nil
      (cons-stream (f (car s)) (map-stream f (cdr-stream s)))
  )
)

(define (naturals n)
  (cons-stream n (naturals (+ n 1)))
)

(define nat (naturals 0))

(define evens (map-stream (lambda (x) (* x 2)) nat))

(car (cdr-stream evens))

(define (slice s start end)
  (define (start-from-n s n)
    (cond ((null? s) nil)
          ((= n 0) s)
          (else (start-from-n (cdr-stream s) (- n 1)))
    )
  )
  (define s (start-from-n s start))
  (define end (- end start))
  (if (= end 0) nil
      (cons (car s) (slice (cdr-stream s) 0 (- end 1)))
  )
)

(slice nat 4 12)

(define (combine-with f xs ys)
  (if (or (null? xs) (null? ys))
    nil
    (cons-stream
      (f (car xs) (car ys))
      (combine-with f (cdr-stream xs) (cdr-stream ys)))))

(define factorials
  (cons-stream 1 (combine-with * factorials (naturals 1)))
)

(slice factorials 0 10)

(define fibs
  (cons-stream 0 (cons-stream 1 (combine-with + fibs (cdr-stream fibs))))
)

(slice fibs 0 10)

(define (power x)
  (define xs (cons-stream x xs))
  (cons-stream x (combine-with * xs (power x)))
)

(define (exp x)
  (define summands (combine-with / (power x) (cdr-stream factorials)))
  (cons-stream 1 (combine-with + (exp x) summands))
)

(slice (exp 2) 0 5)

(define-macro (make-lambda expr)
  `(lambda () ,expr)
)

(make-lambda (print 'hi))

(make-lambda (/ 1 0))

(define print-3 (make-lambda (print 3)))

(print-3)

; (define-macro (make-lambda expr)
;   `(lambda () ,expr)
; )

; (define-macro (make-stream first second)
;    `(begin
;       ,first
;       (make-lambda ,second)
;     )
; )

; (define (cdr-stream stream)
;   (stream)
; )

; (define a (make-stream (print 1) (make-stream (print 2) nil)))

; (define b (cdr-stream a))

; (cdr-stream b)

(define (filter-stream f s)
  (cond
    ((null? s) nil)
    ((f (car s)) (cons-stream (car s) (filter-stream f (cdr-stream s))))
    (else (filter-stream f (cdr-stream s)))
  )
)

(define (sieve s)
  (let ((s0 (car s)))
    (cons-stream s0
                 (sieve (filter-stream
                          (lambda (x) (not (zero? (modulo x s0))))
                          (cdr-stream s))
                 )
    )
  )
)

(define primes (sieve (naturals 2)))

(slice primes 0 10)
