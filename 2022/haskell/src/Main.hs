module Main where
import qualified Data.Text.IO as T

import Day1
import Day2
import Day3
import Day4

main :: IO ()
main = do
  T.readFile "../input/1.txt" >>= day1
  T.readFile "../input/2.txt" >>= day2
  T.readFile "../input/3.txt" >>= day3
  T.readFile "../input/4.txt" >>= day4

day1 contents = do
  putStrLn "---- Day 1 ----"
  putStrLn . show $ Day1.sol1 contents
  putStrLn . show $ Day1.sol2 contents

day2 contents = do
  putStrLn "---- Day 2 ----"
  putStrLn . show $ Day2.sol1 contents
  putStrLn . show $ Day2.sol2 contents

day3 contents = do
  putStrLn "---- Day 3 ----"
  putStrLn . show $ Day3.sol1 contents
  putStrLn . show $ Day3.sol2 contents

day4 contents = do
  putStrLn "---- Day 4 ----"
  putStrLn . show $ Day4.sol1 contents
  putStrLn . show $ Day4.sol2 contents
