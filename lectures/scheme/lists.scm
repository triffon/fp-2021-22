(define (list? p)
  (or (null? p) (and (pair? p) (list? (cdr p)))))

(define (length l)
  (if (null? l) 0
      (+ 1 (length (cdr l)))))