# Ici, les commandes à exécuter (compil/clean/timeit)

.PHONY: all build clean

all: build
	python3 pab_naif.py 100001
	bash -c "time out/pab_naif 100001"
	bash -c "time out/pab_opt 100001"
	bash -c "time out/pab_crible 100001"
	bash -c "time lua pab_naif.lua 100001"
	bash -c "time lua pab_opt.lua 100001"
	bash -c "time luajit pab_naif.lua 100001"
	bash -c "time luajit pab_opt.lua 100001"
	bash -c "time out/pab_naif_x64 100001"
	bash -c "time out/mar_naif 100001"
	out/pab_multi_hs 100001
build:
	mkdir -p out/
	gcc -O2 -o out/pab_naif pab_naif.c -lm
	gcc -O2 -o out/pab_opt -DOPTIM pab_naif.c -lm
	gcc -O2 -o out/pab_crible pab_crible.c -lm
	nasm -f elf64 -o out/pab_naif_x64.o pab_naif_x64.asm
	gcc -o out/pab_naif_x64 out/pab_naif_x64.o
	ocamlopt -o out/mar_naif mar_naif.ml
	rm mar_naif.cmi mar_naif.cmx mar_naif.o
	ghc -O -o out/pab_multi_hs -odir out -hidir out pab_multi.hs
clean:
	rm -r out/
