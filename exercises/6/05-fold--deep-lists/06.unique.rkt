#lang racket
(require rackunit rackunit/text-ui)

;### Задача 6
; Връща списък от елементите на l без повторения.
(define (unique l)
  'тук)

(run-tests
  (test-suite "unique tests"
    (check-equal? (unique '(1 2 3 3 3 4 3 3 5 5 3)) '(1 2 3 4 5))
    (check-equal? (unique '(1 2 3)) '(1 2 3))
    (check-equal? (unique '()) '()))
  'verbose)
