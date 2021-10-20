#lang racket

; Зад.1
(define (sum-integers a b)
  (if (> a b) 0
      (+ a (sum-integers (+ a 1) b))))

; Зад.2
(define (fast-exp x n)
  (define (sq x) (* x x))
  ; Защо не (define half (fast-exp x (quotient n 2))) ??
  (define half (quotient n 2))
  (cond [(= n 0) 1]
        [(= n 1) x]
        [(even? n) (sq (fast-exp x half))]
        [else (* x (sq (fast-exp x half)))]))

; Зад.3
(define (last-digit n) (remainder n 10))
(define (remove-last n) (quotient n 10))

(define (count-digit d n)
  (if (= n 0) 0 ;(< n 10) (if (= n d) 1 0)
      (+ (count-digit d (remove-last n))
         (if (= (last-digit n) d) 1 0))))
(define (sq x) (* x x))

;(define (fact n)
;  (if (= n 0) 1
;      (* n (fact (- n 1)))))

(define (fact n)
  ; Инварианта: res е произв. на всички числа < i
  (define (loop i res)
    (if (> i n) res
        (loop (+ i 1) (* res i))))
  (loop 1 1))

(define (fib n)
  ; Инварианта: curr == fib(i); next == fib(i+1)
  (define (loop i curr next)
    (if (= i n) curr
        (loop (+ i 1) next (+ curr next))))
  (loop 0 0 1))

; Зад.4
(define (reverse-int n)
  ; На i-тата итерация в res се съдържат последните
  ; i-1 цифри на n в обр. ред; а в curr - останалите
  (define (loop curr res)
    (if (= curr 0) res
        (loop (remove-last curr)
              (+ (* res 10)
                 (last-digit curr)))))
  (loop n 0))

; Зад.5
(define (palindrome? n)
  (= n (reverse-int n)))

; Зад.6
(define (divides? n d)
  (= (remainder n d) 0))
(define (divisors-sum n)
  (define (loop i res)
    (cond [(> i n) res]
          [(divides? n i) (loop (+ i 1) (+ res i))]
          [else (loop (+ i 1) res)]))
  (loop 1 0))

; Зад.7
(define (perfect? n)
  (= (divisors-sum n) (* 2 n)))

; Зад.8
(define (prime? n)
  (define sqrtn (sqrt n)) ; Бонус: няма нужда да циклим до n-1
  (define (loop i)
    (cond [(> i sqrtn) #t]
          [(divides? n i) #f]
          [else (loop (+ i 1))]))
  (if (= n 1) #f ; Допълнителна проверка преди "цикъла" - 1 не е просто!
      (loop 2)))

; Зад.9
(define (increasing? n)
  (cond ((< n 10) #t) ; няма нужда от помощна функция за опашкова рекурсия
        ((< (last-digit n) (last-digit (quotient n 10))) #f)
        (else (increasing? (quotient n 10)))))