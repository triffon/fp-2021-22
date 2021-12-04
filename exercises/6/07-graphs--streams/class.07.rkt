#lang racket

(define assoc1
  (list (cons 1 '(2 3 4))
        (cons 1 3)
        (cons 15 2)
        (cons 6 "neshto")))
(define assoc2
  '((1 2) (2 3) (3 1 4) (4 3 5) (5 5)))

(define (assoc k l)
  (cond
    ((null? l) #f)
    ((equal? k (car (car l)))
     (cdr (car l)))
    (else
     (assoc k (cdr l)))))
