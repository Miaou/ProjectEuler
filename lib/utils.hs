module Euler.Utils where

import System.Environment (getArgs)
import System.IO (stderr, hPutStrLn)
import System.CPUTime (getCPUTime)


read_string_int = do
    args <- getArgs
    if length args /= 2
      then error "There shall be exactly two arguments (string, int)."
      else return (args !! 0 :: String , read $ args !! 1 :: Int)

echo_err str = hPutStrLn stderr str 

-- See https://wiki.haskell.org/Timing_computations for better time computations
time_3args f x y = do
    start <- getCPUTime
    x <- f x y
    end <- getCPUTime
    return ((fromIntegral (end-start))*1e-12, x)

