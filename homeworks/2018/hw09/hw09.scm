(define-macro (list-of map-expr for var in lst if filter-expr)
  `(map (lambda (,var) ,map-expr) (filter (lambda (,var) ,filter-expr) ,lst))
)

; (map (lambda (var) map-expr) (filter (lambda (var) filter-expr) lst))

; (list-of (* x x) for x in '(3 4 5) if (odd? x))

; (map (lambda (x) (* x x)) (filter (lambda (x) (odd? x)) '(3 4 5)))