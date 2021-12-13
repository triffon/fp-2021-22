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

(define my-empty-stream #f)

(define (my-stream-empty? s)
  (equal? s #f))

(define (my-list-to-stream l)
  (if (null? l)
      my-empty-stream
      (my-stream-cons (car l) (my-list-to-stream (cdr l)))))

; задачи

(define (nats-after x)
  (my-stream-cons x (nats-after (+ 1 x))))

(define nats (nats-after 0))

(define (my-take-from-stream s n)
  (if (or (= n 0) (my-stream-empty? s))
     '()
     (cons (my-stream-first s) (my-take-from-stream (my-stream-rest s) (- n 1)))))