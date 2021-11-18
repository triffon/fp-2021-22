; Помощни функции
(define (filter p l)
  (cond ((null? l) l)
        ((p (car l)) (cons (car l) (filter p (cdr l))))
        (else (filter p (cdr l)))))

(define (foldr op nv l)
  (if (null? l)
      nv
      (op (car l) (foldr op nv (cdr l)))))

(define (list-range a b)
  (if (> a b) '()
      (cons a (list-range (+ a 1) b))))

; Задача 1
(define (list-divisors x)
  (define (divisor-helper i)
    (cond ((> i x) '())
          ((= 0 (remainder x i)) (cons i (divisor-helper (+ i 1))))
          (else (divisor-helper (+ i 1)))))
  (divisor-helper 1))

(define (done? x)
  (let ((divisor-sum (foldr + 0 (filter (lambda (div) (< div x)) (list-divisors x)))))
    (= (- divisor-sum x) 2)))

(define (done-in-range a b)
  (filter done? (list-range a b)))

(define (sum-almost-done a b)
  (define (almost-done? x)
    (let ((dif-start (- x a))
          (dif-end (- b x))
          (dif-done (apply min (map (lambda (d) (abs (- x d))) (done-in-range a b)))))
      (and (= dif-done (min dif-start dif-end dif-done))
           (not (member dif-done (list dif-start dif-end))))))
  (foldr + 0 (filter almost-done? (list-range a b))))

; Задача 2
(define (apply-to-stack f n stack)
  (define (apply-stack-helper i res)
    (if (or (null? (cdr res)) (= i 0) (or (symbol? (car res)) (symbol? (cadr res))))
        res
        (apply-stack-helper (- i 1) (cons (f (car res) (cadr res)) (cddr res)))))
  (apply-stack-helper n stack))

(define (run-machine instructions)
  (define (run-helper current stack)
    (if (null? current)
        stack
        (let ((top (car current))
              (tail (cdr current)))
          (cond ((or (symbol? top) (number? top)) (run-helper tail (cons top stack)))
                ((procedure? top) (run-helper tail (map (lambda (x) (if (number? x) (top x) x)) stack)))
                ((pair? top) (run-helper tail (apply-to-stack (car top) (cdr top) stack)))
                (else (run-helper tail stack))))))
  (run-helper instructions '()))

; Задача 3
(define (major-prefix? lst1 lst2)
  (cond ((null? lst1) #t)
        ((< (length lst2) (length lst1)) #f)
        (else (and (<= (car lst1) (car lst2))
              (major-prefix? (cdr lst1) (cdr lst2))))))

(define (majors? lst1 lst2)
  (if (null? lst1)
      (null? lst2)
      (or (major-prefix? lst2 lst1)
          (majors? (cdr lst1) lst2))))

(define (is-major? ll)
  (or (null? ll)
      (foldr (lambda (x y) (and x y)) #t (map majors? (cdr ll) ll))))
