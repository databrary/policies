PANDOCMD=pandoc -f markdown_github-hard_line_breaks
doc/%.pdf doc/%.docx doc/%.html: %.md
	mkdir -p $(dir $@)
	$(PANDOCMD) -o $@ $<
