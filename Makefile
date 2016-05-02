
stylesheet = stylesheets/fo.xsl
obj = bringup-guide

dtd_version = 4
dtd = /usr/share/xml/docbook/schema/dtd/$(dtd_version)/docbookx.dtd


.PHONY: all check clean

all: pdf

pdf: $(obj).pdf

-include *.d

%.pdf: %.fo
	fop -fo $^ -pdf $@

%.fo: %.xml $(stylesheet)
	xsltproc --load-trace --xinclude $(stylesheet) $< 2>&1 > $@ | \
		utils/parse-trace $*.d $@

check:
	xmllint --dtdvalid $(dtd) --nonet --xinclude --noout $(obj).xml

clean:
	rm -f *.pdf *.fo *.d
