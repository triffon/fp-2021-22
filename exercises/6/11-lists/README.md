# Още списъци (упр 11)

> За да имплементирате някои функции от Prelude, избягвайки грешките за двусмислици, може да скриете вградените дефиниции по следния начин:
```hs
import Prelude hiding (sum, length, maximum, elem, reverse, take, drop, concat, zipWith)
```
> Може и просто да добавяте `'` към имената на вашите функции, например `take'`.


## Функции над списъци от модула [Prelude](https://hackage.haskell.org/package/base-4.16.0.0/docs/Prelude.html#g:13)

<details>
  <summary>Покажи</summary>

```hs
(++) :: [a] -> [a] -> [a] -- infixr 5
map :: (a -> b) -> [a] -> [b]
filter :: (a -> Bool) -> [a] -> [a]

head :: [a] -> a
tail :: [a] -> [a]

init :: [a] -> [a]
last :: [a] -> a

(!!) :: [a] -> Int -> a -- infixl 9
null :: [a] -> Bool

length :: [a] -> Int
elem :: Eq a => a -> [a] -> Bool
notElem :: Eq a => a -> [a] -> Bool
reverse :: [a] -> [a]
sum :: Num a => [a] -> a
product :: Num a => [a] -> a
maximum :: Ord a => [a] -> a
minimum :: Ord a => [a] -> a

and :: [Bool] -> Bool
or :: [Bool] -> Bool
any :: (a -> Bool) -> [a] -> Bool
all :: (a -> Bool) -> [a] -> Bool
concat :: [[a]] -> [a]
concatMap :: (a -> [b]) -> [a] -> [b]

iterate :: (a -> a) -> a -> [a]
repeat :: a -> [a]
replicate :: Int -> a -> [a]
cycle :: [a] -> [a]

take :: Int -> [a] -> [a]
drop :: Int -> [a] -> [a]
takeWhile :: (a -> Bool) -> [a] -> [a]
dropWhile :: (a -> Bool) -> [a] -> [a]

span :: (a -> Bool) -> [a] -> ([a], [a])
break :: (a -> Bool) -> [a] -> ([a], [a])
splitAt :: Int -> [a] -> ([a], [a])

lookup :: Eq a => a -> [(a, b)] -> Maybe b

zip :: [a] -> [b] -> [(a, b)]
zip3 :: [a] -> [b] -> [c] -> [(a, b, c)]
zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith3 :: (a -> b -> c -> d) -> [a] -> [b] -> [c] -> [d]
unzip :: [(a, b)] -> ([a], [b])
unzip3 :: [(a, b, c)] -> ([a], [b], [c])

lines :: String -> [String]
words :: String -> [String]
unlines :: [String] -> String
unwords :: [String] -> String
```

#### От по-висок ред:
```hs
foldr :: (a -> b -> b) -> b -> [a] -> b
foldl :: (b -> a -> b) -> b -> [a] -> b
foldl' :: (b -> a -> b) -> b -> [a] -> b
foldr1 :: (a -> a -> a) -> [a] -> a
foldl1 :: (a -> a -> a) -> [a] -> a

scanr :: (a -> b -> b) -> b -> [a] -> [b]
scanl :: (b -> a -> b) -> b -> [a] -> [b]
scanr1 :: (a -> a -> a) -> [a] -> [a]
scanl1 :: (a -> a -> a) -> [a] -> [a]
```
</details>

