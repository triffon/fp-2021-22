(define (1+ x) (+ x 1))
(define (id x) x)

(define (accumulate-rec op nv a b next term)
  (if (> a b)
      nv
      (op (term a) (accumulate-rec op nv (next a) b next term))))

(define (accumulate op nv a b next term)
  (if (> a b)
      nv
      (accumulate op
                  (op nv (term a))
                  (next a)
                  b
                  next
                  term)))

(define (fact x)
  (accumulate * 1 1 x 1+ id))

; (all? even? 2 4) -> #f
; (all? number? 1 10) -> #t
(define (all? p? a b)
  (accumulate (lambda (x y) (and x y)) #t a b 1+ p?))

(define (count-divisors n)
  (accumulate + 0 1 n 1+ (lambda (x) (if (= 0 (remainder n x)) 1 0))))

(define (prime? n)
  (if (= n 1) #f
      (= 2 (count-divisors n))))

(define (count-primes a b)
  (accumulate + 0 a b 1+ (lambda (x) (if (prime? x) 1 0))))


(define (list-length lst)
  (if (null? lst)
      0
      (+ 1 (list-length (cdr lst)))))

(define (contains? x lst)
  (cond ((null? lst) #f)
        ((equal? (car lst) x) #t)
        (else (contains? x (cdr lst)))))

(define (list-identity lst)
  (if (null? lst)
      '()
      (append (car lst) (list-identity (cdr lst)))))

(define (reverse-list lst)
  (define (reverse-helper current result)
    (if (null? current)
        result
        (reverse-helper (cdr current) (cons (car current) result))))
  (reverse-helper lst '()))

