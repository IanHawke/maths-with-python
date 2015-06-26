Testing.pdf: Testing.tex
	pdflatex Testing.tex
	pdflatex Testing.tex
Testing.tex: Testing.ipynb article-mod.tplx
	ipython nbconvert --to latex --template=article-mod.tplx Testing.ipynb
#Testing.tex: Testing.md listings-setup.tex
#	pandoc Testing.md --listings -H listings-setup.tex --to latex -o Testing.tex

%.pdf: %.tex %.ipynb
	pdflatex $<
	pdflatex $<

%.tex: %.ipynb article-mod.tplx
	ipython nbconvert --to latex --template=article-mod.tplx $<

clean:
	rm *.{out,log,aux}
	rm -rf auto
