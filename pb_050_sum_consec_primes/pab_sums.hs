module Main where


import Data.List -- elemIndex
import Data.Maybe -- fromJust


-- From pb_007, which should implement an interface for the best method
--  (not to find the nth prime, but to generate primes until n)
primes_opt n = do
    let ps = 2:[x | x <- [3..n],
                all (\y -> mod x y > 0) $ takeWhile (<= (floor $ sqrt $ fromIntegral x)) ps]
    ps

-- Finds the longest sum which adds to a prime under n
find_sum n = do
    -- list of primes up to n
    let ps = primes_opt n
    -- list of (list of cumulative sum of primes starting from ith prime up to sum < n)
    let lls = [takeWhile (< n) $ scanl (+) 0 $ drop i ps | i <- [0..length ps - 1]]
    --print (lls !! 0)
    --zip [0..] $ lls !! 0
    -- now let's find sums that yields a prime in l of lls, and keep the one which is the longest
    --  (in number of terms in the sum)
    let areps = [maximum $ filter (\x -> elem (snd x) ps) $ zip [0..] l | l <- lls]
    -- now find the index of max of areps, which gives the index of the first prime of the list,
    --  as well as the number of terms, and the value of the sum
    let m = maximum areps in 
        (fromJust $ elemIndex m areps, fst m, snd m)
    -- and the first elem of previous list is the 
    --let rs = zip [0..] [ (elem.snd) (last l) ps then ((length l)-1) else 0 |
    --                    l <- lls]
    --print rs
    --filter ((>0).snd) rs
