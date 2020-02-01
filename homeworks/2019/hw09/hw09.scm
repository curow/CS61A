
; Tail recursion

(define (replicate x n)
  (define (replicate-tail lst k)
    (if (= k n) lst
        (replicate-tail (append (list x) lst) (+ k 1))
    )
  )
  (replicate-tail nil 0)
)

(define (accumulate combiner start n term)
  (if (zero? n) start
      (accumulate combiner (combiner start (term n)) (- n 1) term)
  )
)

(define (accumulate-tail combiner start n term)
  (if (zero? n) start
      (accumulate combiner (combiner start (term n)) (- n 1) term)
  )
)

; Streams

(define (map-stream f s)
    (if (null? s)
    	nil
    	(cons-stream (f (car s)) (map-stream f (cdr-stream s)))))

(define multiples-of-three
  (cons-stream 3 (map-stream (lambda (x) (+ x 3)) multiples-of-three))
)


(define (nondecreastream s)
  (define (nondecreastream-tail lst last rest)
    (cond ((null? rest) (cons-stream lst nil))
          ((>= (car rest) last) 
            (nondecreastream-tail (append lst (list (car rest))) (car rest) (cdr-stream rest))
          )
          (else (cons-stream lst (nondecreastream-tail (list (car rest)) (car rest) (cdr-stream rest))))
    )
  )
  (if (null? s) nil
      (nondecreastream-tail (list (car s)) (car s) (cdr-stream s))
  )
)


(define finite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 3
                (cons-stream 1
                    (cons-stream 2
                        (cons-stream 2
                            (cons-stream 1 nil))))))))

(define infinite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 2
                infinite-test-stream))))
