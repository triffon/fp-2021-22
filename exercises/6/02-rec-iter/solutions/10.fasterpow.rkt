#lang racket
(require rackunit)
(require rackunit/text-ui)

;### зад 10
; Итеративен вариант на `fastpow` от миналото упражнение.
(define (square x)
  (* x x))

(define (fasterpow x n)
  (define (iter y i result)
    (cond
      ((= i 0)   result)
      ((even? i) (iter (square y) (quotient i 2) result))
      (else      (iter y (- i 1) (* y result)))))
  (iter x n 1))

(run-tests
  (test-suite
    "fasterpow tests"
    (check = (fasterpow 3 15) 14348907)
    (check = (fasterpow 10 4) 10000)
    (check = (fasterpow 5 3) 125)
    (check = (fasterpow -5 3) -125)
    (check = (fasterpow -5 0) 1))
  'verbose)

