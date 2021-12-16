#lang racket
(define the-empty-stream '())
;(define (cons-stream h t)
;  (cons h (delay t)))
(define head car)
(define (tail s) (force (cdr s)))
(define empty-stream? null?)

(define s1 (cons-stream 1 (cons-stream 2 (cons-stream 3 the-empty-stream))))

(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream h t) (cons h (delay t)))))

(define ones
  (cons-stream 1 ones))

(define (from x)
  ;(cons x (delay (from (+ 1 x)))))
  (cons-stream x (from (+ 1 x))))


(define (s-from-to a b)
  (if (> a b)
      the-empty-stream
      (cons-stream a (s-from-to (+ 1 a) b))))

(define (s-take n l)
  (if (= n 0)
      '()
      (cons
       (car l)
            (s-take (- n 1) (force (cdr l))))))


(define nats (from 0))


(define (map-stream f s)
  (if (empty-stream? s)
      s
      (cons-stream (f (head s))
                   (map-stream f (tail s)))))

(define (1+ n) (+ n 1))

(define nats*
  (cons-stream 0 (map-stream 1+ nats*)))

(define (zip-streams-with f s1 s2)
  (cons-stream (f (head s1)
                  (head s2))
               (zip-streams-with f (tail s1) (tail s2))))

(define fibs
  (cons-stream 0
               (cons-stream 1
                            (zip-streams-with + fibs (tail fibs)))))


(define (filter-stream p? s)
  (if (p? (head s))
      ;(begin (display "chosen\n")
      (cons-stream (head s)
                   (filter-stream p? (tail s)))
      ;)
      (filter-stream p? (tail s))))

(define (primes-from i)
  (cons-stream i
               (filter-stream (lambda (x) (not (= 0 (remainder x i))))
                              (primes-from (+ i 1)))))

(define primes (primes-from 2))

; Дефинирайте pythagorean-triples - поток от Питагоровите тройки.
; Питагорова тройка е наредена тройка (a, b, c), за която a^2 + b^2 = c^2.

;(define (nats3-from a b c)
;  (cons-stream (list a b c)
;    (cons-stream (list (+ a 1) b c)
;      (cons-stream (list a (+ b 1) c)
;                                         (cons-stream (list a b (+ c 1))
   ;                                                   (cons-stream (list (+ a 1) (+ b 1) c)
  ;                                                                 (cons-stream (list (+ a 1) b (+ c 1))
    ;                                                                            (cons-stream (list a (+ b 1) (+ c 1))                 
 ;                                                                                            (nats3-from (+ a 1) (+ b 1) (+ c 1))))))))))
;
;
;
      ;                                                                                                                                                                                (nats3-from (+ a 1) (+ b 1) (+ c 1))))))))



'((0 1 2 3 4 5 6 7 8 9 10 ...)
  (1 2 3 4 5 6 ...)
  (2 3 4 5 6 ...)
  (3 4 5 6 ...)
  (4 5 6 ....)
  (...))
(define (nats3-from a b c) '())
; Всички наредени тройки ест. числа
(define nats3 (nats3-from 0 0 0))
(define (sq x)
  ;(display "neshto\n")
  (* x x))

(define (pythagorean-triples-wrong)
  (filter-stream (lambda (x)
                   (display (string-append "checking "
                                           (number->string (car x))
                                           " "
                                           (number->string (cadr x))
                                           " "
                                           (number->string (caddr x))
                                           ": "
                                           (number->string (+ (sq (car x))
                                                              (sq (cadr x))))
                                           " = "
                                           (number->string (sq (caddr x)))
                                           "\n"))
                   (= (+ (sq (car x))
                         (sq (cadr x)))
                      (sq (caddr x))))
                 nats3))
;(list 0 0 0)
;(list 0 0 1)
;(list 0 1 0)
;(list 0 1 1)
;(list 1 0 0)
;(list 1 0 1)
;(list 1 1 0)
;(list 1 1 1)
;(list 1 1 2)
;....




(define (from-to a b)
  (if (> a b)
      '()
      (cons a (from-to (+ a 1) b))))

; взима поток от списъци от неща и намаля нивото, прави го поток от неща
(define (stream-concat s)
     (foldr (lambda (x rec) (cons-stream x (force rec)))
            (delay (stream-concat (tail s)))
            (head s)))

(define nats2
  (stream-concat (map-stream (lambda (diag)
                               (map (lambda (x)
                                      (cons x (- diag x)))
                                    (from-to 0 diag)))
                             (from 0))))








(define pythagorean-triples
  (filter-stream (lambda (t)
                   (exact? (caddr t)))
                 (map-stream (lambda (p)
                               (list (car p) (cdr p) (sqrt (+ (sq (car p))
                                                              (sq (cdr p))))))
                              nats2)))


