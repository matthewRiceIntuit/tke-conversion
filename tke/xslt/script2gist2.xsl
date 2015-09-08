<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


    <xsl:output method="xml" encoding="utf-8" indent="yes"/>

    <!-- Identity template : copy all text nodes, elements and attributes -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>

    <!-- When matching DataSeriesBodyType: do nothing -->
    <xsl:template match="NumericChoice" >
        <NumericChoice>
            <Choice><xsl:value-of select="InputRoles/*[1]"/></Choice>
            <Possibility><xsl:value-of select="InputRoles/*[2]"/></Possibility>
            <Possibility><xsl:value-of select="InputRoles/*[3]"/></Possibility>
            <ChoiceMapping>
                <Option>
                    <Value>true</Value>
                    <ID><xsl:value-of select="InputRoles/*[2]"/></ID>
                    <NoOtherOption>false</NoOtherOption>
                </Option>
                <DefaultOption>
                    <ID><xsl:value-of select="InputRoles/*[3]"/></ID>
                    <NoOtherOption>false</NoOtherOption>
                </DefaultOption>
            </ChoiceMapping>
        </NumericChoice>

    </xsl:template>


</xsl:stylesheet>