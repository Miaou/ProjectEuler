# Ici, les commandes à exécuter (compil/clean/timeit)

.PHONY: all build clean

TARGET = 1000

all: build
	out/ebi_naif $(TARGET)
build:
	mkdir -p out/
	ghc -O -o out/ebi_naif -outputdir out -main-is MainNaif ebi_naif.hs
clean:
	rm -r out/
