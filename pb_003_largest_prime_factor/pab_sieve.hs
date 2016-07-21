module MainPABNaif where

import Euler.Utils

main :: IO()
main = do
    prod <- read_int
    stat_func (last . decompNotPrime) prod


-- Based on naive primes, pseudo-seive
primes = filterPrime [2..]
    where filterPrime (p:xs) = p:filterPrime [x | x <- xs, x `mod` p /= 0]
decompNotPrime :: Int -> [Int]
decompNotPrime prod
        | prod > 1  = let primesUntil n = takeWhile (<= (truncate $ (fromIntegral n)**0.5)) primes -- primesUntil has primes until square root of n, they are the potential divider of n
                          divider n d = n `mod` d == 0
                          div1 = head $ filter (divider prod) (primesUntil prod ++ [prod])
                      in div1 : decompNotPrime (prod `div` div1)
        | otherwise = []

