(define (list? p)
  (or (null? p) (and (pair? p) (list? (cdr p)))))

(define (length l)
  (if (null? l) 0
      (+ 1 (length (cdr l)))))

; (cons <елемент> <списък>)
; (list <елемент₁> <елемент₂>)
; (append <списък₁> <списък₂>)

; (define (append l1 l2)
;   (if (null? l2) l1
;      (if (null? (cdr l2)) (cons (car l2) l1) '())))

(define (append l1 l2)
  (if (null? l1) l2
      (cons (car l1) (append (cdr l1) l2))))

(define (reverse l)
  (if (null? l) l
      (append (reverse (cdr l)) (list (car l)))))

(define (reverse l)
  (define (iter l res)
     (if (null? l) res
         (iter (cdr l) (cons (car l) res))))
  (iter l '()))

(define (list-tail l n)
  (if (= n 0) l
      (list-tail (cdr l) (- n 1))))

(define (list-ref l n)
  (if (= n 0) (car l)
      (list-ref (cdr l) (- n 1))))

(define (member-all x l equality?)
  (cond ((null? l) #f)
        ((equality? x (car l)) l) ; връщаме свидетелство
        (else (member-all x (cdr l) equality?))))

(define (member x l) (member-all x l equal?))
(define (memv x l) (member-all x l eqv?))
(define (memq x l) (member-all x l eq?))

(define (from-to a b)
  (if (> a b) '()
      ; a ≤ b
      (cons a (from-to (+ a 1) b))))

(define (accumulate op nv a b term next)
  (if (> a b) nv
      (op (term a) (accumulate op nv (next a) b term next))))

(define (1+ x) (+ x 1))

(define (id x) x)

(define (from-to a b)
  (accumulate cons '() a b id 1+))

; (collect a b term next) --> (term a), (term (next a)), ...
; collect <- accumulate
; accumulat <- collect + foldr

(define (map f l)
  (if (null? l) l
      (cons (f (car l)) (map f (cdr l)))))

(define (filter p l) ; --> (filter p (cdr l))
  (cond ((null? l) l)
        ; l ≠ '()
        ((p (car l)) (cons (car l) (filter p (cdr l))))
        ; p (cdr l) = #f
        (else (filter p (cdr l)))))

(define (filter p l)
  (if (null? l) l
      (let ((res (filter p (cdr l))))
        (if (p (car l)) (cons (car l) res) res))))

(define (foldr op nv l)
  (if (null? l) nv
      (op (car l) (foldr op nv (cdr l)))))

(define (fact n) (foldr * 1 (from-to 1 n)))

(define (filter p l)
  (foldr (lambda (h r) (if (p h) (cons h r) r)) '() l))

(define (map f l)
  (foldr (lambda (h r) (cons (f h) r)) '() l))

(define (foldl op nv l)
  (if (null? l) nv
      (foldl op (op nv (car l)) (cdr l))))

(define (reverse l)
  (define (iter l res)
     (if (null? l) res
         (iter (cdr l) (cons (car l) res))))
  (iter l '()))

(define (snoc t h) (cons h t))

(define (reverse l)
  ; (foldl (lambda (r h) (cons h r)) '() l))
  (foldl snoc '() l))

(define (maximum l)
  (foldr max (car l) l))

(define (foldr1 op l)
  (if (null? (cdr l)) (car l)
      (op (car l) (foldr1 op (cdr l)))))

(define (foldl1 op l)
  (foldl op (car l) (cdr l)))

(define dl '((1 (2)) (((3) 4) (5 (6)) () (7)) 8))

(define (atom? x)
  (not (or (pair? x) (null? x))))

(define (count-atoms dl)
  (cond ((null? dl) 0)
        ((atom? dl) 1)
        (else (+ (count-atoms (car dl)) (count-atoms (cdr dl))))))

(define (flatten dl)
  (cond ((null? dl) '())
        ((atom? dl) (list dl))
        (else (append (flatten (car dl)) (flatten (cdr dl))))))

(define (deep-reverse dl)
  (cond ((null? dl) '())
        ((atom? dl) dl)
        (else (append (deep-reverse (cdr dl)) (list (deep-reverse (car dl)))))))

; (append (list x) l) = (cons x l)