#lang racket
(require rackunit)
(require rackunit/text-ui)

(require "common.03.rkt")

;### Зад 1
; Имплементирайте `fact` и `fib` чрез `accumulate`.
(define (fact n)
  'тук)

(define (fib n)
  'тук)

(run-tests
  (test-suite "fact-fib tests"
    (test-suite "factorial tests"
      (check = (fact 0)
               1)
      (check = (fact 1)
               1)
      (check = (fact 15)
               1307674368000)
      (check = (fact 5)
               120))
    (test-suite "fibonacci tests"
      (check = (fib 0)
               0)
      (check = (fib 1)
               1)
      (check = (fib 2)
               1)
      (check = (fib 3)
               2)
      (check = (fib 5)
               5)
      (check = (fib 12)
               144)))
  'verbose)
