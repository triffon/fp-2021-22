#lang racket
(require rackunit rackunit/text-ui)

;### Зад 3
; Намира най-малкото число, което се среща поне 2 пъти в списъка `l`.
(define (min-duplicate l)
  'тук)

(run-tests
  (test-suite "min-duplicate tests"
    (check-equal? (min-duplicate '(-8 -8)) -8)
    (check-equal? (min-duplicate '(1 2 3 4 4 5 6)) 4)
    (check-equal? (min-duplicate '(5 1 2 3 4 5 3 6 2 3 2 3 2 3)) 2)
    (check-equal? (min-duplicate '(3 2 2 2 1 1)) 1))
  'verbose)
