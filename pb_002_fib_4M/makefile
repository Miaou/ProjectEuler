# Ici, les commandes à exécuter (compil/clean/timeit)

.PHONY: all build clean

TARGET = 4000000

all: build
	out/ebi_naif $(TARGET)
	out/ebi_opt $(TARGET)
build:
	mkdir -p out/
	ghc -O -o out/ebi_naif -odir out -hidir out ebi_naif.hs
	ghc -O -o out/ebi_opt -odir out -hidir out ebi_opt.hs
clean:
	rm -r out/
