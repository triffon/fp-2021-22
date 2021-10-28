#lang racket
(require rackunit rackunit/text-ui)

;### Зад 19
; По дадено цяло число `n`, връща списък от цифрите му.
(define (explode-digits n)
  'тук)


(run-tests
  (test-suite "explode-digits tests"
    (check-equal? (explode-digits 0)
                  '(0))
    (check-equal? (explode-digits 1234)
                  '(1 2 3 4))
    (check-equal? (explode-digits 1000)
                  '(1 0 0 0)))
  'verbose)
