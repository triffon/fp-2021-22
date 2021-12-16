; #lang racket/base

(define g '((1 2) (2 3) (3 1 4) (4 3 5) (5 5)))

(define the-empty-graph '())

(define (vertices g)
  (map car g))
; (display (vertices g))

(define (children v g)
  (cdr (assoc v g)))
; (display (children 3 g))

; unidirectional... is there an edge u->v ?
(define (edge? u v g)
  (member v (children u g)))
; (display (edge? 3 1 g))

(define (find p? l)
  (and (not (null? l))
       (or (p? (car l))
           (find p? (cdr l)))))

; (define (exists? p? l)
;   (foldl (lambda (x acc) (or (p? x) acc)) #f l))

(define (for-all? p? l)
  (not (find (lambda (x) (not (p? x))) l)))

(define (dfs-path u v g)
  (define (dfs path)
    (if (equal? (car path) v)
        (reverse path)
        (find (lambda (w)
                (and (not (member w path))
                     (dfs (cons w path))))
              (children (car path) g))))
  (dfs (list u)))

(define path? dfs-path)

(define (concat ll)
  (apply append ll))

(define (bfs-path u v g)
  (define (filter-acyclic paths)
    (filter (lambda (path)
              (not (member (car path) (cdr path))))
            paths))

  (define (extend-path path)
    (map (lambda (w) (cons w path))
         (children (car path) g)))

  (define (add-next-level paths)
    (concat (map extend-path paths)))

  (define (target-reached? path)
    (and (equal? (car path) v) (reverse path)))

  ; На всяка стъпка разгръщаме успоредно всички пътища с 1 връх
  ; елеминираме всички пътища, които образуват цикли.
  ; В някакъв момент ще някой от пътищата ще стигне до целевия връх
  ; или всички върхове ще са обходени.
  ; Спираме когато след последното разрастване на пътищата, не е останал необходен връх
  (define (bfs paths)
    (and (not (null? paths))
         (or (find target-reached? paths)
             (bfs
               (filter-acyclic ; повторно посещавани върхове образуват цикли - елеминираме ги
                 (add-next-level paths)))))) ; за всеки път създаваме няколко нови пътя

  ; Започваме с 1 път, който съдържа началния връх u
  (bfs (list (list u))))

; (display (dfs-path 1 3 g))
; (display (bfs-path 1 3 g))

(define (connected-bi? g)
  (and (not (null? g))
       (for-all?
         (lambda (v) (path? (caar g) v g))
         (vertices g))))

(display (connected-bi? g))

(define (edges g)
  (concat
    (map (lambda (cluster)
           (map (lambda (v)
                  (cons (car cluster) v))
                (cdr cluster)))
         g)))

(newline)
(display (edges g))

(define (add-edge u v g)
  (cond ((null? g) (list (list u v)))
        ((equal? (caar g) u)
           (cons (append (car g) (list v))
                 (cdr g)))
        (else
           (cons (car g)
                 (add-edge u v (cdr g))))))

; (newline)
; (display (add-edge 1 5 g))

; (newline)
; (display (add-edge 6 1 g))

(define (transpose g)
  (foldl (lambda (edge g)
           (add-edge (cdr edge) (car edge) g))
         the-empty-graph
         (edges g)))

(newline)
(display (transpose g))

; Kosaraju's algorithm
(define (strongly-connected? g)
  (and (connected-bi? g)
       (connected-bi? (transpose g))))

(newline)
(display (strongly-connected? g))

(define strongly-connected-graph '((0 1) (1 2) (2 3 4) (3 0) (4 2)))

(newline)
(display (connected-bi? strongly-connected-graph))

(newline)
(display (strongly-connected? strongly-connected-graph))
