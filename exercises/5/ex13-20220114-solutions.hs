data Shape = Circle Double | Rect Double Double
-- Аналогично в C++, с разликата че тук Circle и Rect _не са_ типове
-- struct Circle { double r; }; struct Rect { double w, h; };
-- std::variant<Circle, Rect>

area :: Shape -> Double
area (Circle r) = 3.14 * r * r
area (Rect w h) = w * h

-- Лоша идея: функции, които не обработват всички алтернативи (не са тотални)
getRadius :: Shape -> Double
getRadius (Circle r) = r
getRadius _ = error "Not a circle"

--data Maybe a = Nothing | Just a
-- Аналогично в C++: std::optional<T>

maybe5 :: Maybe Int
maybe5 = Just 5

{- Как да патърн-мачваме "междинни" стойности от алгебрични типове
foo x = case y of Nothing -> ...
                  (Just 3) -> ... -- можем да мачваме и конкретни стойности
                  (Just z) -> ...
  where y :: Maybe a
        y = нещо си
-}

-- Прилича на Bool, но носи друг смисъл (семантика)
-- => дефинираме друг тип, за да може компилаторът да гарантира,
-- че няма да омешаме стойности с различна семантика
data Parity = Even | Odd
-- data Bool = False | True

-- Една примерна (неудобна) имплементация
data NonEmpty a = a :. [a]
  deriving Show
infixr 5 :.

head' :: NonEmpty a -> a
head' (h :. _) = h

tail' :: NonEmpty a -> Maybe (NonEmpty a)
tail' (_ :. []) = Nothing
tail' (_ :. (x:xs)) = Just (x :. xs)

length' :: NonEmpty a -> Int
length' lst = case tail' lst of Nothing -> 1
                                Just rest -> 1 + length' rest
-- А може просто length' (x :. xs) = 1 + length xs

-- "Чийтваме", минавайки през обикновен списък
reverse' :: NonEmpty a -> NonEmpty a
reverse' (x :. xs) = head res :. tail res
  where res = reverse $ (x:xs)

data BinTree a = Empty | Node a (BinTree a) (BinTree a)

makeLeaf :: a -> BinTree a
makeLeaf x = Node x Empty Empty

{- Проблем: повтаряме много код, разликите са минимални
prune :: BinTree a -> BinTree a
prune Empty = Empty
prune (Node x Empty Empty) = Empty
prune (Node x l r) = Node x (prune l) (prune r)

bloom :: BinTree a -> BinTree a
bloom Empty = Empty
bloom (Node x Empty Empty) = Node x (makeLeaf x) (makeLeaf x)
bloom (Node x l r) = Node x (bloom l) (bloom r)
-}
-- Решение: "параметризираме" по _начина_ за обработване на листа (т.е. функция)
helper :: (a -> BinTree a) -> BinTree a -> BinTree a
helper _ Empty = Empty
helper f (Node x Empty Empty) = f x -- помощната функция да каже какво да върнем вместо листото
helper f (Node x l r) = Node x (helper f l) (helper f r)

prune, bloom :: BinTree a -> BinTree a
prune t = helper (const Empty) t
bloom t = helper (\x -> let leaf = makeLeaf x in Node x leaf leaf) t
