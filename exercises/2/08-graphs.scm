(define sample-alist '((a . 3) (b . 4) (c . 5)))

(define (get-keys alist)
  (map car alist))

(define (get-values alist)
  (map cdr alist))

(define (map-alist f keys)
  (map (lambda (k) (cons k (f k))) keys))

#|
(define graph '((a b e)
                (b d c)
                (c f)
                (d c)
                (e)
                (f)))
|#

(define graph '((a . (b e))
                (b . (d c))
                (c . (f))
                (d . (c))
                (e . ())
                (f . ())))

(define (edge? v1 v2 g)
  (and (member v2 (cdr (assoc v1 g))) #t))

(define (children v g)
  (cdr (assoc v g)))

(define (out-degree v g)
  (length (children v g)))

(define (in-degree v g)
  (define (count-helper values count)
    (cond ((null? values) count)
          ((member v (car values)) (count-helper (cdr values) (+ count 1)))
          (else (count-helper (cdr values) count))))
  (count-helper (get-values g) 0))

(define (degree v g)
  (+ (in-degree v g)
     (out-degree v g)))

(define (parents v g)
  (cond ((null? g) '())
        ((member v (cdar g)) (cons (caar g) (parents v (cdr g))))
        (else (parents v (cdr g)))))

(define (create-stack lst)
  (define (self prop . params)
    (cond ((equal? prop 'empty?) (null? lst))
          ((equal? prop 'top) (car lst))
          ((equal? prop 'push) (append (reverse params) lst))
          ((equal? prop 'pop) (cdr lst))))
  self)

(define (dfs v g)
  (define (dfs-helper visited stack)
    (if (stack 'empty?)
        '()
        (let ((u (stack 'top))
              (rest (stack 'pop)))
          (if (member u visited)
              (dfs-helper visited (create-stack rest))
              (cons u (dfs-helper (cons u visited)
                                  (create-stack (apply (create-stack rest) 'push (children u g)))))))))
  (dfs-helper '() (create-stack (list v))))