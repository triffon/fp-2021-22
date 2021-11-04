#lang racket
; Разни функции, показани на лекции. Ползваме ги наготово.


; Следния ред означава че текущия файл provide-ва (предоставя) описаните идентификатори.
; Тълкуваме го като export на съответните функции, за да може да се използват в други файлове,
; където е import-нат текущия.
; Примери са задачите от това упражение, повече от които точно import-ват този (common.03.rkt).
(provide id 1+ sum prod accumulate accumulate-i twice compose repeated)

(define (fixed-point? f x)
  (= (f x) x))

(define (branch p? f g x)
  ((if (p? x) f g) x))

(define (id x)
  x)
(define (1+ x)
  (+ x 1))


(define (sum a b term next)
  (if (> a b)
      0
      (+ (term a) (sum (next a) b term next))))

(define (prod a b term next)
  (if (> a b)
      1
      (* (term a) (prod (next a) b term next))))

(define (accumulate op nv a b term next)
  (if (> a b)
      nv
      (op (term a) (accumulate op nv (next a) b term next))))

(define (accumulate-i op nv a b term next)
  (if (> a b)
    nv
    (accumulate-i op (op nv (term a)) (next a) b term next)))

(define (square x)
  (* x x))
(define square2
  (lambda (x)
    (* x x)))

(define (twice2 f x)
  (f (f x)))

(define (twice f)
  (lambda (x)
    (f (f x))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (accumulate compose id 1 n (lambda (i) f) 1+))

(define (derive f dx)
  (lambda (x)
    (/ (- (f (+ x dx))
          (f x))
       dx)))

(define (derive-n f n dx)
  ((repeated (lambda (f) (derive f dx)) n)
   f))

(define Y
  (lambda (gamma)
    ((lambda (me) (lambda (n) ((gamma (me me)) n)))
     (lambda (me) (lambda (n) ((gamma (me me)) n))))))
