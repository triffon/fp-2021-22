#lang racket
(require rackunit rackunit/text-ui)

;### Задача 9
; Връща списък с елементите на l без елементите на m
(define (set-minus l m)
  'тук)

(run-tests
  (test-suite "set-minus tests"
    (check-equal? (set-minus '(1 2 3 4 5 6) '(6 1 4)) '(2 3 5))
    (check-equal? (set-minus '(1 2 3 4 5 6) '()) '(1 2 3 4 5 6))
    (check-equal? (set-minus '() '(6 1 4)) '()))
  'verbose)
