<?xml version="1.0"?>
<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xi="http://www.w3.org/2001/XInclude"
 version="1.0">

 <xsl:output method="text"/>
 <xsl:param name="target"/>
 <xsl:param name="base"/>

 <xsl:template match="xi:include">
  <xsl:text> \&#x0a;</xsl:text>
  <xsl:text>&#x09;</xsl:text>
  <xsl:value-of select="@href"/>
 </xsl:template>

 <xsl:template match="/">
  <xsl:value-of select="$target"/>
  <xsl:text>: </xsl:text>
  <xsl:value-of select="$base"/>
  <xsl:apply-templates select="//xi:include"/>
  <xsl:text>&#x0a;</xsl:text>
 </xsl:template>

</xsl:stylesheet>
