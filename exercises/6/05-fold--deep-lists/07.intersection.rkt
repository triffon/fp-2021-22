#lang racket
(require rackunit rackunit/text-ui)

;### Задача 7
; Връща сечение на елементите на l и на m
(define (intersection l m)
  'тук)

(run-tests
  (test-suite "intersection tests"
    (check-equal? (intersection '(1 2 3 4) '(6 1 4 5)) '(1 4))
    (check-equal? (intersection '() '(6 1 4 5)) '())
    (check-equal? (intersection '(1 5 4 2) '()) '()))
  'verbose)
