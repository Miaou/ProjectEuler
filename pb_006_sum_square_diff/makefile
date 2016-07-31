# Ici, les commandes à exécuter (compil/clean/timeit)

.PHONY: all build clean

TARGET = 100

all: build
	out/ebi_naif $(TARGET)
	out/ebi_opt $(TARGET)
build:
	mkdir -p out/
	ghc -O -o out/ebi_naif -outputdir out -main-is MainEBINaif ebi_naif.hs
	ghc -O -o out/ebi_opt -outputdir out -main-is MainEBIOpt ebi_opt.hs
clean:
	rm -r out/

all_ocaml: clean_ocaml build_ocaml

build_ocaml:
	ocamlopt -o vla_solution vla_solution.ml

clean_ocaml:
	rm vla_solution.cm* vla_solution.o

