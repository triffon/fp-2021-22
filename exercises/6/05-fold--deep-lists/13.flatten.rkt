#lang racket
(require rackunit rackunit/text-ui)

;### Задача 13
; Списък от атомите в дълбокия списък dl.
(define (flatten dl)
  'тук)

(run-tests
  (test-suite "flatten tests"
    (check-equal? (flatten '((1 2 3) (4) ((5 6) ((7))))) '(1 2 3 4 5 6 7))
    (check-equal? (flatten '()) '())
    (check-equal? (flatten '(((((((((((123)))))))))))) '(123)))
  'verbose)
