module Tree where

data Tree a = EmptyTree | TreeNode a (Tree a) (Tree a) deriving Show

nullTree :: Tree a -> Bool
nullTree EmptyTree = True
nullTree _ = False

isLeaf :: Tree a -> Bool
isLeaf EmptyTree = False
isLeaf (TreeNode _ left right) = nullTree left && nullTree right

makeLeaf :: a -> Tree a
makeLeaf x = TreeNode x EmptyTree EmptyTree

treeMap :: (a -> b) -> Tree a -> Tree b
treeMap _ EmptyTree = EmptyTree
treeMap f (TreeNode x left right) = TreeNode (f x) (treeMap f left) (treeMap f right)

traverseInOrder :: Tree a -> [a]
traverseInOrder EmptyTree = []
traverseInOrder (TreeNode x left right) = traverseInOrder left ++ [x] ++ traverseInOrder right

bstFind :: (Eq a, Ord a) => a -> Tree a -> Maybe a
bstFind _ EmptyTree = Nothing
bstFind x (TreeNode elem left right)
  | x == elem = Just x
  | x < elem = bstFind x left
  | otherwise = bstFind x right

bstInsert :: (Ord a) => a -> Tree a -> Tree a
bstInsert x EmptyTree = makeLeaf x
bstInsert x (TreeNode elem left right) = if x < elem then TreeNode elem (bstInsert x left) right else TreeNode elem left (bstInsert x right)

