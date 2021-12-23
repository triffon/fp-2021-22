import Prelude hiding (signum, sum)

add :: Int -> Int -> Int
add a b = a + b

-- addN n = (lambda (x) (+ x n))
-- addN n = \x -> x + n
-- addN n x = add n x
-- addN n = add n
addN = add

-- signum x = if x < 0 then -1 else 1
signum 0 = 0
signum x
  | x > 0 = 1
  | otherwise = -1


factorial :: (Eq p, Num p) => p -> p
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- fib 0 = 0
-- fib 1 = 1
-- fib n = fib (n - 1) + fib (n - 2)


fib n = iter 0 1 0
  where iter current next count
          | count == n = current
          | otherwise = iter next (current + next) (count + 1)


sum start end
  | start == end = start
  | otherwise = start + sum (start + 1) end


square x = x * x

fastPow x 0 = 1
fastPow x 1 = x
fastPow x n
  | even n = square (fastPow x (n `div` 2))
  | otherwise = x * fastPow x (n - 1)


countDigits n
  | n < 10 = 1
  | otherwise = 1 + countDigits (n `div` 10)


-- twice f x = f (f x)

compose f g x = f (g x)
-- compose f g = \x -> f (g x)

twice f = compose f f

repeated :: (Eq t1, Num t1) => (t2 -> t2) -> t1 -> (t2 -> t2)
repeated f 0 = id
repeated f 1 = f
repeated f n = compose f (repeated f (n - 1))


main :: IO ()
main = print
  (  signum 42 == 1
  && signum (-4) == -1
  && signum 0 == 0
  && factorial 5 == 120
  && fib 7 == 13
  && sum 1 5 == 15
  && fastPow 2 10 == 1024
  && countDigits 12345 == 5
  && compose square square 2 == 16
  && repeated square 2 2 == 16
  )
