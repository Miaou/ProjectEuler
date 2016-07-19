# Ici, les commandes à exécuter (compil/clean/timeit)

.PHONY: all build clean

TARGET = 600851475143

all: build
	java out.ebi_naive $(TARGET)
	out/mar_ocaml $(TARGET)
	out/jal_c $(TARGET)
	rm -rf mar_ocaml.cmi mar_ocaml.cmx mar_ocaml.o
build:
	mkdir -p out/
	javac -d . ebi_naive.java
	ocamlopt mar_ocaml.ml -o out/mar_ocaml
	gcc -O2 -o out/jal_c jal_naive.c -lm
clean:
	rm -r out/
