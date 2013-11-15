all:

clean:
	rm -f doc/*

GITDATE=$(shell git log -1 --pretty=format:%ad --date=short -- $(SRCFILE))
PANDOCMD=pandoc -f markdown_github-hard_line_breaks -V author=Databrary -V date="$(GITDATE)" -V geometry="margin=1in"
GEN=$(subst .,-$(GITDATE).,$@)

doc/%.pdf: %.md
	$(PANDOCMD) -o $(GEN) $<
	ln -s $(notdir $(GEN)) $@
doc/%.docx: %.md
	$(PANDOCMD) -o $(GEN) $<
	ln -s $(notdir $(GEN)) $@
doc/%.html: %.md
	$(PANDOCMD) -o $(GEN) $<
	ln -s $(notdir $(GEN)) $@
