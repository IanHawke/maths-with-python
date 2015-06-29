FirstYearComputing_Master.pdf: FirstYearComputing_Master.tex \
	00-first-steps.tex 01-python-basics.tex 02-programs.tex \
	03-loops-control-flow.tex 04-basic-plotting.tex \
	05-classes-oop.tex 06-exceptions-debugging-testing.tex 07-numpy-plotting.tex \
	08-sympy.tex
	pdflatex $<
	pdflatex $<



%.pdf: %.tex %.ipynb
	pdflatex $<
	pdflatex $<

%.tex: %.ipynb chapter-base.tplx
	ipython nbconvert --to latex --template=chapter-base.tplx $<

clean:
	rm *.{out,log,aux}
	rm -rf auto
