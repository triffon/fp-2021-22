#lang racket
(require rackunit)
(require rackunit/text-ui)

;### зад 2
; Сума от цифрите на цяло число.
(define (sum-digits n)
  'тук)

(run-tests
  (test-suite
    "sum-digits tests"
    (check = (sum-digits 3) 3)
    (check = (sum-digits 12) 3)
    (check = (sum-digits 42) 6)
    (check = (sum-digits 666) 18)
    (check = (sum-digits 1337) 14)
    (check = (sum-digits 65510) 17)
    (check = (sum-digits 8833443388) 52)
    (check = (sum-digits 100000000000) 1)
    (check = (sum-digits 100000000020) 3))
  'verbose)
