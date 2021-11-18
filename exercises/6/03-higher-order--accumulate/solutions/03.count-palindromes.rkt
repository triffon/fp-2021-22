#lang racket
(require rackunit)
(require rackunit/text-ui)

(require "common.03.rkt")

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

(define (1+ n) (+ n 1))

;### Зад 3
; Броят на целите числа палиндроми в интервала [a, b].
(define (count-palindromes a b)
  (accumulate + 0 a b
              (lambda (i) (if (palindrome? i) 1 0))
              1+))

(run-tests
  (test-suite "count-palindromes tests"
    (check = (count-palindromes 100 200)
             10)
    (check = (count-palindromes 1 200)
             28)
    (check = (count-palindromes 1 10000)
             198))
  'verbose)
