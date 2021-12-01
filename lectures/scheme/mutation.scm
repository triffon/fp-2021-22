(define (f x)
  (define (g y)
    (set! x (* y 2))
    y)
  (begin
    (display (g 5))
    (newline)
    (display x)
    (newline)
    (set! x (+ x 1))
    (display x)
    (newline)
    (* x x)))

;; template <typename U, typename V> struct pair { U car; V cdr; }
;; (set-car! p x) <-> p->car = x;
;; (set-cdr! p y) <-> p->cdr = y;

(define (make-account sum)
  (lambda (amount)
    (if (< (+ amount sum) 0)
        (display "Insufficient funds!\n")
        (set! sum (+ sum amount)))
    sum))
