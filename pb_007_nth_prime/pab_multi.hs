module Main where

import System.Environment   -- getArgs
import Text.Printf
import System.IO            -- stderr
import System.CPUTime


-- See https://wiki.haskell.org/Timing_computations for better time computations
time f v = do
    start <- getCPUTime
    x <- return $! f v
    end <- getCPUTime
    --return ()
    return ((fromIntegral (end-start))*1e-12, x)


main :: IO()
main = do
    args <- getArgs
    if length args /= 1
      then putStrLn "Fournir l'index du premier à trouver en argument du programme"
      else let iPrime = read $ args !! 0 :: Int in do
        (t,v) <- time primes_naif iPrime
        printf "pab_naif_hs(%d) = %d\n" iPrime (v::Integer)
        hPutStr stderr $ printf "user   %.3fs\n" (t::Float)
        (t,v) <- time primes_opt iPrime
        printf "pab_opt_hs(%d) = %d\n" iPrime (v::Integer)
        hPutStr stderr $ printf "user   %.3fs\n" (t::Float)


-- Computes the nth prime (Indexed from 1)
--  (the list is enclosed in a do statement do have a common interfacei with other functions)
primes_naif n = do
    let ps = [x | x <- [2..],
              all (\y -> mod x y > 0) [2..floor $ sqrt $ fromIntegral x]]
    ps !! (n-1)

-- Computes the nth prime, but using the prime list (avoids intermediate lists)
primes_opt n = do
    let ps = 2:[x | x <- [3..],
                all (\y -> mod x y > 0) $ takeWhile (<= (floor $ sqrt $ fromIntegral x)) ps]
    ps !! (n-1)
