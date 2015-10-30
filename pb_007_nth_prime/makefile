# Ici, les commandes à exécuter (compil/clean/timeit)

.PHONY: all build clean

all: build
	python3 pab_naif.py 100001
	bash -c "time out/pab_naif 100001"
	bash -c "time out/pab_opt 100001"
	bash -c "time out/pab_crible 100001"
	bash -c "time lua pab_naif.lua 100001"
	bash -c "time lua pab_opt.lua 100001"
build:
	mkdir -p out/
	gcc -O2 -o out/pab_naif pab_naif.c -lm
	gcc -O2 -o out/pab_opt -DOPTIM pab_naif.c -lm
	gcc -O2 -o out/pab_crible pab_crible.c -lm
clean:
	rm -r out/
