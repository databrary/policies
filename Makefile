ALL=\
    sops \
    investigator-agmt \
    $(foreach share,share share-health, \
	    $(foreach age,adult child minor12-17, \
		databrary-permission-to-$(share)-$(age) \
	    ) \
	    databrary-assent-to-$(share)-child-script \
    )

all: $(foreach d,$(ALL),doc/$(d).pdf doc/$(d).docx)

PANDOCMD=pandoc -f markdown_github-hard_line_breaks
GITDATE=git log --date=short --pretty=format:%ad -1 --
STAMP=ln -f $@ $(subst .,-$(shell $(GITDATE) $<).,$@)
doc/%.pdf: %.md
	$(PANDOCMD) -o $@ $<
	$(STAMP)
doc/%.docx: %.md
	$(PANDOCMD) -o $@ $<
	$(STAMP)
doc/%.html: %.md
	$(PANDOCMD) -o $@ $<
	$(STAMP)
