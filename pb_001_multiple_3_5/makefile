# Ici, les commandes à exécuter (compil/clean/timeit)

.PHONY: all build clean

TARGET = 1000

all: build
	out/ebi_solution $(TARGET)
build:
	mkdir -p out/
	ghc -O -o out/ebi_solution -odir out -hidir out ebi_solution.hs
clean:
	rm -r out/
