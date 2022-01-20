import System.IO (openFile, IOMode(..), hGetContents, hPutStrLn, hClose)
-- data IOMode = ReadMode | WriteMode | AppendMode | ReadWriteMode
-- type FilePath = String

isPalindrome :: String -> Bool
isPalindrome lst = lst == reverse lst

-- main :: IO ()
-- main = do
--   inputHandle <- openFile "words.txt" ReadMode
--   contents <- hGetContents inputHandle

--   let palindromes = filter isPalindrome $ lines contents

--   putStrLn contents
--   putStrLn $ unlines palindromes

--   outputHandle <- openFile "palindromes.txt" WriteMode
--   hPutStrLn outputHandle $ unlines palindromes

--   hClose inputHandle
--   hClose outputHandle

main :: IO ()
main = do
  contents <- readFile "words.txt"
  writeFile "palindromes.txt" $ unlines (filter isPalindrome $ lines contents)
