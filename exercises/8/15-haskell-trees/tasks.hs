-- data List a = Nil | Cons a (List a) deriving Show

data Tree a =
    Empty
  | Leaf a
  | Node (Tree a) a (Tree a) deriving Show

t :: Tree Integer
t = Node (Node (Leaf 4)
               13
               (Leaf 9))
         5
         (Node (Leaf 2)
               7
               (Node (Leaf 1)
                     15
                     (Node (Leaf 42)
                           5
                           (Leaf 19))))

treeSize Empty = 0
treeSize (Leaf _) = 1
treeSize (Node left _ right) = 1 + treeSize left + treeSize right

countLeaves Empty = 0
countLeaves (Leaf _) = 1
countLeaves (Node left _ right) = countLeaves left + countLeaves right

mapTree :: (t -> p) -> Tree t -> Tree p
mapTree f Empty = Empty
mapTree f (Leaf x) = Leaf (f x)
mapTree f (Node left root right) =
    Node (mapTree f left)
         (f root)
         (mapTree f right)

inOrder Empty = []
inOrder (Leaf x) = [x]
inOrder (Node left root right) =
       inOrder left
    ++ [root]
    ++ inOrder right

isEmpty :: Tree a -> Bool
isEmpty Empty = True
isEmpty _ = False

rootTree :: Tree p -> p
rootTree Empty = error "cannot get root of empty tree"
rootTree (Leaf x) = x
rootTree (Node _ x _) = x

isBST :: Ord a => Tree a -> Bool
isBST Empty = True
isBST (Leaf _) = True
isBST (Node left root right) =
    (isEmpty left || (root > rootTree left))
 && (isEmpty right || (root < rootTree right))
 && isBST left
 && isBST right

insert :: Ord a => Tree a -> a -> Tree a
insert Empty value = Leaf value
insert (Leaf x) value
  | value > x = Node Empty x (Leaf value)
  | otherwise = Node (Leaf value) x Empty
insert (Node left root right) value
  | value > root = Node left root (insert right value)
  | otherwise = Node (insert left value) root right

main = print
  (  treeSize t == 11
  && inOrder t == [4, 13, 9, 5, 2, 7, 1, 15, 42, 5, 19]
  )