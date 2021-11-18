#lang racket
(require rackunit rackunit/text-ui)

(define (divides? x y)
  (= (remainder y x) 0))
(define (prime? n)
  (and (>= n 2)
       (let ((rootn (sqrt n)))
         (define (iter i)
           (or (> i rootn)
               (and (not (divides? i n))
                    (iter (+ 1 i)))))
         (iter 2))))

;### Зад 12
; Намира сумата на третите степени на всички прости числа в `l`.
(define (scp l)
  'тук)


(run-tests
  (test-suite "scp tests"
    (check-equal? (scp '())
                  0)
    (check-equal? (scp '((5 2) (1 3)))
                  0)
    (check-equal? (scp '(1 2 3 4 5))
                  160))
  'verbose)
