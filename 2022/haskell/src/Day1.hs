module Day1 where
import Data.List
import qualified Data.Text as T
import qualified Data.Text.Read as T
import qualified Data.Text.IO as T

sortedSums contents =
  reverse $ sort sums
  where
    sums = sum <$> partInts
    partInts = fmap (read . T.unpack) <$> partLines :: [[Int]]
    partLines = T.lines <$> parts
    parts = T.splitOn "\n\n" contents

sol1 = head . sortedSums

sol2  = sum . take 3 . sortedSums
