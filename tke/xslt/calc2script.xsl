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

    <xsl:template match="FunctionCall" mode="getID"><xsl:apply-templates mode="getID"/></xsl:template>

    <!--
    <xsl:template match="Literal[@val='0']" mode="getID">$Zero</xsl:template>
    <xsl:template match="Literal[@val='.15']" mode="getID">$FifteenPercent</xsl:template>
    -->

    <xsl:template match="Literal" mode="getID">$<xsl:value-of select="@val"/></xsl:template>
    <xsl:template match="Boolean" mode="getID">$<xsl:value-of select="@val"/></xsl:template>
    <xsl:template match="Call[@val='hasvalue']" mode="getID"><xsl:choose><xsl:when test="name(..)='Assign'"><xsl:value-of select="../ID/@val"/></xsl:when><xsl:otherwise>@<xsl:value-of select="ArgList/VarRef/ID/@val"/>IsNotBlank</xsl:otherwise></xsl:choose></xsl:template>
    <xsl:template match="Call[@val='ischecked']" mode="getID"><xsl:value-of select="ArgList/VarRef/ID/@val"/></xsl:template>
    <xsl:template match="Call" mode="getID"><xsl:choose><xsl:when test="name(..)='Assign'"><xsl:value-of select="../ID/@val"/></xsl:when><xsl:otherwise>@<xsl:value-of select="/CALC/FORMSET/FORM/@val"/>/<xsl:value-of select="./ancestor::Section/@val"/>/<xsl:value-of select="@val"/><xsl:value-of select="../@id"/></xsl:otherwise></xsl:choose></xsl:template>
    <xsl:template match="Predicate[@val='&gt;']" mode="getID">@<xsl:value-of select="VarRef/ID/@val"/>AboveThreshold</xsl:template>
    <xsl:template match="Predicate[@val='&lt;']" mode="getID">@<xsl:value-of select="VarRef/ID/@val"/>BelowThreshold</xsl:template>
    <xsl:template match="VarRef" mode="getID"><xsl:choose><xsl:when test="name(..)='Assign'"><xsl:value-of select="../ID/@val"/></xsl:when><xsl:otherwise><xsl:value-of select="ID/@val"/></xsl:otherwise></xsl:choose></xsl:template>
    <xsl:template match="and" mode="getID">@AllConditionsTrue<xsl:value-of select="@id"/></xsl:template>
    <xsl:template match="or" mode="getID">@AtLeastOneConditionTrue<xsl:value-of select="@id"/></xsl:template>
    <xsl:template match="DivMul|Multiply" mode="getID"><xsl:choose><xsl:when test="name(..)='Assign'"><xsl:value-of select="../ID/@val"/></xsl:when><xsl:otherwise>@DivMul<xsl:value-of select="@id"/></xsl:otherwise></xsl:choose></xsl:template>
    <xsl:template match="AddSub|Accumulation|Difference" mode="getID"><xsl:choose><xsl:when test="name(..)='Assign'"><xsl:value-of select="../ID/@val"/></xsl:when><xsl:otherwise>@<xsl:value-of select="/CALC/FORMSET/FORM/@val"/>/<xsl:value-of select="./ancestor::Section/@val"/>/AddSub<xsl:value-of select="@id"/></xsl:otherwise></xsl:choose></xsl:template>
    <xsl:template match="MultiCopyAccumulate" mode="getID"><xsl:value-of select="../ID/@val"/></xsl:template>



    <xsl:template match="Call[@val='hasvalue']">
        <IsNotBlank>
            <ID>@<xsl:apply-templates  mode="getID"/>IsNotBlank</ID>
            <INPUT><xsl:apply-templates  mode="getID"/></INPUT>
        </IsNotBlank>
    </xsl:template>

    <xsl:template match="Call[@val='ischecked']">
        <IsChecked><ID><xsl:apply-templates  mode="getID"/></ID></IsChecked>
    </xsl:template>






    <!--<xsl:template match="Assign/FunctionCall[Call/@val='max']">-->
        <!--{"<xsl:value-of select="../ID/@val"/> = Cap(":{"inputs":["<xsl:value-of select="ID/@val"/>",]-->


        <!--}},-->
    <!--</xsl:template>-->
    <xsl:template match="/">
        <xml>
            <xsl:attribute name="form"><xsl:value-of select="/CALC/FORMSET/FORM/@val"/></xsl:attribute>
            <xsl:apply-templates/>
        </xml>
    </xsl:template>

    <xsl:template match="Section">
        <Section>
            <xsl:attribute name="id"><xsl:value-of select="@val"/></xsl:attribute>
            <xsl:apply-templates/>
        </Section>
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

    <xsl:template match="Call[@val='hasvalue']|Call[@val='IsChecked']">
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


    <xsl:template match="Literal[name(..)='Assign']|Boolean[name(..)='Assign']">
        <Assign>
            #####
            <ID><xsl:value-of select="../ID/@val"/></ID>
            <INPUT><xsl:apply-templates select="."  mode="getID"/></INPUT>
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

    <xsl:template match="or">
        <xsl:apply-templates/>
        <AtLeastOneConditionTrue>
            <ID><xsl:apply-templates select="."  mode="getID"/></ID>
            <xsl:for-each select="*">
                <INPUT><xsl:apply-templates   mode="getID"/></INPUT>
            </xsl:for-each>
        </AtLeastOneConditionTrue>
    </xsl:template>

    <xsl:template match="AddSub[@val='+']|Accumulation">
        <xsl:apply-templates/>
        <Accumulation>
            <ID><xsl:apply-templates select="."  mode="getID"/></ID>
            <xsl:for-each select="*">
                <INPUT><xsl:apply-templates select="."  mode="getID"/></INPUT>
            </xsl:for-each>
        </Accumulation>
    </xsl:template>

    <xsl:template match="AddSub[@val='-']|Difference">
        <xsl:apply-templates/>
        <Difference>
            <ID><xsl:apply-templates select="."  mode="getID"/></ID>
            <xsl:for-each select="*">
                <INPUT><xsl:apply-templates select="."  mode="getID"/></INPUT>
            </xsl:for-each>
        </Difference>
    </xsl:template>

    <xsl:template match="FunctionCall[Call[@val='max']]">
        <xsl:apply-templates/>
        <Maximum>
            <ID><xsl:apply-templates select="."  mode="getID"/></ID>
            <xsl:for-each select="Call/ArgList/*">
                <INPUT><xsl:apply-templates select="."  mode="getID"/></INPUT>
            </xsl:for-each>
        </Maximum>
    </xsl:template>

    <xsl:template match="FunctionCall[Call[@val='min']]">
        <xsl:apply-templates/>
        <Minimum>
            <ID><xsl:apply-templates select="."  mode="getID"/></ID>
            <xsl:for-each select="Call/ArgList/*">
                <INPUT><xsl:apply-templates select="."  mode="getID"/></INPUT>
            </xsl:for-each>
        </Minimum>
    </xsl:template>



    <xsl:template match="Predicate[@val='&gt;']">
        <xsl:apply-templates/>
        <AboveThreshold>
            <ID><xsl:apply-templates select="."  mode="getID"/></ID>
            <xsl:for-each select="*">
                <INPUT><xsl:apply-templates select="."  mode="getID"/></INPUT>
            </xsl:for-each>
        </AboveThreshold>
    </xsl:template>

    <xsl:template match="Predicate[@val='&lt;']">
        <xsl:apply-templates/>
        <BelowThreshold>
            <ID><xsl:apply-templates select="."  mode="getID"/></ID>
            <xsl:for-each select="*">
                <INPUT><xsl:apply-templates select="."  mode="getID"/></INPUT>
            </xsl:for-each>
        </BelowThreshold>
    </xsl:template>

    <xsl:template match="and">
        <xsl:apply-templates/>
        <AllConditionsTrue>
            <ID><xsl:apply-templates select="."  mode="getID"/></ID>
            <xsl:for-each select="*">
                <INPUT><xsl:apply-templates select="."  mode="getID"/></INPUT>
            </xsl:for-each>
        </AllConditionsTrue>
    </xsl:template>


    <xsl:template match="MultiCopyAccumulate">
        <xsl:apply-templates/>
        <MultiCopyAccumulation>
            <ID><xsl:apply-templates select="."  mode="getID"/></ID>
            <INPUT><xsl:value-of select="ID/@val"/></INPUT>
        </MultiCopyAccumulation>

    </xsl:template>




</xsl:stylesheet>
