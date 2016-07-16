module MainNaif where

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
        (t,v) <- time get_diff lim
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

get_diff target = let array = [1 .. target] in (sum array)^2 - (sum $ zipWith (*) array array)

