
(define-macro (switch expr cases)
  (let ((value (eval expr)))
    (cond ((null? cases) nil)
          ((eq? value (car (car cases))) (eval (car (cdr (car cases)))))
          (else `(switch ,expr ,(cdr cases)))
    )
  )
)
