#lang racket
; Решения

(define (count-digits n)
  (if (<= n 0)
      0
      (+ 1 (count-digits (quotient n 10)))))


(define (sum-digits n)
  (if (<= n 0)
      0
      (+ (remainder n 10) (sum-digits (quotient n 10)))))


(define (prime? n)
  (define (helper possible-divisor)
    (cond
      ((= possible-divisor 1) #t)
      ((= (remainder n possible-divisor) 0) #f)
      (else (helper (- possible-divisor 1)))))
  (helper (- n 1)))


(define (count-digits-iter n)
  (define (helper current result)
    (if (<= current 0)
        result
        (helper (quotient current 10)
                (+ result 1))))
  (helper n 0))


(define (sum-digits-iter n)
  (define (helper current result)
    (if (<= current 0)
        result
        (helper (quotient current 10)
                (+ result (remainder current 10)))))
  (helper n 0))


(define (automorphic? x)
  (= x (remainder (expt x 2) (expt 10 (count-digits x)))))


(define (dec-to-bin n)
  (if (= n 0)
      0
      (+ (remainder n 2) (* 10 (dec-to-bin (quotient n 2))))
  )
)


(define (bin-to-dec n)
  (if (= n 0)
      0
      (+ (remainder n 10) (* 2 (bin-to-dec (quotient n 10))))
  )
)