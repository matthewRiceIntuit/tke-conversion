<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml"/>
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
    <xsl:template match="VarRef|Literal" mode="getID"><xsl:choose><xsl:when test="name(..)='Assign'"><xsl:value-of select="../ID/@val"/></xsl:when><xsl:otherwise><xsl:value-of select="ID/@val"/></xsl:otherwise></xsl:choose></xsl:template>
    <xsl:template match="and" mode="getID">@AllConditionsTrue<xsl:value-of select="@id"/></xsl:template>
    <xsl:template match="DivMul|Multiply" mode="getID"><xsl:choose><xsl:when test="name(..)='Assign'"><xsl:value-of select="../ID/@val"/></xsl:when><xsl:otherwise>@DivMul<xsl:value-of select="@id"/></xsl:otherwise></xsl:choose></xsl:template>
    <xsl:template match="AddSub|Accumulate" mode="getID"><xsl:choose><xsl:when test="name(..)='Assign'"><xsl:value-of select="../ID/@val"/></xsl:when><xsl:otherwise>@AddSub<xsl:value-of select="@id"/></xsl:otherwise></xsl:choose></xsl:template>
    <xsl:template match="FunctionCall" mode="getID"><xsl:choose><xsl:when test="name(..)='Assign'"><xsl:value-of select="../ID/@val"/></xsl:when><xsl:otherwise>@AddSub<xsl:value-of select="@id"/></xsl:otherwise></xsl:choose></xsl:template>
    <xsl:template match="MultiCopyAccumulate" mode="getID"><xsl:value-of select="../ID/@val"/></xsl:template>






    <!--<xsl:template match="Assign/FunctionCall[Call/@val='max']">-->
        <!--{"<xsl:value-of select="../ID/@val"/> = Cap(":{"inputs":["<xsl:value-of select="ID/@val"/>",]-->


        <!--}},-->
    <!--</xsl:template>-->
    <xsl:template match="/">
        <xml>
            <xsl:apply-templates/>
        </xml>
    </xsl:template>

    <xsl:template match="IfStruct[Parens/VarRef/ID[@val='F2441.RUNCALC']]">
        <xsl:apply-templates select="*[2]"/>
    </xsl:template>

    <xsl:template match="IfStruct">
        <IF>
            <TEST><xsl:apply-templates select="*[1]"/></TEST>
            <THEN><xsl:apply-templates select="*[2]"/></THEN>
            <xsl:if test="*[3]">
                <ELSE><xsl:apply-templates select="*[3]"/></ELSE>
            </xsl:if>
        </IF>
    </xsl:template>

    <xsl:template match="Call[@val='HasValue']|Call[@val='IsChecked']">
        <IsNotBlank>
            <ID><xsl:apply-templates select="."  mode="getID"/></ID>
            <INPUT><xsl:value-of select="ArgList/VarRef/ID/@val"/></INPUT>
        </IsNotBlank>
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="VarRef[name(..)='Assign']">
        <Assign>
            <xsl:variable name="id"><xsl:apply-templates select="."  mode="getID"/></xsl:variable>
            <ID><xsl:value-of select="$id"/></ID>
            <INPUT><xsl:value-of select="ID/@val"/></INPUT>
        </Assign>
    </xsl:template>


    <xsl:template match="Literal[name(..)='Assign']">
        <Assign>
            <ID><xsl:apply-templates select="."  mode="getID"/></ID>
            <INPUT><xsl:value-of select="@val"/></INPUT>
        </Assign>
    </xsl:template>


    <xsl:template match="DivMul[@val='*']|Multiply">
        <Product>
            <ID><xsl:apply-templates select="."  mode="getID"/></ID>
            <xsl:for-each select="*">
                <INPUT><xsl:apply-templates select="."  mode="getID"/></INPUT>
            </xsl:for-each>
        </Product>
        <xsl:apply-templates/>

    </xsl:template>

    <xsl:template match="AddSub[@val='+']|Accumulate">
        <Accumulate>
            <ID><xsl:apply-templates select="."  mode="getID"/></ID>
            <xsl:for-each select="*">
                <INPUT><xsl:apply-templates select="."  mode="getID"/></INPUT>
            </xsl:for-each>
        </Accumulate>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="AddSub[@val='-']|Difference">
        <Difference>
            <ID><xsl:apply-templates select="."  mode="getID"/></ID>
            <xsl:for-each select="*">
                <INPUT><xsl:apply-templates select="."  mode="getID"/></INPUT>
            </xsl:for-each>
        </Difference>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="FunctionCall[Call[@val='max']]">
        <Cap>
            <ID><xsl:apply-templates select="."  mode="getID"/></ID>
            <xsl:for-each select="Call/ArgList/*">
                <INPUT><xsl:apply-templates select="."  mode="getID"/></INPUT>
            </xsl:for-each>
        </Cap>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="FunctionCall[Call[@val='min']]">
        <Threshold>
            <ID><xsl:apply-templates select="."  mode="getID"/></ID>
            <xsl:for-each select="Call/ArgList/*">
                <INPUT><xsl:apply-templates select="."  mode="getID"/></INPUT>
            </xsl:for-each>
        </Threshold>
        <xsl:apply-templates/>
    </xsl:template>



    <xsl:template match="Predicate[@val='&gt;']">
        <AboveThreshold>
            <ID><xsl:apply-templates select="."  mode="getID"/></ID>
            <xsl:for-each select="*">
                <INPUT><xsl:apply-templates select="."  mode="getID"/></INPUT>
            </xsl:for-each>
        </AboveThreshold>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="Predicate[@val='&lt;']">
        <BelowThreshold>
            <ID><xsl:apply-templates select="."  mode="getID"/></ID>
            <xsl:for-each select="*">
                <INPUT><xsl:apply-templates select="."  mode="getID"/></INPUT>
            </xsl:for-each>
        </BelowThreshold>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="and">
        <AllConditionsTrue>
            <ID><xsl:apply-templates select="."  mode="getID"/></ID>
            <xsl:for-each select="*">
                <INPUT><xsl:apply-templates select="."  mode="getID"/></INPUT>
            </xsl:for-each>
        </AllConditionsTrue>
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="MultiCopyAccumulate">
        <MultiCopyAccumulation>
            <ID><xsl:apply-templates select="."  mode="getID"/></ID>
            <INPUT><xsl:value-of select="ID/@val"/></INPUT>
        </MultiCopyAccumulation>
        <xsl:apply-templates/>

    </xsl:template>




</xsl:stylesheet>
