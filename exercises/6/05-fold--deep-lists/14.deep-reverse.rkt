#lang racket
(require rackunit rackunit/text-ui)

;### Задача 14
; Обръща реда на елементите във всеки списък в дълбокия списък dl.
(define (deep-reverse dl)
  'тук)

(run-tests
  (test-suite "deep-reverse tests"
    (check-equal? (deep-reverse '((1 2 3) (4) ((5 6) ((7))))) '((((7)) (6 5)) (4) (3 2 1)))
    (check-equal? (deep-reverse '()) '())
    (check-equal? (deep-reverse '(((((((((((123)))))))))))) '(((((((((((123)))))))))))))
    (check-equal? (deep-reverse '((4) (5) (6))) '((6) (5) (4)))
  'verbose)
