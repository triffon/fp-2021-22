;#lang racket

; Throwback:
; - Нямаме цикли, само рекурсия
; - Всичко е стойност (в частност функциите)
; - кода на scheme е под формата на списъци
; - Функции - извикване и дефиниране
; - define, if, cond
; - Малко рекурсия

; Миналия път показахме как можем да дефинираме функции
; с define.
(define (succ n) (+ n 1))

; Можем да правим вложени дефиниции
(define (succ-then-square x)
  (define (square x) (expt x 2))
  (square (succ x)))

(succ-then-square 3) ; 16


; Нека разгледаме n!
(define (factorial n)
  (if (= n 0)
    1
    (* n (factorial (- n 1)))))

; ако бележим factorial с f, изчислителния процес на 5!
; изглежда така:
;(f 5)
;(* 5 (f 4))
;(* 5 (* 4 (f 3)))
;(* 5 (* 4 (* 3 (f 2))))
;(* 5 (* 4 (* 3 (* 2 (f 1)))))
;(* 5 (* 4 (* 3 (* 2 (* 1 (f 0))))))
;(* 5 (* 4 (* 3 (* 2 (* 1 1)))))
;(* 5 (* 4 (* 3 (* 2 1))))
;(* 5 (* 4 (* 3 2)))
;(* 5 (* 4 6))
;(* 5 24)
;120

; памет: O(n)
; време: О(n)

; Това е същински рекурсивен процес заради отложените операции.

; Използвайки вложена дефиниция:
(define (factorial-iter n)
  (define (iter product counter)
    ; Тук на практика ползваме помощни аргументи като допълнителна памет.
    ; Крайният требител няма достъп до тях.
    (if (> counter n)
      product
      (iter
        (* counter product)
        (+ counter 1))))
  (iter 1 1))

; Вече изчислителния процес изглежда така:
;(factorial-iter 5)
;(iter   1 1)
;(iter   1 2)
;(iter   2 3)
;(iter   6 4)
;(iter  24 5)
;(iter 120 6)
;120

; време: O(n)
; памет: O(1)

; Това е линеен итеративен процес, заради липсата на отложени операции.
; Нарича се още опашкова рекурсия.

; Scheme третира опашковата рекурсия като итеративен процес.
; Ако всички рекурсивни извиквания в една функция са опашкови,
; тя генерира линеен итеративен процес.


; Тази реализация поражда дървовиден рекурсивен процес,
; защото има 2 рекурсивни извиквания и отложена операция.
(define (fib n)
  (if (< n 2)
    n
    (+ (fib (- n 1))
       (fib (- n 2)))))

; време: O(2^n)

; Можем ли да го направим итеративно? (динамично програмиране)
; Ще намираме числата на фибоначи последователно и ще помним предходните две.
; Така няма да трябва да ги изчисляваме всеки път когато ни потрябват.
(define (fib-iter n)
  (define (iter n1 n2 index)
    (if (= index 0)
      n1
      (iter n2
            (+ n1 n2)
            (- index 1))))
  (iter 0 1 n))

; (time (fib 42))
; (time (fib-iter 42))
; time измерва колко време отнема на подадената функция да звърши


;-------------------------;
; Функции от по-висок ред ;
;-------------------------;

; Функциите, както всички останали стойности, можем
; да ги подаваме като аргументи на функции.
; Такава функция, която приема като аргумент друга функция,
; наричаме функция от по-висок ред.

(define (binary-op f x y) (f x y))
; Очаква се f да бъде функция и в тялото на binary-op я използваме като такава.
; Тоест прилагаме я върху x и y.

(binary-op + 2 3) ;5
(binary-op * 2 3) ;6

; Можем и като резултат на една функция да върнем друга.
(define (ifp p g f)
  (if p g f))

(ifp (< 1 2) + *) ;#procedure:+>
; Можем да приложим върнатата функция върху някакви аргументи
((ifp (< 1 2) + *) 5 8)  ;13
((ifp (> 1 2) + *) 5 8)  ;40

; Анонимна (ламбда) функции
; (lambda (<arg1> <arg2> .. <argn>) <body>)

