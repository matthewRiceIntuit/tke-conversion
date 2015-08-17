<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:strip-space elements="*" />
    <xsl:template match="Versions"/>


    <xsl:param name="tke_vars"/>

    <xsl:template match="/">
    <xsl:value-of select="$tke_vars"/>
    [
    <xsl:apply-templates  />
    ]
</xsl:template>

    <xsl:template match="Literal[@val='0']" mode="getID">/Constants/Zero</xsl:template>
    <xsl:template match="Call[@val='HasValue']|Call[@val='IsChecked']" mode="getID">@<xsl:value-of select="ArgList/VarRef/ID/@val"/>IsNotBlank</xsl:template>
    <xsl:template match="Predicate[@val='&gt;']" mode="getID">@<xsl:value-of select="VarRef/ID/@val"/>AboveThreshold</xsl:template>
    <xsl:template match="Predicate[@val='&lt;']" mode="getID">@<xsl:value-of select="VarRef/ID/@val"/>BelowThreshold</xsl:template>
    <xsl:template match="VarRef" mode="getID"><xsl:choose><xsl:when test="name(..)='Assign'"><xsl:value-of select="../ID/@val"/></xsl:when><xsl:otherwise><xsl:value-of select="ID/@val"/></xsl:otherwise></xsl:choose></xsl:template>
    <xsl:template match="and" mode="getID">@AllConditionsTrue<xsl:value-of select="@id"/></xsl:template>
    <xsl:template match="DivMul|Multiply" mode="getID"><xsl:choose><xsl:when test="name(..)='Assign'"><xsl:value-of select="../ID/@val"/></xsl:when><xsl:otherwise>@DivMul<xsl:value-of select="@id"/></xsl:otherwise></xsl:choose></xsl:template>
    <xsl:template match="AddSub|Accumulate" mode="getID"><xsl:choose><xsl:when test="name(..)='Assign'"><xsl:value-of select="../ID/@val"/></xsl:when><xsl:otherwise>@AddSub<xsl:value-of select="@id"/></xsl:otherwise></xsl:choose></xsl:template>
    <xsl:template match="FunctionCall" mode="getID"><xsl:choose><xsl:when test="name(..)='Assign'"><xsl:value-of select="../ID/@val"/></xsl:when><xsl:otherwise>@AddSub<xsl:value-of select="@id"/></xsl:otherwise></xsl:choose></xsl:template>


    <xsl:template match="Predicate[@val='&gt;']">
        {"<xsl:apply-templates select="."  mode="getID"/> = AboveThreshold(":{"inputs":["value:<xsl:value-of select="VarRef/ID/@val"/>","threshold:<xsl:value-of select="Literal/@val"/>"]}},
    </xsl:template>
    <xsl:template match="Predicate[@val='&lt;']">
        {"<xsl:apply-templates select="."  mode="getID"/> = BelowThreshold(":{"inputs":["value:<xsl:value-of select="VarRef/ID/@val"/>","threshold:<xsl:value-of select="Literal/@val"/>"]}},
    </xsl:template>

    <xsl:template match="and">
        {"<xsl:apply-templates select="."  mode="getID"/> = AllConditionsTrue(":{"inputs":["<xsl:apply-templates select="*[1]" mode="getID"/>","<xsl:apply-templates select="*[2]" mode="getID"/>"]}},
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="Call[@val='HasValue']|Call[@val='IsChecked']">
        {"<xsl:apply-templates select="." mode="getID"/> = IsNotBlank(":{"inputs":["<xsl:value-of select="ArgList/VarRef/ID/@val"/>",]}},
    </xsl:template>


    <!--<xsl:template match="Assign/FunctionCall[Call/@val='max']">-->
        <!--{"<xsl:value-of select="../ID/@val"/> = Cap(":{"inputs":["<xsl:value-of select="ID/@val"/>",]-->


        <!--}},-->
    <!--</xsl:template>-->
    <xsl:template match="VarRef[name(..)='Assign']">
        {"<xsl:apply-templates select="."  mode="getID"/> = NumericCopy(":{"inputs":["<xsl:value-of select="ID/@val"/>",]
        <xsl:if test="../../../../IfStruct">,"_BlankIfFalse":"<xsl:apply-templates select="../../.." mode="getID"/>"</xsl:if>
        }},
    </xsl:template>


    <xsl:template match="DivMul[@val='*']|Multiply">
        {"<xsl:apply-templates select="."  mode="getID"/> = Product(":{"inputs":[
        <xsl:for-each select="*">
            {"value": "<xsl:apply-templates select="."  mode="getID"/>"},
        </xsl:for-each>
        ]}},
        <xsl:apply-templates/>

    </xsl:template>

    <xsl:template match="AddSub[@val='+']|Accumulate">
        {"<xsl:apply-templates select="."  mode="getID"/> = Accumulate(":{"inputs":[
        <xsl:for-each select="*">
            {"value": "<xsl:apply-templates select="."  mode="getID"/>"},
        </xsl:for-each>
        ]}},
        <xsl:apply-templates/>

    </xsl:template>

    <xsl:template match="FunctionCall[Call[@val='max']]">
        {"<xsl:apply-templates select="."  mode="getID"/> = Threshold(":{"inputs":[
        <xsl:for-each select="Call/ArgList/*">
            {"value": "<xsl:apply-templates select="."  mode="getID"/>"},
        </xsl:for-each>
        ]}},
        <xsl:apply-templates/>
    </xsl:template>


<!--<xsl:template match="IfStruct">-->
    <!--{"IsCondition<xsl:value-of select="position()"/> = AllConditionsTrue":{"inputs":["<xsl:value-of select="ArgList/VarRef/ID/@val"/>",]}},-->
    <!--<xsl:apply-templates/>-->
<!--</xsl:template>-->
</xsl:stylesheet>
