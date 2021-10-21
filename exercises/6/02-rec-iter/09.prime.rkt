#lang racket
(require rackunit)
(require rackunit/text-ui)

;### зад 9
; Дали числото е просто?
; > Дадено цяло число n е просто, ако не се дели на никое от числата между 2 и n-1 (даже [от 2 до √n][primality-test]).
(define (prime? n)
  'тук)

(run-tests
  (test-suite
    "prime? tests"
    (check-false (prime? 0))
    (check-false (prime? 1))
    (check-false (prime? -120))
    (check-false (prime? 120))
    (check-true (prime? 2))
    (check-true (prime? 3))
    (check-true (prime? 7))
    (check-true (prime? 101))
    (check-true (prime? 2411)))
  'verbose)
