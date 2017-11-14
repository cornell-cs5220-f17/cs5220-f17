TEXINPUTS:=.:/Users/dbindel/work/class/arch/cs5220-f15/lecture/2015-11-05/

LEC=\
	pdf/2017-08-22-slides.pdf \
	pdf/2017-08-24-notes.pdf \
	pdf/2017-08-24-slides.pdf \
	pdf/2017-08-29-slides.pdf \
	pdf/2017-08-31-slides.pdf \
	pdf/2017-09-07-slides.pdf \
	pdf/2017-09-12-slides.pdf \
	pdf/2017-09-14-slides.pdf \
	pdf/2017-09-19-slides.pdf \
	pdf/2017-09-21-slides.pdf \
	pdf/2017-09-26-slides.pdf \
	pdf/2017-09-28-slides.pdf \
	pdf/2017-10-03-slides.pdf \
	notes/2017-10-05-notes.md \
	pdf/2017-10-12-slides.pdf \
	pdf/2017-10-17-slides.pdf \
	pdf/2017-10-19-slides.pdf \
	pdf/2017-10-24-slides.pdf \
	pdf/2017-10-26-slides.pdf \
	pdf/2017-11-07-slides.pdf \
	pdf/2017-11-09-slides.pdf \
	pdf/2017-11-14-slides.pdf

.PHONY: all copy
all: $(LEC)

pdf/%.pdf: notes/%.tex
	xelatex -output-dir pdf $<
	xelatex -output-dir pdf $<

pdf/%.pdf: slides/%.tex
	xelatex -output-dir pdf $<
	xelatex -output-dir pdf $<

clean:
	rm -f pdf/*.aux pdf/*.log pdf/*.out
	rm -f pdf/*.nav pdf/*.snm pdf/*.toc 
	rm -f pdf/*.vrb

distclean: clean
	rm -f pdf/*.pdf

copy:
	mkdir -p ../web/lec
	cp $(LEC) ../web/lec
