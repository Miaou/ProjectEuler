# Ici, les commandes à exécuter (compil/clean/timeit)
# On a une configuration par langage, all appelant tous les builds de tous les langages et tous les exes...

.PHONY: all clean

OBJDIR = out
LIBDIR = ../lib

# Haskell configuration
HS_SRC_FILES := $(wildcard *.hs)
HS_EXES := $(patsubst %.hs, $(OBJDIR)/hs_%, $(HS_SRC_FILES))
HS_UTILS := $(LIBDIR)/utils.hs
HS_EXE_CALLS := $(patsubst %.hs, EXE/hs_%, $(HS_SRC_FILES))

# OCaml configuration
ML_SRC_FILES := $(wildcard *.ml)
ML_EXES := $(patsubst %.ml, $(OBJDIR)/ml_%, $(ML_SRC_FILES))
ML_UTILS :=
ML_EXE_CALLS := $(patsubst %.ml, EXE/ml_%, $(ML_SRC_FILES))

# Java configuration
JAVA_SRC_FILES := $(wildcard *.java)
JAVA_EXES := $(patsubst %.java, $(OBJDIR)/%.class, $(JAVA_SRC_FILES))
JAVA_UTILS := $(LIBDIR)/utils.java
JAVA_EXE_CALLS := $(patsubst %.java, EXE/java_%, $(JAVA_SRC_FILES))

# Rust configuration
RUST_SRC_FILES := $(wildcard *.rs)
RUST_EXES := $(patsubst %.rs, $(OBJDIR)/rust_%, $(RUST_SRC_FILES))
RUST_UTILS :=
RUST_EXE_CALLS := $(patsubst %.rs, EXE/rust_%, $(RUST_SRC_FILES))


include setup.mk

all: build $(HS_EXE_CALLS) $(ML_EXE_CALLS) $(JAVA_EXE_CALLS) $(RUST_EXE_CALLS)

build: build_outdir $(HS_EXES) $(ML_EXES) $(JAVA_EXES) $(RUST_EXES)

build_outdir:
	@mkdir -p $(OBJDIR)

clean:
	rm -rf out/

# Règles Haskell
$(OBJDIR)/hs_%: %.hs
	ghc -O -o $@ -outputdir $(OBJDIR) -main-is $(shell cat $< | grep '^module' | sed 's/^.*module\s\+\(.*\)\s\+where.*$$/\1/') $(HS_UTILS) $<

EXE/hs_%:
	$(OBJDIR)/hs_$* $(ARGS)

# Règles OCaml
$(OBJDIR)/ml_%: %.ml
	ocamlopt $< -o $@
	rm -rf $*.cmi $*.cmx $*.o

EXE/ml_%: %.ml
	$(OBJDIR)/ml_$* $(ARGS)

# Règles Java
$(OBJDIR)/%.class: %.java
	javac -d . $< $(JAVA_UTILS)

EXE/java_%: %.java
	java $(OBJDIR).$* $(ARGS)

# Règles Rust
$(OBJDIR)/rust_%: %.rs
	rustc -O -o $@ $<

EXE/rust_%: %.rs
	$(OBJDIR)/rust_$* $(ARGS)
