#lang racket
(require rackunit rackunit/text-ui)

;### Задача 15
; Връща елементът на позиция `n` в списъка `l`. Броенето започва от нула.
(define (list-ref l n)
  'тук)


(run-tests
  (test-suite "list-ref tests"
    (check-equal? (list-ref '(1 2 3 4) 0)
                  1)
    (check-equal? (list-ref '(21 22 23 24) 3)
                  24)
    (check-equal? (list-ref '(1 (2 3 4) (5 6) ((7)) 8) 1)
                  '(2 3 4)))
  'verbose)

