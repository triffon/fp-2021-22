#lang racket
(define head car)
(define tail cdr)

(define (all? p? lst)
  (foldr (lambda (el res) (and (p? el) res)) #t lst))
(define (zipWith op lst1 lst2)
  (if (or (null? lst1) (null? lst2)) '()
      (cons (op (head lst1) (head lst2))
            (zipWith op (tail lst1) (tail lst2)))))
(define (id x) x)

(define (majors? lst1 lst2)
  ;(and (= (length lst1) (length lst2))
  ;     (all? id (zipWith <= lst1 lst2))))
  (if (null? lst1)
      (null? lst2)
      (and (not (null? lst2))
           (<= (head lst1) (head lst2))
           (majors? (tail lst1) (tail lst2)))))

(define (take n lst)
  (if (or (zero? n) (null? lst)) '()
      (cons (head lst) (take (- n 1) (tail lst)))))

(define (majors-prefix? lst1 lst2)
  (majors? lst1 (take (length lst1) lst2)))

(define (majors-by-sublist? lst1 lst2)
  (and (not (null? lst2))
       (or (majors-prefix? lst1 lst2)
           (majors-by-sublist? lst1 (tail lst2)))))

(define (is-major? ll)
  (or (null? ll)
      (null? (tail ll))
      (and (majors-by-sublist? (head ll) (head (tail ll)))
           (is-major? (tail ll)))))

(is-major? '((1 3) (4 2 7) (2 5 4 3 9 12)))
(is-major? '((1 3) (4 2 7) (2 5 3 3 9 12)))

; Забележка - решението с помощна функция, обработваща
; само една команда + използването ѝ във foldl, е по-просто.
(define (run-machine cmds)
  (define (loop cmds stack)
    (if (null? cmds) stack
        (let* [(first (head cmds))
               (rest (tail cmds))
               (op (if (pair? first) (car first) #f))
               (n (if (pair? first) (cdr first) #f))
               (a1 (if (null? stack) #f (head stack)))
               (a2 (if (or (null? stack) (null? (tail stack)))
                       #f
                       (head (tail stack))))]
          (cond [(or (number? first) (symbol? first))
                 (loop rest (cons first stack))]
                [(procedure? first)
                 (loop rest (map (lambda (i)
                                   (if (number? i)
                                       (first i)
                                       i))
                                 stack))]
                [(and (pair? first)
                      (procedure? op)
                      (number? n)
                      (positive? n)
                      (not (null? stack))
                      (not (null? (tail stack)))
                      (number? a1)
                      (number? a2))
                 (loop (cons (cons op (- n 1)) rest)
                       (cons (op a1 a2) (tail (tail stack))))]
                [else (loop rest stack)]))))
  (loop cmds '()))

(run-machine (list 1 'x 4 'a 9 16 25 sqrt 6)) ;(6 5 4 3 a 2 x 1)
(run-machine (list 1 'x 4 'a 9 16 25 sqrt 6 (cons + 2) (cons * 5))) ; (45 a 2 x 1)













