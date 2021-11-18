#lang racket
(require rackunit)
(require rackunit/text-ui)

;### зад 10
; Итеративен вариант на `fastpow` от миналото упражнение.
(define (fasterpow x n)
  'тук)

(run-tests
  (test-suite
    "fasterpow tests"
    (check = (fasterpow 3 15) 14348907)
    (check = (fasterpow 10 4) 10000)
    (check = (fasterpow 5 3) 125)
    (check = (fasterpow -5 3) -125)
    (check = (fasterpow -5 0) 1))
  'verbose)

