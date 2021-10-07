#lang racket
; REPL
; read evaluate print loop

(+ 12.1 15 2 13)
; (<функция> <арг1> <арг2> ... <арг-н>)

(define a (+ 3 2))
(define b (+ a 2))
; immutability


; environment - среда
; a => 5
; b => 7
(+ a b)

(define (add2 x)
  (+ x 2)
)

(add2 9)

; (if <условие> <израз, ако условието е вярно> <израз за иначе (else)>)
; (if #t (display "less than 5") (p 2))
; short circuit

(define (p x)
  (p x)
)
; while (a < 5)
;{
;
;}

(define (factorial n)
  (if (= n 0)
      1
      (* n (factorial (- n 1)))
  )
)

; factorial 0 = 1
; factorial n = n * factorial (n - 1)

(factorial 5)
;(* 5 (factorial 4))
;(* 5 (* 4 (factorial 3)))
;(* 5 (* 4 (* 3 (* 2 (* 1 (factorial 0))))))

(define (multiply x y)
  (if (= y 0)
      0
      (+ x (multiply x (- y 1)))
  )
)

(define (expt x n)
  (if (= n 0)
      1
      (* x (expt x (- n 1)))
  )
)

(cond ((< a 5) 5)
      ((< b 8) 6)
      (else 10)
)

(if (< a 5)
    5
    (if (< b 8)
        6
        10))


;0 1 1 2 3 5...
; fib 0 = 0
; fib 1 = 1
; fib n = fib (n - 1) + fib (n - 2)


(define (fib n)
  (cond
    ((= n 0) 0)
    ((= n 1) 1)
    (else (+ (fib (- n 1)) (fib (- n 2))))
  )
)



(define (fib3 n)
  (define (fib curr next n)
    (cond
      ((= n 0) curr)
      ((= n 1) next)
      (else (fib next (+ curr next) (- n 1)))
      )
    )
  (fib 0 1 a)
)

;(fib 5)
(fib3 5)
