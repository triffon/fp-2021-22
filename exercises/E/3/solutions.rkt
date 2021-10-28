#lang racket

; Решения

(define (reverse-digits n)
  (define (helper current result)
    (if (<= current 0)
        result
        (helper (quotient current 10)
                (+ (* result 10)
                   (remainder current 10)))))
  (helper n 0))

(define (palindrome? n)
  (define (helper current result)
    (cond
      ((< current result) #f)
      ((or (= current result) (= (quotient current 10) result)) #t)
      (else (helper (quotient current 10)
                    (+ (* result 10) (remainder current 10))))))
  (if (= 0 (remainder n 10))
      #f
      (helper n 0)))

(define (palindrome2? n)
  (= n (my-reverse n)))


(define pow (lambda (x n) (expt x n)))


(define (square x) (* x x))
(define (plus-four x) (+ x 4))
(define square-plus-four (compose plus-four square))


(define (all-interval? a b pred?)
  (cond
    ((> a b) #t)
    ((not (pred? a)) #f)
    (else (all-interval? (+ a 1) b pred?))
  )
)

(define (repeat f n)
  (if (= n 0)
    (lambda (x) x)
    (compose f (repeat f (- n 1)))
  )
)

; 5. Например 5 пъти събираме число с 1
  (define (plus1 x) (+ x 1))
  ((repeat plus1 5) 1)

(define (testlet x)
  (let
    ((x-plus-3 (+ x 3))
    (x-plus-5 (+ x 5)))
    (* x-plus-3 x-plus-5)
  )
)

(define (testlet* x)
  (let*
    ((x-plus-3 (+ x 3))
    (x-plus-5 (+ x-plus-3 2)))
    (* x-plus-3 x-plus-5)
  )
)