<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml"/>
    <xsl:strip-space elements="*"/>


    <xsl:template match="ID">
        <xsl:variable name="elem"><xsl:apply-templates select="@val"/></xsl:variable>
        <xsl:element name="{$elem}">
            <xsl:attribute name="baseType">xsd:integer</xsl:attribute>
            <xsl:attribute name="structure">field</xsl:attribute>
            <xsl:attribute name="type">USAmountType</xsl:attribute>
        </xsl:element>
    </xsl:template>


    <xsl:template match="Literal">
        <xsl:variable name="elem">CONSTANT_<xsl:value-of select="@val"/></xsl:variable>
        <xsl:element name="{$elem}">
            <xsl:attribute name="baseType">xsd:integer</xsl:attribute>
            <xsl:attribute name="structure">field</xsl:attribute>
            <xsl:attribute name="type">USAmountType</xsl:attribute>
        </xsl:element>
    </xsl:template>

    <xsl:template match="/">
        <Return structure="group">
            <Header structure="group"/>
            <Data structure="group">
                <xsl:variable name="formset">FORMSET_<xsl:value-of select="/CALC/FORMSET/@val"/></xsl:variable>
                <xsl:element name="{$formset}">
                    <xsl:attribute name="structure">group</xsl:attribute>
                    <xsl:variable name="form">FORM_<xsl:value-of select="/CALC/FORMSET/FORM/@val"/></xsl:variable>
                    <xsl:element name="{$form}">
                        <xsl:attribute name="structure">form</xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:element>
            </Data>
        </Return>
    </xsl:template>
</xsl:stylesheet>