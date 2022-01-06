-- Recap:

a :: Int -- Int, Integer, Float, Double, Bool
a = 5

sum' :: Num a => a -> a -> a
sum' a b = a + b
-- (+) 1 3

-- camelCase

-- Type

-- if x > 4 then x else (x - 1)

abs' x
  | x > 0 = x
  | x < 0 = -x
  | otherwise = 0

-- type classes:
--  Eq ==
--  Ord < <= .. 
--  Integral - Int, Integer
--  Floating - Float, Double
type FN = Int
type Name = String
type Student = (Name, FN)

complAdd :: Num a => (a,a) -> (a,a) -> (a, a)
complAdd (x1, x2) (y1, y2) = (x1+y1, x2+y2)

list :: [Int]
list = [1,2,3]

-- head tail
-- (x:xs) -> x, xs

length' :: Eq a => [a] -> Int
length' l = if l == [] then 0 else 1 + length' (tail l)

length'' :: Eq a => [a] -> Int
length'' [] = 0
length'' (x:xs) = 1 + length'' xs
-- (kotka:kotki)

length''' :: Eq a => [a] -> Int
length''' [] = 0
length''' (_:xs) = 1 + length''' xs

-- S = {a | a < 10}
length'''' :: Eq a => [a] -> Int
length'''' xs = sum [1 | x <- xs]

countEven :: [Int] -> Int
countEven xs = sum [1 | x <- xs, even x]

squares :: Num a => [a] -> [a]
squares xs = map (\x -> x ^ 2) xs

-- append ++
-- cons :
-- null l
-- list-ref !!

-- sum' -> събира елементите на списък
-- elem' -> проверява дали елемента n е част от списъка xs
-- reverse' -> обръща списък


elem' :: Int -> [Int] -> Bool
elem' n (x:xs)
   | null xs = False
   | head xs == n = True
   | otherwise = elem' n (tail xs)

elem'' :: Int -> [Int] -> Bool
elem'' n [] = False
elem'' n (x:xs) = if n == x then True else elem'' n xs

reverse' :: Eq a => [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]

-- map'
-- filter'
-- union (x:xs) (y:ys)
-- intersection
-- differense
-- take' n (x:xs)
-- drop' n (_:xs)
-- takeUntil (x:xs) p
-- takeWhile (x:xs) p
-- zip (x:xs) (y:ys)
-- zipWith (x:xs) (y:ys) f -> f е двуаргументна функция, която връща нещо

map' :: (Num a, Num b) => (a -> b) -> [a] -> [b]
map' f xs = [f x | x <- xs]

map'' f [] = []
map'' f (x:xs) = f x : map'' f xs

intersection' :: Eq a => [a] -> [a] -> [a]
-- intersection' _ [] = []
intersection' [] _ = []
intersection' (x:xs) ys = [x | x <- xs, x `elem` ys]