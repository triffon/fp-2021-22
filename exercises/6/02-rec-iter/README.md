# Рекурсия и итерация (упр 2)

#### [Сваляне на задачите][download]
#### [Решения][solutions]

> Често е по-лесно да решите задача рекурсивно първия път.

### [Зад 1 `count-digits`][count-digits]
Брой цифри на цяло число (вкл. и отрицателно).

### [Зад 2 `sum-digits`][sum-digits]
Сума от цифрите на цяло число.

### [Зад 3 `bin-to-dec`][bin-to-dec]
Преобразуване от двоична в десетична бройна система.

> Забележка: тук под бройна система разбираме просто използваните цифри в представянето на числото. Тоест няма създаваме двоични числа, започващи с [#b]. Фактически работим само с десетични числа в Scheme.

### [Зад 4 `dec-to-bin`][dec-to-bin]
Преобразува число от десетична в двоична бройна система.

### [Зад 5 `reverse-digits`][reverse-digits]
Обръща реда на цифрите на число.

### [Зад 6 `palindrome?`][palindrome?]
Дали числото е палиндром?

### [Зад 7 `sum-divisors`][sum-divisors]
Сбор от делителите на число.

### Зад 8 итерация
Интеративен вариант в същия файл на
[`count-digits`][count-digits],
[`sum-digits`][sum-digits],
[`bin-to-dec`][bin-to-dec],
[`dec-to-bin`][dec-to-bin] и
[`reverse-digits`][reverse-digits].

### [Зад 9 `prime?`][prime?]
Дали числото е просто?

> Дадено цяло число n е просто, ако не се дели на никое от числата между 2 и n-1 (даже [от 2 до √n][primality-test]).

### [Зад 10 `fasterpow`][fasterpow]
Итеративен вариант на `fastpow` от [миналото упражнение][prev-exercise].

### [Зад 11 `automorphic?`][automorphic?] **за домашно (2т.)**
Дали е автоморфно числото? Едно число е _автоморфно_, ако квадратът му завършва на него.

```scheme
(automorphic? 6) -> #t
(automorphic? 5) -> #t

(automorphic? 4) -> #f
(automorphic? 11) -> #f
```

[download]: https://download-directory.github.io/?url=https%3A%2F%2Fgithub.com%2Ftriffon%2Ffp-2021-22%2Ftree%2Fmaster%2Fexercises%2F6%2F02-rec-iter
[solutions]: ./solutions
[#b]: http://people.csail.mit.edu/jaffer/r5rs/Syntax-of-numerical-constants.html
[primality-test]: https://en.wikipedia.org/wiki/Primality_test
[prev-exercise]: ../01-basics/problems.01.rkt

[count-digits]: ./01.count-digits.rkt
[sum-digits]: ./02.sum-digits.rkt
[bin-to-dec]: ./03.bin-to-dec.rkt
[dec-to-bin]: ./04.dec-to-bin.rkt
[reverse-digits]: ./05.reverse-digits.rkt
[palindrome?]: ./06.palindrome.rkt
[sum-divisors]: ./07.sum-divisors.rkt
[prime?]: ./09.prime.rkt
[fasterpow]: ./10.fasterpow.rkt
[automorphic?]: ./11.automorphic.rkt
