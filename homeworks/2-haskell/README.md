# Второ домашно по ФП

> В решението е позволено да се ползва само модулът `Prelude`. Всякакви други модули са забранени.

## Типове

В състава на ДНК участват 4 вида молекули - цитозин, гуанин, аденин и тимин.
Ще ги наричаме бази и ще ги бележим съответно C, G, A и T.
```hs
data Base = C | G | A | T
    deriving (Eq, Show)
```

Последователността от базите в ДНК наричаме генетичен код. Представяме го като списък от бази:
```hs
data GeneticCode = GeneticCode [Base]
    deriving (Eq, Show)
```

Кодон наричаме последователност от три бази:
```hs
data Codon = Codon Base Base Base
    deriving (Eq, Show)
```

Всеки кодон кодира една от 20 аминокиселини. Аминокиселините номерираме от 1 до 20:
```hs
data Aminoacid = Aminoacid Int
    deriving (Eq, Ord, Show)
```

Съответствието между кодон и аминокиселина е зададено с асоциативен списък:
```hs
type CodingTable = [(Codon, Aminoacid)]
```
Възможно е няколко кодона да съответстват на една и съща аминокиселина.
Също е възможно кодони да не задават нито една аминокиселина (т.е. да не присъстват в асоциативния списък),
наричаме ги стоп-кодони.

Ген наричаме последователност от кодиращи кодони в генетичен код, ограничена от два стоп-кодона
(и/или краищата на генетичния код). Представяме го чрез списък:
```hs
type Gene = [Codon]
```
Белтък наричаме списък от аминокиселини. Ген кодира белтък, като всеки кодон се замести със съответната му аминокиселина.
```hs
type Protein = [Aminoacid]
```

## Функции

(7т)
Да се реализира функция `hasSameProteins`, която проверява дали в даден генетичен код има два различни гена, които кодират един и същи белтък.
```hs
hasSameProteins :: CodingTable -> GeneticCode -> Bool
```

> Забележка: Няма нужда да валидирате входа на функциите -
  винаги ще им се подава правилен вход, в частност аминокиселини с номера между 1 и 20
  и генетичен код с дължина кратна на 3.


Мутация наричаме промяна на единствена база в генетичения код.

(8т)
Да се реализира функция `maxMutations`, която намира максималния брой мутации N
на даден генетичен код, които са възможни без да се променят белтъците,
кодирани от него (т.е. N+1 мутации със сигурност водят до промяна в кодираните белтъци).
```hs
maxMutations :: CodingTable -> GeneticCode -> Int
```

## Предаване
В мудъл качвате един файл - `GroupX_fnY.hs`, като го преименувате с X = вашата група и Y = вашия факултетен номер.

Преименуването ще попречи на пускането на примерите чрез `Example.hs` затова преименувайте само накрая преди предаване.

## Примери
Виж [Example.hs].

> Забележка: Примерите не тестват всичко, домашното ви ще бъде пробвано срещу повече случаи.

### Пускане на примерите
Препоръчително е свалите файловете в тази директория, да си пишете кода в [GroupX_fnY.hs], и да го тествате чрез [Example.hs]:
```sh
$ runhaskell Examples.hs
testing hasSameProteins
🗸 pass: hasSameProteins standardCoding shortCodeDup
🗸 pass: hasSameProteins standardCoding mediumCodeDup
🗸 pass: hasSameProteins standardCoding longCodeDup
🗸 pass: hasSameProteins standardCoding shortCode
🗸 pass: hasSameProteins standardCoding mediumCode
🗸 pass: hasSameProteins standardCoding longCode
testing maxMutations
🗸 pass: maxMutations standardCoding shortCodeDup
🗸 pass: maxMutations standardCoding mediumCodeDup
🗸 pass: maxMutations standardCoding longCodeDup
🗸 pass: maxMutations standardCoding shortCode
🗸 pass: maxMutations standardCoding mediumCode
🗸 pass: maxMutations standardCoding longCode
```
Стартирането на `Examples.hs` може да стане чрез `runghc Examples.hs`, или `runhaskell Examples.hs`, или в `ghci Examples.hs` да се стартира `main`.

[Example.hs]: ./Examples.hs
[GroupX_fnY.hs]: ./GroupX_fnY.hs
