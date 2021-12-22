module Lists where

import Prelude hiding (head, tail, null, length,
                       enumFromTo, enumFromThenTo,
                       (++), reverse, (!!), elem,
                       init, last, take, drop,
                       map, filter, foldr, foldl,
                       foldr1, foldl1, scanr, scanl)

head :: [a] -> a
head (h:_) = h

tail :: [a] -> [a]
tail (_:t) = t

null :: [a] -> Bool
null [] = True
null _  = False

{-
length []    = 0
length (_:t) = 1 + length t
-}

length :: [a] -> Int
{-
length l = case l of []    -> 0
                     (_:t) -> 1 + length t
-}
-- foldr :: (t -> u -> u) -> u -> [t] -> u
-- t = a
-- u = Int

-- const :: a -> b -> a
-- const x _ = x
-- const x = \_ -> x
-- \_ -> (1+)

length = foldr (const (1+)) 0

-- 1 + 2:(case x of [] -> 0 ... )

enumFromTo :: (Enum t, Ord t) => t -> t -> [t]
enumFromTo a b
 | a > b     = []
 | otherwise = a : enumFromTo (succ a) b

enumFromThenTo :: (Num t, Ord t) => t -> t -> t -> [t]
enumFromThenTo a a' b
 | a > b     = []
 | otherwise = a : enumFromThenTo (a + dx) (a + 2 * dx) b
   where dx = a' - a

-- !!! enumFromThenTo 'a' 'e' 'z' не работи !!!
-- домашно: enumFromThenTo :: Enum t => t -> t -> t -> [t]

-- (++) [] l = l
(++) :: [a] -> [a] -> [a]
{-
[]     ++ ys = ys
(x:xs) ++ ys = x:(xs ++ ys)
-}
(++) xs ys = foldr (:) ys xs

reverse :: [a] -> [a]

{-
reverse []    = []
reverse (x:xs) = reverse xs ++ [x]
-}
-- reverse = foldr (\x -> (++[x])) []
-- rcons xs x = x : xs
-- flip f x y = f y x
-- rcons = flip (:)
reverse = foldl (flip (:)) []

(!!) :: [a] -> Int -> a
[]    !! _ = error "Невалиден индекс!"
(h:_) !! 0 = h
(_:t) !! n = t !! (n-1)

elem :: Eq a => a -> [a] -> Bool
-- foldr :: (t -> u -> u) -> u -> [t] -> u
-- t == a
-- u == Bool

{-
elem _ []    = False
elem y (x:xs) = y == x || elem y xs
-}

elem y = foldr (\x -> (||) (y == x)) False

-- elem x l = not (null l) && (x == head l || elem x (tail l))
x ∈ l = elem x l

елемент_на x l = elem x l

pythagoreanTriples :: Int -> Int -> [(Int,Int,Int)]
pythagoreanTriples a b = [ (x, y, z) | z <- [a..b],
                                       x <- [a..z],
                                       y <- [x+1..z],
                                       z^2 == x^2 + y^2,
                                       gcd x y == 1]

init :: [a] -> [a]
init [_]   = []
init (h:t) = h:init t
-- foldr1 :: (a -> a -> a) -> [a] -> a
-- init   ::                  [a] -> [a]


last :: [a] -> a
{-
last [a]   = a
last (_:t) = last t
-}
-- foldr1 :: (a -> a -> a) -> [a] -> a
-- last ::                    [a] -> a
last = foldr1 (const id)
-- last = foldl1 (\r x -> x)

take :: Int -> [a] -> [a]
take 0 _     = []
take _ []    = error "Невалиден брой елементи!"
take n (h:t) = h:take (n-1) t

drop :: Int -> [a] -> [a]
drop 0 l     = l
drop _ []    = error "Невалиден брой елементи!"
drop n (_:t) = drop (n-1) t

f2 = const 2

map :: (a -> b) -> [a] -> [b]
{-
map _ []     = []
map f (x:xs) = f x : map f xs
-}
-- map f l = [ f x | x <- l ]

filter :: (a -> Bool) -> [a] -> [a]
-- filter p l = [ x | x <- l, p x ]
{-
filter _ [] = []
filter p (x:xs)
 | p x       = x:r
 | otherwise = r
  where r = filter p xs

filter p (x:xs) = if p x then x:r else r
  where r = filter p xs
-}

enumF a = a:enumF (a+1)

-- foldr op nv l
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr _  nv []     = nv
foldr op nv (x:xs) = x `op` foldr op nv xs

-- map   :: (a -> b)           -> [a] -> [b]
-- foldr :: (t -> u -> u) -> u -> [t] -> u
-- t = a
-- u = [b]

-- map f = foldr (\x r -> f x : r) []
map f = foldr (\x -> (f x:)) []


-- filter :: (a -> Bool) ->       [a] -> [a]
-- foldr :: (t -> u -> u) -> u -> [t] -> u
-- t = a
-- u = [a]
-- filter p = foldr (\x r -> if p x then x:r else r) []
filter p = foldr (\x -> if p x then (x:) else id) []

foldl :: (b -> a -> b) -> b -> [a] -> b
foldl _  nv []     = nv
foldl op nv (x:xs) = foldl op (nv `op` x) xs

foldr1 :: (a -> a -> a) -> [a] -> a
foldr1 _  [x]    = x
foldr1 op (x:xs) = x `op` foldr1 op xs

foldl1 :: (a -> a -> a) -> [a] -> a
foldl1 op (x:xs) = foldl op x xs

-- foldr :: (a -> b -> b) -> b -> [a] -> b
scanr    :: (a -> b -> b) -> b -> [a] -> [b]
-- foldr _  nv []     = nv
scanr     _ nv []     = [nv]
-- foldr op nv (x:xs) = x `op` foldr op nv xs
-- foldr op nv xs = head (scanr op nv xs)
scanr    op nv (x:xs) = x `op` r:rest
 where rest@(r:_) = scanr op nv xs
-- може ли scanr чрез foldr?

-- foldl :: (b -> a -> b) -> b -> [a] -> b
scanl    :: (b -> a -> b) -> b -> [a] -> [b]
-- foldl _  nv []     = nv
scanl    _  nv []     = [nv]
-- foldl op nv (x:xs) = foldl op (nv `op` x) xs
-- foldl op nv xs = last (scanl op nv xs)
scanl    op nv (x:xs) = nv:scanl op (nv `op` x) xs
-- може ли scanl чрез foldl?
