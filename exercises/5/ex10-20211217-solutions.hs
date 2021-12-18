import Data.List (maximumBy, sortBy, group, sort, sortOn)
import Data.Ord (comparing)

-- Зад.6
compress :: Eq a => [a] -> [(a,Int)]
compress [] = []
compress lst = (head lst, numHeads) : (compress rest)
  where (heads, rest) = span (== head lst) lst -- (\x -> x == head lst)
        numHeads = length heads

-- Зад.7
maxRepeated :: Eq a => [a] -> Int
maxRepeated lst = maximum $ map snd $ compress lst

-- Най-често срещани typeclass-ове:
-- Eq, Ord, Num, Integral, Floating, Show, Read
-- Зад.8
makeSet :: Eq a => [a] -> [a]
makeSet [] = []
makeSet (x:xs) = x : makeSet (filter (/= x) xs)
-- Аналогична сигнатура на C++20, със ограниченията:
-- template <typename T>
--   requires std::equality_comparable<T>
-- std::vector<T> makeSet(std::vector<T>) { ... }

-- и тук можем да ползваме помощни итеративни функции
makeSet' :: Eq a => [a] -> [a]
makeSet' lst = helper [] lst
  where helper res [] = res
        helper res (x:xs)
          | x `elem` res = helper res xs
          | otherwise    = helper (x:res) xs

makeSet'' :: Eq a => [a] -> [a]
makeSet'' lst =
    foldl (\res x -> if x `elem` res then res else x:res) [] lst

-- Зад.9
-- Можем да използваме и group + sort за това, но би наложило
-- по-силно ограничение от (Eq a, Ord a)
histogram :: Eq a => [a] -> [(a,Int)]
histogram lst = [ (x, count x) | x<-makeSet lst ]
  where count x = length $ filter (==x) lst

-- Зад.10
-- Тук ограниченията са наложени съотв. от sqrt и maximum
maxDistance :: (Floating a, Ord a) => [(a,a)] -> a
maxDistance pts = maximum [ dist p1 p2 | p1<-pts, p2<-pts ]
  where dist (x1,y1) (x2,y2) = sqrt $ (x1-x2)^2 + (y1-y2)^2

-- Помощната за minimumBy/maximumBy/sortBy функция comparing е дефинирана така:
-- comparing f = \x y -> compare (f x) (f y)
-- Забележете, че извиква f за двата си аргумента всеки път (!)

-- Зад.11
-- sortOn е по-ефективна ot sortBy откъм време, но не и откъм памет
-- (кешира стойностите, върнати от f за всеки ел-т на списъка)
-- Тя е по-подходяща при "скъпа" f, а sortBy при "евтина" f (напр. snd)
specialSort :: (Eq a, Ord a) => [[a]] -> [[a]]
--specialSort lst = sortBy (comparing mostFrequent) lst
specialSort lst = sortOn mostFrequent lst
  where mostFrequent lst = fst $ maximumBy (comparing snd) (histogram lst)
