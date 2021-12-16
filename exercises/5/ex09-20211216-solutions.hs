-- Добра практика - импортираме само това, което ни трябва
import Data.List (elemIndex)

-- Пример за pattern matching <-> само guard-ове
isSorted [] = True
isSorted [x] = True
isSorted (x:y:xs) = (x <= y) && isSorted (y:xs)

isSorted' lst
  | null lst                   = True
  | null (tail lst)            = True
  | head lst > head (tail lst) = False
  | otherwise                  = isSorted' (tail lst)

-- Зад.2
sumDivisors :: Int -> Int
sumDivisors n   = sum    [ d | d<-[1..n], n `mod` d == 0]
countDivisors :: Int -> Int
countDivisors n = length [ d | d<-[1..n], n `mod` d == 0]

prime :: Int -> Bool
prime 1 = False
prime n = null [ d | d<-[2..sqn], n `mod` d == 0 ]
  where sqn = floor . sqrt . fromIntegral $ n
-- Алтернативно: floor $ sqrt $ fromIntegral n
--           или floor (sqrt (fromIntegral n))
descartes :: [a] -> [b] -> [(a,b)]
descartes lst1 lst2 = [ (x,y) | x<-lst1, y<-lst2 ]

-- Зад.3
primes :: [Int]
primes = filter prime [1..]

-- Зад.4
primes' :: [Int]
primes' = sieve [2..]
  where sieve :: [Int] -> [Int]
        sieve (x:xs) = x : sieve [ y | y<-xs, y `mod` x /= 0 ]

-- Зад.5
-- Проблем: това никога няма да "извърти" всички y за x=1
-- и да стигне до наредени двойки с друга първа компонента
-- pairs = [ (x,y) | x<-[1..], y<-[1..] ]
-- 1,1 1,2 1,3 1,4 ...
-- 2,1 2,2 ...
-- Решение: обхождаме безкрайната матрица по диагонали:
-- 1,1
-- 2,1 1,2
-- 3,1 2,2 1,3
-- 4,1 3,2 2,3 1,4
-- ...
pairs :: [(Int,Int)]
pairs = [ (diag+1-i, i)| diag<-[1..], i<-[1..diag] ]

-- Зад.6 - за следващия път
compress :: Eq a => [a] -> [(a, Int)]
compress = undefined

-- Зад.7
maxRepeated :: Eq a => [a] -> Int
maxRepeated lst = maximum $ map snd $ compress lst
