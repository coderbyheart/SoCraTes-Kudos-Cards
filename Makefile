SHELL:=/bin/bash -O globstar
SVGS := $(wildcard *.svg)

all: pdf png export/all_kudos_kards.pdf

.PHONY: clean
clean:
	-mkdir export
	-rm export/*

pdf: 
	for FILE in ${SVGS}; do $(MAKE) export/$${FILE%"svg"}pdf ; done
png: 
	for FILE in ${SVGS}; do $(MAKE) export/$${FILE%"svg"}png ; done

export/all_kudos_kards.pdf: $(foreach card,$(SVGS),export/$(card:svg=pdf))
	pdftk $^ cat output "$@"

export/%.pdf: %.svg
	inkscape --batch-process --export-dpi=300 --export-text-to-path --export-type=pdf --export-filename="$@" $<

export/%.png: %.svg
	inkscape --export-background=white --export-dpi=300 --export-type=png --export-filename="$@" $<
