#lang racket
(require rackunit)
(require rackunit/text-ui)

(define (count-digits n)
  (if (< n 10)
      1
      (+ 1 (count-digits (quotient n 10)))))

;### зад 5
; Обръща реда на цифрите на число.
; 5032     | 1
; quotient | remainder

(define (reverse-digits n)
  (if (< n 10)
      n
      (+
        (reverse-digits (quotient n 10)) ; 2305
        (* (remainder n 10)
           (expt 10 (- (count-digits n) 1))))))
            ; 2305 + 1 * (10^4) = 12305; n = 50321
            ; (reverse-digits 5032) = 230 + 5 * (10^3)

(run-tests
  (test-suite
    "reverse-digits tests"
    (check = (reverse-digits 12305) 50321)
    (check = (reverse-digits 10000) 1)
    ;(check = (reverse-digits -1093) -3901)
    (check = (reverse-digits 10000001) 10000001))
  'verbose)

