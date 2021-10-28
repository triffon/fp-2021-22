#lang racket
(require rackunit)
(require rackunit/text-ui)

(require "common.03.rkt")

;### Зад 3
; Броят на целите числа палиндроми в интервала [a, b].
(define (count-palindromes a b)
  'тук)

(run-tests
  (test-suite "count-palindromes tests"
    (check = (count-palindromes 100 200)
             10)
    (check = (count-palindromes 1 200)
             28)
    (check = (count-palindromes 1 10000)
             198))
  'verbose)
