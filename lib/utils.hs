module Euler.Utils where

import System.Environment (getArgs)
import System.IO (stderr, hPutStrLn)
import System.CPUTime (getCPUTime)
import Text.Printf (printf)


read_string_int = do
    args <- getArgs
    if length args /= 2
      then error "There shall be exactly two arguments (string, int)."
      else return (args !! 0 :: String , read $ args !! 1 :: Int)

read_int = do
    args <- getArgs
    if length args /= 1
      then error "There shall be exactly one argument (int)."
      else return (read $ head args :: Int)

read_string_integer = do
    args <- getArgs
    if length args /= 2
      then error "There shall be exactly two arguments (string, integer)."
      else return (args !! 0 :: String , read $ args !! 1 :: Integer)

read_integer = do
    args <- getArgs
    if length args /= 1
      then error "There shall be exactly one argument (integer)."
      else return (read $ head args :: Integer)

echo_err str = hPutStrLn stderr str

-- See https://wiki.haskell.org/Timing_computations for better time computations
stat_func :: (Show a, Show b) => (a -> b) -> a -> IO c
stat_func f args = do
    start <- getCPUTime
    x <- return $! f args
    end <- getCPUTime
    printf "Input  : %s\n" (show args)
    printf "Result : %s\n" (show x)
    printf "Time   : %d ms\n" ((truncate . (1e-9*) . fromIntegral) (end-start) :: Int)

