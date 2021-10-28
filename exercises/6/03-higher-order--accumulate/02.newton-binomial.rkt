#lang racket
(require rackunit)
(require rackunit/text-ui)

(require "common.03.rkt")

;### Зад 2
; Нютонов бином чрез `accumulate`.
; https://en.wikipedia.org/wiki/Binomial_theorem
(define (newton-binomial x y n)
  'тук)

(run-tests
  (test-suite "newton-binomial tests"
    (check-= (newton-binomial 1 1 10)
             1024
             0.0001))
  'verbose)
