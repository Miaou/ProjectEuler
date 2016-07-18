# Ici, les commandes à exécuter (compil/clean/timeit)

.PHONY: all clean

OBJDIR = out
LIBDIR = ../lib

# Haskell configuration
HS_SRC_FILES := $(wildcard *.hs)
HS_EXES := $(patsubst %.hs, $(OBJDIR)/% ,$(HS_SRC_FILES))
HS_UTILS := $(LIBDIR)/utils.hs

include setup.mk

all: build
	out/ebi_naif $(ARGS)

build: build_outdir $(HS_EXES)

build_outdir:
	mkdir -p $(OBJDIR)

$(OBJDIR)/% : %.hs
	ghc -O -o $@ -outputdir $(OBJDIR) -main-is $(shell cat $< | grep '^module' | sed 's/^.*module\s\+\(.*\)\s\+where.*$$/\1/') -isrc $(HS_UTILS) $<

clean:
	rm -r out/

