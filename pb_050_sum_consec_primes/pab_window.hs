module Main where


import Euler.Utils


-- Let primes be the primes under N: [2 3 ... p]
-- Search for the longest consecutive sum that adds to a prime below N
-- The sum is a sliding window over ps: either some of the starts are missing, or some of the lasts
-- The largest window is searched.
-- So we start from the largest sum of primes that adds to something lower than N, and it has n elements
-- If it's prime --> won
-- If not --> remove the head, slide it towards left, until a prime is found
-- If not --> remove another prime, ...

-- Slide/window operator
window :: Int -> Int -> [a] -> [a]
window i n xs = drop i $ take (n+i) xs

-- Primes with the sieve (pb_007)
primes = 2:[x | x <- [3..],
                all (\y -> mod x y > 0) $ takeWhile (<= (floor $ sqrt $ fromIntegral x)) primes]

-- Unopt isPrime
isPrime n = all (\y -> mod n y > 0) $ takeWhile (<= (floor $ sqrt $ fromIntegral n)) primes

-- Largest sum of a list under a limit
{-sumWhile :: Num a => (a -> Bool) -> [a] -> a
sumWhile _ [] = 0
sumWhile p (x:xs)
         | p (x + sumWhile -}
sumWhile p xs = last $ takeWhile p $ scanl (+) 0 xs
lengthSumWhile p xs = fst $ last $ zip [0..] $ takeWhile p $ scanl (+) 0 xs

-- Needs non emptiness
not_null :: [a] -> Bool
not_null [] = False
not_null _ = True

-- There's no need for the window: the sumWhile on tail of primes selects only the right amount of primes
-- Moreover, the selected number of primes is decreasing, so the drop [0..] is valid
-- However, when two sums has the same number of terms, the lowest is returned first
--largest n = head $ filter isPrime [sumWhile (< n) $ drop i primes | i <- [0..]]

-- So there's a need for a window

largests n = let nt = lengthSumWhile (< n) primes
                 in head $ filter not_null
                    [let sums_ni = filter isPrime $ takeWhile (< n) [sum $ window i ni primes | i <- [0..]]
                         in sums_ni | ni <- [nt,nt-1..2]]
largest n = last $ largests n

-- The problem with the previous algorithm is that the sum is calculated O(n^2). --> this is false, see the last comment of this file
-- It must be possible to benefit from the sliding window: `sum $ window i+1 n primes == (sum $ window i n) - (primes !! i) + (primes !! i+1+n)`
-- This is called memoization...
{- The unmemoized version:
sumWindow 0 n xs = sum $ take n xs
sumWindow i n xs
          | i < 0 = 0
          | otherwise = (sumWindow (i-1) n xs) - (xs !! (i-1)) + (xs !! (i-1+n))
-}
{- This one does not work, maybe it is (sw n xs) that is recalculated
sumWindow :: Num a => Int -> Int -> [a] -> a
sumWindow i n xs = (map (sw n xs) [0..]) !! i
    where sw n xs 0 = sum $ take n xs
          sw n xs i = (sumWindow (i-1) n xs) - (xs !! (i-1)) + (xs !! (i-1+n))
-}
-- Let's try with explicit lists: memoization works with things such as map, which retains the "local" function/list values,
--  so the following does not memoize, but f = ((sumsW n xs) !!) does
{-
sumsW n xs = ys
    where ys = (sum $ take n xs):[(ys !! (i-1)) - (xs !! (i-1)) + (xs !! (i-1+n)) | i <- [1..]]
-}

-- Memoization could win time, but not here, where the prime generation is the bottleneck ;-)

main = do
    n <- read_int
    stat_func largest n
    return ()
