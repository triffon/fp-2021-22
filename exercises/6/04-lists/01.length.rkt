#lang racket
(require rackunit rackunit/text-ui)

;### Зад 1
; Дължина на списък
(define (length L)
  'тук)


(define l1 '(1 2 3 4 5 6 7 8))
(define l2 '(0 (12 13) (21 22)))

(run-tests
  (test-suite "length tests"
    (check-eq? (length '())
               0)
    (check-eq? (length l1)
               8)
    (check-eq? (length l2)
               3))
  'verbose)
