#lang racket
(require rackunit rackunit/text-ui)

;### Задача 5
; Връща списък от прилагането на f върху елемент на l и елемент на m.
(define (zip-with f l m)
  'тук)

(run-tests
  (test-suite "zip-with tests"
    (check-equal? (zip-with * '(1 2 3) '(4 5 6)) '(4 10 18))
    (check-equal? (zip-with cons '(1 2 3) '(4 5 6)) '((1 . 4) (2 . 5) (3 . 6)))
    (check-equal? (zip-with string-append '("a" "b" "c") '("x" "y")) '("ax" "by"))
    (check-equal? (zip-with + '() '(x y z)) '())
    (check-equal? (zip-with * '(a b c) '()) '()))
  'verbose)
