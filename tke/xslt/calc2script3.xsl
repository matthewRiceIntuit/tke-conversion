<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>


   <xsl:template match="INPUT">
       <xsl:value-of select="."/>
   </xsl:template>
    <xsl:template match="ID">
        <xsl:value-of select="."/>
    </xsl:template>

   <xsl:template match="/">
        <xsl:text>    </xsl:text><xsl:apply-templates/>
   </xsl:template>

    <xsl:template match="DEPRECATE">
    //####### Deprecating Temp TPS calc var <xsl:value-of select="ID"/> := <xsl:value-of select="INPUT"/> ####<xsl:text>

    </xsl:text>
    </xsl:template>

    <xsl:template match="Assign">
        <xsl:param name="extra"/>
        <xsl:value-of select='$extra'/><xsl:value-of select="ID"/> = NumericCopy(inputs:[ <xsl:apply-templates select="INPUT"/> ])

    </xsl:template>

    <xsl:template match="IsNotBlank">
        <xsl:value-of select="ID"/> = IsNotBlank(inputs:[ <xsl:value-of select="INPUT"/> ])

    </xsl:template>

    <xsl:template match="MultiCopyAccumulation">
        <xsl:value-of select="ID"/> = MultiCopyAccumulation(inputs:[ <xsl:value-of select="INPUT"/> ])

    </xsl:template>

    <xsl:template match="node()[ID[not(normalize-space())]]"></xsl:template>

    <xsl:template match="Max|AboveThreshold|Accumulate|Product|Difference|Threshold|Cap">
        <xsl:param name="extra"/>
        <xsl:param name="blankiffalse"/>

        <xsl:value-of select='$extra'/><xsl:apply-templates select="ID"/> = <xsl:value-of select="name()"/>( inputs:[
        <xsl:for-each select="INPUT">
            <xsl:apply-templates select="."/>,
        </xsl:for-each>]<xsl:if test="$blankiffalse">
        ,BlankIfFalse : <xsl:value-of select="$blankiffalse"/></xsl:if>)

    </xsl:template>

    <xsl:template match="IF[ELSE]">
    <xsl:apply-templates select="TEST"/>

    <xsl:for-each select="THEN/*">
        <xsl:choose>
            <xsl:when test="substring(ID,1,1)!='@'" >
                <xsl:value-of select="ID"/> = NumericChoice(inputs: [
                Choice:<xsl:value-of select="../../TEST//ID"/>,
                Possibility:@TRUE<xsl:value-of select="ID"/>,
                Possibility:@FALSE<xsl:value-of select="ID"/>]
                )

    <xsl:apply-templates select="."><xsl:with-param name="extra">@TRUE</xsl:with-param></xsl:apply-templates>
    <xsl:variable name="id" select="ID"/>
    <xsl:apply-templates select="../../ELSE/*[ID=$id]"><xsl:with-param name="extra">@FALSE</xsl:with-param></xsl:apply-templates>

            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="."/>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:for-each>

    </xsl:template>


    <xsl:template match="IF">
        <xsl:apply-templates select="TEST"/>

        <xsl:for-each select="THEN/*">
            <xsl:choose>
                <xsl:when test="substring(ID,1,1)!='@'" >
                    <xsl:apply-templates select="."><xsl:with-param name="blankiffalse"><xsl:value-of select="../../TEST//ID"/></xsl:with-param></xsl:apply-templates>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="."/>
                </xsl:otherwise>

            </xsl:choose>

        </xsl:for-each>

    </xsl:template>


</xsl:stylesheet>
