PDFS=

.PHONY: all clean distclean copy
all: $(PDFS)

clean:

distclean: clean
	rm -f hw*.pdf proj*.pdf

copy: $(PDFS)
	mkdir -p ../web/hw
#	cp $(PDFS) ../web/hw

%.pdf: %.tex common.tex
	pdflatex $<
	pdflatex $<


