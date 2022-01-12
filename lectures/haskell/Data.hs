module Data where

class Measurable a where
  size :: a -> Int
  empty :: a -> Bool
  empty = (==0) . size

larger :: Measurable a => a -> a -> Bool
larger x y = size x > size y

instance Measurable Integer where
  size 0 = 0
  size n = 1 + size (n `div` 10)
  empty = (==0)

instance (Measurable a, Measurable b) => Measurable (a, b) where
  size (x, y) = size x + size y

instance Measurable a => Measurable [a] where
  size = sum . map size

data Weekday = Mon | Tue | Wed | Thu | Fri | Sat | Sun
  deriving (Eq, Ord, Enum, Show, Read)

-- today :: Weekday
today = Wed

x = True

{-
instance Show Weekday where
  show Mon = "понеделник"
  show Tue = "вторник"
  show Wed = "сряда"
  show _   = "вече не знам"
-}

type Name  = String
type Score = Int
--data Player = Player Name Score
data Player = Player { name :: Name, score :: Score }
  deriving (Eq, Show, Read)

katniss :: Player
katniss = Player "Katniss Everdeen" 45

getName :: Player -> Name
getName (Player name _) = name

data Shape =
  Circle { radius :: Double } |
  Rectangle { width, height :: Double }
  deriving (Eq, Ord, Show, Read)

{-

struct Circle { double radius; };
struct Rectangle { double width, height; };

union Shape {
  Circle circle;
  Rectangle rectangle;
};

Shape s;
s.circle.radius = 2;
s.rectangle.width = 5;
s.rectangle.height = 10;

class Shape { };
class Circle : public Shape { double radius; };
class Rectangle : public Shape { double width, height; };

Shape* s = new Circle;
s = new Rectangle;

void* s = new Circle;

// s->radius!!!!
((Circle*)s)->radius;

-}

circle = Circle 2.3
rectangle = Rectangle 3.5 4.8

-- l !! 2
getAt :: Int -> [a] -> Maybe a
getAt _ []     = Nothing
getAt 0 (x:_)  = Just x
getAt n (_:xs) = getAt (n-1) xs

data Nat = Zero | Succ Nat
  deriving (Eq, Ord, Show, Read)

five = (iterate Succ Zero) !! 5

fromNat :: Nat -> Integer
fromNat Zero     = 0
fromNat (Succ n) = 1 + fromNat n

toNat :: Integer -> Nat
toNat 0 = Zero
toNat n = Succ $ toNat $ n-1

data Bin = One | BitZero Bin | BitOne Bin
  deriving (Eq, Ord, Show, Read)

six = BitZero $ BitOne $ One

fromBin :: Bin -> Integer
fromBin One         = 1
fromBin (BitZero b) = 2 * fromBin b
fromBin (BitOne  b) = 2 * fromBin b + 1

succBin :: Bin -> Bin
succBin One         = BitZero One
succBin (BitZero b) = BitOne b
succBin (BitOne  b) = BitZero $ succBin b

-- toBin: за домашно

data List a = Nil | Cons { listHead :: a, listTail :: List a }
  deriving (Eq, Ord, Show, Read)

l = Cons 1 $ Cons 2 $ Cons 3 $ Nil

fromList :: List a -> [a]
fromList Nil         = []
fromList (Cons x xs) = x:fromList xs

(+++) :: List a -> List a -> List a
Nil         +++ ys = ys
(Cons x xs) +++ ys = Cons x (xs +++ ys)

data BinTree a = Empty | Node { root :: a,
                                left, right :: BinTree a }
    deriving (Eq, Ord, Show, Read)

leaf x = Node x Empty Empty
t = Node 3 (leaf 1) (leaf 5)

depth :: BinTree a -> Integer
depth Empty        = 0
depth (Node _ l r) = 1 + max (depth l) (depth r)

leaves :: BinTree a -> [a]
leaves Empty        = []
leaves (Node x Empty Empty) = [x]
leaves (Node x l     r    ) = leaves l ++ leaves r

{-
map _ []     = []
map f (x:xs) = f x : map f xs
-}

mapBinTree :: (a -> b) -> BinTree a -> BinTree b
mapBinTree _ Empty        = Empty
mapBinTree f (Node x l r) = Node (f x)
                                 (mapBinTree f l) (mapBinTree f r)

{-
foldr _  nv []     = nv
foldr op nv (x:xs) = x `op` foldr op nv xs
-}
foldrBinTree :: (a -> b -> b) -> b -> BinTree a -> b
foldrBinTree _  nv Empty        = nv
foldrBinTree op nv (Node x l r) = foldrBinTree op (x `op` foldrBinTree op nv r) l
