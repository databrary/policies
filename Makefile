all: pdf docx html

ALL=\
    sops \
    investigator-agmt \
    $(foreach share,share share-health, \
	    $(foreach age,adult child minor12-17, \
		databrary-permission-to-$(share)-$(age) \
	    ) \
	    databrary-assent-to-$(share)-child-script \
    )

md: $(ALL:=.md)
pdf: $(ALL:%=doc/%.pdf)
docx: $(ALL:%=doc/%.docx)
html: $(ALL:%=doc/%.html)
clean:
	rm -f doc/*

SRCFILE=$(if $(filter databrary-permission-to-share-%.md,$<),permission-to-share.md.m4, \
	$(if $(filter databrary-assent-to-share-%child-script.md,$<),assent-to-share-child-script.md.m4,$<))
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

databrary-permission-to-share-%.md: SHARE.m4 permission-to-share.md
	m4 -DTYPE=$* $^ > $@

databrary-permission-to-share-health-%.md: SHARE.m4 permission-to-share.md
	m4 -DTYPE=$* -DHEALTH $^ > $@

databrary-assent-to-share-%-script.md: SHARE.m4 assent-to-share-script.md
	m4 -DTYPE=$* $^ > $@

databrary-assent-to-share-health-%-script.md: SHARE.m4 assent-to-share-script.md
	m4 -DTYPE=$* -DHEALTH $^ > $@
