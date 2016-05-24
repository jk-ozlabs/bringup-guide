
stylesheet = stylesheets/fo.xsl
java_libdir=/usr/share/java
xml_dir=/usr/share/xml
obj = bringup-guide

docbook_version = 5.0
docbook_schema = $(xml_dir)/docbook/schema/rng/$(docbook_version)/docbook.rng

.PHONY: all check clean

all: pdf

pdf: $(obj).pdf

-include *.d

%.pdf: %.fo
	fop -fo $^ -pdf $@

%.fo: %.xml $(stylesheet)
	java -cp "$(java_libdir)/saxon.jar:$(java_libdir)/xercesImpl.jar:$(java_libdir)/xslthl.jar" \
		-Dxslthl.config=file://$(xml_dir)/docbook/stylesheet/docbook-xsl/highlighting/xslthl-config.xml \
		-Djavax.xml.parsers.DocumentBuilderFactory=org.apache.xerces.jaxp.DocumentBuilderFactoryImpl \
		-Djavax.xml.parsers.SAXParserFactory=org.apache.xerces.jaxp.SAXParserFactoryImpl \
		-Dorg.apache.xerces.xni.parser.XMLParserConfiguration=org.apache.xerces.parsers.XIncludeParserConfiguration \
		com.icl.saxon.StyleSheet \
		-o $@ $< $(stylesheet)

check:
	xmllint --relaxng $(docbook_schema) --nonet --xinclude --noout $(obj).xml

clean:
	rm -f *.pdf *.fo *.d
