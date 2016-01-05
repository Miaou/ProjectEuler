# Ici, les commandes à exécuter (compil/clean/timeit)

.PHONY: all build clean

all: build
	python3 pab_naif.py 100001
	out/pab_naif.cython 100001
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
	java out.ebi_all Naive     100001
	java out.ebi_all NaiveOpt  100001
	java out.ebi_all BiteSet   100001
	java out.ebi_all BoolList  100001
	java out.ebi_all BoolArray 100001
	java out.ebi_all ByteArray 100001
build:
	mkdir -p out/
	gcc -O2 -o out/pab_naif pab_naif.c -lm
	gcc -O2 -o out/pab_opt -DOPTIM pab_naif.c -lm
	gcc -O2 -o out/pab_crible pab_crible.c -lm
	nasm -f elf64 -o out/pab_naif_x64.o pab_naif_x64.asm
	gcc -o out/pab_naif_x64 out/pab_naif_x64.o
	ghc -O2 -o out/pab_multi_hs -outputdir out pab_multi.hs
	ocamlopt -o out/mar_naif mar_naif.ml
	rm mar_naif.cmi mar_naif.cmx mar_naif.o
	javac -d . ebi_all.java
	cython -o out/pab_naif_cython.c --embed pab_naif.pyx
	gcc -O2 -o out/pab_naif.cython -I /usr/include/python3.4 out/pab_naif_cython.c -lpython3.4m -lm
clean:
	rm -r out/
