#lang racket
(require rackunit rackunit/text-ui)

;### Задача 15
; Сортира списъка l по алгоритъма quicksort.
; Като pivot може да ползвате първия елемент на списъка, за най-лесно.
(define (quicksort l)
  'тук)

(run-tests
  (test-suite "deep-reverse tests"
    (check-equal? (quicksort '(5 1 2 6 3)) '(1 2 3 5 6))
    (check-equal? (quicksort '(5 1 2 1 6 3 2 2 6)) '(1 1 2 2 2 3 5 6 6))
    (check-equal? (quicksort '()) '()))
  'verbose)
