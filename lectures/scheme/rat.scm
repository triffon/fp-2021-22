;(define (make-rat n d) (cons n (if (= d 0) 1 d)))
(define (make-rat n d)
  (if (= d 0) (make-rat 0 1)
      ; d <> 0
      (let* ((g (gcd n d))
             (numer (/ n g))
             (denom (/ d g)))
        ; gcd(numer,denom) = 1
        (if (< denom 0)
            (cons (- numer) (- denom))
            (cons numer denom)))))

(define get-numer car)
(define get-denom cdr)

(define (+rat r1 r2)
  (make-rat (+ (* (get-numer r1) (get-denom r2))
               (* (get-numer r2) (get-denom r1)))
            (* (get-denom r1) (get-denom r2))))

(define (accumulate op nv a b term next)
  (if (> a b) nv
      (op (term a) (accumulate op nv (next a) b term next))))

(define (1+ x) (+ x 1))
(define (id x) x)
(define (fact n)
  (accumulate * 1 1 n id 1+))

(define (pow x n)
  (accumulate * 1 1 n (lambda (i) x) 1+))

(define (my-exp x n)
  (accumulate +rat (make-rat 0 1) 0 n
              (lambda (i) (make-rat (pow x i) (fact i)))
              1+))

(define (rat-to-float r)
  (+ .0 (/ (get-numer r) (get-denom r))))