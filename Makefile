DOCS=irb-application work-with-irb agreement agreement-annex-I agreement-annex-II agreement-annex-III staff-release staff-agreement agreement-revision best-practices bill-of-rights data-sharing-manifesto definitions standard-operating-procedures release-template dmp-template terms privacy
all: $(foreach d,$(DOCS),$(foreach e,pdf docx html shtml,doc/$d.$e))

clean:
	rm -f doc/*

GITDATE=$(shell git log -1 --pretty=format:%ad --date=short -- $<)
GEN=$(subst .,-$(GITDATE).,$@)
FIXLINKS=sed 's!(\([-a-z]*\)\.md\(\#[-a-z]*\)\?)!(http://databrary.org/user-guide/policies/\1.html\2)!g'
LINK=ln -sf $(notdir $(GEN)) $@
PANDOCARGS_.tex=-s
PANDOCMD=mkdir -p $(dir $@) ; $(FIXLINKS) $< | pandoc -f markdown_github-hard_line_breaks+markdown_in_html_blocks+raw_tex --email-obfuscation=none -V author=Databrary -V date="$(GITDATE)" -V geometry="margin=.75in" -V links-as-notes $(PANDOCARGS_$(suffix $@)) -o $(GEN)

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
