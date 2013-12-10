DOCS=best-practices bill-of-rights data-sharing-manifesto definitions investigator-agmt sops sharing-release-instructions
all: $(foreach d,$(DOCS),doc/$d.pdf doc/$d.docx doc/$d.html)

clean:
	rm -f doc/*

GITDATE=$(shell git log -1 --pretty=format:%ad --date=short -- $(SRCFILE))
GEN=$(subst .,-$(GITDATE).,$@)
FIXLINKS=sed 's/\.md)/$(suffix $@))/g'
PANDOCMD=mkdir -p $(dir $@) ; $(FIXLINKS) $< | pandoc -f markdown_github-hard_line_breaks -V author=Databrary -V date="$(GITDATE)" -V geometry="margin=1in" -o $(GEN) && ln -sf $(notdir $(GEN)) $@

doc/%.pdf: %.md
	$(PANDOCMD)
doc/%.docx: %.md
	$(PANDOCMD)
doc/%.html: %.md
	$(PANDOCMD)
doc/%.tex: %.md
	$(PANDOCMD)
