#lang racket
(require rackunit rackunit/text-ui)

;### Зад 20
; Намира колко пъти цифрата `d` се среща в цялото число `n`. Използвайте `explode-digits`.
(define (digit-occurence d n)
  'тук)


(run-tests
  (test-suite "digit-occurence tests"
    (check-equal? (digit-occurence 0 0)
                  1)
    (check-equal? (digit-occurence 2 122342)
                  3)
    (check-equal? (digit-occurence 0 1000)
                  3))
  'verbose)
