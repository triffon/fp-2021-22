#lang racket
(require rackunit rackunit/text-ui)

;### Задача 3
; Връща подсписъкът на l от позиция a до позиция b. Позициите започват от 0.
(define (slice a b l)
  'тук)

(run-tests
  (test-suite "slice tests"
    (check-equal? (slice 3 7 '(1 2 3 4 5 6 7 8 9)) '(4 5 6 7 8))
    (check-equal? (slice 0 8 '(1 2 3 4 5 6 7 8 9)) '(1 2 3 4 5 6 7 8 9))
    (check-equal? (slice 4 4 '(1 2 3 4 5 6 7 8 9)) '(5))
    (check-equal? (slice 4 3 '(1 2 3 4 5 6 7 8 9)) '()))
  'verbose)
