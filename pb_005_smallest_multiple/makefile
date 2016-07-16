# Ici, les commandes à exécuter (compil/clean/timeit)

.PHONY: all build clean

TARGET = 20

all: build
	bash -c "time out/ebi_smart $(TARGET)"
build:
	mkdir -p out/
	gcc -O2 -o out/ebi_smart ebi_smart.c -lm
clean:
	rm -r out/
