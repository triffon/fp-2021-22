#lang racket
(require rackunit)
(require rackunit/text-ui)

(require "common.03.rkt")


;### Зад 11 за домашно (4т.)
; Броят на наредените двойки цели числа (`x`,`y`) от интервала [a,b], които имат най-голям общ делител равен на `n`.

(define (count-pairs-gcd n a b)
  'тук)

(run-tests
  (test-suite "count-pairs-gcd tests"
    (check = (count-pairs-gcd 10 1 11)
             1)
    (check = (count-pairs-gcd 3 1 11)
             7)
    (check = (count-pairs-gcd 16 1 11)
             0)
    (check = (count-pairs-gcd 4 1 11)
             3))
  'verbose)
