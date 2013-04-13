all: pdf docx

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

PANDOCMD=pandoc -f markdown_github-hard_line_breaks
GITDATE=git log --date=short --pretty=format:%ad -1 --
STAMP=ln -f $@ $(subst .,-$(shell $(GITDATE) $(if $(filter databrary-permission-to-share-%.md,$<),permission-to-share.md.m4,$<)).,$@)

doc/%.pdf: %.md
	$(PANDOCMD) -o $@ $<
	$(STAMP)
doc/%.docx: %.md
	$(PANDOCMD) -o $@ $<
	$(STAMP)
doc/%.html: %.md
	$(PANDOCMD) -o $@ $<
	$(STAMP)

databrary-permission-to-share-%.md: permission-to-share.md.m4
	m4 -DTYPE=$* $< > $@

databrary-permission-to-share-health-%.md: permission-to-share.md.m4
	m4 -DTYPE=$* -DHEALTH $< > $@
