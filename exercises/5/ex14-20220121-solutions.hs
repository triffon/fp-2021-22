data BinTree a = Empty | Node a (BinTree a) (BinTree a)

data Direction = L | R deriving Show

-- Обикновено алгоритмите, използващи ротации, подсигуряват валидността на входа,
-- т.е. не се опитват да извършват такива ако не са възможни.
-- Един вид, това не е функция за публично ползване (и може да не бъде експортирана).
rotate :: Direction -> BinTree a -> BinTree a
rotate L (Node q (Node p a b) c) = Node p a (Node q b c)
rotate R (Node p a (Node q b c)) = Node q (Node p a b) c

{- Проблем: няма смисъл някое от поддърветата в списъка да е празно
data NTree a = NEmpty | NNode a [NTree a]

instance Functor NTree where
  fmap _ NEmpty = NEmpty
  fmap f (NNode x subtrees) = NNode (f x) [ fmap f t | t<-subtrees ]
-}

-- Решение: правим тип дърво, който е невъзможно да е празен...
data NonEmptyTree a = NENode a [NonEmptyTree a]
  deriving Show
data NTree a = NEmpty | NTree (NonEmptyTree a)
  deriving Show

instance Functor NonEmptyTree where
  fmap f (NENode x subtrees) = NENode (f x) [ fmap f t | t<-subtrees ]
instance Functor NTree where
  fmap _ NEmpty = NEmpty
  fmap f (NTree t) = NTree (fmap f t) -- тук извикваме горната инстанция на fmap
-- Операторът <$> е синоним на fmap, направен да изглежда подобен на $
-- Аналогът е: $ взима функция и стойност и я прилага над стойността;
-- <$> взима функция и "контейнер" със стойности и я прилага над стойностите в контейнера,
-- запазвайки "структурата" му - примерно, не размества или удължава списък.
-- even $ 5 -> False
-- even <$> [1,2,3] -> [False,True,False] -- за списъци fmap = map :)
-- even <$> [] -> []
-- even <$> Just 5 -> Just False
-- even <$> Nothing -> Nothing

-- Пример за тип, параметризиран по два други
-- template <typename k, typename v> class Map { ... };
data Map k v = MEmpty | MNode k v (Map k v) (Map k v)
  deriving Show

mapSearch :: Ord k => k -> Map k v -> Maybe v
mapSearch _ MEmpty = Nothing
mapSearch x (MNode k v l r)
  | x < k  = mapSearch x l
  | x > k  = mapSearch x r
  | x == k = Just v

-- Заб.: във всички случаи "модифицираме" някоя част на дървото, т.е. правим ново дърво
mapInsert :: Ord k => k -> v -> Map k v -> Map k v
mapInsert k' v' MEmpty = MNode k' v' MEmpty MEmpty
mapInsert k' v' (MNode k v l r)
  | k' < k  = MNode k v (mapInsert k' v' l) r
  | k' > k  = MNode k v l (mapInsert k' v' r)
  | k' == k = MNode k v' l r

-- Частично приложен типов конструктор, lol
instance Functor (Map k) where
  fmap _ MEmpty = MEmpty
  fmap f (MNode k v l r) = MNode k (f v) (fmap f l) (fmap f r)

-- Помощна функция за построяване на дърво от списък
-- uncurry превръща функция на наредена двойка във функция на два отделни аргумента :)
fromPairs :: Ord k => [(k,v)] -> Map k v
fromPairs lst = foldr (uncurry mapInsert) MEmpty lst
-- Сега head <$> fromPairs [(2,"foo"),(3,"bar"),(1,"x")]
-- ще е еквивалентно на fromPairs [(2,'f'),(3,'b'),(1,'x')]

-- За този тип данни няма смисъл да инстанцираме Functor,
-- защото може да наруши вътрешната инварианта на типа (!)
data BST a = BSTEmpty | BSTNode a (BST a) (BST a)

bstPath :: Ord a => a -> BST a -> Maybe [Direction]
bstPath _ BSTEmpty = Nothing
bstPath x (BSTNode x' l r)
  | x < x'  = (L:) <$> (bstPath x l) -- (!) употребата на <$>
  | x > x'  = (R:) <$> (bstPath x r)
  | x == x' = Just []

testBST :: BST Int
testBST = BSTNode 2 (BSTNode 1 BSTEmpty BSTEmpty) (BSTNode 3 BSTEmpty BSTEmpty)
-- bstPath 2 testBST -> Just []
-- bstPath 4 testBST -> Nothing
