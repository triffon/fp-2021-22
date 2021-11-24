(define (foldr op nv l)
  (if (null? l) nv (op (car l) (foldr op nv (cdr l)))))

(define (all? p? l)
  (foldr (lambda (x y) (and x y)) #t (map p? l)))

(define (alist? al)
  (and (list? al) (all? pair? al)))

(define (make-alist f keys)
  (map (lambda (x) (cons x (f x))) keys))


(define al (make-alist (lambda (x) (* x x)) '(1 2 3)))

(define (keys al) (map car al))
(define (values al) (map cdr al))

(define (assoc key al)
  (cond ((null? al) #f)
        ((equal? (caar al) key) (car al))
        (else (assoc key (cdr al)))))

(define (del-assoc key al)
  (cond ((null? al) al)
        ((equal? (caar al) key) (cdr al))
        (else (cons (car al) (del-assoc key (cdr al))))))

(define (add-assoc key value al)
  (if (assoc key al) (map (lambda (kv) (if (equal? (car kv) key) (cons key value) kv)) al)
      (cons (cons key value) al)))

(define (filter p? l)
  (cond ((null? l) l)
        ((p? (car l)) (cons (car l) (filter p? (cdr l))))
        (else (filter p? (cdr l)))))

(define (exists? p? l)
  (not (null? (filter p? l))))

(define (search p? l)
  (let ((result (filter p? l)))
    (if (not (null? result)) (car result) #f)))

(define (search p l)
  (cond ((null? l) #f)
        ((p (car l)) (p (car l)))
        (else (search p (cdr l)))))

(define (search p l)
  (and (not (null? l)) (or (p (car l)) (search p (cdr l)))))

; (if x #f y) <-> (and (not x) y)
; (if x x y)  <-> (or x y)

(define (all? p? l)
  (= (length (filter p? l)) (length l)))

(define (all? p? l)
  (not (search (lambda (x) (not (p? x))) l)))