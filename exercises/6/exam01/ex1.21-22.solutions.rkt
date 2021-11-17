#lang racket

(define (foldr op nv l)
  (if (null? l)
      nv
      (op (car l) (foldr op nv (cdr l)))))

(define (filter p? l)
  (foldr (lambda (x rec)
           (if (p? x)
               (cons x rec)
               rec))
         '()
         l))

(define (from-to a b)
  (if (> a b)
      '()
      (cons a (from-to (+ a 1) b))))
(define (sum l)
  (foldr + 0 l))

(define (divisors n)
  (filter (lambda (k) (= 0 (remainder n k)))
          (from-to 1 (- n 1))))

(define (last l)
  (if (null? (cdr l))
      (car l)
      (last (cdr l))))

(define (done? n)
  (= (+ n 2)
     (sum (divisors n))))

(define (sum-almost-done-alt a b)
  (define dones (filter done? (from-to (+ a 1) (- b 1))))
  (if (null? dones)
      0
      ; Ползвам let* за да се правят дефинициите единствено когато
      ; dones не е '().
      ; Ако пък ги бях define-нал най-отгоре щеше да излезе грешка
      ; че се извиква car върху '() ако ли се случи да е вярно (null? dones).
      (let*
       ((left-done (car dones))
        (right-done (last dones))
        (start (ceiling (/ (+ a left-done 1) 2)))
        (end (floor (/ (+ b right-done -1) 2))))

       (sum (from-to start end)))))

(define (dist x y)
  (abs (- x y)))

(define (sum-almost-done a b)
  (define dones (filter done? (from-to (+ a 1) (- b 1))))
  (sum (filter (lambda (x)
                 (any (lambda (d)
                        (< (dist x d)
                           (min (dist x a)
                              (dist x b))))
                      dones))
               (from-to a b))))






(define (foldl op nv l)
  (if (null? l)
      nv
      (foldl op (op nv (car l)) (cdr l))))

(define (run-machine l)
  (define (reduce f n memory)
    (if (or (= n 0)
            (null? memory)
            (symbol? (car memory))
            (null? (cdr memory))
            (symbol? (cadr memory)))
        memory
        (reduce f (- n 1)
                (cons (f (car memory) (cadr memory))
                      (cddr memory)))))
  (define (exec memory instr)
    (cond
      ((or (number? instr) (symbol? instr))
       (cons instr memory))
      ((procedure? instr)
       (map (lambda (x)
              (if (number? x)
                  (instr x)
                  x))
            memory))
      ((and (pair? instr)
            (procedure? (car instr))
            (number? (cdr instr)))
       (reduce (car instr) (cdr instr) memory))
      (else memory)))

  (foldl exec '() l))





;(define (prefix? l m)
;  (cond
;    ((null? l) #t)
;    ((null? m) #f)
;    ((equal? (car l) (car m)) (prefix? (cdr l) (cdr m)))
;    (else #f)))

;(define (sublist? l m)
;  (cond
;    ((null? l) #t)
;    ((null? m) #f)
;    ((prefix? l m) #t)
;    (else (sublist? l (cdr m)))))

(define (all2 p? l m)
  (or (null? l)
      (null? m)
      (and (p? (car l) (car m))
           (all2 p? (cdr l) (cdr m)))))
(define (any p? l)
  (foldr (lambda (x rec) (or (p? x) rec)) #f l))
(define (take n l)
  (if (or (= n 0)
          (null? l))
      '()
      (cons (car l)
            (take (- n 1) (cdr l)))))

(define (sublists-of-len n l)
  (cond
    ((= n 0) '(()))
    ((< (length l) n) '())
    (else (cons (take n l)
                (sublists-of-len n (cdr l))))))

(define (majored? l m)
  (and (= (length l) (length m))
       (all2 <= l m)))

(define (is-major? ll)
  (or (null? ll)
      (null? (cdr ll))
      (and (any (lambda (m) (majored? (car ll) m))
                (sublists-of-len (length (car ll))
                                 (cadr ll)))
           (is-major? (cdr ll)))))

(define (1+ n) (+ n 1))
(define (accumulate op nv a b term next)
  (if (> a b)
      nv
      (op (term a) (accumulate op nv (next a) b term next))))

(define (longest ll)
  (define (longer x y)
    (if (> (length y) (length x))
        y
        x))
  (foldr longer '() ll))

(define (find-longest-major ll)
  (accumulate
    (lambda (ss rec)
      (longest (cons rec (filter is-major? ss))))
    '()
    0
    (length ll)
    (lambda (n) (sublists-of-len n ll))
    1+))

;(find-longest-major '((1 3) (4 2 7) (2 5 3 3 9 12)))
