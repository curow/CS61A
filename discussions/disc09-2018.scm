(define (fact n)
    (define (fact-iter k result)
        (if (= k 0) result
            (fact-iter (- k 1) (* k result))
        )
    )
    (fact-iter n 1)
)

(define (sum lst)
    (define (sum-helper lst totoal)
        (if (null? lst) totoal
            (sum-helper (cdr lst) (+ (car lst) totoal))
        )
    )
    (sum-helper lst 0)
)

(define (reverse lst)
    (define (reverse-sofar lst lst-sofar)
        (if (null? lst) lst-sofar
            (reverse-sofar (cdr lst) (cons (car lst) lst-sofar))
        )
    )
    (reverse-sofar lst nil)
)

(define (append a b)
    (define (rev-append-tail a b)
       (if (null? a) b
            (rev-append-tail (cdr a) (cons (car a) b))
       )
    )
    (rev-append-tail (reverse a) b)
)

(define (insert n lst)
    (define (rev-insert lst rev-lst)
        (cond ((null? lst) rev-lst)
              ((> (car lst) n) (append (reverse rev-lst) (cons n lst)))
              (else (rev-insert (cdr lst) (cons (car lst) rev-lst)))
        )
    )
    (rev-insert lst nil)
)

(define-macro (for sym vals expr)
    (list 'map (list 'lambda (list sym) expr) vals)
)

(define-macro (for sym vals expr)
    `(map (lambda (,sym) ,expr) ,vals)
)