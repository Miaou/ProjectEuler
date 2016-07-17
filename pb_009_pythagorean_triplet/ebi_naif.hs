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
        (t,v) <- time (prod_triplet . get_triplet) lim
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

get_triplet lim = [(a, b, c) | a <- [1..(div lim 2)], b <- [a..(div lim 2)], c <- [lim - a - b], a^2 + b^2 == c^2]
prod_triplet [(a, b, c)] = a * b * c
prod_triplet []          = error "No triplet found"
prod_triplet _           = error "More than one triplet found"

