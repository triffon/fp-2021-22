#lang racket
(require rackunit)
(require rackunit/text-ui)

;### зад 11 **за домашно (2т.)**
; Дали е автоморфно числото? Едно число е _автоморфно_, ако квадратът му завършва на него.
(define (automorphic? x n)
  'тук)

(run-tests
  (test-suite
    "automorphic? tests"
    (check-false (automorphic? 2))
    (check-false (automorphic? 3))
    (check-false (automorphic? 4))
    (check-false (automorphic? 7))
    (check-false (automorphic? 8))
    (check-false (automorphic? 9))
    (check-false (automorphic? 10))

    (check-true (automorphic? 1))
    (check-true (automorphic? 5))
    (check-true (automorphic? 6))
    (check-true (automorphic? 25))
    (check-true (automorphic? 76))
    (check-true (automorphic? 376))
    (check-true (automorphic? 625))
    (check-true (automorphic? 9376)))
  'verbose)
