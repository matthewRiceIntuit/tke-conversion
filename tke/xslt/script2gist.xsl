<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml"/>
    <xsl:strip-space elements="*" />

    <xsl:key name="vars" match="//Var/@val" use="." />
    <xsl:key name="tmps" match="//Tmp/@val" use="." />

    <xsl:template match="/">
        <Nodes
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:noNamespaceSchemaLocation="TKE_Calc_Graph.xsd" >
        <xsl:attribute name="topic">TkeConverter</xsl:attribute>
        <Versions>
            <Version id="TKE.Calc.Runtime">1</Version>
            <Version id="TKE.Calc.FileFormat">4</Version>
            <Version id="TKE.Gist">1</Version>
            <Version id="TKE.MeF">1</Version>
        </Versions>
            <xsl:apply-templates/>

            <xsl:comment>
<xsl:text>





</xsl:text>
            </xsl:comment>
            <xsl:for-each select="/Gistscript/Section/Gist//Var/@val[generate-id() = generate-id(key('vars',.)[1])]">
                <xsl:sort/>
                <InputNode><xsl:attribute name="name"><xsl:value-of select="."/></xsl:attribute>

                    <PostProcessing>
                        <RoundTo>
                            <Dollars/>
                        </RoundTo>
                        <ZeroIfBlank/>
                    </PostProcessing>
                </InputNode>
            </xsl:for-each>

            <xsl:for-each select="/Gistscript/Section/Gist//Tmp/@val[generate-id() = generate-id(key('tmps',.)[1])]">

                <InputNode><xsl:attribute name="name">/Temporary/Temp<xsl:value-of select="."/></xsl:attribute>
                    <PostProcessing>
                        <RoundTo>
                            <Dollars/>
                        </RoundTo>
                        <ZeroIfBlank/>
                    </PostProcessing>
                </InputNode>
            </xsl:for-each>

            <xsl:for-each select="/Gistscript/Section/Gist//Const">

                <ConstantNode><xsl:attribute name="name">/Constants/<xsl:value-of select="@val"/></xsl:attribute>
                    <PostProcessing>
                        <RoundTo>
                            <Dollars/>
                        </RoundTo>
                        <ZeroIfBlank/>
                    </PostProcessing>
                </ConstantNode>
            </xsl:for-each>



        </Nodes>
    </xsl:template>

    <xsl:template match="Var"><xsl:value-of select="@val"/></xsl:template>
    <xsl:template match="Tmp">/Temporary/Temp<xsl:value-of select="@val"/></xsl:template>
    <xsl:template match="Const">/Constants/<xsl:value-of select="@val"/></xsl:template>
    <xsl:template match="Named_param[Var]"><xsl:variable name="name" select="Name/@val"/><xsl:element name="{$name}">/Return/ReturnData/<xsl:value-of select="Var/@val"/></xsl:element></xsl:template>
    <xsl:template match="Named_param[Tmp]"><xsl:variable name="name" select="Name/@val"/><xsl:element name="{$name}">/Temporary/Temp<xsl:value-of select="Var/@val"/></xsl:element></xsl:template>

    <xsl:template match="/Gistscript/Section">
        <Node><xsl:attribute name="name"><xsl:apply-templates select="*[1]"/></xsl:attribute>
            <Inputs>
                <xsl:for-each select="Gist/Params[Name/@val='inputs']/Param_list/*">
                    <Input><xsl:apply-templates select="(.)"/></Input>
                </xsl:for-each>
            </Inputs>
            <xsl:if test="Gist/Params/Name[@val='BlankIfFalse']">
                <BlankCondition>
                    <BlankIfFalse><xsl:apply-templates  select="Gist/Params[Name/@val='BlankIfFalse']/Param/*[1]"/></BlankIfFalse>
                </BlankCondition>
            </xsl:if>
            <Gist>
                <xsl:variable name="gist" select="Gist/@val"/>
                <xsl:element name="{$gist}">
                    <InputRoles>
                        <xsl:for-each select="Gist/Params[Name/@val='inputs']/Param_list/*">
                            <Value><xsl:apply-templates select="."/></Value>
                        </xsl:for-each>
                    </InputRoles>
                </xsl:element>
            </Gist>
        </Node>

<xsl:comment>
<xsl:text>



</xsl:text>
</xsl:comment>
    </xsl:template>

</xsl:stylesheet>
