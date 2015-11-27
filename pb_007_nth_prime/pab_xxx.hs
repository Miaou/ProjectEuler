let primes = 2:filter (\x -> all (\y -> mod x y > 0) (takeWhile (<= (floor (sqrt (fromIntegral x)))) primes)) [3..]
