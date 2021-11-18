#lang racket
(require rackunit rackunit/text-ui)

;### Зад 9
; Прилага функция над всеки от елементите на списък.
; Спрямо `(a1 a2 a3 a4 ... an)` връща `((f a1) (f a2) (f a3) (f a4) ... (f an))`.
(define (map f L)
  'тук)


(define (cube x) (expt x 3))

(run-tests
  (test-suite "map tests"
    (check-equal? (map cube '())
                  '())
    (check-equal? (map cube '(1 2 3 4))
                  '(1 8 27 64))
    (check-equal? (map (lambda (x) 9) '(1 2 3 4))
                  '(9 9 9 9))
    (check-equal? (map (lambda (x) (+ 9 x)) '(1 2 3 4))
                  '(10 11 12 13)))
  'verbose)

