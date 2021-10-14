#lang racket

; 1. Намира броя на цифрите на дадено цяло число n.
; Реализирайте я чрез линейна рекурсия (итерация).
(define (count-digits-i n)
  (define (iter counter number)
    (if (< number 10)
      counter
      (iter (+ counter 1)
            (quotient number 10))))
  (iter 1 (abs n)))

; 2. За дадени числа a и b намира сумата на целите числа в интервала [a,b].
; Трябва да работи и за a > b.
; Реализирайте я чрез линейна рекурсия (итерация).
(define (interval-sum-i a b)
  (define (iter i j acc)
    (if (= i j)
      (+ acc i)
      (iter (+ i 1)
            j
            (+ acc i))))
  (if (< a b)
    (iter a b 0)
    (iter b a 0)))

; 3. За дадено цяло число n връща число, чийто цифри са в обратен ред.
; Реализирайте го чрез линейна рекурсия (итерация).
(define (reverse-digits-i n)
  (define (iter number result)
    (if (zero? number)
      result
      (iter (quotient number 10)
            (+ (* result 10)
               (remainder number 10)))))
  (iter n 0))

; 4. За дадени цели числа x и n връща x^n.
; Реализирайте я чрез линейна рекурсия (итерация).
(define (pow-i x n)
  (define (iter step accumulator)
    (if (zero? step)
      accumulator
      (iter (- step 1)
            (* accumulator x))))
  (if (negative? n)
    (/ 1 (iter (- n) 1))
    (iter n 1)))

; 5. За дадени цели числа x и n връща x^n. Но се възползва от свойството:
; ако n е четно, то x^n = (x^(n/2))^2. Реализирайте я чрез линейна рекурсия (итерация).
(define (fast-pow x n)
  (define (iter base exponent accumulator)
    (cond [(zero? exponent) accumulator]
          [(even? exponent)
           (iter (* base base)
                 (/ exponent 2)
                 accumulator)]
          [else (iter base
                      (- exponent 1)
                      (* accumulator base))]))
  (if (negative? n)
      (/ 1 (iter x (- n) 1))
      (iter x n 1)))



;-------------------------;
; функции от по-висок ред ;
;-------------------------;

; Идентитета не е част от R5RS, може да ви потрябва :)
(define (id x) x)

; 1. За даден едноместен предикат p, връща отрицанието му.
; Не отрицанието на резултата, а нов предикат който е отрицание на p.
(define (complement p)
  (lambda (x) (not (p x))))

; 2. За дадена функция на два аргумента f,
; връща функцията над разменени аргументи.
(define (flip f)
  (lambda (x y) (f y x)))

; 3. Взима едноаргументна функция f и връща композицията (f∘f)
(define (double f)
  (lambda (x) (f (f x))))

; 4. За дадени едноаргументни функции f и g връща композицията им (f∘f)
(define (compose f g)
  (lambda (x) (f (g x))))

; 5. За дадена едноаргументна функция f и число n,
; връща n-тото прилагане на f. Тоест f^n.
; Пример: (repeat f 3) x) ще е същото като (f (f (f x)))
(define (repeat f n)
  (if (zero? n)
    id
    (lambda (x) (f ((repeat f (- n 1)) x)))))
