module Main where
import qualified Data.Text.IO as T

import Day1
import Day2

main :: IO ()
main = mapM_ run $ zip [1..] days
  where
    run (i, f) = do
      putStr $ mconcat ["Day ", show i, " "]
      input i >>= f

    input i = T.readFile $ mconcat ["../input/", show i, ".txt"]
    days = [Day1.sol, Day2.sol]
