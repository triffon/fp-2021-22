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

;### зад 6
; Дали числото е палиндром?
(define (palindrome? n)
  (= n (reverse-digits n)))

(run-tests
  (test-suite
    "palindrome? tests"
    (check-false (palindrome? 1234))
    (check-false (palindrome? 1231))
    (check-true (palindrome? 9102019))
    (check-true (palindrome? 10000001))
    (check-true (palindrome? 0))
    (check-true (palindrome? 5)))
  'verbose)

