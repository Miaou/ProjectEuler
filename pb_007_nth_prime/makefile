# Ici, les commandes à exécuter (compil/clean/timeit)

.PHONY: all build clean

TARGET = 100001

all: build
	python3 pab_multi.py $(TARGET)
	out/pab_naif.cython $(TARGET)
	bash -c "time out/pab_naif $(TARGET)"
	bash -c "time out/pab_opt $(TARGET)"
	bash -c "time out/pab_crible $(TARGET)"
	bash -c "time lua pab_naif.lua $(TARGET)"
	bash -c "time lua pab_opt.lua $(TARGET)"
	bash -c "time luajit pab_naif.lua $(TARGET)"
	bash -c "time luajit pab_opt.lua $(TARGET)"
	bash -c "time out/pab_naif_x64 $(TARGET)"
	bash -c "time out/mar_naif $(TARGET)"
	out/pab_multi_hs $(TARGET)
	java out.ebi_all Naive     $(TARGET)
	java out.ebi_all NaiveOpt  $(TARGET)
	java out.ebi_all BiteSet   $(TARGET)
	java out.ebi_all BoolList  $(TARGET)
	java out.ebi_all BoolArray $(TARGET)
	java out.ebi_all ByteArray $(TARGET)
build:
	mkdir -p out/
	gcc -O2 -o out/pab_naif pab_naif.c -lm
	gcc -O2 -o out/pab_opt -DOPTIM pab_naif.c -lm
	gcc -O2 -o out/pab_crible pab_crible.c -lm
	nasm -f elf64 -o out/pab_naif_x64.o pab_naif_x64.asm
	gcc -o out/pab_naif_x64 out/pab_naif_x64.o
	ghc -O2 -o out/pab_multi_hs -outputdir out -main-is MainPAB pab_multi.hs
	ocamlopt -o out/mar_naif mar_naif.ml
	rm mar_naif.cmi mar_naif.cmx mar_naif.o
	javac -d . ebi_all.java
	cython -o out/pab_naif_cython.c --embed pab_naif.pyx
	gcc -O2 -o out/pab_naif.cython -I /usr/include/python3.4 out/pab_naif_cython.c -lpython3.4m -lm
clean:
	rm -r out/
