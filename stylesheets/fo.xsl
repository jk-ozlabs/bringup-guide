<?xml version="1.0"?>
<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:fo="http://www.w3.org/1999/XSL/Format"
 version="1.0">
 <xsl:output method="xml"/>

 <xsl:param name="paper.type">A4</xsl:param>

 <xsl:param name="body.start.indent">0</xsl:param>

 <!-- label all section numbers, so that we can cross-reference to specific
      sections -->
 <xsl:param name="section.autolabel">1</xsl:param>
 <xsl:param name="section.label.includes.component.label">1</xsl:param>

 <!-- Just generate a table-of-contents; we don't need table of figures,
      examples, etc -->
 <xsl:param name="generate.toc" select="'book toc,title'"/>

 <xsl:param name="callout.graphics">0</xsl:param>
 <xsl:param name="callout.unicode">1</xsl:param>

 <xsl:include
  href="/usr/share/xml/docbook/stylesheet/docbook-xsl/fo/docbook.xsl"/>

</xsl:stylesheet>