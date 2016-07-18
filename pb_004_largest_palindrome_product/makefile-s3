all: palindromes.res

palindromes.res: palindromes.hll palindromes.cex palindromes.map
	 cex_simulator -hll palindromes.hll -cex palindromes.cex -res palindromes.res -map palindromes.map

palindromes.cex: palindromes.lll 
	s3 -lll palindromes.lll -bmc stop 0 -cex palindromes.cex

palindromes.lll: palindromes.hll
	expand1 -hll palindromes.hll -lll palindromes.lll -dumpMap palindromes.map

palindromes.map: palindromes.lll

clean:
	rm -f palindromes.cex palindromes.lll palindromes.map palindromes.res
