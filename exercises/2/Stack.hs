module Stack where

data Stack a = EmptyStack | Stack { top :: a, rest :: Stack a } deriving (Eq)
-- data Stack a = EmptyStack | Stack a (Stack a) deriving (Eq)
-- top :: Stack a -> a
-- top EmptyStack = error "stack is empty"
-- top (Stack x _) = x

-- rest :: Stack a -> Stack a
-- rest EmptyStack = error "stack is empty"
-- rest (Stack _ rest) = rest

instance Show a => Show (Stack a) where
  show stack = "Stack(" ++ showHelper stack [] ++ ")" where
    showHelper :: (Show a) => Stack a -> [a] -> String
    showHelper EmptyStack result = show result
    showHelper stack result = showHelper (rest stack) (result ++ [top stack])

isEmpty :: Stack a -> Bool
isEmpty EmptyStack = True
isEmpty _ = False

push :: Stack a -> a -> Stack a
push EmptyStack value = Stack value EmptyStack
push s value = Stack value s

pushMultiple :: Stack a -> [a] -> Stack a
-- pushMultiple s [] = s
-- pushMultiple s (x:xs) = pushMultiple (push s x) xs
pushMultiple = foldl push
