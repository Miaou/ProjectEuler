module Main where

import System.Environment   -- getArgs
import Text.Printf
import System.IO            -- stderr
import System.CPUTime

main :: IO()
main = do
    args <- getArgs
    if length args /= 1
      then echo_err "There shall be exactly one argument."
      else let lim = read $ args !! 0 :: Integer in do
        (t,v) <- time get_sum_3_5 lim
        printf "Input  : %d\n" lim
        printf "Result : %d\n" (v::Integer)
        printf "Time   : %.3fs\n" (t::Float)

echo_err str = hPutStrLn stderr str 

-- See https://wiki.haskell.org/Timing_computations for better time computations
time f v = do
    start <- getCPUTime
    x <- return $! f v
    end <- getCPUTime
    return ((fromIntegral (end-start))*1e-12, x)

get_sum_3_5 :: (Integral a) => a -> a
get_sum_3_5 target = (get_sum target 3) + (get_sum target 5) - (get_sum target 15)

-- SUM(x, 1, N) = N * (N + 1) / 2
get_sum :: (Integral a) => a -> a -> a
get_sum target multiple = let higher_bound = (target - 1) `div` multiple
                          in multiple * higher_bound * (higher_bound + 1) `div` 2

