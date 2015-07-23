<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml"/>
    <xsl:strip-space elements="*" />
    <xsl:template match="//Section">
        <Nodes
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:noNamespaceSchemaLocation="TKE_Calc_Graph.xsd" >
            <xsl:attribute name="topic">
                <xsl:value-of select="@val"/>
            </xsl:attribute>
            <Versions>
                <Version id="TKE.Calc.Runtime">1</Version>
                <Version id="TKE.Calc.FileFormat">1</Version>
                <Version id="TKE.Gist">1</Version>
                <Version id="TKE.MeF">1</Version>
            </Versions>
            <xsl:apply-templates select="//Assign">
                <xsl:with-param name="section"><xsl:value-of select="@val"/></xsl:with-param>
                <xsl:with-param name="form">FORMSET_<xsl:value-of select="/CALC/FORMSET/@val"/>/FORM_<xsl:value-of select="/CALC/FORMSET/FORM/@val"/></xsl:with-param>
            </xsl:apply-templates>

            <xsl:comment>
               INPUTS
            </xsl:comment>

            <xsl:for-each select="//VarRef">
                <Node type="input">
                    <xsl:attribute name="name">/Return/Data/FORMSET_<xsl:value-of select="/CALC/FORMSET/@val"/>/FORM_<xsl:value-of select="/CALC/FORMSET/FORM/@val"/>/<xsl:apply-templates/></xsl:attribute>
                    <RoundTo>
                        <Dollars/>
                    </RoundTo>
                </Node>
            </xsl:for-each>

            <xsl:comment>
                CONSTANTS
            </xsl:comment>

            <xsl:for-each select="//Literal">
                <Node type="input">
                    <xsl:attribute name="name">/Return/Data/FORMSET_<xsl:value-of select="/CALC/FORMSET/@val"/>/FORM_<xsl:value-of select="/CALC/FORMSET/FORM/@val"/>/CONSTANT_<xsl:value-of select="@val"/></xsl:attribute>
                    <RoundTo>
                        <Dollars/>
                    </RoundTo>
                </Node>
            </xsl:for-each>


        </Nodes>

    </xsl:template>

    <xsl:template match="ID"><xsl:value-of select="@val"/></xsl:template>
    <xsl:template match="Literal">CONSTANT_<xsl:value-of select="@val"/></xsl:template>


    <xsl:template match="Assign">
        <xsl:param name="section" />
        <xsl:param name="form" />

        <xsl:comment>

            ASSIGNMENT



        </xsl:comment>
        <Node >
            <xsl:attribute name="name">/Return/Data/<xsl:value-of select="$form" />/<xsl:value-of select="ID/@val"/></xsl:attribute>

        <xsl:apply-templates select="PercentageOf|Accumulate">
            <xsl:with-param name="form"><xsl:value-of select="$form"/></xsl:with-param>
        </xsl:apply-templates>
            <RoundTo><Dollars/></RoundTo>
        </Node>
    </xsl:template>


    <xsl:template match="PercentageOf">
        <xsl:param name="form" />
        <Inputs>
                <Input>/Return/Data/<xsl:value-of select="$form" />/<xsl:apply-templates select="*[1]"/></Input>
                <Input>/Return/Data/<xsl:value-of select="$form" />/<xsl:apply-templates select="*[2]"/></Input>
            </Inputs>
            <Gist>
                <PercentageOf>
                    <Value>/Return/Data/<xsl:value-of select="$form" />/<xsl:apply-templates select="*[1]"/></Value>
                    <Percentage>/Return/Data/<xsl:value-of select="$form" />/<xsl:apply-templates select="*[2]"/></Percentage>

                    <ValueType>price</ValueType>
                    <OutputType>rebate</OutputType>
                </PercentageOf>
            </Gist>


    </xsl:template>

    <xsl:template match="Accumulate">
        <xsl:param name="form" />
        <xsl:param name="section" />

            <Inputs>
                <xsl:for-each select="VarRef">
                    <Input>/Return/Data/<xsl:value-of select="$form" />/<xsl:apply-templates/></Input>
                </xsl:for-each>
            </Inputs>
            <Gist>
                <Accumulation>
                    <xsl:for-each select="VarRef">
                        <Value>/Return/Data/<xsl:value-of select="$form" />/<xsl:apply-templates/></Value>
                    </xsl:for-each>

                    <Type>income</Type>
                </Accumulation>
            </Gist>

    </xsl:template>



</xsl:stylesheet>