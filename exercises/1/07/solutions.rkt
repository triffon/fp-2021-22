#lang racket

; Функциите от миналия път за асоциативни списъци

(define (make-alist fn keys)
  (map (lambda (key)
         (cons key (fn key)))
       keys))

(define (add-assoc key value alist)
  (cons (cons key value)
        alist))

(define (alist-keys alist)
  (map car alist))

(define (alist-values alist)
  (map cdr alist))

(define (alist-assoc key alist)
  (cond [(null? alist) '()]
        [(equal? (caar alist) key) (cdar alist)]
        [else (alist-assoc key (cdr alist))]))

(define (del-assoc key alist)
  (filter (lambda (alist-pair)
            (not (equal? (car alist-pair) key)))
          alist))


; Граф ще представяме като списък на съседство

; Няколко функции за работа с графи:
;
; Можем да конструираме граф само с върхове и без ребра
(define (make-graph vs)
  (map list vs))

; проверява дали графа g е празен.
(define empty-graph? null?)

; Списък от първите елементи на подсписъците на g
; са точно върховете на g.
; Но ние вече имаме функция която има същата дефиниция
(define vertices alist-keys)

; Добавяме списък от върха v,
; тоест той първоначално няма ребра до други върхове.
(define (add-vertex v g)
  (cons (list v) g))


; Имплементирайте следните функции за работа с графи
; Може да ползвате горните функции за асоциативни списъци

; Връща списък от всички ребра* на графа g.
; * т.е. двойки върхове (x . y), такива че има ребро от x към y
(define (children-edges vs)
  (map (lambda (v) (cons (car vs) v))
       (cdr vs)))

(define (edges g)
  (apply append (map children-edges g)))

; Връща списък от децата на върха v в g.
(define (children v g)
  (alist-assoc v g))

; Проверява дали има ребро от върха u до върха v в g.
(define (edge? u v g)
  (not (null? (member v (children u g)))))

; Връща списък от прилаганията на функцията f върху децата на v в g.
(define (map-children v f g)
  (map f (children v g)))

; Връща първото дете на v в g, което е вярно за предиката p.
(define (search-child v p g)
  (define (help-search vs)
    (cond [(null? vs) '()]
          [(p (car vs)) (car vs)]
          [else (help-search (cdr vs))]))
  (help-search (children v g)))

; Премахване на върха v от графа g заедно с ребрата до него.
(define (remove-vertex v g)
  (map (lambda (xs)
         (filter (lambda (x) (not (equal? x v))) xs))
       (del-assoc v g)))

; Добавяне на ребро от u до v в g.
(define (add-if-missing x l)
  (if (member x l)
      l
      (cons x l)))

(define (add-edge u v g)
  (let ((g-with-u-v (add-vertex v (add-vertex u g))))
    (add-assoc u
               (add-if-missing v (children u g-with-u-v))
               g-with-u-v)))

; премахване на ребро от u до v в g.
(define (remove-edge u v g)
  (add-assoc u
             (remove v (children u g))
             g))


; Имплементирайте следните функции за графи.

; Връща степента на върха v в графа g.
(define (degree v g)
  (length (alist-assoc v g)))

; Проверява дали графа g е симетричен.
(define (every? p l)
  (or (null? l)
      (and (p (car l))
           (every? p (cdr l)))))

(define (symmetric? g)
  (every? (lambda (edge)
            (edge? (cadr edge) (car edge) g))
          (edges g)))

; Инвертира графа g. Тоест за всяко ребро (u,v) в g новият граф ще има реброто (v,u).
(define (invert g)
  (foldl (lambda (edge g-inverted)
           (add-edge (cadr edge) (car edge) g-inverted))
         (make-graph (vertices g))
         (edges g)))

; Проверява дали има път между върховете u и v в графа g.
(define (search p l)
  (and (not (null? l))
       (or (p (car l))
           (search p (cdr l)))))

(define (path? u v g)
  (define (dfs path)
    (let ((current (car path)))
      (or (equal? current v)
          (and (not (member current (cdr path)))
               (search-child current
                             (lambda (child)
                               (dfs (cons child path)))
                             g)))))
    (not (search (lambda (vertex)
                 (dfs (list vertex)))
               (vertices g))))

; Проверява дали графа g е ацикличен.
(define (acyclic? g)
  (define (dfs path)
    (let ((current (car path)))
      (or (member current (cdr path))
          (search-child current
                        (lambda (child)
                          (dfs (cons child path)))
                        g))))
    (not (search (lambda (vertex)
                 (dfs (list vertex)))
               (vertices g))))

