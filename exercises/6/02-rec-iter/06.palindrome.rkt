#lang racket
(require rackunit)
(require rackunit/text-ui)

;### зад 6
; Дали числото е палиндром?
(define (palindrome? n)
  'тук)

(run-tests
  (test-suite
    "palindrome? tests"
    (check-false (palindrome? 1234))
    (check-false (palindrome? 1231))
    (check-true (palindrome? 9102019))
    (check-true (palindrome? 10000001)))
    (check-true (palindrome? 0)))
    (check-true (palindrome? 5)))
  'verbose)

