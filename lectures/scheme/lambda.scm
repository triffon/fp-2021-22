(define my#t (lambda (x y) x))
(define my#f (lambda (x y) y))
(define (my-if b x y) ((b x y)))

(define (fact n)
  (if (= n 0) 1
      (* n (fact (- n 1)))))

(define gamma
  (lambda (F)
    (lambda (n) (if (= n 0) 1 (* n (F (- n 1)))))))

(define fact (gamma fact))

(define (compose f g) (lambda (x) (f (g x))))

(define (id x) x)

(define (repeated f n)
  (if (= n 0) id
      (compose f (repeated f (- n 1)))))

(define fact ((repeated gamma 50) 'empty))

(define (gamma-inf me) (lambda (n) ((gamma (me me)) n)))

(define fact (gamma-inf gamma-inf))

(define gamma2
  (lambda (F)
    (lambda (n) (if (= n 0) 1 (* 2 (F (- n 1)))))))

(define (gamma2-inf me) (lambda (n) ((gamma2 (me me)) n)))

(define 2^ (gamma2-inf gamma2-inf))

(define Y
  (lambda (gamma)
  ((lambda (me) (lambda (n) ((gamma (me me)) n))) (lambda (me) (lambda (n) ((gamma (me me)) n))))))


(define fact (Y gamma))
(define 2^ (Y gamma2))
