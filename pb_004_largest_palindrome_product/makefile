# Ici, les commandes à exécuter (compil/clean/timeit)

.PHONY: all build clean

TARGET = 3

all: build
	java out.ebi_naive $(TARGET)
	out/ebi_naif $(TARGET)
build:
	mkdir -p out/
	javac -d . ebi_naive.java
	ghc -O -o out/ebi_naif -outputdir out -main-is MainNaif ebi_naif.hs
clean:
	rm -r out/
