# Ici, les commandes à exécuter (compil/clean/timeit)

.PHONY: all build clean

NB_DIGITS = 13
INPUT_FILE = input.txt

all: build
	out/ebi_naif $(INPUT_FILE) $(NB_DIGITS)
build:
	mkdir -p out/
	ghc -O -o out/ebi_naif -outputdir out -main-is EbiNaif ebi_naif.hs
clean:
	rm -r out/
