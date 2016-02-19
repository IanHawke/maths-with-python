FirstYearComputing_Master.pdf: FirstYearComputing_Master.tex \
	00-first-steps.tex 01-python-basics.tex 02-programs.tex \
	03-loops-control-flow.tex 04-basic-plotting.tex \
	05-classes-oop.tex  06-numpy-plotting.tex \
	07-sympy.tex 08-statistics.tex 09-exceptions-testing.tex \
	10-generators.tex 11-more-classes.tex latex_chapter.tex
	pdflatex $<
	pdflatex $<

FirstYearComputing_Master_xelatex.pdf: FirstYearComputing_Master_xelatex.tex \
		00-first-steps.tex 01-python-basics.tex 02-programs.tex \
		03-loops-control-flow.tex 04-basic-plotting.tex \
		05-classes-oop.tex  06-numpy-plotting.tex \
		07-sympy.tex 08-statistics.tex 09-exceptions-testing.tex \
		10-generators.tex 11-more-classes.tex latex_chapter.tex
		xelatex $<
		xelatex $<

all_html: index.html \
		00-first-steps.html 01-python-basics.html 02-programs.html \
		03-loops-control-flow.html 04-basic-plotting.html \
		05-classes-oop.html  06-numpy-plotting.html \
		07-sympy.html 08-statistics.html 09-exceptions-testing.html \
		10-generators.html 11-more-classes.html

web_html: website-index.html \
		00-first-steps.html 01-python-basics.html 02-programs.html \
		03-loops-control-flow.html 04-basic-plotting.html \
		05-classes-oop.html  06-numpy-plotting.html \
		07-sympy.html 08-statistics.html 09-exceptions-testing.html \
		10-generators.html 11-more-classes.html \
		ExercisesSolutions.html

%.pdf: %.tex %.ipynb
	pdflatex $<
	pdflatex $<

%.tex: %.ipynb chapter-base.tplx
	jupyter nbconvert --to latex --template=chapter-ipython.tplx $<

%.html: %.ipynb full-title.tpl
		jupyter nbconvert --to html --template=full-title.tpl $<

Exercises.tex: Exercises.ipynb
	jupyter nbconvert --to latex $<
ExercisesSolutions.tex: ExercisesSolutions.ipynb
	jupyter nbconvert --to latex $<

webpages: web_html
	mkdir -p webpages
	cp [01]*html ExercisesSolutions.html webpages/
	cp website-index.html webpages/index.html
	cp -r images webpages/
	ghp-import -m "Generate website" -b gh-pages webpages
	git push origin gh-pages

clean:
	rm -f *.{out,log,aux,toc}
	rm -rf auto
	rm -f [01]*tex
	rm -rf [01]*files
	rm -f Exercises*tex
	rm -rf Exercises*files
	rm -rf __pycache__
	rm -f *.html
	rm -rf webpages
