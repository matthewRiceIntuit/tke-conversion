<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:strip-space elements="*" />
    <xsl:template match="Versions"/>


    <xsl:template match="/">
        {
            <xsl:apply-templates />
        }
    </xsl:template>

    <xsl:template match="Mapping">
        '<xsl:value-of select="../@corecopy"/>.<xsl:value-of select="@corecopy"/>':'<xsl:value-of select="../@xpath"/>/<xsl:value-of select="@xpath"/>',
    </xsl:template>

    <xsl:template match="MapValueToAddress">
        '<xsl:value-of select="../@corecopy"/>.<xsl:value-of select="Map[1]/@corecopy"/>':'<xsl:value-of select="../@xpath"/>/<xsl:value-of select="@xpath"/>',
    </xsl:template>

</xsl:stylesheet>
