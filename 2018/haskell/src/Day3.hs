module Day3 where

import           Data.List            (find, group, sort)
import           Data.Map.Strict      (Map)
import qualified Data.Map.Strict      as M
import           Data.Text            (Text)
import qualified Data.Text            as T
import           Data.Void            (Void)
import           Input                (inputFor)
import           Text.Megaparsec
import           Text.Megaparsec.Char

type Parser = Parsec Void Text

data Claim = Claim
  { claimId :: Int
  , slots   :: [(Int, Int)]
  } deriving Show

claim :: Parser Claim
claim = do
  _      <- char '#'
  claimId <- read <$> some digitChar
  _      <- space
  _      <- char '@'
  _      <- space
  x      <- read <$> some digitChar
  _      <- char ','
  y      <- read <$> some digitChar
  _      <- char ':'
  _      <- space
  dx     <- read <$> some digitChar
  _      <- char 'x'
  dy     <- read <$> some digitChar
  pure $ Claim
    { claimId = claimId
    , slots  = (,) <$> [x+1..x+dx] <*> [y+1..y+dy]
    }

answer1 = do
  input <- T.lines <$> inputFor "Day3"
  let grid = createGrid input
  pure $ length . M.filter ((>=2) . length) <$> grid

answer2 = do
  input <- T.lines <$> inputFor "Day3"
  let soleClaim = do
        claims <- traverse (parse claim "") input
        grid   <- createGrid input
        pure $ find (all (\s -> fmap length (M.lookup s grid) == Just 1) . slots) claims
  pure soleClaim

createGrid input = do
  claims <- traverse (parse claim "") input
  let c1 = head claims
  let insertClaim c mp = foldr (\s mp2 -> M.insertWith (++) s [claimId c] mp2) mp $ slots c
  pure $ foldr insertClaim M.empty claims
