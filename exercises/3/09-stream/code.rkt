#lang racket

(define-syntax-rule (my-delay x) (lambda () x))
(define (my-delay2 x) (lambda () x))
(define (my-force p) (p))

(define-syntax-rule (my-stream-cons x s)
  (cons x (my-delay s)))

(define (my-stream-first s)
  (car s))

(define (my-stream-rest s)
  (my-force (cdr s)))

(define my-empty-stream 'empty-stream)

(define (my-stream-empty? s)
  (equal? s 'empty-stream))

(define (my-list-to-stream l)
  (if (null? l)
      my-empty-stream
      (my-stream-cons (car l) (my-list-to-stream (cdr l)))))

; задачи

(define (nats-after x)
  (my-stream-cons x (nats-after (+ 1 x))))

(define nats (nats-after 0))
(define nats1 (nats-after 1))
(define nats2 (nats-after 2))

(define (my-take-from-stream s n)
  (if (or (= n 0) (my-stream-empty? s))
     '()
     (cons (my-stream-first s) (my-take-from-stream (my-stream-rest s) (- n 1)))))

(define (my-nth-from-stream s n)
  (if (= n 0)
     (my-stream-first s)
     (my-nth-from-stream (my-stream-rest s) (- n 1))))

(define (my-stream-filter p s)
  (cond
    ((my-stream-empty? s) my-empty-stream)
    ((p (my-stream-first s))
      (my-stream-cons (my-stream-first s) (my-stream-filter p (my-stream-rest s))))
    (else
      (my-stream-filter p (my-stream-rest s)))))

(define (my-stream-map f s)
  (if (my-stream-empty? s)
      my-empty-stream
      (my-stream-cons (f (my-stream-first s)) (my-stream-map f (my-stream-rest s)))))

; вариант с безкрайно сито на Ератостен
(define (is-divider? x n)
  (= (remainder n x) 0))

(define (filter-not-divided-by div s)
  (my-stream-filter (lambda (f) (not (is-divider? div f))) s))

(define (primes-iter pp)
  (my-stream-cons
   (my-stream-first pp)
   (primes-iter (filter-not-divided-by (my-stream-first pp) (my-stream-rest pp)))))

(define primes2 (my-stream-cons 1 (primes-iter nats2)))

; вариант с проверка за просто число (лесен)
(define (prime? n)
  #t) ; тук имплементираме проверка за просто число

(define primes (my-stream-filter prime? nats))

(define (iterate f x)
  (my-stream-cons x (iterate f (f x))))

(define (iterate2 f x)
  (my-stream-cons x (my-stream-map f (iterate2 f x))))