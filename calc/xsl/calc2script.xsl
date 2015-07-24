<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:strip-space elements="*" />
    <xsl:template match="Versions"/>


<xsl:template match="/">
    [
    <xsl:apply-templates />
    ]
</xsl:template>

<xsl:template match="Call[@val='HasValue']|Call[@val='IsChecked']">
    {"<xsl:value-of select="ArgList/VarRef/ID/@val"/>___IsNotBlank = IsNotBlank":{"inputs":["<xsl:value-of select="ArgList/VarRef/ID/@val"/>",]}},
</xsl:template>

<xsl:template match="IfStruct">
    {"IsCondition<xsl:value-of select="position()"/> = AllConditionsTrue":{"inputs":["<xsl:value-of select="ArgList/VarRef/ID/@val"/>",]}},
    <xsl:apply-templates/>
</xsl:template>
</xsl:stylesheet>
