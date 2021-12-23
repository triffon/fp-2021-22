import Prelude hiding (length, foldr, take, drop)

-- 1. `sum' xs` - сумира всички елементи на списък от числа
--sum :: Num a => [a] -> a
--sum :: [a] -> a
--sum :: [Double] -> Double
sum' :: [Integer] -> Integer
sum' [] = 0
sum' (x:xs) = x + sum xs


-- [] е списък
-- (x : xs) е списък, където xs е списък

--complAdd (1,2) (-3,5) -> (-2,7)
--complSub (4,8) (2,-1) -> (2,9)
--complMul (3,5) (2,1) -> (1,13)
complAdd :: (Int, Int) -> (Int, Int) -> (Int, Int)
complAdd (x, y) (u,v) = (x + u, y + v)

complSub :: (Int, Int) -> (Int, Int) -> (Int, Int)
complSub pair1 pair2 = (fst pair1 - fst pair2, snd pair1 - snd pair2)

complMult :: (Int, Int, Int) -> (Int, Int, Int) -> (Int, Int, Int)
complMult (x,y,z) (u,v,w) = (x * u, y * v, z * w)


--length' xs - намира дължина на списък
length :: [a] -> Int
length [] = 0
length (_:xs) = 1 + length xs



--isSorted xs - проверява дали списък от числа е сортиран
--isSorted :: Ord a => [a] -> Bool
isSorted :: [Int] -> Bool
isSorted [] = True
isSorted (x:[]) = True
isSorted (x:(y:ys)) = x <= y && isSorted (y:ys)
 --(cond ((null? l) #t)
 --      (null? (cdr l) #t)
 --      (else (and (<= x y) (isSorted (cdr l))))

get2 (x:(y:ys)) = (x,y, ys)

myGroupBy :: Eq b => (a -> b) -> [a] -> [(b, [a])]
myGroupBy f xs = foldr insert [] xs
  where
    insert x [] = [(f x, [x])]
    insert x ((fy,ys):yss) =
      if f x == fy
      then (fy, x:ys):yss
      else (fy,ys) : insert x yss

-- (foldr op nv l)
foldr op nv [] = nv
foldr op nv (x:xs) = op x (foldr op nv xs)

-- insertionSort xs - сортира списък по алгоритъма insertion sort
insertionSort :: [Int] -> [Int]
--insertionSort xs =
--  foldr insert [] xs
insertionSort [] = []
insertionSort (x:xs) = insert x (insertionSort xs)

insert :: Int -> [Int] -> [Int]
insert x [] = x:[] -- същото като [x]
insert x (y:ys) =
  if x <= y
  then x : (y:ys)
  else y : insert x ys

--take' n xs - взима първите n елемента от даден списък
take :: Int -> [a] -> [a]
take 0 xs = []
take n [] = []
take n (x:xs) = x : take (n-1) xs

drop :: Int -> [a] -> [a]
drop 0 xs = xs
drop n [] = []
drop n (x:xs) = drop (n-1) xs


unique :: Eq a => [a] -> [a]
unique [] = []
unique (x:xs) = x : (unique (filter (\y -> y /= x) xs))

maximumBy :: Ord b => (a -> b) -> [a] -> a
maximumBy f (x:[]) = x
maximumBy f (x:(y:ys)) =
  if f x >= f y
  then maximumBy f (x:ys)
  else maximumBy f (y:ys)

-- Покупка се означава с наредена тройка от име на магазин (низ), категория (низ) и цена (дробно число).
type StoreName = String
type Category = String
type Price = Double
type Purchase = (StoreName, Category, Price)
-- Да се реализира функция, която по даден списък от покупки връща списък от тройки, съдържащи категория,
-- обща цена на покупките в тази категория и името на магазина, в който общата цена на покупките в тази
-- категория е максимална. Всяка категория да се среща в точно една тройка от резултата.
summary :: [Purchase] -> [(Category, Price, StoreName)]
summary purchases =
  map (\category -> (category, sumPriceInCategory category, maxStoreInCategory category)) categories
  where
    getCategory :: Purchase -> Category
    getCategory (s, category, p) = category
    getPrice :: Purchase -> Price
    getPrice (s, c, price) = price
    getStoreName :: Purchase -> StoreName
    getStoreName (s, c, p) = s

    categories = unique (map getCategory purchases)

    sumPriceInCategory :: Category -> Price
    sumPriceInCategory category =
      sum
        (map getPrice
          (filter (\(s, c, p) -> c == category)
            purchases))
    maxStoreInCategory :: Category -> StoreName
    maxStoreInCategory category =
      maximumBy
        (\store ->
          sum (map getPrice (filter (\(s,c,p) -> s == store) pitc)))
        stores
      where
        pitc = (filter (\(s, c, p) -> c == category) purchases)
        stores = map getStoreName pitc



