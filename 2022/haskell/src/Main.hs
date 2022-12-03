module Main where
import qualified Data.Text.IO as T

import Day1

main :: IO ()
main = do
  contents <- T.readFile "../input/1.txt"
  putStrLn "---- Day 1 ----"
  putStrLn . show $  Day1.sol1 contents
  putStrLn . show $ Day1.sol2 contents
