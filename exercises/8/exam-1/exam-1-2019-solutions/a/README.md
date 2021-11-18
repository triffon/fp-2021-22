Задача 1. а) (3 т.) Да се реализира функция product-digits, която намира произведението от цифрите на дадено естествено число.
б) (7 т.) Нека с {n} означим разликата на n и произведението на цифрите на n. Да се реализира функция largest-diff, която намира най-голямата разлика {m} – {n} за m, n ∈ [a; b], където a и b са параметри на функцията.
Пример: (largest-diff 28 35) → 19  = {30} – {29} = (30 – 0) – (29 – 18))

Задача 2. (10 т.) “Метрика” наричаме функция, която приема като параметър списък от числа и връща число като резултат. Да се напише функция max-metric, която приема като параметри списък от метрики ml и списък от списъци от числа ll и връща метрика m от ml, за която сумата от стойностите, които m връща над елементите на ll, е максимална в сравнение с останалите метрики от ml.
Примери:
(define (prod l) (apply * l))        (define (sum l) (apply + l)) 
(max-metric (list sum prod) '((0 1 2) (3 4 5) (1337 0))) → <sum>
(max-metric (list car sum)  '((1000 -1000) (29 1) (42))) → <car>

Задача 3. (10 т.) “Ниво на влагане” на атом в дълбок списък наричаме броя пъти, който трябва да се приложи операцията car за достигане до атома. Да се реализира функция deep-repeat, която в подаден дълбок списък заменя всеки атом на ниво на влагане n с n негови повторения.
Пример:
(deep-repeat '(1 (2 3) 4 (5 (6)))) → (1 (2 2 3 3) 4 (5 5 (6 6 6)))
