#lang racket
(require rackunit rackunit/text-ui)

;### Задача 10
; Връща списък от последователните подсписъци на l с дължина n.
(define (chunk n l)
  'тук)

(run-tests
  (test-suite "chunk tests"
    (check-equal? (chunk 3 '(1 2 3 4 5 6 7 8 9 10)) '((1 2 3) (4 5 6) (7 8 9) (10)))
    (check-equal? (chunk 3 '()) '())
    (check-equal? (chunk 3 '(1)) '((1))))
  'verbose)
