module Main where
-- main = putStrLn "Hello, world!"

-- !!! main = putStrLn $ "Въведохтe: " ++ getLine

-- IO ? -> IO ? -> IO ?

main :: IO ()
main = do line <- getLine
          let lineToPrint = "Въведохте: " ++ line
          putStrLn lineToPrint

          
