#lang racket
(define vs
  '(("lolcat" . 15)
    ("doge" . 35)
    ("omgseetrhis" . 28)
    ("neshto" . 20)
    ("neshto2" . 18)))
(define get-duration cadr)

(define (foldr1 op l)
  (if (null? (cdr l))
      (car l)
      (op (car l)
          (foldr1 op (cdr l)))))

(define (maximumOn f l)
  (define (fmax x y)
    (if (>= (f x) (f y))
        x
        y))
  (foldr1 fmax l))







(define (insertion-sort l)
  (foldr insert '() l))

(define (insert x sl)
  (cond ((null? sl) (cons x sl))
        ((< x (car sl)) (cons x sl))
        (else (cons (car sl)
                    (insert x (cdr sl))))))

(define (quicksort l)
  (if (null? l)
      l
      (append (quicksort (filter (lambda (x) (<= x (car l))) (cdr l)))
              (list (car l))
              (quicksort (filter (lambda (x) (> x (car l))) l))
              )))



(define (sort-on f l)
  (define (insert x sl)
    (cond ((null? sl) (cons x sl))
          ((< (f x) (f (car sl))) (cons x sl))
          (else (cons (car sl)
                      (insert x (cdr sl))))))

  (foldr insert '() l))








; Лекарство се задава със наредена двойка от име (низ) и списък от
; активни съставки, зададени като наредени двойки от име (низ) и количество в
; мг (цяло число). Казваме, че лекарството A е заместител на лекарството B,
; ако A има точно същите активни съставки като B в същата пропорция.
; a.
; (4 т.) Да се реализира функция isSubstitute, която по две дадени
; лекарства проверява дали едното е заместител на другото.
; b.
; (6 т.) Да се реализира функция bestSubstitutes, която по лекарство A
; и списък от лекарства L намира името на "най-добрия" заместител на A
; в L, чиито активни съставки са най-близки по количество до тези на A,
; без да ги надхвърлят, или празният низ, ако такъв няма.
; c.
; (8 т.) Да се реализира функция groupSubstitutes, по даден списък от
; лекарства ги групира по “заместителство”, т.е. връща списък от
; списъци от лекарства, където всички лекарства в даден списък са
; заместители един на друг.
; Пример: l = [("A",[("p",6),("q",9)]),("B",[("p",2),("q",3)]),("C",[("p",3)])]
; isSubstitute (l!!0) (l!!1) → True
; bestSubstitute (l!!0) (tail l) → "B"
;
;[("A",[("p",6),("q",9)])
;,("B",[("p",2),("q",3)])
;,("C",[("p",3)])]
(define lek1
  (list
   (list "A" (cons "p" 6) (cons "q" 9))
   (list "B" (cons "p" 2) (cons "q" 3))
   (list "C" (cons "p" 3))))



(define lek2
  '(("A" ("p" . 6) ("q" . 9))
    ("B" ("p" . 2) ("q" . 3))
    ("C" ("p" . 3))))
(define lek3
  '(
    ("A" ("p" . 6) ("q" . 2) ("z" . 10) ("w" . 8))
    ("S" ("p" . 3) ("z" . 5) ("q" . 1) ("w" . 4))
    ("O" ("w" . 3) ("q" . 2) ("z" . 10) ("p" . 4))
    ("K" ("p" . 3/2) ("q" . 1/2) ("z" . 5/2)  ("w" . 4/2))
    ("Z" ("p" . 12) ("q" . 4) ("z" . 20) ("w" . 16))
    ("B" ("p" . 2) ("q" . 3))
    ("C" ("p" . 3) ("z" . 10))))


(define (get-numerator m)
  (cdr (cadr m)))

(define (get-denominator m)
  (if (null? (cdr (cdr m)))
      1
      (cdr (car (cdr (cdr m))))))

(define (get-proportion m)
  (if (null?  (get-denominator m))
      (get-numerator m)
      (/ (get-numerator m)
         (get-denominator m))))


(define (is-substitute? m1 m2)
  (equal? (get-proportion m1)
          (get-proportion m2)))


(define (all p? l)
  (foldr (lambda (x rec)
           (and (p? x)
                rec))
         #t
         l))

(define (multiset-eq s1 s2)
  (and (= (length s1) (length s2))
       (all (lambda (x)
              (member x s2))
            s1)
       (all (lambda (x)
              (member x s1))
            s2)
       ))

(define (med-eq l1 l2)
  (and (= (length l1) (length l2))
       (all (lambda (x)
              (define name (car x))
              (define prop (cdr x))
              (define other (assoc name l2))
              (if (eq? other #f)
                  #f
                  (= prop (cdr other)))
              )
            l1)))

(define get-ingrs cdr)
(define (sum l)
  (foldr + 0 l))

(define (isSubstitute m1 m2)
  (define ingrs1 (get-ingrs m1))
  (define sum-m1 (sum (map cdr ingrs1)))
  
  (define ingrs2 (get-ingrs m2))
  (define sum-m2 (sum (map cdr ingrs2)))

  (med-eq  ;multiset-eq
   (map (lambda (i)
          (cons (car i)
                (/ (cdr i) sum-m1)))
        ingrs1)
   (map (lambda (i)
          (cons (car i)
                (/ (cdr i) sum-m2)))
        ingrs2)
   ))


(define (best-substitute med meds)
  (car (maximumOn (lambda (x)
                    (if (<= (get-proportion x)
                            (get-proportion med))
                        (get-proportion x)
                        0))
                  meds)))

;(define get-ingrs cdr)

(define (func l)
  (if (null? l)
      #f
      (let ([x (car l)]
            [tail (cdr l)]
            [asd 'asd])
        (func (cdr l)))))

(define (bestSubstitute med meds)
  (maximumOn
   (lambda (m)
     (sum (map cdr (cdr m))))

   (filter (lambda (m)
             (define ingr-m (get-ingrs m))
             (define ingr-med (cdr med))
             (and (isSubstitute med m)
                  (all (lambda (i)
                         (define other (assoc (car i) ingr-med))
                         (if (eq? other #f)
                             #f
                             (<= (cdr i) (cdr other))))
                       ingr-m)
                  ))
           meds)))

; lekarstva

(define (groupSubstitutes meds)
  (if (null? meds)
      meds
      (cons
       (filter (lambda (med)
                 (is-substitute? med (car meds)))
               meds)
       (groupSubstitutes
        (filter (lambda (med)
                  (not (is-substitute? med (car meds))))
                meds)))))




