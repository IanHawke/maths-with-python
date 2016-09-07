FirstYearComputing_Master.pdf: FirstYearComputing_Master.tex \
	00-first-steps.tex 01-python-basics.tex 02-programs.tex \
	03-loops-control-flow.tex 04-basic-plotting.tex \
	05-classes-oop.tex  06-numpy-plotting.tex \
	07-sympy.tex 08-statistics.tex 09-exceptions-testing.tex \
	10-generators.tex 11-more-classes.tex latex_chapter.tex
	pdflatex $<
	pdflatex $<

%.pdf: %.tex %.ipynb
	pdflatex $<
	pdflatex $<

%.tex: %.ipynb chapter-base.tplx
	jupyter nbconvert --to latex --template=chapter-ipython.tplx $<
