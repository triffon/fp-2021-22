import Data.Bits ((.&.)) -- побитово "и"

-- Зад.0
-- Пример за съставяне на поток с взаимна рекурсия като "оптимизация"
-- Този процес се нарича мемоизация (запомнете за другия семестър по ДАА)
fibs :: [Int]
fibs = map f [0..]
  where f 0 = 0
        f 1 = 1
        f n = (fibs !! (n-1)) + (fibs !! (n-2))

-- Зад.1
-- (an-2k, an-k, x e аритметична прогресия) <=> (x == 2*an-k - an-2k)
-- Инварианта: f n == forestFire !! n - използваме го просто за оптимизация вместо рекурсивно да извикваме f
forestFire :: [Int]
forestFire = map f [0..]
  where f 0 = 1
        f n = findMinNotIn (findXs n)
        findXs n = [ 2*forestFire!!(n-k) - forestFire!!(n-2*k) | k<-[1.. n `div` 2] ]
        findMinNotIn lst = head [ x | x<-[1..], not $ x `elem` lst ]

-- Зад.2
-- Проблем: първите няколко "прозореца" не са пълни
-- един вариант: generate да различава пълен от непълен прозорец
sumLast :: Int -> Int -> [Int]
sumLast k n = k : generate [k]
  where generate :: [Int] -> [Int]
        generate currents = x : generate newWindow
          where x = sum currents
                newWindow = (if (length currents == n) then tail else id) currents ++ [x]
-- втори вариант: съставяме първия прозорец експлицитно
-- и винаги работим с "пълни" прозорци в generate
sumLast' :: Int -> Int -> [Int]
sumLast' k n = first ++ generate first
  where generate currents = x : generate (tail currents ++ [x])
          where x = sum currents
        first = k : [ k*2^i | i<-[0..n-2]] -- Инварианта - дължината на first е n

-- Зад.3
quickSort :: Ord a => [a] -> [a]
quickSort [] = []
quickSort [x] = [x]
quickSort (x:xs) = quickSort [ y | y<-xs, y < x] -- filter (<x) xs
                ++ [x]
                ++ quickSort [ y | y<-xs, not $ y < x] -- filter (not.(<x)) xs

-- Подадената функция връща True, ако левият ѝ аргумент трябва да е преди десният в резултата
quickSort' :: (a -> a -> Bool) -> [a] -> [a]
quickSort' _ [] = []
quickSort' _ [x] = [x]
quickSort' p (x:xs) = quickSort' p [ y | y<-xs, p y x]
                   ++ [x]
                   ++ quickSort' p [ y | y<-xs, not $ p y x]
--quickSort = quickSort' (<)

-- Зад.4
mergeSort' :: (a -> a -> Bool) -> [a] -> [a]
mergeSort' _ [] = []
mergeSort' _ [x] = [x]
mergeSort' p lst = merge (mergeSort' p left) (mergeSort' p right)
  where n = length lst
        left = take (n `div` 2) lst
        right = drop (n `div` 2) lst
        merge [] lst = lst
        merge lst [] = lst
        merge lst1@(x:xs) lst2@(y:ys)
          | p x y     = x : merge xs lst2
          | otherwise = y : merge lst1 ys
mergeSort :: Ord a => [a] -> [a]
mergeSort = mergeSort' (<)

-- Зад.5
zastup :: Int -> Int -> Bool
-- zastup n m = (n .&. m == 0)
zastup 0 _ = True
zastup _ 0 = True
zastup n m = (odd n && odd m) || zastup (n `div` 2) (m `div` 2)

-- Зад.6
uniques' :: (a -> a -> Bool) -> [a] -> [a]
uniques' _ [] = []
uniques' p (x:xs) = x : uniques' p [ y | y<-xs, not $ p x y ]

-- Зад.7
type Order = (String, String, Double)

uniquePairs :: [Order] -> [(String, String)]
uniquePairs orders = [ (name, cat) | (name, cat, _)<-uniques' p orders ]
  where p :: Order -> Order -> Bool
        p (n1, c1, _) (n2, c2, _) = n1 == n2 && c1 == c2

findAvg :: (String,String) -> [Order] -> Double
findAvg (name,cat) orders = average [ p | (n,c,p)<-orders, name == n, cat == c ]
  where average lst = sum lst / (fromIntegral $ length lst)

foo :: [Order] -> [Order]
foo orders = [ (name, cat, findAvg (name,cat) orders) | (name, cat)<-uniquePairs orders ]
