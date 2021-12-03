module Basics where

x :: Int
x = 2

y :: Double
y = fromIntegral(x)^2 + 7.5
-- !!! y = toDouble(x)^2 + 7.5

z :: String
z = "I love Haskell!"

c :: Char
c = 'a'

longnumber :: Integer
longnumber = 9432187832749874821747382174821749821748217481748174981743287

--intnumber :: Int
--intnumber = 9432187832749874821747382174821749821748217481748174981743287

square :: Int -> Int
-- square x = x * x
square = diag (*)

twice :: (Int -> Int) -> Int -> Int
twice f x = f (f x)

diag :: (b -> b -> a) -> b -> a
diag f x = f x x

plus1 = (+) 1

fact n
  | n == 0   = 1
  | n > 0    = n * fact (n - 1)
  | n < 0    = error "подадено отрицателно число"

factugly n | n == 0 = 1 | n > 0    = n * factugly (n - 1) | n < 0 = error "подадено отрицателно число"

result = let x = t
               where t = 2 + 3
             y = x
         in x + y

result2 = x + y
 where  x = 5
        y = x

result3 = x + y where { x = 5 ; y = x }

factnew 0 = 1
factnew n = n * factnew (n - 1)
