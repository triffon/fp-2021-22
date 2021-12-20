{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}     -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}          -- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}      -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}          -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-} -- warn about incomplete patterns v2
{-# OPTIONS_GHC -Werror #-}                        -- turn warnings into errors

import Prelude hiding (abs, head, tail, sum)

fact :: Int -> Int
fact 0 = 1
fact n = n * fact (n - 1)

fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

abs :: Int -> Int
abs n
    | n < 0     = - n
    | otherwise = n

composeInt :: (Int -> Int) -> (Int -> Int) -> (Int -> Int)
composeInt f g = \x -> f (g x)

compose :: (foo -> foo) -> (foo -> foo) -> (foo -> foo)
compose f g = \x -> f (g x)

head :: [Int] -> Int
head (x:_) = x
head _ = undefined

sum :: [Int] -> Int
sum [] = 0
sum (x:xs) = x + (sum xs)

myConcat :: [a] -> [a] -> [a]
myConcat [] l = l
myConcat (h:t) l = h : (myConcat t l)

isIntPrefix :: [Int] -> [Int] -> Bool
isIntPrefix [] _ = True
isIntPrefix (h1:t1) (h2:t2)
        | h1 /= h2      = False
        | otherwise     = isIntPrefix t1 t2
isIntPrefix _ [] = False


isPrefix :: (Eq a) => [a] -> [a] -> Bool
isPrefix [] _ = True
isPrefix (h1:t1) (h2:t2)
        | h1 /= h2      = False
        | otherwise     = isPrefix t1 t2
isPrefix _ [] = False

frepeat :: Int -> (a -> a) -> a -> a
frepeat n f x
   | n > 0      =  f (frepeat (n - 1) f x)
   | otherwise  = x

frepeated :: Int -> (a -> a) -> (a -> a)
frepeated n f
    | n > 0     = f . (frepeated (n - 1) f)
    | otherwise = \x -> x

frepeated' :: Int -> (a -> a) -> (a -> a)
frepeated' n f = frepeat n f

frepeated'' :: Int -> (a -> a) -> (a -> a)
frepeated'' n f = \x -> frepeat n f x

frepeated''' :: Int -> (a -> a) -> (a -> a)
frepeated''' = frepeat
