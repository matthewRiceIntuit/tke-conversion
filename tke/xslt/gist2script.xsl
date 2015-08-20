<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>
<xsl:strip-space elements="*" />
<xsl:template match="Versions"/>
<xsl:template match="/Nodes/Node">

<xsl:for-each select="BlankCondition"><xsl:for-each select="*">if <xsl:value-of select="name()"/>( <xsl:value-of select="text()"/> ):
</xsl:for-each>
</xsl:for-each>
<xsl:value-of select="@name"/> = <xsl:value-of select="name(Gist/*)"/>(<xsl:apply-templates select="Gist/*"/><xsl:for-each select="RoundTo"><xsl:text>     </xsl:text>RoundTo=<xsl:value-of select="name(*)"/></xsl:for-each>
)
<xsl:text>

</xsl:text>
</xsl:template>
    
<xsl:template match="InputRoles">[ <xsl:for-each select="*"><xsl:value-of select="name()"/>=<xsl:value-of select="text()"/>, </xsl:for-each>],
</xsl:template>
<xsl:template match="Configuration">
    Configuration=[
<xsl:for-each select="*"><xsl:text>          </xsl:text>{'<xsl:value-of select="name()"/>':'<xsl:value-of select="text()"/>'},<xsl:text>
</xsl:text></xsl:for-each><xsl:text>     </xsl:text>],

</xsl:template>
</xsl:stylesheet>
