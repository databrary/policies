DOCS=best-practices bill-of-rights data-sharing-manifesto definitions investigator-agmt sops release-instructions release-template
all: $(filter-out doc/release-template.docx doc/release-template.pdf,$(foreach d,$(DOCS),$(foreach e,pdf docx html shtml,doc/$d.$e)))

clean:
	rm -f doc/*

GITDATE=$(shell git log -1 --pretty=format:%ad --date=short -- $(SRCFILE))
GEN=$(subst .,-$(GITDATE).,$@)
FIXLINKS=sed 's/\.md\(\#[-a-z]*\)\?)/$(subst html,shtml,$(suffix $@))\1)/g'
PANDOCARGS_tex=-s
PANDOCMD=mkdir -p $(dir $@) ; $(FIXLINKS) $< | pandoc -f markdown_github-hard_line_breaks -V author=Databrary -V date="$(GITDATE)" -V geometry="margin=1in" $(PANDOCARGS_$(suffix $@)) -o $(GEN) && ln -sf $(notdir $(GEN)) $@

doc/%.pdf: %.md
	$(PANDOCMD)
doc/%.docx: %.md
	$(PANDOCMD)
doc/%.html: %.md
	$(PANDOCMD)
doc/%.tex: %.md
	$(PANDOCMD)
doc/%.shtml: template.shtml
	sed 's/%FILE%/$*/' $< > $@
