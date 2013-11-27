DOCS=best-practices bill-of-rights data-sharing-manifesto definitions investigator-agmt sops
all: $(foreach d,$(DOCS),doc/$d.pdf doc/$d.docx doc/$d.html)

clean:
	rm -f doc/*

GITDATE=$(shell git log -1 --pretty=format:%ad --date=short -- $(SRCFILE))
GEN=$(subst .,-$(GITDATE).,$@)
FIXLINKS=sed 's/\.md)/$(suffix $@))/g'
PANDOCMD=$(FIXLINKS) $< | pandoc -f markdown_github-hard_line_breaks -V author=Databrary -V date="$(GITDATE)" -V geometry="margin=1in" -o $(GEN)

doc/%.pdf: %.md
	$(PANDOCMD)
	ln -sf $(notdir $(GEN)) $@
doc/%.docx: %.md
	$(PANDOCMD)
	ln -sf $(notdir $(GEN)) $@
doc/%.html: %.md
	$(PANDOCMD)
	ln -sf $(notdir $(GEN)) $@