; По същия начин както с именованите функции, ламбда функциите
; можем да ги подаваме като аргументи на други функции или да
; ги връщаме като резултат.

(binary-op (lambda
             (a b)
             (/ (+ a b) 2))
           10
           2) ;6
; Можем да конструираме операцията на място, вместо да правим отделна дефиниция.

; Можем и да я извикаме веднага след като я дефинираме ако искаме.
((lambda (x y) (gcd x y)) 17 6) ;1
; ОЩЕ СКОБИ!

; Важно е че анонимната функция пази указател към средата,
; в която е оценена.



;;;;;;;;;;
; ЗАДАЧИ ;
;;;;;;;;;;

; За сравнение,
; ето решения на задачите от миналия път,
; които сега ще трябва да напишете с опашкова рекурсия.
; ----------------------
(define (count-digits n)
  (if (< n 10)
    1
    (+ 1 (count-digits (quotient n 10)))))

(define (pow x n)
  (if (zero? n)
    1
    (* x (pow x (- n 1)))))

(define (interval-sum a b)
  (if (= a b)
    b
    (+ a (interval-sum (+ a 1) b))))
; ----------------------------------

; 1. Намира броя на цифрите на дадено цяло число n.
; Реализирайте я чрез линейна рекурсия (итерация).
(define (count-digits-i n) void)

; 2. За дадени числа a и b намира сумата на целите числа в интервала [a,b].
; Трябва да работи и за a > b.
; Реализирайте я чрез линейна рекурсия (итерация).
(define (interval-sum-i a b) void)

; 3. За дадено цяло число n връща число, чийто цифри са в обратен ред.
; Реализирайте го чрез линейна рекурсия (итерация).
(define (reverse-digits-i n) void)

; 4. За дадени цели числа x и n връща x^n.
; Реализирайте я чрез линейна рекурсия (итерация).
(define (pow-i x n) void)

; 5. За дадени цели числа x и n връща x^n. Но се възползва от свойството:
; ако n е четно, то x^n = (x^(n/2))^2. Реализирайте я чрез линейна рекурсия (итерация).
(define (fast-pow x n) void)


;-------------------------;
; функции от по-висок ред ;
;-------------------------;

; 1. За даден едноместен предикат p, връща отрицанието му.
; Не отрицанието на резултата, а нов предикат който е отрицание на p.
(define (complement p) void)

; 2. За дадена функция на два аргумента f,
; връща функцията над разменени аргументи.
(define (flip f) void)

; 3. Взима едноаргументна функция f и връща композицията (f∘f)
(define (double f) void)

; 4. За дадени едноаргументни функции f и g връща композицията им (f∘f)
(define (compose f g) void)

; 5. За дадена едноаргументна функция f и число n,
; връща n-тото прилагане на f. Тоест f^n.
; Пример: (repeat f 3) x) ще е същото като (f (f (f x)))
(define (repeat f n) void)


; Идентитета не е част от R5RS, може да ви потрябва :)
(define (id x) x)

; * Вече писахме функция, която намира сумата на числа в интервал.
; acc (акумулатор) - начална стойност и променлива в която
; натрупваме, полученият досега резултат.

; 6. Намира сумата на израз от числата в даден интервал
; - term(x), за всяко x от интервала при сумиране
; Пример: сума на x^2, x/4, 2^x и т.н.
(define (sum-term from to term acc) void)

; 7. Напишете функция като горната,
; но натрупва резултата с произволна бинарна операция op.
; Реализирайте я чрез итеративен процес.
; Пример: сума, произведение, дизюнкция и т.н.
(define (accumulate from to op term acc) void)

; 8. Реализирайте факториел чрез accumulate.
(define (fact n) void)

; 9. Намира броя на числата в интервал, които изпълняват даден предикат.
; Реализирайте я чрез accumulate.
(define (count-p from to p) void)

; 10. Проверява дали даден предикат е верен за всички числа в даден интервал.
; Реализирайте я чрез accumulate.
(define (for-all? from to p) void)

; 11 .Тя проверява дали някое число в даден интервал изпълнява даден предикат.
; Реализирайте я чрез accumulate.
(define (exists? from to p) void)