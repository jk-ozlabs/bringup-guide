<?xml version="1.0"?>
<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:fo="http://www.w3.org/1999/XSL/Format"
 xmlns:xslthl="http://xslthl.sf.net"
 version="1.0">

 <xsl:import
  href="/usr/share/xml/docbook/stylesheet/docbook-xsl/fo/highlight.xsl"/>

 <xsl:template match="xslthl:comment" mode="xslthl">
  <fo:inline color="#f000c0"><xsl:apply-templates mode="xslthl"/></fo:inline>
 </xsl:template>

 <xsl:template match="xslthl:string" mode="xslthl">
  <fo:inline color="#2020ff"><xsl:apply-templates mode="xslthl"/></fo:inline>
 </xsl:template>

 <xsl:template match="xslthl:number" mode="xslthl">
  <fo:inline color="#2020ff"><xsl:apply-templates mode="xslthl"/></fo:inline>
 </xsl:template>

 <xsl:template match="xslthl:keyword" mode="xslthl">
  <fo:inline color="#7040ff"><xsl:apply-templates mode="xslthl"/></fo:inline>
 </xsl:template>

</xsl:stylesheet>
