#lang racket
(require rackunit)
(require rackunit/text-ui)

;### зад 4
; Преобразува число от десетична в двоична бройна система.
(define (dec-to-bin n)
  (if (< n 2)
      n
      (+ (remainder n 2)
         (* 10 (dec-to-bin (quotient n 2))))))

(run-tests
  (test-suite
    "dec-to-bin tests"
    (check = (dec-to-bin 0) 0)
    (check = (dec-to-bin 1) 1)
    (check = (dec-to-bin 4) 100)
    (check = (dec-to-bin 31) 11111)
    (check = (dec-to-bin 64) 1000000)
    (check = (dec-to-bin 55) 110111)
    (check = (dec-to-bin 3767) 111010110111))
  'verbose)

