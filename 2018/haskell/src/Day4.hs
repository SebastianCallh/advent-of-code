module Day4 where

import           Data.Foldable        (foldl', maximumBy)
import           Data.List            (sort)
import qualified Data.Map.Strict      as M
import           Data.Maybe           (fromJust)
import           Data.Ord             (comparing)
import           Data.Text            (Text)
import qualified Data.Text            as T
import           Data.Time
import           Data.Void            (Void)
import           Input                (inputFor)

import           Text.Megaparsec      hiding (State)
import           Text.Megaparsec.Char

type Parser = Parsec Void Text
type Min = Int
type Naps = M.Map (Guard, Min) Int
{-
data Observation = Observation
  { observationMinute :: !Min
  , observationEvent  :: !Event
  } deriving Show

data Timestamp = Timestamp
  { timestampDay  :: !Day
  , timestampTime :: !TimeOfDay
  } deriving Show

timestamp :: Parser Timestamp
timestamp = do
  str <- some anyChar
  let dateString = "1518-07-08 00:57" -- 26 Jan 2012 10:54 AM"
  let timeFromString = parseTimeOrError True defaultTimeLocale "%d %b %Y %l:%M %p" dateString :: UTCTime
  pure $ Timestamp day time

day = undefined

time = undefined
-}

data Observation
  = FallAsleep Min
  | WakeUp Min
  | BeginShift Guard
  deriving Show

type Guard = Int
data State = State
  { stateGuard    :: !Guard
  , stateNaps     :: !(Naps)
  , stateAsleepAt :: !Min
  }

-- [1518-06-05 00:46] falls asleep

observation :: Parser Observation
observation = do
  _ <- char '['
  m <- minute
  _ <- char ']' *> space
  e <- event m
  pure e

minute :: Parser Min
minute = do
  _ <- some $ digitChar <|> char '-'
  _ <- space *> some digitChar *> char ':'
  m <- some digitChar
  pure $ read m

event :: Min -> Parser Observation
event m = string "falls asleep" *> pure (FallAsleep m)
  <|>     string "wakes up"     *> pure (WakeUp m)
  <|>     guardBeginShift
  where
    guardBeginShift = do
      _       <- string "Guard" *> space *> char '#'
      guardId <- read <$> some digitChar
      _ <- space *> string "begins shift"
      pure $ BeginShift guardId

answer1 = do
  lines <- sort . T.lines <$> inputFor "Day4"
  pure $ do
    obs <- traverse (parse observation "") lines
    let naps = parseNaps obs
    let bs   = biggestSleeper naps
    let msm  = mostSleptMinute naps bs
    pure $ bs * msm

answer2 = do
  lines <- sort . T.lines <$> inputFor "Day4"
  pure $ do
    obs <- traverse (parse observation "") lines
    let naps   = parseNaps obs
    let guards = fst <$> M.keys naps
    let guard  = maximumBy (comparing $ mostSleptAmount naps) guards
    let msm    = mostSleptMinute naps guard
    pure $ guard * msm

biggestSleeper :: Naps -> Guard
biggestSleeper naps =
  maximumBy (comparing sleepTime) guards
  where
    sleepTime = sum . fmap (fromJust . flip M.lookup naps) . slots
    slots g   = filter ((==g) . fst) $ M.keys naps
    guards    = fst <$> M.keys naps

mostSleptMinute :: Naps -> Guard -> Min
mostSleptMinute naps =
  snd . fst . maximumBy (comparing snd) . slots naps

mostSleptAmount :: Naps -> Guard -> Min
mostSleptAmount naps = do
  snd . maximumBy (comparing snd) . slots naps

slots naps g = filter ((==g) . fst . fst) $ M.assocs naps

parseNaps :: [Observation] -> M.Map (Guard, Int) Int
parseNaps obs = stateNaps $ foldl' f state obs
  where
    state = State firstGuard M.empty 0
    (BeginShift firstGuard) = head obs
    f s o = case o of
        FallAsleep m -> s { stateAsleepAt = m }
        WakeUp     m -> recordNap s (m-1)
        BeginShift g -> s { stateGuard = g }

recordNap :: State -> Min -> State
recordNap s m =
  s { stateNaps = foldl' record (stateNaps s) napTime}
  where
    record :: Naps -> (Guard, Min) -> Naps
    record log x = M.insertWith (const (+1)) x 1 log

    napTime :: [(Guard, Min)]
    napTime = (,) (stateGuard s) <$> [stateAsleepAt s..m]