#### Още полезни функции могат да се намерят и в модула [Data.List](https://hackage.haskell.org/package/base-4.16.0.0/docs/Data-List.html#v:intersperse)
<details>
  <summary>Покажи</summary>

  ```haskell
  intersperse :: a -> [a] -> [a]
  intercalate :: [a] -> [[a]] -> [a]
  transpose :: [[a]] -> [[a]]
  subsequences :: [a] -> [[a]]
  permutations :: [a] -> [[a]]

  stripPrefix :: Eq a => [a] -> [a] -> Maybe [a]
  group :: Eq a => [a] -> [[a]]
  inits :: [a] -> [[a]]
  tails :: [a] -> [[a]]

  isPrefixOf :: Eq a => [a] -> [a] -> Bool
  isSuffixOf :: Eq a => [a] -> [a] -> Bool
  isInfixOf :: Eq a => [a] -> [a] -> Bool
  isSubsequenceOf :: Eq a => [a] -> [a] -> Bool

  partition :: (a -> Bool) -> [a] -> ([a], [a])
  elemIndex :: Eq a => a -> [a] -> Maybe Int
  elemIndices :: Eq a => a -> [a] -> [Int]
  findIndex :: (a -> Bool) -> [a] -> Maybe Int
  findIndices :: (a -> Bool) -> [a] -> [Int]

  nub :: Eq a => [a] -> [a]
  delete :: Eq a => a -> [a] -> [a]
  (\\) :: Eq a => [a] -> [a] -> [a] infix 5
  union :: Eq a => [a] -> [a] -> [a]
  intersect :: Eq a => [a] -> [a] -> [a]

  sortOn :: Ord b => (a -> b) -> [a] -> [a]

  nubBy :: (a -> a -> Bool) -> [a] -> [a]
  deleteBy :: (a -> a -> Bool) -> a -> [a] -> [a]
  deleteFirstsBy :: (a -> a -> Bool) -> [a] -> [a] -> [a]
  unionBy :: (a -> a -> Bool) -> [a] -> [a] -> [a]
  intersectBy :: (a -> a -> Bool) -> [a] -> [a] -> [a]
  groupBy :: (a -> a -> Bool) -> [a] -> [[a]]
  sortBy :: (a -> a -> Ordering) -> [a] -> [a]

  maximumBy :: (a -> a -> Ordering) -> [a] -> a
  minimumBy :: (a -> a -> Ordering) -> [a] -> a
  ```
</details>

## Задачи:

Напишете типови декларации и дефиниции на следните функции:
1. `sum' xs` - сумира всички елементи на списък от числа
3. `length' xs` - намира дължина на списък
1. `isSorted xs` - проверява дали списък от числа е сортиран
1. `insertionSort xs` - сортира списък по алгоритъма insertion sort
4. `maximum' xs` - намира най-големия елемент в списък
5. `elem' x ys` - намира дали елемент се съдържа в списък
   ```hs
   elem' :: a -> [a] -> Bool
   ```
6. `reverse' xs` – обръща реда на елементите на списък
7. `isPrefix xs ys` – приема два списъка и връща дали първия е префикс на втория
   ```hs
   isPrefix [1,2,3] [1,2,3,4,5] -> True
   ```
8. `take' n xs` - взима първите `n` елемента от даден списък
9. `drop' n xs` - премахва първите `n` елемента от даден списък
1. `chunk n xs` - разделя списъка `xs` на списъци с дължина `n`:
   ```haskell
   >>> chunk 3 [1..10]
   [[1,2,3], [4,5,6], [7,8,9], [10]]
   ```
8. `takeWhile' p xs` - взима елементи `x` от `xs` докато е вярно че `p x`
   ```haskell
   takeWhile' :: (a -> Bool) -> [a] -> [a]
   ```
9. `dropWhile' p xs` - премахва елементи `x` от `xs` докато е вярно че `p x`
10. `zip'` - по дадени два списъка връща списък от наредени двойки с елементите им
    ```hs
    zip' [1,2,3] [4,5,6,7] -> [(1,4),(2,5),(3,6)]
    ```
11. `concat'` - от списък от списъци намяла с 1 нивото на влагане, слепяйки всички елементи на входния списък
    ```hs
    concat' [[1,2,3],[4],[5,6]] -> [1,2,3,4,5,6]
    ```
12. `zipWith'` - по два списъка образува нов, извиквайки функция над всяка съответна двойка елементи
    ```hs
    zipWith' (,) [1,2,3] [4,5,6,7] -> [(1,4),(2,5),(3,6)]
    zipWith' (+) [1,2,3] [4,5,6,7] -> [5,7,9]
    ```
1. `unzip xs` - по списък от наредени двойки връща наредена двойка от списъци


1. Покупка се означава с наредена тройка от име на магазин (низ), категория (низ) и цена (дробно число).

   Да се реализира функция, която по даден списък от покупки връща списък от тройки, съдържащи категория, обща цена на покупките в тази категория и името на магазина, в който общата цена на покупките в тази категория е максимална. Всяка категория да се среща в точно една тройка от резултата.

   Да се реализира функция, която по даден списък от покупки връща списък от тройки, съдържащи име на магазин, обща цена на покупките в този магазин и името на категорията, в която е направена покупка за цена максимално близка до средното аритметично на цените на покупките в този магазин. Всеки магазин да се среща в точно една тройка от резултата.

   Да се реализира функция, която по даден списък от покупки връща списък от тройки, съдържащи име на магазин, име на категория и средна цена на покупките в този магазин и тази категория. Всяка двойка от магазин и категория, за които има поне една покупка, да се среща в точно една тройка от резултата.

