# Ici, les commandes à exécuter (compil/clean/timeit)

.PHONY: all build clean

TARGET = 4000000

all: build
	out/ebi_naif $(TARGET)
build:
	mkdir -p out/
	ghc -O -o out/ebi_naif -odir out -hidir out ebi_naif.hs
clean:
	rm -r out/
