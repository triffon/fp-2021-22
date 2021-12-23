import Prelude hiding (map, filter, foldr)

map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f (x:xs) = (f x) : map f xs

filter :: (a -> Bool) -> [a] -> [a]
filter _ [] = []
filter p (x:xs)
  |p x = x : filter p xs
  |otherwise = filter p xs

--[1,1,1,3,3,2,2,2,4,1,1,2,2,2]
--[(1,3), (3,2), (2,3), (4,1), (1,2), (2,3)]

decompress :: [(Int, Int)] -> [Int]
decompress [] = []
decompress (x:xs) = unfold x ++ decompress xs
  where unfold (n,oc) = map (\_ -> n) [1..oc]


mostConsecutiveOccurrences :: [(Int, Int)] -> Int
mostConsecutiveOccurrences [] = undefined
mostConsecutiveOccurrences all@(x:xs) = fst $ foldr compare x all
  where compare a@(_,oc1) b@(_,oc2) = if oc1 > oc2 then a else b 


foldr :: (a -> b -> b) -> b -> [a] -> b
foldr _ nv [] = nv
foldr f nv (x:xs) = f x (foldr f nv xs)

mean :: Fractional a => [(Int, Int)] -> a
mean [] = 0
mean xs = (/) (fromIntegral $ sumAllElements xs) (fromIntegral $ sumAllOccurrences xs)  

sumAllElements :: [(Int,Int)] -> Int
sumAllElements = sum . map (\(x,y) -> x * y)

sumAllOccurrences :: [(Int,Int)] -> Int
sumAllOccurrences = sum . map snd

--toSet :: [(Int, Int)] -> [Int]
--
--sortByOccurrences :: [(Int, Int)] -> [(Int, Int)]


