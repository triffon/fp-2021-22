#lang racket
(require rackunit rackunit/text-ui)

;### Задача 2
; Сортира списъка l по алгоритъма selection sort.
(define (selection-sort l)
  'тук)

(run-tests
  (test-suite "selection-sort tests"
    (check-equal? (selection-sort '(5 1 2 6 3)) '(1 2 3 5 6))
    (check-equal? (selection-sort '(5 1 2 1 6 3 2 2 6)) '(1 1 2 2 2 3 5 6 6)))
  'verbose)
