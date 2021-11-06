#lang racket
(require rackunit rackunit/text-ui)

;### Задача 8
; Връща обединение на елементите на l и m
(define (union l m)
  'тук)

(run-tests
  (test-suite "union tests"
    (check-equal? (union '(1 2 3 4) '(6 1 4 5)) '(1 2 3 4 6 5))
    (check-equal? (union '(1 2 3 4) '()) '(1 2 3 4))
    (check-equal? (union '() '()) '()))
  'verbose)
