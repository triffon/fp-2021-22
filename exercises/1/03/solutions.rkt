#lang racket

; NOTE: Суфикса * е защото съществуват вградени процедури със същите имена.

; 1. Намира дължината на списъка lst.
(define (length* lst)
  (if (null? lst)
    0
    (+ 1
       (length* (cdr lst)))))
; 2. Намира сумата на елементите на списъка lst. Предполага се че са само числа.
(define (sum lst)
  (if (null? lst)
    0
    (+ (car lst)
       (sum (cdr lst)))))

; 3. Връща последния елемент на списъка lst.
(define (last* lst)
  (if (null? (cdr lst))
    (car lst)
    (last (cdr lst))))

; 4. Връща n-тия елемент на списъка lst.
(define (nth n lst)
  (define (help i lst)
    (cond [(null? lst) 'not-found]
          [(= i n) (car lst)]
          [else (help (+ 1 i) (cdr lst))]))
  (help 0))

; 5. Връща конкатенацията на lst1 и lst2.
(define (concat lst1 lst2)
  (if (null? lst1)
    lst2
    (cons
      (car lst1)
      (concat (cdr lst1) lst2))))

; 6. Прилага fn над елементите на lst, връща новия списък.
(define (map* f lst)
  (if (null? lst)
    lst
    (cons
      (f (car lst))
      (map* f (cdr lst)))))

; 7. Връща списък от елементите на lst, за които pred е вярно.
(define (filter* p lst)
  (cond [(null? lst) lst]
        [(p (car lst))
         (cons
           (car lst)
           (filter* p (cdr lst)))]
        [else (filter* p (cdr lst))]))

; 8. Връща списък от 2 елемента - списъци
;   - Елементите от lst изпълняващи предиката p
;   - Останалите елементи на lst
(define (partition* p lst)
  (define (help truthy falsy lst)
    (cond [(null? lst) (cons truthy (list falsy))]
          [(p (car lst))
           (help (cons (car lst) truthy)
                 falsy
                 (cdr lst))]
          [else (help truthy
                      (cons (car lst) falsy)
                      (cdr lst))]))
  (help '() '() lst))

; NOTE: Или по-лесно - filter в-ху предиката и filter в-ху complement варианта му.

; NOTE: Вградената функция partition работи малко по-различно
;       - връща (values lst1 lst2)


; ---------------------
; ЗАДАЧИ ОТ МИНАЛИЯ ПЪТ

; 1*. Напишете функция която комбинира числата в даден интервал [from, to]
; с дадена бинарна операция op,
; като преди това върху всяко число прилага дадена едноаргументна функция term.
; Натрупването започва от дадената стойност acc.
; Пример: сума, произведение, дизюнкция и т.н.
(define (accumulate from to op term acc)
  (if (> from to)
    acc
    (accumulate (+ from 1)
                 to
                 op
                 term
                 (op acc (term from)))))

; 2. Реализирайте факториел чрез accumulate.
(define (fact n)
  (accumulate 1 n * id 1))

; 3. Намира броя на числата в интервал, които изпълняват даден предикат.
; Реализирайте я чрез accumulate.
(define (count-p from to p)
  (define (inc-if acc x)
      (if (p x) (+ acc 1) acc))
  (accumulate from to inc-if id 0))

; 4. Проверява дали даден предикат е верен за всички числа в даден интервал.
; Реализирайте я чрез accumulate.
(define (for-all? from to p)
  (define (and2 a b)
    (and a b))
  (accumulate from to and p #t))

; 5 .Тя проверява дали някое число в даден интервал изпълнява даден предикат.
; Реализирайте я чрез accumulate.
(define (exists? from to p)
  (define (or2 a b)
    (or a b))
  (accumulate from to or2 p #f))
(define (accumulate from to op term acc)
  (if (> from to)
    acc
    (accumulate (+ from 1)
                 to
                 op
                 term
                 (op acc (term from)))))
