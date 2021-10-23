# Упражнение 3

## Функции от по-висок ред
  - приемат функции като аргументи и/или
  - връщат функции


1. sum-interval
   - инкрементиране
   - събирането
   - минималната стойност
   - прилагане на нещо върху а


   ```
   (define (sum-interval a b)
    (if (> a b)
        0
        (sum-interval (+ a 1) b)
    )
  )


  (define (sum a b) (+ a b))
  (define sum-min 0)


  (define prod-min 1)
  (define (prod a b) (* a b))

  (define (accumulate-interval a b min op)
    (if (> a b)
      min
      (op a (accumulate-interval (plus-one a) b min op))))


  (define (plus-one a) (+ 1 a))
  (define (plus-one-lambda) (lambda (a) (+ 1 a)))
  ```


2. lambda
  - анонимни функции
  - викат се на момента
    ```
    (lambda (x) + x 1)
    ((lambda (x) (+ x 1)) 2)
    (define (sum) (lambda (a b) (+ a b)))
    ```


3. compose -> много важно да връщате ламбди, когато условието е да се върне процедура
  ```
  (define (compose f g)
    (lambda (x) (f (g x))))
  ```
  - как ще го викнем това?
  ```
     ((compose (lambda (x) (+ 1 x)) (lambda (x) (/ 2 x))) 3)
  ```
  - колко ще върне това?


4. let, let*, letrec
  - свързваме име и стойност локално за израза
  - let* ни дава достъп до горните свързвания
  - letrec ни дава опция да ги викаме рекурсивно
  ! ВАЖНО: let стойностите са достъпни само в блока им

  ```
  (define (sum-let a b)
    (let*
      ((first a)
      (second (b)))
      (+ first second)
    )
  )
  ```

  Пример за намиране на сбора от корените на квадратно уравнение:
  ```
  (define (sum-roots a b c)
    (let* ((d (- (sqr b) (* 4 a c)))
          (x1 (/ (- (- b) (sqrt d)) (* 2 a)))
          (x2 (/ (+ (- b) (sqrt d)) (* 2 a))))
      (+ x1 x2)
    )
  )
  ```

  ```
  (define (testletrec x)
    (letrec
      ((my-even? (lambda (x)
                  (if (= x 1)
                      #f
                      (my-odd? (- x 1)))))
      (my-odd? (lambda (x)
                  (not (my-even? x)))))
      (my-odd? x)))
  ```