#lang racket
(define head car)
(define tail cdr)

(define (extremumBy cmp lst)
  (foldr (lambda (el res) (if (cmp el res) el res))
         (head lst)
         (tail lst)))

(define (get-best-FAIL fs x)
  (define (>-metric f g)
    (if (> (f x) (g x)) f g))
  (extremumBy >-metric fs))

(define (get-best-OKAY fs x)
  (define (loop fs res)
    (cond [(null? fs) res]
          [(> ((head fs) x) (res x)) (loop (tail fs) (head fs))]
          [else (loop (tail fs) res)]))
  (loop (tail fs) (head fs)))

(define (sum l) (apply + l))
; Защо връщат различни неща?
(get-best-FAIL (list car sum) '(100 -100))
(get-best-OKAY (list car sum) '(100 -100))