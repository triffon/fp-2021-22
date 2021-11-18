#lang racket
(require rackunit)
(require rackunit/text-ui)

(require "common.03.rkt")

;### Зад 9
; Броят на числата, удовлетворяващи предиката `pred?` сред числата `a`, `(next a)`, `(next (next a))`, ..., `b`.
(define (count-p pred? a b next)
  (accumulate + 0 a b (lambda (i) (if (pred? i) 1 0)) next))

(define (2+ n) (+ n 2))

(run-tests
  (test-suite "count-p tests"
    (check-eq? (count-p number? 1 5 1+)
               5)
    (check-eq? (count-p odd? 1 5 1+)
               3)
    (check-eq? (count-p even? 1 5 1+)
               2)
    (check-eq? (count-p odd? 1 10 2+)
               5)
    (check-eq? (count-p even? 1 10 2+)
               0))
  'verbose)
