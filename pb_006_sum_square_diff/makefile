# Ici, les commandes à exécuter (compil/clean/timeit)

.PHONY: all build clean

TARGET = 100

all: build
	out/ebi_naif $(TARGET)
	out/ebi_opt $(TARGET)
build:
	mkdir -p out/
	ghc -O -o out/ebi_naif -outputdir out -main-is MainNaif ebi_naif.hs
	ghc -O -o out/ebi_opt -outputdir out -main-is MainOpt ebi_opt.hs
clean:
	rm -r out/
