#lang racket
;((lambda (x)
;   ((lambda (y)
;      ((lambda (z) (+ x y z)) 1))
;    2))
; 3)
;
;(define a 5)
;(define x 2)
;
;(let* ((x 3)
;       (y (+ x 2))
;       (z 1))
;  (+ x y z))

; конструктор
;(cons 1 2)

(define p (cons (cons 2 3) (cons 5 (lambda (x) (+ x 2)))))

((cdr (cdr p)) 4)

(cadr p); -> (car (cdr p))

; type Person
(define (create-person name family)
  (cons name family)
)

(define (name person)
  (car person)
)

(define (family person)
  (cdr person)
)

(define (full-name person)
  (string-append (name person) " " (family person)))

(define ivan (create-person "Ivan" "Petkov"))

(full-name ivan)


'(1 2 3)

; списък
;'() - празен
;(cons <нещо> <списък>)

'()
(cons 1 '())
(cons 1 (cons 2 '()))

; не е списък
(cons 1 (cons 2 3))

(define L '(1 2 3))
(car L)

(cons 1 (cons 2 (cons 3 '())))
(car (cdr L))
(cadr L)

(caddr L)

(define (list-ref l n)
  (if (= n 1)
      (car l)
      (list-ref (cdr l) (- n 1)))
)
; (define head car)
; (define tail cdr)

;проверка дали списък е празен
;(null? '())

(define (length l)
  (if (null? l)
      0
      (+ 1 (length (cdr l))))
)

(define (sum l)
  (if (null? l)
      0
      (+ (car l) (sum (cdr l))))
)

(define (product l)
  (if (null? l)
      1
      (* (car l) (product (cdr l))))
)
;
(define (reduce l op null-value)
  (if (null? l)
      null-value
      (op (car l) (reduce (cdr l) op null-value)))
)

; всеки елемент от l събираме с 2
(define (add-two l)
  (if (null? l)
      '()
      (cons (+ 2 (car l)) (add-two (cdr l))))
)

(add-two '(1 2 3))
(cons 3 (cons 4 (cons 5 '())))

;(+ 1 (+ 1 (+ 1 0)))
;
;(cons 1 (cons 2 (cons 3 '())))
;'(1 2 3)
;'()








