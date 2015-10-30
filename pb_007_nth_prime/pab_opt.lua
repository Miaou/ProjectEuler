-- Miaou.


function get_nth_prime(iPrime)
    local i,j,bNotPrime,root,lPrimes,ilP

    if iPrime==nil or iPrime<1 then
        return iPrime
    end

    i = 2
    lPrimes = {}
    ilP = 1
    while true do
        bNotPrime = false
        root = math.floor(math.sqrt(i))
        j = 2
        for j=2,root do -- Reste plus optimisé que de faire la boucle while
        --for j=1,#lPrimes do -- C'est une perte de temps de parcourir des éléments dans une liste...
        --for k,j in ipairs(lPrimes) do
            if ((i%j) == 0) then
                bNotPrime = true
                break
            end
        end
        if not bNotPrime then
            lPrimes[ilP] = i
            ilP = ilP + 1
            iPrime = iPrime - 1
            if iPrime == 0 then
                return i
            end
        end
        i = i+1
    end
end

if arg~=nil and arg[1]~=nil then
    iPrime = tonumber(arg[1])
    print(string.format("pab_opt_lua(%d) = %d", iPrime, get_nth_prime(iPrime)))
else
    print("Give me the index you want to find...")
end
