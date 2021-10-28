#lang racket
(require rackunit rackunit/text-ui)

;### Зад 2
; Сумата на всички числа от `l`
(define (sum l)
  'тук)


(define l1 '(1 2 3 4 5 6 7 8))
(define l2 '(0 (12 13) (21 22)))

(run-tests
  (test-suite "sum tests"
    (check-eq? (sum '())
               0)
    (check-eq? (sum l1)
               36)
    (check-eq? (sum '(-5 5 4))
               4))
  'verbose)
