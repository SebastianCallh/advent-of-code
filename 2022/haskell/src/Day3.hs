module Day3 where

import Data.Maybe
import Data.List.Split
import qualified Data.Text as T
import qualified Data.Set as Set
import qualified Data.Map as Map


compartments xs = [p1, p2]
  where
    (p1, p2) = T.splitAt halfway xs
    halfway = T.length xs `div` 2

overlap = head . Set.elems . foldr1 Set.intersection . fmap (Set.fromList . T.unpack)

score x =
  fromJust $ Map.lookup x scoreMap
  where
    scoreMap = lowerCaseMap <> upperCaseMap
    lowerCaseMap = Map.fromList $ zip ['a'..'z'] [1..26]
    upperCaseMap = Map.fromList $ zip ['A'..'Z'] [27..52]

groups = chunksOf 3

sol1 = sum . fmap (score . overlap . compartments) . T.lines
sol2 = sum . fmap (score . overlap) . groups . T.lines
