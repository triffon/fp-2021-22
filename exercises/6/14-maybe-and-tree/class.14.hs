{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}

import Prelude hiding (Maybe(..))

class Eq' a where
  (=~=) :: a -> a -> Bool
  (/~=) :: a -> a -> Bool

class Group a where
  nula :: a
  add :: a -> a -> a


instance Eq' a => Eq' [a] where
  (=~=) [] [] = True
  (=~=) (x:xs) (y:ys) =
    if x =~= y
    then xs =~= ys
    else False

  (/~=) xs ys = not (xs =~= ys)



instance Group Int where
  nula = 1000
  add x y = x + y

instance Group String where
  nula = "nula"
  add x y = x ++ y

--data Matrix3x3 = MkMat [[Int]]
type Matrix3x3 = [[Int]]

m1 :: Matrix3x3
m1 =
  [ [1,2,3]
  , [4,5,6]
  , [7,8,9]
  ]

instance Group Matrix3x3 where
  nula =
    [ [1,0,0]
    , [0,1,0]
    , [0,0,1]
    ]
  add m1 m2 =
    zipWith (zipWith (+)) m1 m2

func :: Group a => a -> a
func x =
  add x nula


data Maybe a
  = Nothing
  | Just a
  deriving Show

-- Задача: равенство на Maybe
-- Повдигаме равенството на `а` върху `Maybe a`
instance (Eq a) => Eq (Maybe a) where
  Nothing == Nothing = True
  (Just x) == (Just y) = x == y
  _ == _ = False



-- Задача: целичислено делене
safeDiv :: Int -> Int -> Maybe Int
safeDiv _ 0 = Nothing
safeDiv x y = Just (div x y)

head' :: [a] -> a
head' [] = error "empty list"
head' (x:xs) = x

safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:xs) = Just x

safeTail :: [a] -> Maybe [a]
safeTail [] = Nothing
safeTail (x:xs) = Just xs

lookup' :: Eq a => a -> [(a, b)] -> Maybe b
lookup' x [] =
  Nothing
lookup' x ((key, value):ys) =
  if x == key
  then Just value
  else lookup' x ys

tochki :: [(String, Int)]
tochki = [("ani",8),("gosho",6),("pesho",10), ("dragan", -1)]




data Base = C | G | A | T
    deriving Read --(Eq, Show)

data GeneticCode = GeneticCode [Base]
    deriving (Eq, Show)

data Codon = Codon Base Base Base
    deriving (Eq, Show)

data Aminoacid = Aminoacid Int
    deriving (Eq, Ord, Show)

type CodingTable = [(Codon, Aminoacid)]
type Gene = [Codon]
type Protein = [Aminoacid]


addAA :: Aminoacid -> Aminoacid -> Aminoacid
addAA (Aminoacid x) (Aminoacid y) = Aminoacid (x + y)

codonToList :: Codon -> [Base]
codonToList (Codon x y z) = [x, y, z]

hasSameProteins :: CodingTable -> GeneticCode -> Bool
hasSameProteins = undefined

maxMutations :: CodingTable -> GeneticCode -> Int
maxMutations = undefined


aacid :: Codon -> CodingTable -> Aminoacid
aacid c table =
    case lookup' c table of
        Just a -> addAA a (Aminoacid 100)
        Nothing -> Aminoacid 1

--data Base = C | G | A | T
--    deriving (Eq, Show, Read)

instance Eq Base where
    C == C = True
    G == G = True
    A == A = True
    T == T = True
    _ == _ = False

instance Show Base where
    --show :: Base -> String
    show C = "C"
    show G = "G"
    show A = "A"
    show T = "T"

--instance Read Base where
--    --read :: String -> a
--    read "C" = C
--    read "G" = G
--    read "A" = A
--    read "T" = T


main :: IO ()
main = do
    putStrLn "zdrasti"
    putStrLn "svqt"
    input <- getLine
    let b :: [Base]
        b = (read input)

    putStrLn (show b)
    print b

