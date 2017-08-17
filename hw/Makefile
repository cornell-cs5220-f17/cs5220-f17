HW_FILES=\
	hw0.txt

.PHONY: all clean distclean copy
all: $(HW_FILES)

clean:

distclean: clean
	rm -f hw*.pdf proj*.pdf

copy: $(PDFS)
	mkdir -p ../web/hw
	cp $(HW_FILES) ../web/hw

%.pdf: %.tex common.tex
	pdflatex $<
	pdflatex $<


