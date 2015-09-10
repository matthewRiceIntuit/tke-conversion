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

    <xsl:template match="Difference" >
        <Difference>
            <InputRoles>
                <Left><xsl:value-of select="InputRoles/*[1]"/></Left>
                <Right><xsl:value-of select="InputRoles/*[1]"/></Right>
            </InputRoles>
        </Difference>
    </xsl:template>

    <xsl:template match="AboveThreshold" >
        <AboveThreshold>
            <InputRoles>
                <Value><xsl:value-of select="InputRoles/*[1]"/></Value>
                <Threshold><xsl:value-of select="InputRoles/*[2]"/></Threshold>
            </InputRoles>
        </AboveThreshold>
    </xsl:template>

    <xsl:template match="Product[contains(InputRoles/Value[2]/text(),'Percent')]" >
        <PercentageOf>
            <InputRoles>
                <Value><xsl:value-of select="InputRoles/*[1]"/></Value>
                <Percentage><xsl:value-of select="InputRoles/*[2]"/></Percentage>
            </InputRoles>
            <Configuration>
                <ValueType>income</ValueType>
                <OutputType>penalty</OutputType>
            </Configuration>
        </PercentageOf>
    </xsl:template>

    <xsl:template match="Product" >
        <Product>
            <InputRoles>
                <Product><xsl:value-of select="InputRoles/*[1]"/></Product>
                <Product><xsl:value-of select="InputRoles/*[2]"/></Product>
            </InputRoles>
        </Product>
    </xsl:template>


    <xsl:template match="Nodes/Node[Gist/AboveThreshold]/PostProcessing" >
    </xsl:template>




</xsl:stylesheet>