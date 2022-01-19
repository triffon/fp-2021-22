module IO where

findAverage :: IO Double
findAverage = do putStrLn "Моля, въведете брой числа:"
                 n <- getInt
                 s <- readAndSum n
                 return (fromIntegral s / fromIntegral n)

readAndSum :: Int -> IO Int
readAndSum 0 = return 0
readAndSum n = do x <- getInt
                  s <- readAndSum $ n - 1
                  return $ x + s

getInt :: IO Int
getInt = do line <- getLine
            return $ read line

printRead :: String -> IO Int
printRead s = do putStr $ s ++ " = "
                 getInt

throwAwayResult :: IO a -> IO ()
throwAwayResult t = do t
                       return ()

forever :: IO a -> IO b
forever t = do t
               forever t

readInt :: String -> IO Int
readInt s = do putStr $ "Моля, въведете " ++ s ++ ": "
               getInt

findAveragev2 :: IO Double
findAveragev2 = do n <- readInt "брой"
                   l <- mapM (readInt.("число #"++).show) [1..n]
                   let s = sum l
                   return $ fromIntegral s / fromIntegral n

main = forever $
       do avg <- findAveragev2
          putStrLn $ "Средното аритметично е: " ++ show avg
          putStrLn "Хайде отново!"

              
