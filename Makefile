runipy_pdf:
	cp *.tplx nbconvert_book.sty _runipy/
	cp -r images _runipy/
	cp latex_chapter.tex FirstYearComputing_Master.tex _runipy/
	python run_notebooks.py
	make -C _runipy FirstYearComputing_Master.pdf

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

# Makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
PAPER         =
BUILDDIR      = _build

# User-friendly check for sphinx-build
ifeq ($(shell which $(SPHINXBUILD) >/dev/null 2>&1; echo $$?), 1)
$(error The '$(SPHINXBUILD)' command was not found. Make sure you have Sphinx installed, then set the SPHINXBUILD environment variable to point to the full path of the '$(SPHINXBUILD)' executable. Alternatively you can add the directory with the executable to your PATH. If you don't have Sphinx installed, grab it from http://sphinx-doc.org/)
endif

# Internal variables.
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS   = -d $(BUILDDIR)/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .
# the i18n builder cannot share the environment and doctrees with the others
I18NSPHINXOPTS  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .

html:
	$(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $(BUILDDIR)/html
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/html."

epub:
	$(SPHINXBUILD) -b epub $(ALLSPHINXOPTS) $(BUILDDIR)/epub
	@echo
	@echo "Build finished. The epub file is in $(BUILDDIR)/epub."


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
	rm -rf $(BUILDDIR)/*
	rm -f _runipy/*.{ipynb,tex,out,log,aux,toc}
	rm -rf _runipy/*_files _runipy/images _runipy/.ipynb_checkpoints
	rm -f _runipy/*.{tplx,sty}
