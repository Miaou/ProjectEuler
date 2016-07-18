# Ici, les commandes à exécuter (compil/clean/timeit)

.PHONY: all build clean s3

TARGET = 3

all: build
	java out.ebi_naive $(TARGET)
	out/ebi_naif $(TARGET)
build:
	mkdir -p out/
	javac -d . ebi_naive.java
	ghc -O -o out/ebi_naif -outputdir out -main-is MainEBINaif ebi_naif.hs
clean:
	rm -r out/
s3:
	make -C makefile-s3
