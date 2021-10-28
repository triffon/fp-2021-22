#lang racket
(require rackunit)
(require rackunit/text-ui)

;### зад 1
;Брой цифри на цяло число (вкл. и отрицателно).
(define (count-digits n)
  (if (< (abs n) 10)
      1
      (+ 1 (count-digits (quotient n 10)))))

(run-tests
  (test-suite
    "count-digits tests"
    (check = (count-digits 12345) 5)
    (check = (count-digits 0) 1)
    (check = (count-digits -1009) 4)
    (check = (count-digits 1000000) 7))
  'verbose)
