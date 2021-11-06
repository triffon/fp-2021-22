#lang racket
(require rackunit rackunit/text-ui)

;### Задача 1
; Намира най-големият елемент в l
(define (maximum l)
  'тук)

(run-tests
  (test-suite "maximum tests"
    (check-eq? (maximum '(1 2 3 4 3 2 1)) 4)
    (check-eq? (maximum '(1)) 1)
    (check-eq? (maximum '(4 4 3 4 3 4 1)) 4))
  'verbose)
