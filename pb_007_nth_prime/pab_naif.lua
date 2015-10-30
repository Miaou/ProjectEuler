-- Miaou.

function count(start)
    --[[
    Iterateur, compte depuis start.
    Est en fait une fonction qui génère une fonction à chaque pas,
     dont le résultat est l'élément sur lequel itérer.
    --]]
    local i=start-1
    return function()
             i = i+1
             return i
           end
end

function get_nth_prime(iPrime)
    local i,j,bNotPrime,root

    if iPrime==nil or iPrime<1 then
        return iPrime
    end

    for i in count(2) do
        bNotPrime = false
        root = math.floor(math.sqrt(i))
        for j=2,root do
            if ((i%j) == 0) then
                bNotPrime = true
                break
            end
        end
        if not bNotPrime then
            iPrime = iPrime - 1
            if iPrime == 0 then
                return i
            end
        end
    end
end

if arg~=nil and arg[1]~=nil then
    iPrime = tonumber(arg[1])
    print(string.format("pab_naif_lua(%d) = %d", iPrime, get_nth_prime(iPrime)))
else
    print("Give me the index you want to find...")
end
