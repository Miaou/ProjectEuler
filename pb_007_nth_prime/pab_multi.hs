module Main where

import System.Environment   -- getArgs
import Text.Printf
import System.IO            -- stderr
import System.CPUTime
import qualified Data.Set as Set -- sieve functions
import Debug.Trace


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

-- Computes a sieve up to number N
--  (present numbers are primes)
-- Lente car fait beaucoup de constructions d'arbre
--sieve n [] = []
--sieve n (p:ps) = p : (sieve n (Set.toList $ Set.difference (Set.fromList ps) (Set.fromList [2*p,3*p..n])))
-- Gourmande car stoque les sp intermédiare
--sieve n [] _ = []
--sieve n (p:ps) sp = p : (sieve n (filter (\x -> not $ Set.member x sp) ps) (Set.union sp (Set.fromList [2*p,3*p..n])))
-- Il faudrait pouvoir executer un for sans conséquences autres que la modif de sp
--sieve n [] _ = []
--sieve n (p:ps) sp = p : (sieve n (filter (\x -> not $ Set.member x sp) ps) (foldl (\s e -> Set.insert e s) sp [2*p,3*p..n]))
-- Reste le filter
sieve_calc n [] _ = []
sieve_calc n (p:ps) sp = p : (sieve_calc n ps (foldl (\s e -> Set.insert e s) sp [2*p,3*p..n]))
sieve n = do
    let sp = Set.empty :: Set.Set Int
    let ps = filter (\x -> not $ Set.member x sp) [2..n]
    let res = sieve_calc n ps sp
    trace ("sp "++show sp) res
