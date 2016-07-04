# Ici, les commandes à exécuter (compil/clean/timeit)

.PHONY: all build clean

TARGET = 3

all: build
	java out.ebi_naive $(TARGET)
build:
	mkdir -p out/
	javac -d . ebi_naive.java
clean:
	rm -r out/
