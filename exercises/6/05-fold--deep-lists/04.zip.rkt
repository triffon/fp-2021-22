#lang racket
(require rackunit rackunit/text-ui)

;### Задача 4
; Връща списък от наредени двойки от елементите на l и m.
(define (zip l m)
  'тук)

(run-tests
  (test-suite "zip tests"
    (check-equal? (zip '(1 2 3) '(4 5 6)) '((1 . 4) (2 . 5) (3 . 6)))
    (check-equal? (zip '(a b c) '(x y)) '((a . x) (b . y)))
    (check-equal? (zip '(k l) '(x y z)) '((k . x) (l . y)))
    (check-equal? (zip '() '(x y z)) '())
    (check-equal? (zip '(a b c) '()) '()))
  'verbose)
