(define (count-digits x)
  (if (< (abs x) 10)
      1
      (+ 1 (count-digits (quotient x 10)))))

(define (sum-digits x)
  (if (< x 10)
      x
      (+ (remainder x 10) (sum-digits (quotient x 10)))))


(define (pow x n)
  (cond ((= n 0) 1)
        ((= n 1) x)
        (else (* x (pow x (- n 1))))))

(define (test-match x)
  (cond ((= x 10) "test")
        ((<= x 10) "ten")
        (else "hi")))

(define (fast-pow x n)
  (define (sq x) (* x x))
  (cond ((= n 0) 1)
        ((even? n) (sq (fast-pow x (/ n 2))))
        (else (* x (fast-pow x (- n 1))))))

; n = 0 -> 0
; n = 1 -> 1
; n = 2 -> 1
; n = 3 -> 2
; ...
(define (fibonacci n)
  (cond ((= n 1) 1)
        ((= n 2) 1)
        (else (+ (fibonacci (- n 2)) (fibonacci (- n 1))))))

(define (fib-iter n prev curr)
  (cond ((= n 0) prev)
        ((= n 1) curr)
        (else (fib-iter (- n 1) curr (+ prev curr)))))

(define (my-gcd a b)
  (cond ((= a b) a)
        ((> a b) (my-gcd (- a b) b))
        (else (my-gcd a (- b a)))))

(define (fact x)
  (if (<= x 1)
      1
      (* x (fact (- x 1)))))

(define (fact-iter x acc)
  (if (<= x 1)
      acc
      (fact-iter (- x 1) (* x acc))))

#|
fact-iter 5 1 = fact-iter 4 5
              = fact-iter 3 20
              = fact-iter 2 60
              = fact-iter 1 120
              = 120

|#

#|
fact 5 = 5 * fact 4
       = 5 * (4 * fact 3)
       = 5 * (4 * (3 * fact 2))
       = 5 * (4 * (3 * (2 * fact 1))
       = 5 * (4 * (3 * (2 * 1)))
       = 5 * (4 * (3 * 2))
       = 5 * (4 * 6)
       = 5 * 24
       = 120
|#

; [a, b]
; = current b => sum([a, b))
(define (sum a b)
  (define (sum-helper current result)
    (if (= current b)
        result
        (sum-helper (+ current 1) (+ result current))))
  (sum-helper a 0))

; 1234 -> 4321
(define (reverse-number x)
  (define (reverse-helper curr acc)
    (if (= curr 0)
        acc
        (reverse-helper (quotient curr 10) (+ (* 10 acc) (remainder curr 10)))))
  (reverse-helper x 0))

(define (is-prime? x)
