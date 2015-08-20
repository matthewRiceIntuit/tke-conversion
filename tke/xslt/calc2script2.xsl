<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


    <xsl:output method="xml" encoding="utf-8" indent="yes"/>

    <!-- Identity template : copy all text nodes, elements and attributes -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>

    <!-- When matching DataSeriesBodyType: do nothing -->
    <xsl:template match="Assign[substring(INPUT,1,1)='#' or substring(ID,1,1)='#']" >
        <DEPRECATE>
            <xsl:copy-of select="@*|node()" />
        </DEPRECATE>
    </xsl:template>
    <xsl:template match="INPUT[substring(.,1,1)='#']" ><INPUT><xsl:variable name="id" select="."/><xsl:value-of select="//INPUT[text()=$id]/../ID"/></INPUT></xsl:template>
    <xsl:template match="ID[substring(.,1,1)='#']" ><ID><xsl:variable name="id" select="."/><xsl:value-of select="//Assign[INPUT/text()=$id]/ID"/></ID></xsl:template>

</xsl:stylesheet>