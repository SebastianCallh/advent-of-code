module Day2 where

import qualified Data.List       as L
import qualified Data.Map.Strict as M
import           Data.Text       (Text)
import qualified Data.Text       as T
import           Input           (inputFor)

data Counts = Counts
  { doubles :: Int
  , triples :: Int
  } deriving Show

instance Semigroup Counts where
  (<>) (Counts x1 x2) (Counts y1 y2) = Counts (x1 + y1) (x2 + y2)

instance Monoid Counts where
  mempty = Counts 0 0

prod :: Counts -> Int
prod (Counts x y) = x*y

answer1 = do
  input <- T.lines <$> inputFor "Day2"
  let counts = mconcat
        $ foldr getCounts mempty
        . T.foldr charCounts M.empty <$> input

  pure $ prod counts

getCounts :: Int -> Counts -> Counts
getCounts x counts
  | x == 2    = counts {doubles = 1}
  | x == 3    = counts {triples = 1}
  | otherwise = counts

charCounts :: Char -> M.Map Char Int -> M.Map Char Int
charCounts char = M.insertWith (const (+1)) char 1

answer2 = do
  input <- T.lines <$> inputFor "Day2"
  let n = T.length $ head input
  let intersections = intersect <$> input <*> input
  let diffByOne = filter ((==n-1) . T.length) intersections
  pure $ head diffByOne

intersect :: Text -> Text -> Text
intersect a b =
  T.concat
  . fmap fst
  . filter (uncurry (==))
  $ zip (T.chunksOf 1 a) (T.chunksOf 1 b)
