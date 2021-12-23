
intersection :: Eq a => [a] -> [a] -> [a]
intersection _ [] = []
intersection [] _ = []
intersection lst1 lst2 = [x | x <- lst1, x `elem` lst2]

prime :: Int -> Bool
prime 1 = False
prime 2 = True
prime x = [divisor | divisor <- [1..x], x `mod` divisor == 0] == [1, x]

primeFactorization :: Int -> [Int]
primeFactorization x
  | prime x = [x]
  | otherwise = p : primeFactorization (x `div` p) where
    primeDivisors = [d | d <- [2..x `div` 2], prime d && x `mod` d == 0]
    p = head primeDivisors

argumentModifier :: [[Integer]]
argumentModifier = generateListsUpTo 5 [] where
  generateListsUpTo k acc
    | k > 10 = acc
    | otherwise = generateListsUpTo (k + 1) ([o | o <- [1..k], odd o] : acc)

palindrome :: String -> Bool
palindrome [] = True
palindrome [_] = True
palindrome str
  | head str == last str = palindrome (tail (init str))
  | otherwise = False

map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map' f xs

plusOne :: Integer -> Integer
plusOne = (+ 1)

something :: Integral a => a -> (a -> a) -> a -> a
something a f d = (a + f d + d) ^ a

addToAll :: (Num a) => a -> [a] -> [a]
-- addToAll n lst = map (\x -> x + n) lst
addToAll n = map (+ n)

twoToThePowerOf = (2 ^)
square = (^ 2)

cut :: Int -> Int -> Int -> Int
cut a b c = a + b - c

subtract' = cut 5 10

add' x = cut x 10 7

filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' pred (x:xs) = if pred x then x : filter' pred xs else filter' pred xs

compose :: (a -> b) -> (c -> a) -> c -> b
compose f g x = f (g x)

turnNegative :: [Int] -> [Int]
turnNegative = map $ negate . abs

applyTwice :: (b -> b) -> b -> b
applyTwice f = f . f

applyNTimes :: (Eq t, Num t) => (c -> c) -> t -> c -> c
applyNTimes f n
  | n == 1 = f
  | n == 2 = f . f
  | otherwise = f . applyNTimes f (n - 1)

naturalNumbers = [1..]

isArithmeticSequence :: [Int] -> Bool
isArithmeticSequence [] = False
isArithmeticSequence [_] = True
isArithmeticSequence [a, b] = True
isArithmeticSequence (a:b:c:rest) = b - a == c - b && isArithmeticSequence (b:c:rest)

generateNumber :: Int -> Int
generateNumber 1 = 1
generateNumber 2 = 1
generateNumber n = head [x | x <- naturalNumbers, k <- [1..n `div` 2], satisfiesCondition x k] where
  satisfiesCondition elem index = not (isArithmeticSequence[generateNumber(n - 2 * index), generateNumber(n - index), elem])

forestFire :: [Int]
forestFire = [generateNumber n | n <- naturalNumbers]

reverseList :: [a] -> [a]
reverseList = foldl (\acc x -> x : acc) []

filterFold :: (a -> Bool) -> [a] -> [a]
filterFold p = foldr (\x acc -> if p x then x : acc else acc) []
