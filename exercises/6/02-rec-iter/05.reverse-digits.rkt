#lang racket
(require rackunit)
(require rackunit/text-ui)

;### зад 5
; Обръща реда на цифрите на число.

(define (reverse-digits n)
  'тук)

(run-tests
  (test-suite
    "reverse-digits tests"
    (check = (reverse-digits 12305) 50321)
    (check = (reverse-digits 10000) 1)
    (check = (reverse-digits -1093) -3901)
    (check = (reverse-digits 10000001) 10000001))
  'verbose)

