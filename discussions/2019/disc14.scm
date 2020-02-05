(define (merge s1 s2)
  (if (< (car s1) (car s2))
      (cons-stream (car s1) (merge (cdr s1) s2))
      (cons-stream (car s2) (merge (cdr s2) s1))
  )
)

(define (cycle start)
  (cons-stream start (cycle (modulo (+ start 2))))
)

(define-macro (when condition exprs)
  (list 'if condition (cons 'begin exprs) ''okay))

(define-macro (when condition exprs)
  `(if ,condition ,(cons 'begin exprs) 'okay))
