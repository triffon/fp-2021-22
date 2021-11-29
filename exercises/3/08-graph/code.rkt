#lang racket

; copy from last time
(define (exists? l p)
  (if (null? l)
      #f
      (if (p (car l))
          #t
          (exists? (cdr l) p))))

(define (forall? l p)
  (if (null? l)
      #t
      (if (p (car l))
          (forall? (cdr l) p)
          #f)))

(define assoc-empty '())

(define (assoc-empty? list)
  (null? list))

(define (contains-key? key assoc-list)
  (if (assoc-empty? assoc-list) #f
     (if(equal? key (car (car assoc-list))) #t
        (contains-key? key (cdr assoc-list)))))

(define (contains-only-pairs? l)
  (forall? l pair?))

(define (no-duplicate-keys? l)
  (if(assoc-empty? l) #t
     (if (not (contains-key? (car (car l)) (cdr l)))
         (no-duplicate-keys? (cdr l))
         #f)))

(define (assoc? l)
  (and (list? l) (contains-only-pairs? l) (no-duplicate-keys? l)))

(define (assoc-set l k v)
  (if (null? l) (cons (cons k v) l)
      (if (equal? (car (car l)) k)
          (cons (cons k v) (cdr l))
          (cons (car l) (assoc-set (cdr l) k v)))))

(define (assoc-get l k)
  (if(null? l) #f
     (if(equal? k (caar l)) (cdr (car l))
        (assoc-get (cdr l) k))))

(define (assoc-map f l)
  (map (lambda (x) (cons (car x) (f (cdr x)))) l))

(define (assoc-filter p l)
  (filter (lambda (x) (p (cdr x))) l))

(define (assoc-merge l1 l2)
  (if (null? l2) l1
      (assoc-merge (assoc-set l1 (caar l2) (cdar l2)) (cdr l2))))

(define (forall-values? l p)
  (forall? l (lambda (x) (p (cdr x)))))

; graphs

(define my-graph
  (list
   (cons 1 (list 1 2 3))
   (cons 2 (list 3))
   (cons 3 (list 1))))

(define my-dag
  (list
   (cons 1 (list 2 3))
   (cons 2 (list 3 4 5))
   (cons 4 (list 5))
   (cons 3 (list 6))
   (cons 6 (list 5))))

(define (neighbours-list g)
  (forall-values? g (lambda (x) (forall? x (lambda (y) (contains-key? y g)) ))))


(define (graph? g)
  (and
   (assoc? g)
   (forall-values? g list?)
   (neighbours-list g)))

(define (out-deg g x)
  (length (assoc-get g x)))

(define (out-deg2 g x)
  (accumulate + 0
                 (lambda (pair) (if (equal? x (car pair))
                                    (length (cdr pair)) 0)) g))

(define (member? elem l)
  (if (null? l) #f
      (if (equal? elem (car l)) #t
          (member? elem (cdr l)))))

(define (accumulate op nv term l)
  (if (null? l) nv
      (op (term (car l)) (accumulate op nv term (cdr l)))))

(define (in-deg g x)
  (accumulate + 0 (lambda (pair) (if (member? x (cdr pair)) 1 0)) g))

(define (deg g x)
  (+ (out-deg g x)
     (in-deg g x)))

(define (max-deg g)
 (accumulate max 0 (lambda (y) (deg g (car y))) g))

(define (edge2? g x y)
  (accumulate
   (lambda (x y) (or x y))
   #f
   (lambda (pair) (and (equal? x (car pair)) (member? y (cdr pair))))
   g ))

(define (children g x)
  (assoc-get g x))

(define (edge? g x y)
  (member? y (children g x)))

(define (id x) x)

(define (shorter l1 l2)
  (if (< (length l2) (length l1))
      l2
      l1))

(define (shortest l)
  (if (null? l)
      #f
      (if (null? (cdr l))
          (car l)
          (shorter (car l) (shortest (cdr l))))))
      
(define (path g x y)
  (path-limited g x y (length g)))

(define (path-limited g x y depth-limit)
  (define (path-to-y z) (path-limited g z y (- depth-limit 1)))
  (define (remove-falses l) (filter id l))
  (define (add-x p) (cons x p))

  (if (equal? x y)
      (list x)
      (if (= depth-limit 0)
          #f
          (shortest (map add-x (remove-falses (map path-to-y (children g x))))))))