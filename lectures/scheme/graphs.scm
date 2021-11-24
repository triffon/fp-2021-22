(define (search p l)
  (and (not (null? l)) (or (p (car l)) (search p (cdr l)))))

(define (all? p? l)
  (not (search (lambda (x) (not (p? x))) l)))

(define (keys al) (map car al))

(define g '((1 2 3) (2 3) (3 4 5) (4) (5 2 4 6) (6 2)))

(define (filter p? l)
  (cond ((null? l) l)
        ((p? (car l)) (cons (car l) (filter p? (cdr l))))
        (else (filter p? (cdr l)))))

(define (vertices g) (keys g))

(define (children u g) (cdr (assq u g)))

(define (edge? u v g) (memv v (children u g)))

(define (map-children f u g) (map f (children u g)))

(define (search-child p u g) (search p (children u g)))

(define (childless g)
  (filter (lambda (v) (null? (children v g))) (vertices g)))

(define (parents v g)
  (filter (lambda (u) (memv v (children u g))) (vertices g)))

; (parents v g) (children v g)

(define (symmetric? g)
  (all? (lambda (u)   ;∀u 
          (all? (lambda (v) ;∀v
              (edge? v u g)) ;v → u
          (children u g))) ;u → v
       (vertices g))) ; u ∈ vertices(g)

(define (dfs-path? u v g)
  (or (eqv? u v) (search-child (lambda (w) (dfs-path? w v g)) u g)))

(define (dfs-path u v g)
  (or (and (eqv? u v) (list u))
      (search-child (lambda (w) (cons#f u (dfs-path w v g))) u g)))

(define (cons#f x l) (and l (cons x l)))

(define (dfs-path u v g)
  (define (dfs-search path) ; намира дали може да разшири пътя в дълбочина, така че да стигне до v
    (let ((current (car path)))
      (if (eqv? current v) (reverse path)
          (search-child (lambda (w) (and (not (memv w path))
                                         (dfs-search (cons w path)))) current g))))
  (dfs-search (list u))
)


(define (bfs-path u v g)
  (define (extend path)  ; път -> списък от пътища
    (map-children (lambda (w) (cons w path)) (car path) g))

  (define (remains-acyclic? p)
    (not (memv (car p) (cdr p))))

  (define (extend-acyclic path) ; път -> списък от пътища
    (filter remains-acyclic? (extend path)))

  (define (target-path path)
    (and (eqv? (car path) v) path))

  (define (extend-level level)                 ; списък от пътища -> списък от списък от пътища ≠ списък от пътища = ниво
    (apply append (map extend-acyclic level))) ; да разширим всички пътища в нивото

  (define (bfs-level level)
    (if (null? level) #f
        (or  (search target-path level)          ; има път в нивото, който е стигнал до целта
             (bfs-level (extend-level level))))) ; има път в разширението на нивото
  (bfs-level (list (list u))))

; път = списък от върхове
; ниво = списък от пътища = списък от списъци от върхове
