<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml"/>
    <xsl:strip-space elements="*" />

    <xsl:key name="vars" match="//Var/@val" use="." />
    <xsl:key name="tmps" match="//Tmp/@val" use="." />

    <xsl:template match="/">
        <Nodes>
            <xsl:apply-templates/>

            <xsl:comment>
<xsl:text>





</xsl:text>
            </xsl:comment>
            <xsl:for-each select="//Var/@val[generate-id() = generate-id(key('vars',.)[1])]">
                <xsl:sort/>
                <InputNode><xsl:attribute name="name">/Return/ReturnData/<xsl:value-of select="."/></xsl:attribute>

                    <RoundTo>
                        <Dollars />
                    </RoundTo>
                </InputNode>
            </xsl:for-each>

            <xsl:for-each select="//Tmp/@val[generate-id() = generate-id(key('tmps',.)[1])]">

                <InputNode><xsl:attribute name="name">/Temporary/EIC/<xsl:value-of select="."/></xsl:attribute>
                    <RoundTo>
                        <Dollars />
                    </RoundTo>
                </InputNode>
            </xsl:for-each>

        </Nodes>
    </xsl:template>

    <xsl:template match="Var"><Value>/Return/ReturnData/<xsl:value-of select="@val"/></Value></xsl:template>
    <xsl:template match="Tmp"><Value>/Temporary/EIC/<xsl:value-of select="@val"/></Value></xsl:template>
    <xsl:template match="Named_param[Var]"><xsl:variable name="name" select="Name/@val"/><xsl:element name="{$name}">/Return/ReturnData/<xsl:value-of select="Var/@val"/></xsl:element></xsl:template>
    <xsl:template match="Named_param[Tmp]"><xsl:variable name="name" select="Name/@val"/><xsl:element name="{$name}">/Temporary/EIC/<xsl:value-of select="Var/@val"/></xsl:element></xsl:template>

    <xsl:template match="/Gistscript/Section">
<xsl:comment>
<xsl:text>





</xsl:text>
</xsl:comment>

        <Node><xsl:attribute name="name"><xsl:apply-templates select="*[1]"/></xsl:attribute>
            <Inputs>
                <xsl:for-each select="Gist/Params[Name/@val='inputs']//Var">
                    <input><xsl:apply-templates select="(.)"/></input>
                </xsl:for-each>
            </Inputs>
            <xsl:if test="Gist/Params/Name[@val='BlankIfFalse']">
                <BlankCondition>
                    <BlankIfFalse><xsl:value-of select="Gist/Params[Name/@val='BlankIfFalse']/Param/Var/@val"/></BlankIfFalse>
                </BlankCondition>
            </xsl:if>
            <Gist>
                <xsl:variable name="gist" select="Gist/@val"/>
                <xsl:element name="{$gist}">
                    <InputRoles>
                        <xsl:apply-templates select="Gist/Params[Name/@val='inputs']/Param_list/Param"/>
                    </InputRoles>
                </xsl:element>
            </Gist>
            <RoundTo>
                <Dollars/>
            </RoundTo>
        </Node>

    </xsl:template>

</xsl:stylesheet>
