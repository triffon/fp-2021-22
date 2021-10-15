# Рекурсия и итерация (упр 2)

> Често е по-лесно да решите задача рекурсивно първия път.

### [зад 1 `count-digits`][count-digits]
Брой цифри на цяло число (вкл. и отрицателно).

### [зад 2 `sum-digits`][sum-digits]
Сума от цифрите на цяло число.

### [зад 3 `bin-to-dec`][bin-to-dec]
Преобразуване от двоична в десетична бройна система.

> Забележка: тук под бройна система разбираме просто използваните цифри в представянето на числото. Тоест няма създаваме двоични числа, започващи с [#b](http://people.csail.mit.edu/jaffer/r5rs/Syntax-of-numerical-constants.html). Фактически работим само с десетични числа в Scheme.
Примери:
```scheme
(bin-to-dec 100) -> 4
(bin-to-dec 1111) -> 15
```

### [зад 4 `dec-to-bin`][dec-to-bin]
Преобразува число от десетична в двоична бройна система.
```scheme
(dec-to-bin 4) -> 100
(dec-to-bin 31) -> 11111
```

### [зад 5 `reverse-digits`][reverse-digits]
Обръща реда на цифрите на число.
```scheme
(reverse-num 12305) -> 50321
(reverse-num 10000) -> 1
(reverse-num -1093) -> -3901
```

### [зад 6 `palindrome?`][palindrome?]
Дали числото е палиндром?
```scheme
(palindrome? 1234) -> #f
(palindrome? 9102019) -> #t
(palindrome? 10000001) -> #t
```

### [зад 7 `sum-divisors`][sum-divisors]
Сбор от делителите на число.

### зад 8 итерация
Интеративен вариант в същия файл на
[`count-digits`][count-digits],
[`sum-digits`][sum-digits],
[`bin-to-dec`][bin-to-dec],
[`dec-to-bin`][dec-to-bin] и
[`reverse-digits`][reverse-digits].

### [зад 9 `prime?`][prime?]
Дали числото е просто?

> Дадено цяло число n е просто, ако не се дели на никое от числата между 2 и n-1 (даже [от 2 до √n][primality-test]).

### [зад 10 `fasterpow`][fasterpow]
Итеративен вариант на `fastpow` от [миналото упражнение][prev-exercise].

### [зад 11 `automorphic?`][automorphic?] **за 2т. бонус**
Дали е автоморфно числото? Едно число е _автоморфно_, ако квадратът му завършва на него.

```scheme
(automorphic? 6) -> #t
(automorphic? 5) -> #t

(automorphic? 4) -> #f
(automorphic? 11) -> #f
```

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
