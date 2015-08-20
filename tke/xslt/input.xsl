<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml"/>
    <xsl:strip-space elements="*" />


    <xsl:template match="ID">
                <xsl:variable name="elem"><xsl:apply-templates select="@val"/></xsl:variable>
                <xsl:element name="{$elem}">99</xsl:element>
    </xsl:template>


    <xsl:template match="Literal">
                <xsl:variable name="elem">CONSTANT_<xsl:value-of select="@val"/></xsl:variable>
                <xsl:element name="{$elem}"><xsl:value-of select="@val"/></xsl:element>
    </xsl:template>

    <xsl:template match="/">
        <Return>
            <Data>
                <xsl:variable name="formset">FORMSET_<xsl:value-of select="/CALC/FORMSET/@val"/></xsl:variable>
                <xsl:element name="{$formset}">
                    <xsl:variable name="form">FORM_<xsl:value-of select="/CALC/FORMSET/FORM/@val"/></xsl:variable>
                    <xsl:element name="{$form}"><xsl:apply-templates/></xsl:element>
                </xsl:element>
            </Data>
        </Return>
    </xsl:template>
</xsl:stylesheet>