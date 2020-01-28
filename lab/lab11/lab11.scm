


(define-macro (def func bindings body)
    `(define ,func (lambda ,bindings ,body))
)

; (define f (lambda (x y) (+ x y)))