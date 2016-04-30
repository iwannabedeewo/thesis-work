<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns="http://www.w3.org/TR/xhtml1/strict">
    
  <xsl:output method="html" indent="yes" omit-xml-declaration="yes" encoding="utf-8"/>

  <xsl:template match="/">
  <html>
    <head>
      <title>Silo lists</title>
    </head>
    <body>
      <xsl:apply-templates select="/root/configuration/devices"/>
    </body>
  </html>
  </xsl:template>

  <xsl:template match="devices">
    <table>
    <xsl:apply-templates select="silo"/>
    </table>

<!--     <xsl:text> -->
<!--      <p>summa: -->
<!--      <xsl:value-of select="count(silo)"/> -->
<!--      </p> -->
<!--     </xsl:text> -->
    
  </xsl:template>

  <xsl:template match="silo">
    <tr>
      <td>
	<xsl:copy>
	  <xsl:text>name:</xsl:text>
	  <xsl:value-of select="@name"/>
	  <xsl:text> plcIndex:</xsl:text>
	  <xsl:value-of select="@plcIndex"/>
	</xsl:copy>
      </td>
    </tr>
  </xsl:template>

</xsl:stylesheet>
