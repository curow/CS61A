; ; 1.3
(define (cat meow purr) (+ meow purr))

(define cat (lambda (meow purr) (+ meow purr)))

; ; 1.4
(define (sum-every-other lst)
  (cond 
    ((null? lst)
     0
    )
    ((null? (cdr lst))
     (car lst)
    )
    (else
     (+ (car lst) (sum-every-other (cdr (cdr lst))))
    )
  )
)

; ; 1.5
(define (sixty-ones lst)
  (cond 
    ((< (length lst) 2)
     0
    )
    ((and (= (car lst) 6) (= (car (cdr lst)) 1))
     (+ (sixty-ones (cdr (cdr lst))) 1)
    )
    (else
     (sixty-ones (cdr lst))
    )
  )
)

; ; 1.6
(define (no-elevens n)
  (cond 
    ((= n 1)
     '((1) (6))
    )
    (else
     (define all_but_first (no-elevens (- n 1)))
     (define six_ahead
             (map (lambda (x) (cons 6 x)) all_but_first)
     )
     (define one_ahead
             (map (lambda (x) (cons 1 x))
                  (filter (lambda (x) (not (= 1 (car x))))
                          all_but_first
                  )
             )
     )
     (define (extend a b)
       (if (null? a)
           b
           (extend (cdr a) (cons (car a) b))
       )
     )
     (extend six_ahead one_ahead)
    )
  )
)

; 1.6 official solution
(define (add-to-all number lists)
  (cond 
    ((null? lists)
     ()
    )
    (else
     (cons (cons number (car lists))
           (add-to-all number (cdr lists))
     )
    )
  )
)

(define (no-elevens n)
  (cond 
    ((= n 0)
     '(())
    )
    ((= n 1)
     '((1) (6))
    )
    (else
     (append (add-to-all 6 (no-elevens (- n 1)))
             (add-to-all 1 (add-to-all 6 (no-elevens (- n 2))))
     )
    )
  )
)


; 1.7
(define (remember f)
  (define result nil)
  (define (g)
    (if (null? result)
        (set! result (f))
    )
    result
  )
  g
)

; ; What is the purpose of the quote special form?
; ; quote is meant to allow us to get desired expression after evaluation

; ; 2.2
(define (concat a b)
  (define (last a)
    (if (null? (cdr a))
        (car a)
        (last (cdr a))
    )
  )
  (define (all-but-last a)
    (if (null? (cdr a))
        ()
        (cons (car a) (all-but-last (cdr a)))
    )
  )
  (if (null? a)
      b
      (concat (all-but-last a) (cons (last a) b))
  )
)

(define (better-append x (variadic y))
  (if (null? y)
      x
      (apply better-append
             (cons (concat x (car y)) (cdr y))
      )
  )
)
