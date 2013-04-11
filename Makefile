ALL=sops investigator-agmt 

all: $(foreach d,$(ALL),doc/$(d).pdf doc/$(d).docx)

PANDOCMD=pandoc -f markdown_github-hard_line_breaks
GITDATE=git log --date=short --pretty=format:%ad -1 --
STAMP=ln -f $@ $(subst .,-$(shell $(GITDATE) $<).,$@)
doc/%.pdf: %.md doc
	$(PANDOCMD) -o $@ $<
	$(STAMP)
doc/%.docx: %.md doc
	$(PANDOCMD) -o $@ $<
	$(STAMP)
doc/%.html: %.md doc
	$(PANDOCMD) -o $@ $<
	$(STAMP)
doc:
	mkdir -p doc
