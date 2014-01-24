DOCS=best-practices bill-of-rights data-sharing-manifesto definitions investigator-agreement standard-operating-proceedures release-instructions release-template
all: $(foreach d,$(DOCS),$(foreach e,pdf docx html shtml,doc/$d.$e))

clean:
	rm -f doc/*

GITDATE=$(shell git log -1 --pretty=format:%ad --date=short -- $<)
GEN=$(subst .,-$(GITDATE).,$@)
FIXLINKS=sed 's/\.md\(\#[-a-z]*\)\?)/$(subst html,shtml,$(suffix $@))\1)/g'
LINK=ln -sf $(notdir $(GEN)) $@
PANDOCARGS_tex=-s
PANDOCMD=mkdir -p $(dir $@) ; $(FIXLINKS) $< | pandoc -f markdown_github-hard_line_breaks -V author=Databrary -V date="$(GITDATE)" -V geometry="margin=1in" $(PANDOCARGS_$(suffix $@)) -o $(GEN)

doc/release-template.pdf: release-template.pdf
	ln $< $(GEN)
	$(LINK)
doc/release-template.docx: release-template.docx
	ln $< $(GEN)
	$(LINK)
doc/%.pdf: %.md
	$(PANDOCMD)
	$(LINK)
doc/%.docx: %.md
	$(PANDOCMD)
	$(LINK)
doc/%.html: %.md
	$(PANDOCMD)
	$(LINK)
doc/%.tex: %.md
	$(PANDOCMD)
	$(LINK)
doc/%.shtml: template.shtml
	sed 's/%FILE%/$*/g' $< > $@
