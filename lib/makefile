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


include setup.mk

all: build $(HS_EXE_CALLS)

build: build_outdir $(HS_EXES)

build_outdir:
	@mkdir -p $(OBJDIR)

clean:
	rm -r out/

# Règles Haskell
$(OBJDIR)/hs_%: %.hs
	ghc -O -o $@ -outputdir $(OBJDIR) -main-is $(shell cat $< | grep '^module' | sed 's/^.*module\s\+\(.*\)\s\+where.*$$/\1/') $(HS_UTILS) $<

EXE/hs_%:
	$(OBJDIR)/hs_$* $(ARGS)

