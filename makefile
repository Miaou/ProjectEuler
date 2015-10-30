# Ici, les commandes à exécuter (compil/clean/timeit)

PB7 = pb7_nth_prime/


.PHONY: pb7-build
pb7-build:
	gcc -O2 -o $(PB7)pab_naif $(PB7)pab_naif.c -lm
	gcc -O2 -o $(PB7)pab_crible $(PB7)pab_crible.c -lm
pb7-run: pb7-build
	python3 $(PB7)pab_naif.py 100001
	time -p $(PB7)pab_naif 100001
	time -p $(PB7)pab_crible 100001
