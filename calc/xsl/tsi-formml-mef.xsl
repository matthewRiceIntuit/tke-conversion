<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.irs.gov/efile"
    xmlns:tsi="http://schemas.intuit.com/cg/services/calc" 
    xmlns:ext="http://exslt.org/common"
    xmlns:mef="http://www.irs.gov/efile" 
    exclude-result-prefixes="tsi mef"
    version="1.0">

    <xsl:output method="xml" omit-xml-declaration="no" indent="yes"/>

    <!-- Walk entire tree -->
    <xsl:template match="node()">
        <xsl:apply-templates select="node()"/>
    </xsl:template>

    <!-- Copy the ouput of 1st Pass and add the ControlBits -->
    <xsl:template match="@*|*|text()" mode="Pass2">
        <xsl:copy>
            <!-- Copy all Children Nodes -->
            <xsl:apply-templates select="@*|*|text()" mode="Pass2"/>
            <xsl:call-template name="AppendFieldAttributes"/>
            <xsl:if test="child::node()[name()='DependentSSN']">
                <xsl:call-template name="AddDependentLegalInformation"/>
            </xsl:if>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template name="AppendFieldAttributes">
        <!-- Calculate the path of the parent -->
        <xsl:variable name="parentPath">
            <xsl:call-template name="genPath"/>
        </xsl:variable>
        <xsl:if test="count($fieldCoverage/tsi:field[@id='GPARENT']/tsi:value[.=$parentPath] ) > 0">
            <FieldAttributes>
                <xsl:for-each select="$fieldCoverage">
                    <xsl:if test="tsi:field[@id='GPARENT']/tsi:value[.=$parentPath] 
                              and tsi:field[@id='GCOVERED']/tsi:value[normalize-space(translate(.,'true','TRUE')) = 'TRUE']">
                        <xsl:element name="{normalize-space(tsi:field[@id='GFLDNAME'])}">
                            <Covered>
                                <xsl:value-of select="normalize-space(tsi:field[@id='GCOVERED'])"/>
                            </Covered>
                        </xsl:element>
                    </xsl:if>
                </xsl:for-each>
            </FieldAttributes>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="node()" name="AddDependentLegalInformation" mode="AddDependentLegalInformation">
        <xsl:variable name="dependentSSN">
            <xsl:value-of select="child::node()[name()='DependentSSN']"/>
        </xsl:variable>
            <xsl:for-each select="$dependentLegalInfo">
                <xsl:if test="tsi:field[@id='SSN']/tsi:value = $dependentSSN">
                    <xsl:choose>
                        <xsl:when test="tsi:field[@id='BOTHPAR']">
                            <DependentLegalParentsPP>Both</DependentLegalParentsPP>
                        </xsl:when>
                        <xsl:when test="tsi:field[@id='TPPAR']">
                            <DependentLegalParentsPP>Taxpayer</DependentLegalParentsPP>
                        </xsl:when>
                        <xsl:when test="tsi:field[@id='SPPAR']">
                            <DependentLegalParentsPP>Spouse</DependentLegalParentsPP>
                        </xsl:when>
                    </xsl:choose>
                </xsl:if>
            </xsl:for-each>
    </xsl:template>
    
    <xsl:variable name="fieldCoverage" select="/tsi:FormML/tsi:formset[contains(@id,'1040PER') or contains(@id,'1040PRO') or contains(@id, 'FDI')]/tsi:form[@id='TKEHAVE']/tsi:table[@id='FLDCVRGG']/tsi:row"/>
    <xsl:variable name="dependentLegalInfo" select="/tsi:FormML/tsi:formset[contains(@id,'1040PER') or contains(@id, 'FDI')]/tsi:form[@id='FWDEPINF']"/>    
    
    <!-- Begin translation -->    
    <xsl:template match="/">
        <xsl:variable name="root">
            <xsl:apply-templates select="*"/>
        </xsl:variable>
        <xsl:apply-templates select="ext:node-set($root)" mode="Pass2"/>
    </xsl:template>
    
    <!-- Traditional formml -->
    <xsl:template match="/tsi:FormML/tsi:formset[contains(@id,'1040PER') or contains(@id,'1040PRO') or contains(@id, 'FDI')]">
        <xsl:apply-templates select="." mode="Return"/>
    </xsl:template>

    <!-- Return -->
    <xsl:template match="node()" mode="Return">
        <Return xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns="http://www.irs.gov/efile" 
            returnVersion="2014v1.0"
            xsi:schemaLocation="https://www.irs.gov/efile.corp.intuit.net/CG/IND-EF/mefSchemas/IRS2014v1.0/IndividualIncomeTax/Ind1040/Return1040.xsd">
            <xsl:call-template name="ReturnHeader"/>
            <xsl:call-template name="ReturnData"/>
        </Return>
    </xsl:template>
    
    <!-- ReturnHeader -->
    <xsl:template name="ReturnHeader">
        <ReturnHeader binaryAttachmentCnt="0">
            <TaxYr>2014</TaxYr>
            <xsl:call-template name="Filer"/>
            <xsl:apply-templates select="tsi:form[@id='FINFOWKS']" mode="SelfSelectPINGrp"/>
            <xsl:apply-templates select="tsi:form[@id='TKEHAVE']" mode="ReturnHeader-Fields"/>
            <xsl:apply-templates select="tsi:form[@id='FONLINE']" mode="FONLINE-ReturnHeader"/>
        </ReturnHeader>
    </xsl:template>
    
    <!-- FONLINE-ReturnHeader -->
    <xsl:template match="tsi:form[@id='FONLINE']" mode="FONLINE-ReturnHeader">
        <xsl:apply-templates select="tsi:field[@id='HLY']" mode="Field">
            <xsl:with-param name="mefId">PriorTaxYrPP</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='HNY']" mode="Field">
            <xsl:with-param name="mefId">NextTaxYrPP</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='HB4L']" mode="Field">
            <xsl:with-param name="mefId">TwoPriorTaxYrPP</xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>
    
    <!-- ReturnData -->
    <xsl:template name="ReturnData">
        <ReturnData>
            <xsl:attribute name="documentCnt">
                <xsl:value-of select="count(tsi:form[not(contains(@id,'FINFOWKS'))])" />
            </xsl:attribute> 
            <xsl:call-template name="ReturnData-Forms"/>
            <xsl:apply-templates select="tsi:form[@id='TKEHAVE']" mode="ReturnData-Fields"/>
        </ReturnData>
    </xsl:template>
    
    <xsl:template name="ReturnData-Forms">
        <!-- Mapping for all MeF forms -->
        <xsl:call-template name="IRS1040"/>
        <xsl:apply-templates select="tsi:form[@id='F1095A']" mode="IRS1095A"/>
        <xsl:apply-templates select="tsi:form[@id='F1095B']" mode="IRS1095B"/>
        <xsl:apply-templates select="tsi:form[@id='F1095C']" mode="IRS1095C"/>
        <xsl:apply-templates select="tsi:form[@id='F1099INT']" mode="IRS1099INT"/>
        <xsl:apply-templates select="tsi:form[@id='F1095OTH']" mode="IRS1095OTH"/>
        <xsl:call-template name="IRS1040ScheduleA"/>
        <xsl:call-template name="IRS8962"/>
        <xsl:call-template name="IRS8965"/>
        <xsl:apply-templates select="tsi:form[@id='F25553T']" mode="IRS2555"/>
        <xsl:apply-templates select="tsi:form[@id='F25553S']" mode="IRS2555"/>
        <xsl:apply-templates select="tsi:form[@id='FSCHC']" mode="IRS1040ScheduleC"/>
        <xsl:apply-templates select="tsi:form[@id='FSCHD']" mode="IRS1040ScheduleD"/>
        <xsl:call-template name="IRS1040ScheduleE"/>
        <xsl:apply-templates select="tsi:form[@id='FSCHF']" mode="IRS1040ScheduleF"/>
        <xsl:apply-templates select="tsi:form[@id='FK1PW']" mode="IRS1065ScheduleK1"/>
        <xsl:apply-templates select="tsi:form[@id='FK1SW']" mode="IRS1120SScheduleK1"/>
        <xsl:apply-templates select="tsi:form[@id='F2119']" mode="IRS2119"/>
        <xsl:apply-templates select="tsi:form[@id='FOTHINC']" mode="OtherIncome"/>
        <xsl:apply-templates select="tsi:form[@id='F8949']" mode="IRS8949"/>
        <xsl:apply-templates select="tsi:form[@id='F6781']" mode="IRS6781"/>
        <xsl:apply-templates select="tsi:form[@id='F4835']" mode="IRS4835"/>
        <xsl:apply-templates select="tsi:form[@id='FK1EW']" mode="IRS1041"/>
        <xsl:apply-templates select="tsi:form[@id='F4797']" mode="IRS4797"/>
        <xsl:apply-templates select="tsi:form[@id='FW2G']" mode="IRSW2G"/>
        <xsl:apply-templates select="tsi:form[@id='FW2']" mode="IRSW2"/>
        <xsl:apply-templates select="tsi:form[@id='TKEHAVE']" mode="IRS4684"/>
        <xsl:apply-templates select="tsi:form[@id='FSEADJ']" mode="ScheduleSEAdjustments"/>
        <xsl:apply-templates select="tsi:form[@id='FCO13']" mode="FederalCarryoverWorksheet"/>
        
        <xsl:call-template name="PPPerson"/>
        <xsl:call-template name="PPReturnInformation"/>

        <!--<xsl:apply-templates select="tsi:form[not(contains(@id,'FINFOWKS'))]"/>-->
    </xsl:template>
    
    <xsl:template match="tsi:form[@id='TKEHAVE']" mode="ReturnHeader-Fields">
        <ACAPP>
            <xsl:apply-templates select="tsi:field[@id='FULLYHI']" mode="EnumField">
                <xsl:with-param name="mefId">HshldCvrIndPP</xsl:with-param>
                <xsl:with-param name="value">FULLYEAR</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='PARTYHI']" mode="EnumField">
                <xsl:with-param name="mefId">HshldCvrIndPP</xsl:with-param>
                <xsl:with-param name="value">PARTYEAR</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='NONEHI']" mode="EnumField">
                <xsl:with-param name="mefId">HshldCvrIndPP</xsl:with-param>
                <xsl:with-param name="value">NONE</xsl:with-param>
            </xsl:apply-templates>
        </ACAPP>
    </xsl:template>
    <xsl:template match="tsi:form[@id='TKEHAVE']" mode="ReturnData-Fields">
        <ACACntrlBitsPP>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='HAY1095A']">
                    <HaveAny1095APP>true</HaveAny1095APP>
                </xsl:when>
                <xsl:when test="tsi:field[@id='HAN1095A']">
                    <HaveAny1095APP>false</HaveAny1095APP>
                </xsl:when>
            </xsl:choose>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='HMY1095A']">
                    <HaveAnyMore1095APP>true</HaveAnyMore1095APP>
                </xsl:when>
                <xsl:when test="tsi:field[@id='HMN1095A']">
                    <HaveAnyMore1095APP>false</HaveAnyMore1095APP>
                </xsl:when>
            </xsl:choose>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='HAY1095B']">
                    <HaveAny1095BPP>true</HaveAny1095BPP>
                </xsl:when>
                <xsl:when test="tsi:field[@id='HAN1095B']">
                    <HaveAny1095BPP>false</HaveAny1095BPP>
                </xsl:when>
            </xsl:choose>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='HMY1095B']">
                    <HaveAnyMore1095BPP>true</HaveAnyMore1095BPP>
                </xsl:when>
                <xsl:when test="tsi:field[@id='HMN1095B']">
                    <HaveAnyMore1095BPP>false</HaveAnyMore1095BPP>
                </xsl:when>
            </xsl:choose>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='HAY1095C']">
                    <HaveAny1095CPP>true</HaveAny1095CPP>
                </xsl:when>
                <xsl:when test="tsi:field[@id='HAN1095C']">
                    <HaveAny1095CPP>false</HaveAny1095CPP>
                </xsl:when>
            </xsl:choose>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='HMY1095C']">
                    <HaveAnyMore1095CPP>true</HaveAnyMore1095CPP>
                </xsl:when>
                <xsl:when test="tsi:field[@id='HMN1095C']">
                    <HaveAnyMore1095CPP>false</HaveAnyMore1095CPP>
                </xsl:when>
            </xsl:choose>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='HAY8965']">
                    <Have8965PP>true</Have8965PP>
                </xsl:when>
                <xsl:when test="tsi:field[@id='HAN8965']">
                    <Have8965PP>false</Have8965PP>
                </xsl:when>
            </xsl:choose>
            
            <xsl:for-each select="tsi:table[@id = 'ACTIVITY']/tsi:row">
                <AssociatedBusinessActivityGrpPP>
                    <xsl:copy-of select="@uuid"/>
                    <xsl:apply-templates select="tsi:field[@id='ACTTYPE']" mode="Field">
                        <xsl:with-param name="mefId">BusinessTypeIdPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='ACTNAME']" mode="Field">
                        <xsl:with-param name="mefId">NameOfBusinessPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='ACTCOPY']" mode="Field">
                        <xsl:with-param name="mefId">FormCopyKeyForBusinessTypePP</xsl:with-param>
                    </xsl:apply-templates>
                </AssociatedBusinessActivityGrpPP>
            </xsl:for-each>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='ACACOMPY']">
                    <ACAInterviewCompletionPP>true</ACAInterviewCompletionPP>
                </xsl:when>
                <xsl:when test="tsi:field[@id='ACACOMPN']">
                    <ACAInterviewCompletionPP>false</ACAInterviewCompletionPP>
                </xsl:when>
            </xsl:choose>
        </ACACntrlBitsPP>
    </xsl:template>
    
    <!-- Mapping for Filer -->
    <xsl:template match="tsi:form[@id='FINFOWKS'] | tsi:form[@id='F1040']" mode="Filer" name="Filer">
        <Filer>
            <xsl:apply-templates select="tsi:form[@id='FINFOWKS']" mode="Filer-FINFOWKS"/>
            <xsl:apply-templates select="tsi:form[@id='F1040']" mode="Filer-F1040"/>
        </Filer>
    </xsl:template>
    <xsl:template match="tsi:form[@id='FINFOWKS']" mode="Filer-FINFOWKS">
        <xsl:copy-of select="@uuid"/>
        <xsl:if test="tsi:field[(attribute::id = 'TFN') or (attribute::id = 'HTLN')]">
            <PrimaryFullNamePP>
                <xsl:apply-templates select="tsi:field[@id='TFN']" mode="Field">
                    <xsl:with-param name="mefId">PersonFirstNm</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='HTLN']" mode="Field">
                    <xsl:with-param name="mefId">PersonLastNm</xsl:with-param>
                </xsl:apply-templates>
            </PrimaryFullNamePP>
        </xsl:if>
        <xsl:if test="tsi:field[(attribute::id = 'SFN') or (attribute::id = 'HMEFSLN')]">
            <SpouseFullNamePP>
                <xsl:apply-templates select="tsi:field[@id='SFN']" mode="Field">
                    <xsl:with-param name="mefId">PersonFirstNm</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='HMEFSLN']" mode="Field">
                    <xsl:with-param name="mefId">PersonLastNm</xsl:with-param>
                </xsl:apply-templates>
            </SpouseFullNamePP>
        </xsl:if>
        <xsl:if test="tsi:field[@id = 'ZIP']">
            <USAddress>
                <xsl:apply-templates select="tsi:field[@id='ZIP']" mode="Field">
                    <xsl:with-param name="mefId">ZIPCd</xsl:with-param>
                </xsl:apply-templates>
            </USAddress>
        </xsl:if>
        <xsl:apply-templates select="tsi:field[@id='RSTA']" mode="Field">
            <xsl:with-param name="mefId">PrimaryResidentStateAbbreviationCdPP</xsl:with-param>
        </xsl:apply-templates>
        <xsl:if test="tsi:table[@id='TPSTATES']">
            <PrimaryResidentStatesInfoGrpPP>
                <xsl:copy-of select="tsi:table[@id='TPSTATES'][@uuid]"/>
                <xsl:for-each select="tsi:table[@id='TPSTATES']/tsi:row">
                    <ResidentStateInfoPP>
                        <xsl:copy-of select="@uuid"/>
                        <xsl:apply-templates select="tsi:field[@id='TPSTATES']" mode="Field">
                            <xsl:with-param name="mefId">ResidentStateAbbreviationCdPP</xsl:with-param>
                        </xsl:apply-templates>
                    </ResidentStateInfoPP>
                </xsl:for-each>
            </PrimaryResidentStatesInfoGrpPP>
        </xsl:if>
        <xsl:if test="tsi:table[@id='SPSTATES']">
            <SpouseResidentStatesInfoGrpPP>
                <xsl:copy-of select="@uuid"/>
                <xsl:for-each select="tsi:table[@id='SPSTATES']/tsi:row">
                    <ResidentStateInfoPP>
                        <xsl:copy-of select="@uuid"/>
                        <xsl:apply-templates select="tsi:field[@id='SPSTATES']" mode="Field">
                            <xsl:with-param name="mefId">ResidentStateAbbreviationCdPP</xsl:with-param>
                        </xsl:apply-templates>
                    </ResidentStateInfoPP>
                </xsl:for-each>
            </SpouseResidentStatesInfoGrpPP>
        </xsl:if>
        
        <xsl:if test="tsi:field[(attribute::id = 'DXT') or (attribute::id = 'DEPTY') or (attribute::id = 'DXTN') or (attribute::id = 'DEPTN') ]">
            <PrimaryInfoDependentOnOtherReturnPP>
                <xsl:choose> <!-- YES-NO field -->
                    <xsl:when test="tsi:field[@id='DXT']">
                        <FilerCanBeClaimedAsDependentIndPP>true</FilerCanBeClaimedAsDependentIndPP>
                    </xsl:when>
                    <xsl:when test="tsi:field[@id='DXTN']">
                        <FilerCanBeClaimedAsDependentIndPP>false</FilerCanBeClaimedAsDependentIndPP>
                    </xsl:when>
                </xsl:choose>     
                <xsl:choose> <!-- YES-NO field -->
                    <xsl:when test="tsi:field[@id='DEPTY']">
                        <FilerIsClaimedAsDependentIndPP>true</FilerIsClaimedAsDependentIndPP>
                    </xsl:when>
                    <xsl:when test="tsi:field[@id='DEPTN']">
                        <FilerIsClaimedAsDependentIndPP>false</FilerIsClaimedAsDependentIndPP>
                    </xsl:when>
                </xsl:choose>
            </PrimaryInfoDependentOnOtherReturnPP>
        </xsl:if>
        
        <xsl:if test="tsi:field[(attribute::id = 'DXS') or (attribute::id = 'DEPSY') or (attribute::id = 'DXSN') or (attribute::id = 'DEPSN') ]">
            <SpouseInfoDependentOnOtherReturnPP>
                <xsl:choose> <!-- YES-NO field -->
                    <xsl:when test="tsi:field[@id='DXS']">
                        <FilerCanBeClaimedAsDependentIndPP>true</FilerCanBeClaimedAsDependentIndPP>
                    </xsl:when>
                    <xsl:when test="tsi:field[@id='DXSN']">
                        <FilerCanBeClaimedAsDependentIndPP>false</FilerCanBeClaimedAsDependentIndPP>
                    </xsl:when>
                </xsl:choose>     
                <xsl:choose> <!-- YES-NO field -->
                    <xsl:when test="tsi:field[@id='DEPSY']">
                        <FilerIsClaimedAsDependentIndPP>true</FilerIsClaimedAsDependentIndPP>
                    </xsl:when>
                    <xsl:when test="tsi:field[@id='DEPSN']">
                        <FilerIsClaimedAsDependentIndPP>false</FilerIsClaimedAsDependentIndPP>
                    </xsl:when>
                </xsl:choose>
            </SpouseInfoDependentOnOtherReturnPP>
        </xsl:if>
        
    </xsl:template>
    <xsl:template match="tsi:form[@id='F1040']" mode="Filer-F1040">
        <xsl:apply-templates select="tsi:field[@id='SSN']" mode="Field">
            <xsl:with-param name="mefId">PrimarySSN</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='SSSN']" mode="Field">
            <xsl:with-param name="mefId">SpouseSSN</xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>

    <!-- Mapping for SelfSelectPINGrp -->
    <xsl:template match="tsi:form[@id='FINFOWKS']" name="SelfSelectPINGrp" mode="SelfSelectPINGrp">
        <xsl:if test="tsi:field[(@id = 'TDOB') or (@id = 'SDOB')]">
            <SelfSelectPINGrp>
                <xsl:apply-templates select="tsi:field[@id='TDOB']" mode="BirthDate">
                    <xsl:with-param name="mefId">PrimaryBirthDt</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='SDOB']" mode="BirthDate">
                    <xsl:with-param name="mefId">SpouseBirthDt</xsl:with-param>
                </xsl:apply-templates>
            </SelfSelectPINGrp>
        </xsl:if>
    </xsl:template>
    
    <!-- Mapping for IRS1040 -->
    <xsl:template match="tsi:form[@id='F1040'] | tsi:form[@id='FINFOWKS'] | tsi:form[@id='FONLINE']" mode="IRS1040" name="IRS1040">
        <IRS1040>
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="tsi:form[@id='F1040']" mode="IRS1040-F1040"/>
            <xsl:apply-templates select="tsi:form[@id='FINFOWKS']" mode="IRS1040-FINFOWKS"/>
            <xsl:apply-templates select="tsi:form[@id='FONLINE']" mode="IRS1040-FONLINE"/>
        </IRS1040>
    </xsl:template>
    
    <xsl:template match="tsi:form[@id='F1040']" name="IRS1040-F1040" mode="IRS1040-F1040">
        <xsl:apply-templates select="tsi:field[@id='L6A']" mode="CheckboxField">
            <xsl:with-param name="mefId">ExemptPrimaryInd</xsl:with-param>
        </xsl:apply-templates> 
        <xsl:apply-templates select="tsi:field[@id='L7']" mode="Field">
            <xsl:with-param name="mefId">WagesSalariesAndTipsAmt</xsl:with-param>
        </xsl:apply-templates> 
        <xsl:apply-templates select="tsi:field[@id='L8A']" mode="Field">
            <xsl:with-param name="mefId">TaxableInterestAmt</xsl:with-param>
        </xsl:apply-templates> 
        <xsl:apply-templates select="tsi:field[@id='L8B']" mode="Field">
            <xsl:with-param name="mefId">TaxExemptInterestAmt</xsl:with-param>
        </xsl:apply-templates> 
        <xsl:apply-templates select="tsi:field[@id='L9']" mode="Field">
            <xsl:with-param name="mefId">OrdinaryDividendsAmt</xsl:with-param>
        </xsl:apply-templates> 
        <xsl:apply-templates select="tsi:field[@id='L10']" mode="Field">
            <xsl:with-param name="mefId">StateLocalIncomeTaxRefundAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L11']" mode="Field">
            <xsl:with-param name="mefId">AlimonyReceivedAmt</xsl:with-param>
        </xsl:apply-templates> 
        <xsl:apply-templates select="tsi:field[@id='L11T']" mode="Field">
            <xsl:with-param name="mefId">TaxpayerAlimonyReceivedAmtPP</xsl:with-param>
        </xsl:apply-templates>
         <xsl:apply-templates select="tsi:field[@id='L11S']" mode="Field">
            <xsl:with-param name="mefId">SpouseAlimonyReceivedAmtPP</xsl:with-param>
        </xsl:apply-templates>  
        <xsl:apply-templates select="tsi:field[@id='L32C']" mode="Field">
            <xsl:with-param name="mefId">AmountRepaidToEmployerJuryDutyPP</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L15B']" mode="Field">
            <xsl:with-param name="mefId">TaxableIRAAmt</xsl:with-param>
        </xsl:apply-templates> 
        <xsl:apply-templates select="tsi:field[@id='L16B']" mode="Field">
            <xsl:with-param name="mefId">TotalTaxablePensionsAmt</xsl:with-param>
        </xsl:apply-templates> 
        <xsl:apply-templates select="tsi:field[@id='L19']" mode="Field">
            <xsl:with-param name="mefId">UnemploymentCompAmt</xsl:with-param>
        </xsl:apply-templates> 
        <xsl:apply-templates select="tsi:field[@id='L20AMOD']" mode="Field">
            <xsl:with-param name="mefId">SocSecBnftAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L20B']" mode="Field">
            <xsl:with-param name="mefId">TaxableSocSecAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L22']" mode="Field">
            <xsl:with-param name="mefId">TotalIncomeAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L23']" mode="Field">
            <xsl:with-param name="mefId">IRADeductionAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L24']" mode="Field">
            <xsl:with-param name="mefId">StudentLoanInterestDedAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L26']" mode="Field">
            <xsl:with-param name="mefId">MovingExpenseAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L27']" mode="Field">
            <xsl:with-param name="mefId">DeductibleSelfEmploymentTaxAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L29']" mode="Field">
            <xsl:with-param name="mefId">SelfEmpldSepSimpleQlfyPlansAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L30']" mode="Field">
            <xsl:with-param name="mefId">PnltyOnErlyWthdrwOfSavingsAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L31']" mode="Field">
            <xsl:with-param name="mefId">TotalAlimonyPaidAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L33']" mode="Field">
            <xsl:with-param name="mefId">AdjustedGrossIncomeAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='N6E']" mode="Field">
            <xsl:with-param name="mefId">TotalExemptionsCnt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='FYCOVX']" mode="Field">
            <xsl:with-param name="mefId">HealthCareRspnsCoverageInd</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='EDUEXP']" mode="Field">
            <xsl:with-param name="mefId">EducatorExpensesAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='BUSEXP']" mode="Field">
            <xsl:with-param name="mefId">BusExpnsReservistsAndOthersAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='HSA']" mode="Field">
            <xsl:with-param name="mefId">HealthSavingsAccountDedAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='TUITION']" mode="Field">
            <xsl:with-param name="mefId">TuitionAndFeesDedAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='DPAD']" mode="Field">
            <xsl:with-param name="mefId">DomesticProductionActDedAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L32W']" mode="Field">
            <xsl:with-param name="mefId">OtherAdjustmentsTotalAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='HDEPDEXE']" mode="Field">
            <xsl:with-param name="mefId">TotalDependentExemptions</xsl:with-param>
        </xsl:apply-templates>
        <xsl:for-each select="tsi:table[@id = 'ALIM']/tsi:row">
            <AlimonyAmountGrp>
                <xsl:copy-of select="@uuid"/>
                <xsl:apply-templates select="tsi:field[@id='ALNAME']" mode="Field">
                    <xsl:with-param name="mefId">RecipientNamePP</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='MRSSN']" mode="Field">
                    <xsl:with-param name="mefId">RecipientSSN</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='L31AMT']" mode="Field">
                    <xsl:with-param name="mefId">AlimonyPaidAmt</xsl:with-param>
                </xsl:apply-templates>
            </AlimonyAmountGrp>
        </xsl:for-each>
        <xsl:apply-templates select="tsi:field[@id='HHAVEAL']" mode="Boolean01">
            <xsl:with-param name="mefId">HaveAnyAlimonyPaidPP</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='HMOREAL']" mode="Boolean01">
            <xsl:with-param name="mefId">HaveAnyMoreAlimonyPaidPP</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L66']" mode="Field">
            <xsl:with-param name="mefId">OverpaidAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L69']" mode="Field">
            <xsl:with-param name="mefId">OwedAmt</xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>
    <xsl:template match="tsi:form[@id='FINFOWKS']" name="IRS1040-FINFOWKS" mode="IRS1040-FINFOWKS">
        <xsl:apply-templates select="tsi:field[@id='TDOD']" mode="Date">
            <xsl:with-param name="mefId">PrimaryDeathDt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='SDOD']" mode="Date">
            <xsl:with-param name="mefId">SpouseDeathDt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:choose>
            <xsl:when test="tsi:field[@id='FS1']/tsi:value[translate(text(),'x','X')='X' or translate(text(),'true','TRUE')='TRUE']">
                <xsl:apply-templates select="tsi:field[@id='FS1']" mode="EnumField">
                    <xsl:with-param name="mefId">IndividualReturnFilingStatusCd</xsl:with-param>
                    <xsl:with-param name="value">1</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="tsi:field[@id='FS2']/tsi:value[translate(text(),'x','X')='X' or translate(text(),'true','TRUE')='TRUE']">
                <xsl:apply-templates select="tsi:field[@id='FS2']" mode="EnumField">
                    <xsl:with-param name="mefId">IndividualReturnFilingStatusCd</xsl:with-param>
                    <xsl:with-param name="value">2</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="tsi:field[@id='FS3']/tsi:value[translate(text(),'x','X')='X' or translate(text(),'true','TRUE')='TRUE']">
                <xsl:apply-templates select="tsi:field[@id='FS3']" mode="EnumField">
                    <xsl:with-param name="mefId">IndividualReturnFilingStatusCd</xsl:with-param>
                    <xsl:with-param name="value">3</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="tsi:field[@id='FS4']/tsi:value[translate(text(),'x','X')='X' or translate(text(),'true','TRUE')='TRUE']">
                <xsl:apply-templates select="tsi:field[@id='FS4']" mode="EnumField">
                    <xsl:with-param name="mefId">IndividualReturnFilingStatusCd</xsl:with-param>
                    <xsl:with-param name="value">4</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="tsi:field[@id='FS5']/tsi:value[translate(text(),'x','X')='X' or translate(text(),'true','TRUE')='TRUE']">
                <xsl:apply-templates select="tsi:field[@id='FS5']" mode="EnumField">
                    <xsl:with-param name="mefId">IndividualReturnFilingStatusCd</xsl:with-param>
                    <xsl:with-param name="value">5</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
        </xsl:choose>
        <xsl:for-each select="tsi:table[@id = 'DEPEND']/tsi:row">
            <DependentDetail>
                <xsl:copy-of select="@uuid"/>
                <xsl:apply-templates select="tsi:field[@id='CHDOB']" mode="BirthDate">
                    <xsl:with-param name="mefId">DependentBirthDtPP</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='L6C1A']" mode="Field">
                    <xsl:with-param name="mefId">DependentFirstNm</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='L6C1C']" mode="Field">
                    <xsl:with-param name="mefId">DependentLastNm</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='L6C3']" mode="Field">
                    <xsl:with-param name="mefId">DependentSSN</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='CHDOD']" mode="Date">
                    <xsl:with-param name="mefId">DependentDeathDtPP</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='CD']" mode="Field">
                    <xsl:with-param name="mefId">DependentCodePP</xsl:with-param>
                </xsl:apply-templates>
            </DependentDetail>
        </xsl:for-each>
    </xsl:template>

    <!-- Mapping for FONLINE -->
    <xsl:template match="tsi:form[@id='FONLINE']" name="IRS1040-FONLINE" mode="IRS1040-FONLINE">
        <xsl:if test="tsi:table[@id='A4533']/tsi:row[@copy='1']/tsi:field[@id='PPROPEX'] | 
                      tsi:table[@id='A4533']/tsi:row[@copy='2']/tsi:field[@id='PPROPEX']">
            <PersonalPropertyRentalExpenses>
                <xsl:apply-templates select="tsi:table[@id='A4533']/tsi:row[@copy='1']/tsi:field[@id='PPROPEX']" mode="Field">
                    <xsl:with-param name="mefId">TaxpayerPersonalPropertyRentalExpensePP</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:table[@id='A4533']/tsi:row[@copy='2']/tsi:field[@id='PPROPEX']" mode="Field">
                    <xsl:with-param name="mefId">SpousePersonalPropertyRentalExpensePP</xsl:with-param>
                </xsl:apply-templates>
            </PersonalPropertyRentalExpenses>
        </xsl:if>
    </xsl:template>

    <!-- Mapping for IRSW2 -->
    <xsl:template match="tsi:form[@id='FW2']" mode="IRSW2">
      <IRSW2>
         <xsl:copy-of select="@uuid" />
         <xsl:attribute name="documentId">
            <xsl:value-of select="concat('IRWSW2-', count(preceding-sibling::tsi:form[@id='FW2'])+1)" />
         </xsl:attribute>
         <xsl:apply-templates select="tsi:field[@id='CORRX']" mode="Field">
            <xsl:with-param name="mefId">CorrectedW2Ind</xsl:with-param>
         </xsl:apply-templates>
               <xsl:apply-templates select="tsi:field[@id='D']" mode="NoDashField">
                <xsl:with-param name="mefId">EmployeeSSN</xsl:with-param>
        </xsl:apply-templates>
         <xsl:apply-templates select="tsi:field[@id='EIN']" mode="NoDashField">
            <xsl:with-param name="mefId">EmployerEIN</xsl:with-param>
         </xsl:apply-templates>
         <xsl:if test="tsi:field[@id='CA']">
            <EmployerNameControlTxt>
               <xsl:call-template name="NameBusinessControl">
                  <xsl:with-param name="input" select="tsi:field[@id='CA']" />
               </xsl:call-template>
            </EmployerNameControlTxt>
         </xsl:if>
         <xsl:if test="tsi:field[@id='CA'] or tsi:field[@id='CA2']">
            <EmployerName>
               <xsl:apply-templates select="tsi:field[@id='CA']" mode="Field">
                  <xsl:with-param name="mefId">BusinessNameLine1Txt</xsl:with-param>
               </xsl:apply-templates>
               <xsl:apply-templates select="tsi:field[@id='CA2']" mode="Field">
                  <xsl:with-param name="mefId">BusinessNameLine2Txt</xsl:with-param>
               </xsl:apply-templates>
            </EmployerName>
         </xsl:if>
         <xsl:choose>
            <xsl:when test="not(tsi:field[(attribute::id = 'FRNX')])">
               <xsl:if test="tsi:field[(attribute::id = 'CB') or (attribute::id = 'CADDR') or (attribute::id = 'CST') or (attribute::id = 'CZIP')]">
                  <EmployerUSAddress>
                     <xsl:apply-templates select="tsi:field[@id='CB']" mode="Field">
                        <xsl:with-param name="mefId">AddressLine1Txt</xsl:with-param>
                     </xsl:apply-templates>
                     <xsl:apply-templates select="tsi:field[@id='CADDR']" mode="Field">
                        <xsl:with-param name="mefId">CityNm</xsl:with-param>
                     </xsl:apply-templates>
                     <xsl:apply-templates select="tsi:field[@id='CST']" mode="Field">
                        <xsl:with-param name="mefId">StateAbbreviationCd</xsl:with-param>
                     </xsl:apply-templates>
                     <xsl:apply-templates select="tsi:field[@id='CZIP']" mode="Field">
                        <xsl:with-param name="mefId">ZIPCd</xsl:with-param>
                     </xsl:apply-templates>
                  </EmployerUSAddress>
               </xsl:if>
            </xsl:when>
            <xsl:otherwise>
               <xsl:if test="tsi:field[(attribute::id = 'CB') or (attribute::id = 'CADDR') or (attribute::id = 'CST') or (attribute::id = 'CZIP') or (attribute::id = 'CCOUNTRY')]">
                  <EmployerForeignAddress>
                     <xsl:apply-templates select="tsi:field[@id='CB']" mode="Field">
                        <xsl:with-param name="mefId">AddressLine1Txt</xsl:with-param>
                     </xsl:apply-templates>
                     <xsl:apply-templates select="tsi:field[@id='CADDR']" mode="Field">
                        <xsl:with-param name="mefId">CityNm</xsl:with-param>
                     </xsl:apply-templates>
                     <xsl:apply-templates select="tsi:field[@id='CST']" mode="Field">
                        <xsl:with-param name="mefId">ProvinceOrStateNm</xsl:with-param>
                     </xsl:apply-templates>
                     <xsl:apply-templates select="tsi:field[@id='CCOUNTRY']" mode="Field">
                        <xsl:with-param name="mefId">CountryCd</xsl:with-param>
                     </xsl:apply-templates>
                     <xsl:apply-templates select="tsi:field[@id='CZIP']" mode="Field">
                        <xsl:with-param name="mefId">ForeignPostalCd</xsl:with-param>
                     </xsl:apply-templates>
                  </EmployerForeignAddress>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
         <xsl:apply-templates select="tsi:field[@id='A']" mode="Field">
            <xsl:with-param name="mefId">ControlNum</xsl:with-param>
         </xsl:apply-templates>
         <!--Need to concat these fields for the full name of Mef, was getting a newline between each of the different fieleds and normalize-space gets rid of that and replaces it with a space-->
         <xsl:if test="tsi:field[@id='EFIRST'] or tsi:field[@id='ELAST']">
            <EmployeeNm>
               <xsl:value-of select="normalize-space(concat(tsi:field[@id='EFIRST'], tsi:field[@id='EMI'], tsi:field[@id='ELAST'], tsi:field[@id='ESF']))" />
            </EmployeeNm>
         </xsl:if>
         <xsl:choose>
            <xsl:when test="not(tsi:field[(attribute::id = 'EFRNX')])">
               <xsl:if test="tsi:field[(attribute::id = 'FA') or (attribute::id = 'FADDR') or (attribute::id = 'FST') or (attribute::id = 'FZIP')]">
                  <EmployeeUSAddress>
                     <xsl:apply-templates select="tsi:field[@id='FA']" mode="Field">
                        <xsl:with-param name="mefId">AddressLine1Txt</xsl:with-param>
                     </xsl:apply-templates>
                     <xsl:apply-templates select="tsi:field[@id='FADDR']" mode="Field">
                        <xsl:with-param name="mefId">CityNm</xsl:with-param>
                     </xsl:apply-templates>
                     <xsl:apply-templates select="tsi:field[@id='FST']" mode="Field">
                        <xsl:with-param name="mefId">StateAbbreviationCd</xsl:with-param>
                     </xsl:apply-templates>
                     <xsl:apply-templates select="tsi:field[@id='FZIP']" mode="Field">
                        <xsl:with-param name="mefId">ZIPCd</xsl:with-param>
                     </xsl:apply-templates>
                  </EmployeeUSAddress>
               </xsl:if>
            </xsl:when>
            <xsl:otherwise>
               <xsl:if test="tsi:field[(attribute::id = 'FA') or (attribute::id = 'FADDR') or (attribute::id = 'FST') or (attribute::id = 'FZIP') or (attribute::id = 'ECOUNTRY')]">
                  <EmployeeForeignAddress>
                     <xsl:apply-templates select="tsi:field[@id='FA']" mode="Field">
                        <xsl:with-param name="mefId">AddressLine1Txt</xsl:with-param>
                     </xsl:apply-templates>
                     <xsl:apply-templates select="tsi:field[@id='FADDR']" mode="Field">
                        <xsl:with-param name="mefId">CityNm</xsl:with-param>
                     </xsl:apply-templates>
                     <xsl:apply-templates select="tsi:field[@id='FST']" mode="Field">
                        <xsl:with-param name="mefId">ProvinceOrStateNm</xsl:with-param>
                     </xsl:apply-templates>
                     <xsl:apply-templates select="tsi:field[@id='ECOUNTRY']" mode="Field">
                        <xsl:with-param name="mefId">CountryCd</xsl:with-param>
                     </xsl:apply-templates>
                     <xsl:apply-templates select="tsi:field[@id='FZIP']" mode="Field">
                        <xsl:with-param name="mefId">ForeignPostalCd</xsl:with-param>
                     </xsl:apply-templates>
                  </EmployeeForeignAddress>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
         <xsl:apply-templates select="tsi:field[@id='WAGES']" mode="RoundedIntField">
            <xsl:with-param name="mefId">WagesAmt</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="tsi:field[@id='FEDTAX']" mode="RoundedIntField">
            <xsl:with-param name="mefId">WithholdingAmt</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="tsi:field[@id='SSWAGES']" mode="RoundedIntField">
            <xsl:with-param name="mefId">SocialSecurityWagesAmt</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="tsi:field[@id='SSTAX']" mode="RoundedIntField">
            <xsl:with-param name="mefId">SocialSecurityTaxAmt</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="tsi:field[@id='MEDWAGES']" mode="RoundedIntField">
            <xsl:with-param name="mefId">MedicareWagesAndTipsAmt</xsl:with-param>
         </xsl:apply-templates>
          <xsl:apply-templates select="tsi:field[@id='MEDTAX']" mode="RoundedIntField">
            <xsl:with-param name="mefId">MedicareTaxWithheldAmt</xsl:with-param>
         </xsl:apply-templates>
          <xsl:apply-templates select="tsi:field[@id='SSTIPS']" mode="RoundedIntField">
            <xsl:with-param name="mefId">SocialSecurityTipsAmt</xsl:with-param>
         </xsl:apply-templates>
          <xsl:apply-templates select="tsi:field[@id='ALLOCTIP']" mode="RoundedIntField">
            <xsl:with-param name="mefId">AllocatedTipsAmt</xsl:with-param>
         </xsl:apply-templates>
          <xsl:apply-templates select="tsi:field[@id='MT20']" mode="Field">
              <xsl:with-param name="mefId">UnreportedMoreThanTwentyDollarsTipsAmtPP</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="tsi:field[@id='LT20']" mode="Field">
              <xsl:with-param name="mefId">UnreportedLessThanTwentyDollarsTipsAmtPP</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="tsi:field[@id='NONCASH']" mode="Field">
              <xsl:with-param name="mefId">UnreportedNonCashTipsAmtPP</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="tsi:field[@id='ACTALLOC']" mode="Field">
              <xsl:with-param name="mefId">UnreportedActualAllocatedTipsAmtPP</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="tsi:field[@id='SHARING']" mode="Field">
              <xsl:with-param name="mefId">UnreportedSharedTipsAmtPP</xsl:with-param>
          </xsl:apply-templates> 
          <xsl:apply-templates select="tsi:field[@id='HTOTTIP']" mode="Field">
              <xsl:with-param name="mefId">TotalTipsPP</xsl:with-param>
          </xsl:apply-templates>         
          <!-- Need to make this mutually exclusive in PT - Yes or No -->
          <xsl:if test="tsi:field[@id='GOVX']/tsi:value[translate(text(),'x','X')='X' or translate(text(),'true','TRUE')='TRUE']">
              <xsl:apply-templates select="tsi:field[@id='GOVX']" mode="EnumField">
                  <xsl:with-param name="mefId">UnreportedTipsGovEmployeeIndPP</xsl:with-param>
                  <xsl:with-param name="value">true</xsl:with-param>
              </xsl:apply-templates>
          </xsl:if>
         <xsl:apply-templates select="tsi:field[@id='DCB']" mode="RoundedIntField">
            <xsl:with-param name="mefId">DependentCareBenefitsAmt</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="tsi:field[@id='NQAMOUNT']" mode="RoundedIntField">
            <xsl:with-param name="mefId">NonqualifiedPlansAmt</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="tsi:field[@id='NQPLANS']" mode="Field">
            <xsl:with-param name="mefId">NonQualifiedPlansDistributionAmtPP</xsl:with-param>
         </xsl:apply-templates>
         <xsl:if test="tsi:table[@id='CODES']/tsi:row">
            <xsl:for-each select="tsi:table[@id='CODES']/tsi:row">
                <EmployersUseGrp>
                  <xsl:apply-templates select="tsi:field[@id='CODESC']" mode="Field">
                     <xsl:with-param name="mefId">EmployersUseCd</xsl:with-param>
                  </xsl:apply-templates>
                  <xsl:apply-templates select="tsi:field[@id='CODESA']" mode="RoundedIntField">
                     <xsl:with-param name="mefId">EmployersUseAmt</xsl:with-param>
                  </xsl:apply-templates>
                  <xsl:apply-templates select="tsi:field[@id='CODESA']" mode="Field">
                     <xsl:with-param name="mefId">EmployersUseAmtCS</xsl:with-param>
                  </xsl:apply-templates>
                </EmployersUseGrp>
            </xsl:for-each>
         </xsl:if>
         <xsl:apply-templates select="tsi:field[@id='STATX']" mode="CheckboxField">
            <xsl:with-param name="mefId">StatutoryEmployeeInd</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="tsi:field[@id='PPX']" mode="CheckboxField">
            <xsl:with-param name="mefId">RetirementPlanInd</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="tsi:field[@id='SICKPAYX']" mode="CheckboxField">
            <xsl:with-param name="mefId">ThirdPartySickPayInd</xsl:with-param>
         </xsl:apply-templates>
         <xsl:if test="tsi:table[@id='OTHR']/tsi:row">
            <xsl:for-each select="tsi:table[@id='OTHR']/tsi:row">
                <OtherDeductionsBenefitsGrp>
                  <xsl:apply-templates select="tsi:field[@id='OTHERD']" mode="Field">
                     <xsl:with-param name="mefId">Desc</xsl:with-param>
                  </xsl:apply-templates>
                  <xsl:apply-templates select="tsi:field[@id='OTHERA']" mode="RoundedIntField">
                     <xsl:with-param name="mefId">Amt</xsl:with-param>
                  </xsl:apply-templates>
                </OtherDeductionsBenefitsGrp>
            </xsl:for-each>
         </xsl:if>
         <xsl:for-each select="tsi:table[@id='STATE']/tsi:row">
            <W2StateLocalTaxGrp>
               <W2StateTaxGrp>
                  <xsl:apply-templates select="tsi:field[@id='STATEST']" mode="Field">
                     <xsl:with-param name="mefId">StateAbbreviationCd</xsl:with-param>
                  </xsl:apply-templates>
                  <xsl:apply-templates select="tsi:field[@id='STATEID']" mode="Field">
                     <xsl:with-param name="mefId">EmployerStateIdNum</xsl:with-param>
                  </xsl:apply-templates>
                  <xsl:apply-templates select="tsi:field[@id='STATEWAG']" mode="RoundedIntField">
                     <xsl:with-param name="mefId">StateWagesAmt</xsl:with-param>
                  </xsl:apply-templates>
                  <xsl:apply-templates select="tsi:field[@id='STATETAX']" mode="RoundedIntField">
                     <xsl:with-param name="mefId">StateIncomeTaxAmt</xsl:with-param>
                  </xsl:apply-templates>
                  <xsl:variable name="state">
                      <xsl:value-of select="tsi:field[@id='STATEST']"/>
                  </xsl:variable>
                  <xsl:for-each select="../../tsi:table[@id='LOCAL']/tsi:row">
                    <xsl:variable name="localState">
                        <xsl:value-of select="tsi:field[@id='LCLSTATE']"/>
                    </xsl:variable>
                    <!--LCLState is used for mapping, state-local pairings based on the state value are unique-->
                    <xsl:if test="$state = $localState">
                       <W2LocalTaxGrp>
                         <xsl:apply-templates select="tsi:field[@id='LCLWAGES']" mode="RoundedIntField">
                           <xsl:with-param name="mefId">LocalWagesAndTipsAmt</xsl:with-param>
                         </xsl:apply-templates>
                         <xsl:apply-templates select="tsi:field[@id='LCLTAX']" mode="RoundedIntField">
                           <xsl:with-param name="mefId">LocalIncomeTaxAmt</xsl:with-param>
                         </xsl:apply-templates>
                         <xsl:apply-templates select="tsi:field[@id='LCLNAME']" mode="Field">
                           <xsl:with-param name="mefId">LocalityNm</xsl:with-param>
                         </xsl:apply-templates>
                         <xsl:apply-templates select="tsi:field[@id='LCLWAGES']" mode="Field">
                           <xsl:with-param name="mefId">LocalWagesAndTipsAmtCS</xsl:with-param>
                         </xsl:apply-templates>
                         <xsl:apply-templates select="tsi:field[@id='LCLTAX']" mode="Field">
                           <xsl:with-param name="mefId">LocalIncomeTaxAmtCS</xsl:with-param>
                         </xsl:apply-templates>
                       </W2LocalTaxGrp>
                    </xsl:if>
                  </xsl:for-each>
                    <xsl:apply-templates select="tsi:field[@id='STATEWAG']" mode="Field">
                       <xsl:with-param name="mefId">StateWagesAmtCS</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='STATETAX']" mode="Field">
                       <xsl:with-param name="mefId">StateIncomeTaxAmtCS</xsl:with-param>
                    </xsl:apply-templates>
               </W2StateTaxGrp>
            </W2StateLocalTaxGrp>
         </xsl:for-each>
         <xsl:for-each select="tsi:table[@id='LOCAL']/tsi:row">
            <!--If an LCLSTATE value does not exist, it was not mapped so create another entry for it-->
            <xsl:if test="not(tsi:field[@id='LCLSTATE'])">
            <W2StateLocalTaxGrp>
               <W2StateTaxGrp>
                  <W2LocalTaxGrp>
                     <xsl:apply-templates select="tsi:field[@id='LCLWAGES']" mode="RoundedIntField">
                        <xsl:with-param name="mefId">LocalWagesAndTipsAmt</xsl:with-param>
                     </xsl:apply-templates>
                     <xsl:apply-templates select="tsi:field[@id='LCLTAX']" mode="RoundedIntField">
                        <xsl:with-param name="mefId">LocalIncomeTaxAmt</xsl:with-param>
                     </xsl:apply-templates>
                     <xsl:apply-templates select="tsi:field[@id='LCLNAME']" mode="Field">
                        <xsl:with-param name="mefId">LocalityNm</xsl:with-param>
                     </xsl:apply-templates>
                     <xsl:apply-templates select="tsi:field[@id='LCLWAGES']" mode="Field">
                        <xsl:with-param name="mefId">LocalWagesAndTipsAmtCS</xsl:with-param>
                     </xsl:apply-templates>
                     <xsl:apply-templates select="tsi:field[@id='LCLTAX']" mode="Field">
                        <xsl:with-param name="mefId">LocalIncomeTaxAmtCS</xsl:with-param>
                     </xsl:apply-templates>
                  </W2LocalTaxGrp>
               </W2StateTaxGrp>
            </W2StateLocalTaxGrp>
            </xsl:if>
         </xsl:for-each>
         <!--NSX should appear here, Y means N (nonstandard) and N means S (standard), it is a checkbox field -->
         <xsl:apply-templates select="tsi:field[@id='NSX']" mode="ConvertCheckboxField">
            <xsl:with-param name="mefId">StandardOrNonStandardCd</xsl:with-param>
            <xsl:with-param name="yesValue">N</xsl:with-param>
            <xsl:with-param name="noValue">S</xsl:with-param>
         </xsl:apply-templates>
         <xsl:if test="tsi:field[@id='EFIRST'] or tsi:field[@id='EMI'] or tsi:field[@id='ESF'] or tsi:field[@id='ELAST']">
            <EmployeeNmCS>
                <xsl:apply-templates select="tsi:field[@id='EFIRST']" mode="Field">
                    <xsl:with-param name="mefId">PersonFirstNm</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='EMI']" mode="Field">
                    <xsl:with-param name="mefId">PersonMiddleNm</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='ELAST']" mode="Field">
                    <xsl:with-param name="mefId">PersonLastNm</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='ESF']" mode="Field">
                    <xsl:with-param name="mefId">PersonNmSuffix</xsl:with-param>
                </xsl:apply-templates>
            </EmployeeNmCS>
         </xsl:if>
         <xsl:apply-templates select="tsi:field[@id='WAGES']" mode="Field">
            <xsl:with-param name="mefId">WagesAmtCS</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="tsi:field[@id='FEDTAX']" mode="Field">
            <xsl:with-param name="mefId">WithholdingAmtCS</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="tsi:field[@id='SSWAGES']" mode="Field">
            <xsl:with-param name="mefId">SocialSecurityWagesAmtCS</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="tsi:field[@id='SSTAX']" mode="Field">
            <xsl:with-param name="mefId">SocialSecurityTaxAmtCS</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="tsi:field[@id='MEDWAGES']" mode="Field">
            <xsl:with-param name="mefId">MedicareWagesAndTipsAmtCS</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="tsi:field[@id='MEDTAX']" mode="Field">
            <xsl:with-param name="mefId">MedicareTaxWithheldAmtCS</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="tsi:field[@id='SSTIPS']" mode="Field">
            <xsl:with-param name="mefId">SocialSecurityTipsAmtCS</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="tsi:field[@id='ALLOCTIP']" mode="Field">
            <xsl:with-param name="mefId">AllocatedTipsAmtCS</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="tsi:field[@id='DCB']" mode="Field">
            <xsl:with-param name="mefId">DependentCareBenefitsAmtCS</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="tsi:field[@id='NQAMOUNT']" mode="Field">
            <xsl:with-param name="mefId">NonqualifiedPlansAmtCS</xsl:with-param>
        </xsl:apply-templates>
        <xsl:if test="tsi:table[@id='OTHR']/tsi:row">
            <xsl:for-each select="tsi:table[@id='OTHR']/tsi:row">
                  <OtherDeductionsBenefitsGrpCS>
                  <xsl:apply-templates select="tsi:field[@id='OTHERD']" mode="Field">
                     <xsl:with-param name="mefId">Desc</xsl:with-param>
                  </xsl:apply-templates>
                  <xsl:apply-templates select="tsi:field[@id='OTHERA']" mode="Field">
                     <xsl:with-param name="mefId">Amt</xsl:with-param>
                  </xsl:apply-templates>
                </OtherDeductionsBenefitsGrpCS>
            </xsl:for-each>
         </xsl:if>
         
          <!--Clergy mappings for the clergy sub flow-->
          <xsl:apply-templates select="tsi:field[@id='CHA']" mode="Field">
              <xsl:with-param name="mefId">ClergyDesignatedHousingAmtPP</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="tsi:field[@id='CUHA']" mode="Field">
              <xsl:with-param name="mefId">ClergySmallestHousingAmtPP</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="tsi:field[@id='HCLTYPE']" mode="Field">
              <xsl:with-param name="mefId">W2ClergyFirstChoicePPR2</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="tsi:field[@id='HCLINC']" mode="Boolean01">
              <xsl:with-param name="mefId">HaveClergyChurchRelSectIncomeIndPP</xsl:with-param>
          </xsl:apply-templates>
          
          <xsl:choose> <!-- Enum fields mapped to different tpsids -->
              <xsl:when test="tsi:field[@id='CLHAX']">
                  <ClergySelfEmploymentTaxCdPP>ClergySETaxonHousing</ClergySelfEmploymentTaxCdPP>
              </xsl:when>
              <xsl:when test="tsi:field[@id='CLW2X']">
                  <ClergySelfEmploymentTaxCdPP>ClergySETaxonW2</ClergySelfEmploymentTaxCdPP>
              </xsl:when>
              <xsl:when test="tsi:field[@id='CLHAW2X']">
                  <ClergySelfEmploymentTaxCdPP>ClergySETaxonHousingandW2</ClergySelfEmploymentTaxCdPP>
              </xsl:when>
              <xsl:when test="tsi:field[@id='CLEX']">
                  <ClergySelfEmploymentTaxCdPP>ClergyExpemptfromSETax</ClergySelfEmploymentTaxCdPP>
              </xsl:when>
              <xsl:when test="tsi:field[@id='NCLW2X']">
                  <ClergySelfEmploymentTaxCdPP>NonClergySETaxonW2</ClergySelfEmploymentTaxCdPP>
              </xsl:when>
              <xsl:when test="tsi:field[@id='NCLEX']">
                  <ClergySelfEmploymentTaxCdPP>NonClergyExpemptfromSETax</ClergySelfEmploymentTaxCdPP>
              </xsl:when>
              <xsl:when test="tsi:field[@id='CLNONE']">
                  <ClergySelfEmploymentTaxCdPP>NoSSAndMedicareTax</ClergySelfEmploymentTaxCdPP>
              </xsl:when>
          </xsl:choose>
          
          <!-- Other Uncommon Situations mappings -->
          <xsl:apply-templates select="tsi:field[@id='FSX']" mode="CheckBoxBoolean-TrueIfChecked">
              <xsl:with-param name="mefId">WorkedOutsideUSIndPP</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="tsi:field[@id='PFLX']" mode="CheckBoxBoolean-TrueIfChecked">
              <xsl:with-param name="mefId">PaidFamilyLeaveIndPP</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="tsi:field[@id='INMATEX']" mode="CheckBoxBoolean-TrueIfChecked">
              <xsl:with-param name="mefId">InmateIndPP</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="tsi:field[@id='SPBX']" mode="CheckBoxBoolean-TrueIfChecked">
              <xsl:with-param name="mefId">SpouseCopyIndPP</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="tsi:field[@id='MILPAYX']" mode="CheckBoxBoolean-TrueIfChecked">
              <xsl:with-param name="mefId">ActiveDutyMilitaryIndPP</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="tsi:field[@id='HNEED4852']" mode="Boolean01">
              <xsl:with-param name="mefId">SubstituteFormIndPP</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="tsi:field[@id='GOTW2SE']" mode="Boolean01">
              <xsl:with-param name="mefId">InternationalOrgIndPP</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="tsi:field[@id='GOTTIPS']" mode="Boolean01">
              <xsl:with-param name="mefId">UnreportedTipsIndPP</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="tsi:field[@id='HMILEIN']" mode="Boolean01">
              <xsl:with-param name="mefId">MilitaryEINIndPP</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="tsi:field[@id='HPENSION']" mode="Boolean01">
              <xsl:with-param name="mefId">PensionPlanIndPP</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="tsi:field[@id='HEMPIMP']" mode="Boolean01">
              <xsl:with-param name="mefId">ImportedEmployerIndPPR2</xsl:with-param>
          </xsl:apply-templates>
          
          
      </IRSW2>
    </xsl:template>
    
    <!-- Mapping for 1095A -->
    <xsl:template match="tsi:form[@id='F1095A']" mode="IRS1095A">
        <IRS1095A>
            <xsl:copy-of select="@uuid"/>
            <xsl:attribute name="documentId">
                <xsl:value-of select="concat('IRS1095A-', count(preceding-sibling::tsi:form[@id='F1095A'])+1)" />
            </xsl:attribute> 
            <xsl:apply-templates select="tsi:field[@id='PAYERNM1']" mode="Field">
                <xsl:with-param name="mefId">PolicyIssuersNamePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='CORRX']" mode="CheckBoxBoolean-TrueIfChecked">
                <xsl:with-param name="mefId">Corrected1095AIndPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='PAYERID']" mode="Field">
                <xsl:with-param name="mefId">MarketplaceIdentiferPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='PLSTDATE']" mode="Date">
                <xsl:with-param name="mefId">PolicyStartDatePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='PLENDATE']" mode="Date">
                <xsl:with-param name="mefId">PolicyTerminationDatePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='RFNAME']" mode="Field">
                <xsl:with-param name="mefId">RecipientFirstNamePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='RLNAME']" mode="Field">
                <xsl:with-param name="mefId">RecipientLastNamePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='RECIPSSN']" mode="Field">
                <xsl:with-param name="mefId">RecipientSSNPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='RDOB']" mode="Date">
                <xsl:with-param name="mefId">RecipientBirthDtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:if test="tsi:field[(attribute::id = 'RECIPADD') or (attribute::id = 'RCTY') 
                                    or (attribute::id = 'RST') or (attribute::id = 'RZIP')]">
                <RecipientAddressPP>
                    <xsl:apply-templates select="tsi:field[@id='RECIPADD']" mode="Field">
                        <xsl:with-param name="mefId">AddressLine1Txt</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='RCTY']" mode="Field">
                        <xsl:with-param name="mefId">CityNm</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='RST']" mode="Field">
                        <xsl:with-param name="mefId">StateAbbreviationCd</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='RZIP']" mode="Field">
                        <xsl:with-param name="mefId">ZIPCd</xsl:with-param>
                    </xsl:apply-templates>
                </RecipientAddressPP>
            </xsl:if>
            <xsl:apply-templates select="tsi:field[@id='RSFNAME']" mode="Field">
                <xsl:with-param name="mefId">RecipientSpouseFirstNamePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='RSLNAME']" mode="Field">
                <xsl:with-param name="mefId">RecipientSpouseLastNamePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='RSSSN']" mode="Field">
                <xsl:with-param name="mefId">RecipientSpouseSSNPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='RSDOB']" mode="Date">
                <xsl:with-param name="mefId">RecipientSpouseBirthDtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='PAYPOLID']" mode="Field">
                <xsl:with-param name="mefId">MarketAssignedPolicyNumberPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='TOTPREM']" mode="Field">
                <xsl:with-param name="mefId">TotalPlanPremiumAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='TOTSLCSP']" mode="Field">
                <xsl:with-param name="mefId">TotalPremiumSLCSPAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='ADVCRED']" mode="Field">
                <xsl:with-param name="mefId">TotalAdvancedPTCAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:for-each select="tsi:table[@id = 'MNTHLYCV']/tsi:row">
                <MonthlyPTCInformationGrpPP>
                    <xsl:copy-of select="@uuid"/>
                    <xsl:apply-templates select="tsi:field[@id='MONTHCD']" mode="Field">
                        <xsl:with-param name="mefId">MonthCdPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='MTHPREM']" mode="Field">
                        <xsl:with-param name="mefId">MonthlyPlanPremiumAmtPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='MTHSLCSP']" mode="Field">
                        <xsl:with-param name="mefId">MonthlyPremiumSLCSPAmtPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='MTHADVCR']" mode="Field">
                        <xsl:with-param name="mefId">MonthlyAdvancedPTCAmtPP</xsl:with-param>
                    </xsl:apply-templates>
                </MonthlyPTCInformationGrpPP>
            </xsl:for-each>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='HOYCIND']">
                    <HaveOtherCoveredIndivIndPP>true</HaveOtherCoveredIndivIndPP>
                </xsl:when>
                <xsl:when test="tsi:field[@id='HONCIND']">
                    <HaveOtherCoveredIndivIndPP>false</HaveOtherCoveredIndivIndPP>
                </xsl:when>
            </xsl:choose>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='HAMYCIND']">
                    <HaveAnyMoreCoveredIndivIndPP>true</HaveAnyMoreCoveredIndivIndPP>
                </xsl:when>
                <xsl:when test="tsi:field[@id='HAMNCIND']">
                    <HaveAnyMoreCoveredIndivIndPP>false</HaveAnyMoreCoveredIndivIndPP>
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates select="tsi:field[@id='SCHC']" mode="Field">
                <xsl:with-param name="mefId">SchCLinkPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='SCHK1P']" mode="Field">
                <xsl:with-param name="mefId">SchK1PLinkPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='SCHF']" mode="Field">
                <xsl:with-param name="mefId">SchFLinkPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='SCHK1S']" mode="Field">
                <xsl:with-param name="mefId">SchK1SLinkPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='STRMTH']" mode="Field">
                <xsl:with-param name="mefId">LinkStartMonthNumberCdPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='ENDMTH']" mode="Field">
                <xsl:with-param name="mefId">LinkEndMonthNumberCdPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:for-each select="tsi:table[@id = 'CVRGHSLD']/tsi:row">
                <CoveredIndivInformationPP>
                    <xsl:copy-of select="@uuid"/>
                    <xsl:apply-templates select="tsi:field[@id='DFNAME']" mode="Field">
                        <xsl:with-param name="mefId">CoveredIndivFirstNamePP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='DLNAME']" mode="Field">
                        <xsl:with-param name="mefId">CoveredIndivLastNamePP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='DSSN']" mode="Field">
                        <xsl:with-param name="mefId">CoveredIndivSSNPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='DDOB']" mode="Date">
                        <xsl:with-param name="mefId">CoveredIndivBirthDtPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='DSTRCVM']" mode="Date">
                        <xsl:with-param name="mefId">CoveredIndivStartDtPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='DENDCVRM']" mode="Date">
                        <xsl:with-param name="mefId">CoveredIndivEndDtPP</xsl:with-param>
                    </xsl:apply-templates>
                </CoveredIndivInformationPP>
            </xsl:for-each>
            <xsl:if test="tsi:field[(@id = 'SHPOLSSN') or (@id = 'SHPOLSM') 
                                 or (@id = 'SHPOLEM') or (@id = 'SPMPPCT') 
                                 or (@id = 'SPSLCSPP') or (@id = 'SPADVPTC')]">
                <SharedPolicyAllocationPP>
                    <xsl:apply-templates select="tsi:field[@id='SHPOLSSN']" mode="Field">
                        <xsl:with-param name="mefId">SSNPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='SHPOLSM']" mode="Field">
                        <xsl:with-param name="mefId">StartMonthNumberCdPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='SHPOLEM']" mode="Field">
                        <xsl:with-param name="mefId">EndMonthNumberCdPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='SPMPPCT']" mode="Field">
                        <xsl:with-param name="mefId">MonthlyPremiumPctPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='SPSLCSPP']" mode="Field">
                        <xsl:with-param name="mefId">MonthlyPremiumSLCSPPctPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='SPADVPTC']" mode="Field">
                        <xsl:with-param name="mefId">MonthlyAdvancedPTCPctPP</xsl:with-param>
                    </xsl:apply-templates>
                </SharedPolicyAllocationPP>
            </xsl:if>
          
            
            <xsl:apply-templates select="tsi:field[@id='HACTCOPY']" mode="Field">
                <xsl:with-param name="mefId">FormCopyKeyForBusinessTypePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='HACTTYPE']" mode="Field">
                <xsl:with-param name="mefId">BusinessTypeIdPP</xsl:with-param>
            </xsl:apply-templates>
            
        </IRS1095A>
    </xsl:template>

    <!-- Mapping for 1095B -->
    <xsl:template match="tsi:form[@id='F1095B']" mode="IRS1095B">
        <IRS1095B>
            <xsl:copy-of select="@uuid"/>
            <xsl:attribute name="documentId">
                <xsl:value-of select="concat('IRS1095B-', count(preceding-sibling::tsi:form[@id='F1095B'])+1)" />
            </xsl:attribute> 
            <xsl:apply-templates select="tsi:field[@id='PAYERNM1']" mode="Field">
                <xsl:with-param name="mefId">IssuerOrProviderNamePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:if test="tsi:field[(attribute::id = 'PAYADD1') or (attribute::id = 'PCTY') 
                                    or (attribute::id = 'PST') or (attribute::id = 'PZIP')]">
                <IssuerOrProviderAddressPP>
                    <xsl:apply-templates select="tsi:field[@id='PAYADD1']" mode="Field">
                        <xsl:with-param name="mefId">AddressLine1Txt</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='PCTY']" mode="Field">
                        <xsl:with-param name="mefId">CityNm</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='PST']" mode="Field">
                        <xsl:with-param name="mefId">StateAbbreviationCd</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='PZIP']" mode="Field">
                        <xsl:with-param name="mefId">ZIPCd</xsl:with-param>
                    </xsl:apply-templates>
                </IssuerOrProviderAddressPP>
            </xsl:if>
            <xsl:apply-templates select="tsi:field[@id='PAYERID']" mode="Field">
                <xsl:with-param name="mefId">IssuerOrProviderEINPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='PCONPHON']" mode="Field">
                <xsl:with-param name="mefId">ContactPersonPhonePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='POLORGCD']" mode="Field">
                <xsl:with-param name="mefId">OriginOfPolicyCdPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='EMPNAME']" mode="Field">
                <xsl:with-param name="mefId">EmployerNamePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:if test="tsi:field[(attribute::id = 'EADDRESS') or (attribute::id = 'ECTY') 
                or (attribute::id = 'EST') or (attribute::id = 'EZIP')]">
                <EmployerAddressPP>
                    <xsl:apply-templates select="tsi:field[@id='EADDRESS']" mode="Field">
                        <xsl:with-param name="mefId">AddressLine1Txt</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='ECTY']" mode="Field">
                        <xsl:with-param name="mefId">CityNm</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='EST']" mode="Field">
                        <xsl:with-param name="mefId">StateAbbreviationCd</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='EZIP']" mode="Field">
                        <xsl:with-param name="mefId">ZIPCd</xsl:with-param>
                    </xsl:apply-templates>
                </EmployerAddressPP>
            </xsl:if>
            <xsl:apply-templates select="tsi:field[@id='EMPLOYID']" mode="Field">
                <xsl:with-param name="mefId">EmployerEINPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='SHOPPLAN']" mode="Field">
                <xsl:with-param name="mefId">PlanIsSHOPIndPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='SHOPPLID']" mode="Field">
                <xsl:with-param name="mefId">SHOPIdentifierPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='RECIPNAM']" mode="Field">
                <xsl:with-param name="mefId">ResponsibleIndivNamePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:if test="tsi:field[(attribute::id = 'RECIPADD') or (attribute::id = 'RCTY') 
                                    or (attribute::id = 'RST') or (attribute::id = 'RZIP')]">
                <ResponsibleIndivAddressPP>
                    <xsl:apply-templates select="tsi:field[@id='RECIPADD']" mode="Field">
                        <xsl:with-param name="mefId">AddressLine1Txt</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='RCTY']" mode="Field">
                        <xsl:with-param name="mefId">CityNm</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='RST']" mode="Field">
                        <xsl:with-param name="mefId">StateAbbreviationCd</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='RZIP']" mode="Field">
                        <xsl:with-param name="mefId">ZIPCd</xsl:with-param>
                    </xsl:apply-templates>
                </ResponsibleIndivAddressPP>
            </xsl:if>
            <xsl:apply-templates select="tsi:field[@id='RECIPSSN']" mode="Field">
                <xsl:with-param name="mefId">ResponsibleIndivSSNPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='RDOB']" mode="Date">
                <xsl:with-param name="mefId">ResponsibleIndivBirthDtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='HOYCIND']">
                    <HaveOtherCoveredIndivIndPP>true</HaveOtherCoveredIndivIndPP>
                </xsl:when>
                <xsl:when test="tsi:field[@id='HONCIND']">
                    <HaveOtherCoveredIndivIndPP>false</HaveOtherCoveredIndivIndPP>
                </xsl:when>
            </xsl:choose>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='HAMYCIND']">
                    <HaveAnyMoreCoveredIndivIndPP>true</HaveAnyMoreCoveredIndivIndPP>
                </xsl:when>
                <xsl:when test="tsi:field[@id='HAMNCIND']">
                    <HaveAnyMoreCoveredIndivIndPP>false</HaveAnyMoreCoveredIndivIndPP>
                </xsl:when>
            </xsl:choose>
            <xsl:for-each select="tsi:table[@id = 'COVINDIV']/tsi:row">
                <CoveredIndivGrpPP>
                    <xsl:copy-of select="@uuid"/>
                    <xsl:apply-templates select="tsi:field[@id='COVFNAM']" mode="Field">
                        <xsl:with-param name="mefId">PersonNmPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='COVSSN']" mode="Field">
                        <xsl:with-param name="mefId">SSNPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='COVDOB']" mode="Date">
                        <xsl:with-param name="mefId">PersonBirthDtPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='COV12MTH']" mode="Field">
                        <xsl:with-param name="mefId">AllYearIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIM1']" mode="Field">
                        <xsl:with-param name="mefId">JanuaryIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIM2']" mode="Field">
                        <xsl:with-param name="mefId">FebruaryIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIM3']" mode="Field">
                        <xsl:with-param name="mefId">MarchIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIM4']" mode="Field">
                        <xsl:with-param name="mefId">AprilIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIM5']" mode="Field">
                        <xsl:with-param name="mefId">MayIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIM6']" mode="Field">
                        <xsl:with-param name="mefId">JuneIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIM7']" mode="Field">
                        <xsl:with-param name="mefId">JulyIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIM8']" mode="Field">
                        <xsl:with-param name="mefId">AugustIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIM9']" mode="Field">
                        <xsl:with-param name="mefId">SeptemberIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIM10']" mode="Field">
                        <xsl:with-param name="mefId">OctoberIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIM11']" mode="Field">
                        <xsl:with-param name="mefId">NovemberIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIM12']" mode="Field">
                        <xsl:with-param name="mefId">DecemberIndPP</xsl:with-param>
                    </xsl:apply-templates>
                </CoveredIndivGrpPP>
            </xsl:for-each>
        </IRS1095B>
    </xsl:template>

    <!-- Mapping for 1095C -->
    <xsl:template match="tsi:form[@id='F1095C']" mode="IRS1095C">
        <IRS1095C>
            <xsl:copy-of select="@uuid"/>
            <xsl:attribute name="documentId">
                <xsl:value-of select="concat('IRS1095C-', count(preceding-sibling::tsi:form[@id='F1095C'])+1)" />
            </xsl:attribute> 
            <xsl:apply-templates select="tsi:field[@id='ERNAME']" mode="Field">
                <xsl:with-param name="mefId">ALENamePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='ERID']" mode="Field">
                <xsl:with-param name="mefId">ALEEINPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='ERPHONE']" mode="Field">
                <xsl:with-param name="mefId">ALEPhoneNumberPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='EEFNAME']" mode="Field">
                <xsl:with-param name="mefId">EmployeeNamePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='EESSN']" mode="Field">
                <xsl:with-param name="mefId">EmployeeSSNPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:if test="tsi:field[(attribute::id = 'EEADDRES') or (attribute::id = 'EECTY') 
                                 or (attribute::id = 'EEST') or (attribute::id = 'EEZIP')]">
                <EmployeeAddressPP>
                    <xsl:apply-templates select="tsi:field[@id='EEADDRES']" mode="Field">
                        <xsl:with-param name="mefId">AddressLine1Txt</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='EECTY']" mode="Field">
                        <xsl:with-param name="mefId">CityNm</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='EEST']" mode="Field">
                        <xsl:with-param name="mefId">StateAbbreviationCd</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='EEZIP']" mode="Field">
                        <xsl:with-param name="mefId">ZIPCd</xsl:with-param>
                    </xsl:apply-templates>
                </EmployeeAddressPP>
            </xsl:if>
            <xsl:if test="tsi:field[(attribute::id = 'ERADDRES') or (attribute::id = 'ERCTY') 
                                 or (attribute::id = 'ERST') or (attribute::id = 'ERZIP')]">
                <ALEAddressPP>
                    <xsl:apply-templates select="tsi:field[@id='ERADDRES']" mode="Field">
                        <xsl:with-param name="mefId">AddressLine1Txt</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='ERCTY']" mode="Field">
                        <xsl:with-param name="mefId">CityNm</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='ERST']" mode="Field">
                        <xsl:with-param name="mefId">StateAbbreviationCd</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='ERZIP']" mode="Field">
                        <xsl:with-param name="mefId">ZIPCd</xsl:with-param>
                    </xsl:apply-templates>
                </ALEAddressPP>
            </xsl:if>
            <xsl:apply-templates select="tsi:field[@id='AOFRCOV']" mode="Field">
                <xsl:with-param name="mefId">AnnualCoverageOfferedCdPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='AESHRPR']" mode="Field">
                <xsl:with-param name="mefId">AnnualMonthlyPremiumAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='ASFHARBR']" mode="Field">
                <xsl:with-param name="mefId">AnnualSafeHarborCdPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:for-each select="tsi:table[@id = 'MNTHLY']/tsi:row">
                <PartIIGrpPP>
                    <xsl:copy-of select="@uuid"/>
                    <xsl:apply-templates select="tsi:field[@id='MONTHCD']" mode="Field">
                        <xsl:with-param name="mefId">MonthNamePP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='OFRCOV']" mode="Field">
                        <xsl:with-param name="mefId">CoverageOfferedCdPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='ESHRPREM']" mode="Field">
                        <xsl:with-param name="mefId">MonthlyPremiumAmtPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='SFHARBOR']" mode="Field">
                        <xsl:with-param name="mefId">SafeHarborCdPP</xsl:with-param>
                    </xsl:apply-templates>
                </PartIIGrpPP>
            </xsl:for-each>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='HOYCIND']">
                    <HaveOtherCoveredIndivIndPP>true</HaveOtherCoveredIndivIndPP>
                </xsl:when>
                <xsl:when test="tsi:field[@id='HONCIND']">
                    <HaveOtherCoveredIndivIndPP>false</HaveOtherCoveredIndivIndPP>
                </xsl:when>
            </xsl:choose>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='HAMYCIND']">
                    <HaveAnyMoreCoveredIndivIndPP>true</HaveAnyMoreCoveredIndivIndPP>
                </xsl:when>
                <xsl:when test="tsi:field[@id='HAMNCIND']">
                    <HaveAnyMoreCoveredIndivIndPP>false</HaveAnyMoreCoveredIndivIndPP>
                </xsl:when>
            </xsl:choose>
            <xsl:for-each select="tsi:table[@id = 'COVINDIV']/tsi:row">
                <CoveredIndivGrpPP>
                    <xsl:copy-of select="@uuid"/>
                    <xsl:apply-templates select="tsi:field[@id='COVFNAM']" mode="Field">
                        <xsl:with-param name="mefId">PersonNmPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='COVSSN']" mode="Field">
                        <xsl:with-param name="mefId">SSNPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='COVDOB']" mode="Date">
                        <xsl:with-param name="mefId">PersonBirthDtPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='COV12MTH']" mode="Field">
                        <xsl:with-param name="mefId">AllYearIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMJAN']" mode="Field">
                        <xsl:with-param name="mefId">JanuaryIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMFEB']" mode="Field">
                        <xsl:with-param name="mefId">FebruaryIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMMAR']" mode="Field">
                        <xsl:with-param name="mefId">MarchIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMAPR']" mode="Field">
                        <xsl:with-param name="mefId">AprilIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMMAY']" mode="Field">
                        <xsl:with-param name="mefId">MayIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMJUN']" mode="Field">
                        <xsl:with-param name="mefId">JuneIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMJUL']" mode="Field">
                        <xsl:with-param name="mefId">JulyIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMAUG']" mode="Field">
                        <xsl:with-param name="mefId">AugustIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMSEP']" mode="Field">
                        <xsl:with-param name="mefId">SeptemberIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMOCT']" mode="Field">
                        <xsl:with-param name="mefId">OctoberIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMNOV']" mode="Field">
                        <xsl:with-param name="mefId">NovemberIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMDEC']" mode="Field">
                        <xsl:with-param name="mefId">DecemberIndPP</xsl:with-param>
                    </xsl:apply-templates>
                </CoveredIndivGrpPP>
            </xsl:for-each>
        </IRS1095C>
    </xsl:template>
    
    <!-- Mapping for 1095Other -->
    <xsl:template match="tsi:form[@id='F1095OTH']" mode="IRS1095OTH">
        <IRS1095Other>
            <xsl:copy-of select="@uuid"/>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='HOYCIND']">
                    <HaveOtherCoveredIndivIndPP>true</HaveOtherCoveredIndivIndPP>
                </xsl:when>
                <xsl:when test="tsi:field[@id='HONCIND']">
                    <HaveOtherCoveredIndivIndPP>false</HaveOtherCoveredIndivIndPP>
                </xsl:when>
            </xsl:choose>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='HAMYCIND']">
                    <HaveAnyMoreCoveredIndivIndPP>true</HaveAnyMoreCoveredIndivIndPP>
                </xsl:when>
                <xsl:when test="tsi:field[@id='HAMNCIND']">
                    <HaveAnyMoreCoveredIndivIndPP>false</HaveAnyMoreCoveredIndivIndPP>
                </xsl:when>
            </xsl:choose>
            <xsl:for-each select="tsi:table[@id = 'COVINDIV']/tsi:row">
                <CoveredIndivGrpPP>
                    <xsl:copy-of select="@uuid"/>
                    <xsl:apply-templates select="tsi:field[@id='COVFNAM']" mode="Field">
                        <xsl:with-param name="mefId">PersonNmPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='COVSSN']" mode="Field">
                        <xsl:with-param name="mefId">SSNPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='COVDOB']" mode="Date">
                        <xsl:with-param name="mefId">PersonBirthDtPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='COV12MTH']" mode="Field">
                        <xsl:with-param name="mefId">AllYearIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMJAN']" mode="Field">
                        <xsl:with-param name="mefId">JanuaryIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMFEB']" mode="Field">
                        <xsl:with-param name="mefId">FebruaryIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMMAR']" mode="Field">
                        <xsl:with-param name="mefId">MarchIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMAPR']" mode="Field">
                        <xsl:with-param name="mefId">AprilIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMMAY']" mode="Field">
                        <xsl:with-param name="mefId">MayIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMJUN']" mode="Field">
                        <xsl:with-param name="mefId">JuneIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMJUL']" mode="Field">
                        <xsl:with-param name="mefId">JulyIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMAUG']" mode="Field">
                        <xsl:with-param name="mefId">AugustIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMSEP']" mode="Field">
                        <xsl:with-param name="mefId">SeptemberIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMOCT']" mode="Field">
                        <xsl:with-param name="mefId">OctoberIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMNOV']" mode="Field">
                        <xsl:with-param name="mefId">NovemberIndPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='CIMDEC']" mode="Field">
                        <xsl:with-param name="mefId">DecemberIndPP</xsl:with-param>
                    </xsl:apply-templates>
                </CoveredIndivGrpPP>
            </xsl:for-each>
        </IRS1095Other>
    </xsl:template>
    
    <!-- Mapping for IRS1040ScheduleA tables and fields -->
    <xsl:template match="tsi:form[@id='FSCHATI'] | tsi:form[@id='FSCHA19'] | tsi:form[@id='FSCHA']" name="IRS1040ScheduleA" mode="IRS1040ScheduleA">
        <IRS1040ScheduleA>
            <xsl:apply-templates select="tsi:form[@id='FSCHATI']" mode="IRS1040ScheduleA-FSCHATI"/>
            <xsl:apply-templates select="tsi:form[@id='FSCHA19']" mode="IRS1040ScheduleA-FSCHA19"/>
            <xsl:apply-templates select="tsi:form[@id='FSCHA']" mode="IRS1040ScheduleA-FSCHA"/>
        </IRS1040ScheduleA>
    </xsl:template>
    <xsl:template match="tsi:form[@id='FSCHATI']" mode="IRS1040ScheduleA-FSCHATI">
        <xsl:copy-of select="@uuid"/>
        <xsl:apply-templates select="tsi:field[@id='HAUTOREG']" mode="Field">
            <xsl:with-param name="mefId">HaveAnyAutoRegistrationIndPP</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id= 'HADDAUTO']" mode="Field">
            <xsl:with-param name="mefId">HaveAnyMoreAutoRegistrationIndPP</xsl:with-param>
        </xsl:apply-templates>
        <xsl:for-each select="tsi:table[@id = 'DMVFEES']/tsi:row">
            <AutoRegistrationGroupPP>
                <xsl:copy-of select="@uuid"/>
                <xsl:apply-templates select="tsi:field[@id='L3A1']" mode="Field">
                    <xsl:with-param name="mefId">MakeModelDescriptionPP</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='L3A']" mode="Field">
                    <xsl:with-param name="mefId">DeductibleRegistrationFeePP</xsl:with-param>
                </xsl:apply-templates>
            </AutoRegistrationGroupPP>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="tsi:form[@id='FSCHA19']" mode="IRS1040ScheduleA-FSCHA19">
        <xsl:apply-templates select="tsi:field[@id='L17']" mode="Field">
            <xsl:with-param name="mefId">GamblingLossesPP</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L12B']" mode="Field">
            <xsl:with-param name="mefId">LegalFeesPP</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='HOBBYEXT']" mode="Field">
            <xsl:with-param name="mefId">TaxpayerHobbyExpensePP</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='HOBBYEXS']" mode="Field">
            <xsl:with-param name="mefId">SpouseHobbyExpensePP</xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="tsi:form[@id='FSCHA']" mode="IRS1040ScheduleA-FSCHA">
        <xsl:apply-templates select="tsi:field[@id='L21']" mode="Field">
            <xsl:with-param name="mefId">TaxPreparationFeesAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L25']" mode="Field">
            <xsl:with-param name="mefId">CalcJobExpnssMiscDedAllwncAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L26']" mode="Field">
            <xsl:with-param name="mefId">NetMiscellaneousDeductionsAmt</xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>
    
    <!-- Mapping for IRS8962 -->
    <xsl:template match="tsi:form[@id='F8962'] | tsi:form[@id='TKEHAVE']" mode="IRS8962" name="IRS8962">
        <IRS8962>
            <xsl:apply-templates select="tsi:form[@id='F8962']" mode="IRS8962-F8962"/>
            <xsl:if test="tsi:form[@id='F8962']/tsi:field[@id='HITERNUM'] or tsi:form[@id='F8962']/tsi:field[@id='HDEDLI'] 
                       or tsi:form[@id='F8962']/tsi:field[@id='HPTCLI']   or tsi:form[@id='F8962']/tsi:field[@id='HDEDALT']
                       or tsi:form[@id='TKEHAVE']/tsi:field[@id='SECOUNT']">
                <SelfEmploymentCalculationDataPP>
                    <xsl:apply-templates select="tsi:form[@id='F8962']/tsi:field[@id='HITERNUM']" mode="Field">
                        <xsl:with-param name="mefId">IterationNumberPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:form[@id='F8962']/tsi:field[@id='HDEDLI']" mode="Field">
                        <xsl:with-param name="mefId">LastIterationDeductionPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:form[@id='F8962']/tsi:field[@id='HPTCLI']" mode="Field">
                        <xsl:with-param name="mefId">LastIterationPTCPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:form[@id='F8962']/tsi:field[@id='HDEDALT']" mode="Field">
                        <xsl:with-param name="mefId">AlternateDeductionPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:form[@id='TKEHAVE']/tsi:field[@id='SECOUNT']" mode="Field">
                        <xsl:with-param name="mefId">TPSIterationNumberPP</xsl:with-param>
                    </xsl:apply-templates>
                </SelfEmploymentCalculationDataPP>
            </xsl:if>
            
            <!-- 12/15/2014 CJP -->
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:form[@id='TKEHAVE']/tsi:field[@id='TYMARRDY']">
                    <YearOfMarriageIndPP>true</YearOfMarriageIndPP>
                </xsl:when>
                <xsl:when test="tsi:form[@id='TKEHAVE']/tsi:field[@id='TYMARRDN']">
                    <YearOfMarriageIndPP>false</YearOfMarriageIndPP>
                </xsl:when>
            </xsl:choose>
            <xsl:choose> <!-- YES-NO field --> <!-- mikea -->
                <xsl:when test="tsi:form[@id='TKEHAVE']/tsi:field[@id='DEPINCNY']">
                    <DependentIncomeIndPP>true</DependentIncomeIndPP>
                </xsl:when>
                <xsl:when test="tsi:form[@id='TKEHAVE']/tsi:field[@id='DEPINCNN']">
                    <DependentIncomeIndPP>false</DependentIncomeIndPP>
                </xsl:when>
            </xsl:choose>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:form[@id='TKEHAVE']/tsi:field[@id='SHRPOLCY']">
                    <SharedPolicyIndPP>true</SharedPolicyIndPP>
                </xsl:when>
                <xsl:when test="tsi:form[@id='TKEHAVE']/tsi:field[@id='SHRPOLCN']">
                    <SharedPolicyIndPP>false</SharedPolicyIndPP>
                </xsl:when>
            </xsl:choose>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:form[@id='TKEHAVE']/tsi:field[@id='SEHLTHEY']">
                    <SEMarketPlaceInsuranceIndPP>true</SEMarketPlaceInsuranceIndPP>
                </xsl:when>
                <xsl:when test="tsi:form[@id='TKEHAVE']/tsi:field[@id='SEHLTHEN']">
                    <SEMarketPlaceInsuranceIndPP>false</SEMarketPlaceInsuranceIndPP>
                </xsl:when>
            </xsl:choose>
        </IRS8962>
    </xsl:template>
    <xsl:template match="tsi:form[@id='F8962']" mode="IRS8962-F8962">
        <xsl:copy-of select="@uuid"/>
        <xsl:choose> <!-- YES-NO field -->
           <xsl:when test="tsi:field[@id='SPABUSEY']">
              <SpousalAbuseIndPP>true</SpousalAbuseIndPP>
           </xsl:when>
           <xsl:when test="tsi:field[@id='SPABUSEN']">
              <SpousalAbuseIndPP>false</SpousalAbuseIndPP>
           </xsl:when>
        </xsl:choose>
        <xsl:apply-templates select="tsi:field[@id='HSHIPIND']" mode="Field">
            <xsl:with-param name="mefId">ReliefInd</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='TOTEXCNT']" mode="Field">
            <xsl:with-param name="mefId">TotalExemptionsCnt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='MODAGI']" mode="Field">
            <xsl:with-param name="mefId">ModifiedAGIAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='DMODAGI']" mode="Field">
            <xsl:with-param name="mefId">TotalDependentsModifiedAGIAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='HSHLDINC']" mode="Field">
            <xsl:with-param name="mefId">HouseholdIncomeAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='PVRTYLVL']" mode="Field">
            <xsl:with-param name="mefId">PovertyLevelAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:choose> <!-- Enum fields mapped to different tpsids -->
            <xsl:when test="tsi:field[@id='AK']">
                <FederalPovertyTableLocCd>A</FederalPovertyTableLocCd>
            </xsl:when>
            <xsl:when test="tsi:field[@id='HI']">
                <FederalPovertyTableLocCd>B</FederalPovertyTableLocCd>
            </xsl:when>
            <xsl:when test="tsi:field[@id='OTH48DC']">
                <FederalPovertyTableLocCd>C</FederalPovertyTableLocCd>
            </xsl:when>
        </xsl:choose>
        <xsl:apply-templates select="tsi:field[@id='PVRTYPCT']" mode="Field">
            <xsl:with-param name="mefId">FederalPovertyLevelPct</xsl:with-param>
        </xsl:apply-templates>
        <xsl:choose> <!-- YES-NO field -->
            <xsl:when test="tsi:field[@id='HILTPVRT']">
                <HshldIncmBelowPTCThresholdInd>true</HshldIncmBelowPTCThresholdInd>
            </xsl:when>
            <xsl:when test="tsi:field[@id='M400PCT']">
                <HshldIncmBelowPTCThresholdInd>false</HshldIncmBelowPTCThresholdInd>
            </xsl:when>
        </xsl:choose>
        <xsl:apply-templates select="tsi:field[@id='APPFIGRT']" mode="Field">
            <xsl:with-param name="mefId">ApplicableFigureRt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='ANNCONTR']" mode="Field">
            <xsl:with-param name="mefId">AnnualContributionAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='MTHCONTR']" mode="Field">
            <xsl:with-param name="mefId">MonthlyContriHealthCareCvrAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:choose> <!-- YES-NO field -->
            <xsl:when test="tsi:field[@id='APORACMI']">
                <SharePolicyMarriedAltCalcInd>true</SharePolicyMarriedAltCalcInd>
            </xsl:when>
            <xsl:when test="tsi:field[@id='APRACMIN']">
                <SharePolicyMarriedAltCalcInd>false</SharePolicyMarriedAltCalcInd>
            </xsl:when>
        </xsl:choose>
        <xsl:choose> <!-- YES-NO field -->
            <xsl:when test="tsi:field[@id='F1095ASM']">
                <Form1095ASameMonthlyAmtInd>true</Form1095ASameMonthlyAmtInd>
            </xsl:when>
            <xsl:when test="tsi:field[@id='F1095ANO']">
                <Form1095ASameMonthlyAmtInd>false</Form1095ASameMonthlyAmtInd>
            </xsl:when>
        </xsl:choose>
        <xsl:choose> <!-- YES-NO field -->
            <xsl:when test="tsi:field[@id='HCPTCY']">
                <ACAPTCRefundMonitorControlPP>true</ACAPTCRefundMonitorControlPP>
            </xsl:when>
            <xsl:when test="tsi:field[@id='HCPTCN']">
                <ACAPTCRefundMonitorControlPP>false</ACAPTCRefundMonitorControlPP>
            </xsl:when>
        </xsl:choose>
        <xsl:if test="tsi:field[(attribute::id = 'ANNPREM') or (attribute::id = 'APSLCSP') 
                             or (attribute::id = 'ANNCONT') or (attribute::id = 'ANNMXAST') 
                             or (attribute::id = 'ANNTXCR') or (attribute::id = 'ANNADVCR')]">
            <AnnualPTCCalculationGrp>
                <xsl:apply-templates select="tsi:field[@id='ANNPREM']" mode="Field">
                    <xsl:with-param name="mefId">AnnualPremiumAmt</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='APSLCSP']" mode="Field">
                    <xsl:with-param name="mefId">AnnualPremiumSLCSPAmt</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='ANNCONT']" mode="Field">
                    <xsl:with-param name="mefId">AnnualContributionAmt</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='ANNMXAST']" mode="Field">
                    <xsl:with-param name="mefId">AnnualMaxPremiumAssistanceAmt</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='ANNTXCR']" mode="Field">
                    <xsl:with-param name="mefId">AnnualPremiumTaxCreditAllwAmt</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='ANNADVCR']" mode="Field">
                    <xsl:with-param name="mefId">AnnualAdvancedPTCAmt</xsl:with-param>
                </xsl:apply-templates>
            </AnnualPTCCalculationGrp>
        </xsl:if>
        <xsl:for-each select="tsi:table[@id = 'MNTHGRP']/tsi:row">
            <MonthlyPTCCalculationGrp>
                <xsl:copy-of select="@uuid"/>
                <xsl:apply-templates select="tsi:field[@id='MONTHCD']" mode="Field">
                    <xsl:with-param name="mefId">MonthCd</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='MTHPREM']" mode="Field">
                    <xsl:with-param name="mefId">MonthlyPremiumAmt</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='MTHSLCSP']" mode="Field">
                    <xsl:with-param name="mefId">MonthlyPremiumSLCSPAmt</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='MTHCONT']" mode="Field">
                    <xsl:with-param name="mefId">MonthlyContributionAmt</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='MTHMXAST']" mode="Field">
                    <xsl:with-param name="mefId">MonthlyMaxPremiumAssistanceAmt</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='MTHTXCR']" mode="Field">
                    <xsl:with-param name="mefId">MonthlyPremiumTaxCreditAllwAmt</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='MTHADVCR']" mode="Field">
                    <xsl:with-param name="mefId">MonthlyAdvancedPTCAmt</xsl:with-param>
                </xsl:apply-templates>
            </MonthlyPTCCalculationGrp>
        </xsl:for-each>
        <xsl:apply-templates select="tsi:field[@id='TOTPTC']" mode="Field">
            <xsl:with-param name="mefId">TotalPremiumTaxCreditAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='TOTADPTC']" mode="Field">
            <xsl:with-param name="mefId">TotalAdvancedPTCAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='RECONPTC']" mode="Field">
            <xsl:with-param name="mefId">ReconciledPremiumTaxCreditAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='EXADVPMT']" mode="Field">
            <xsl:with-param name="mefId">ExcessAdvncPaymentAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='ADDTXLIM']" mode="Field">
            <xsl:with-param name="mefId">AdditionalTaxLimitationAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='PTCLIABL']" mode="Field">
            <xsl:with-param name="mefId">PremiumTaxCreditTaxLiabAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:for-each select="tsi:table[@id = 'SHDPOLAL']/tsi:row">
            <SharedPolicyAllocationGrp>
                <xsl:copy-of select="@uuid"/>
                <!--<xsl:apply-templates select="tsi:field[@id='GRPNUM']" mode="Field">
                    <xsl:with-param name="mefId">GroupNumberCd</xsl:with-param>
                </xsl:apply-templates>-->
                <xsl:apply-templates select="tsi:field[@id='POLCYNUM']" mode="Field">
                    <xsl:with-param name="mefId">PolicyNum</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='SHPOLSSN']" mode="Field">
                    <xsl:with-param name="mefId">SSN</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='SHPOLSM']" mode="Field">
                    <xsl:with-param name="mefId">StartMonthNumberCd</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='SHPOLEM']" mode="Field">
                    <xsl:with-param name="mefId">EndMonthNumberCd</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='SPMPPCT']" mode="Field">
                    <xsl:with-param name="mefId">MonthlyPremiumPct</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='SPSLCSPP']" mode="Field">
                    <xsl:with-param name="mefId">MonthlyPremiumSLCSPPct</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='SPADVPTC']" mode="Field">
                    <xsl:with-param name="mefId">MonthlyAdvancedPTCPct</xsl:with-param>
                </xsl:apply-templates>
            </SharedPolicyAllocationGrp>
        </xsl:for-each>
        <xsl:choose> <!-- YES-NO field -->
            <xsl:when test="tsi:field[@id='SPALLIND']">
                <SharedPolicyAllocationInfoInd>true</SharedPolicyAllocationInfoInd>
            </xsl:when>
            <xsl:when test="tsi:field[@id='SPALLNO']">
                <SharedPolicyAllocationInfoInd>false</SharedPolicyAllocationInfoInd>
            </xsl:when>
        </xsl:choose>
        <xsl:apply-templates select="tsi:field[@id='__POR__']" mode="Boolean01">
            <xsl:with-param name="mefId">PartOfReturnPP</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='SEIDTOTA']" mode="Field">
            <xsl:with-param name="mefId">SelfEmployedHealthInsDedAmtPP</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='SEIDEXCH']" mode="Field">
            <xsl:with-param name="mefId">SelfEmployedExchangeHealthInsDedAmtPP</xsl:with-param>
        </xsl:apply-templates>
        <xsl:if test="tsi:field[(attribute::id = 'TPFAMSZ') or (attribute::id = 'TPMTHCNT') 
                             or (attribute::id = 'TPSTRMTH') or (attribute::id = 'TPENDMTH')]">
            <AltCalcForMarriagePrimaryGrp>
                <xsl:apply-templates select="tsi:field[@id='TPFAMSZ']" mode="Field">
                    <xsl:with-param name="mefId">FamilySizeCnt</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='TPMTHCNT']" mode="Field">
                    <xsl:with-param name="mefId">MonthlyContributionAmt</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='TPSTRMTH']" mode="Field">
                    <xsl:with-param name="mefId">StartMonthNumberCd</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='TPENDMTH']" mode="Field">
                    <xsl:with-param name="mefId">EndMonthNumberCd</xsl:with-param>
                </xsl:apply-templates>
            </AltCalcForMarriagePrimaryGrp>
        </xsl:if>
        <xsl:if test="tsi:field[(attribute::id = 'SPFAMSZ') or (attribute::id = 'SPMTHCNT') 
                             or (attribute::id = 'SPSTRMTH') or (attribute::id = 'SPENDMTH')]">
            <AltCalcForMarriageSpouseGrp>
                <xsl:apply-templates select="tsi:field[@id='SPFAMSZ']" mode="Field">
                    <xsl:with-param name="mefId">FamilySizeCnt</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='SPMTHCNT']" mode="Field">
                    <xsl:with-param name="mefId">MonthlyContributionAmt</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='SPSTRMTH']" mode="Field">
                    <xsl:with-param name="mefId">StartMonthNumberCd</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='SPENDMTH']" mode="Field">
                    <xsl:with-param name="mefId">EndMonthNumberCd</xsl:with-param>
                </xsl:apply-templates>
            </AltCalcForMarriageSpouseGrp>
        </xsl:if>
        <xsl:if test="tsi:field[(attribute::id = 'ATFAMSZ') or (attribute::id = 'ATSTRMTH') 
                             or (attribute::id = 'ATENDMTH')]">
            <AltCalcForMarriageInputsPrimaryCalcGrpPP>
                <xsl:apply-templates select="tsi:field[@id='ATFAMSZ']" mode="Field">
                    <xsl:with-param name="mefId">FamilySizeCntPP</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='ATSTRMTH']" mode="Field">
                    <xsl:with-param name="mefId">StartMonthNumberCdPP</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='ATENDMTH']" mode="Field">
                    <xsl:with-param name="mefId">EndMonthNumberCdPP</xsl:with-param>
                </xsl:apply-templates>
            </AltCalcForMarriageInputsPrimaryCalcGrpPP>
        </xsl:if>
        <xsl:if test="tsi:field[(attribute::id = 'ASFAMSZ') or (attribute::id = 'ASSTRMTH') 
                             or (attribute::id = 'ASENDMTH')]">
            <AltCalcForMarriageInputsSpouseCalcGrpPP>
                <xsl:apply-templates select="tsi:field[@id='ASFAMSZ']" mode="Field">
                    <xsl:with-param name="mefId">FamilySizeCntPP</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='ASSTRMTH']" mode="Field">
                    <xsl:with-param name="mefId">StartMonthNumberCdPP</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='ASENDMTH']" mode="Field">
                    <xsl:with-param name="mefId">EndMonthNumberCdPP</xsl:with-param>
                </xsl:apply-templates>
            </AltCalcForMarriageInputsSpouseCalcGrpPP>
        </xsl:if>
    
        <!-- 12/15/2014 -->
        <xsl:apply-templates select="tsi:field[(@id = 'MARDATE')]" mode="Field">
            <xsl:with-param name="mefId">MonthOfMarriagePP</xsl:with-param>
        </xsl:apply-templates>
        
    </xsl:template>
    
    <!-- Mapping for 1099INT -->

    <xsl:template match="tsi:form[@id='F1099INT']" >
        <IRS1099INTCS softwareId="14000000">

               <xsl:copy-of select="@uuid"/>
               <xsl:attribute name="documentId">
                  <xsl:value-of select="concat('IRS1099INT-', count(preceding-sibling::tsi:form[@id='F1099INT'])+1)" />
               </xsl:attribute> 

               <xsl:apply-templates select="tsi:field[@id='PNA1']" mode="PayerNameControlTxtField">
                  <xsl:with-param name="mefId">PayerNameControlTxtCS</xsl:with-param>
               </xsl:apply-templates>

               <xsl:apply-templates select="tsi:field[@id='PNA1']" mode="PayerNameField">
                  <xsl:with-param name="mefId">PayerNameCS</xsl:with-param>
               </xsl:apply-templates>

               <xsl:apply-templates select="tsi:field[@id='RECIPSSN']" mode="NoDashField">
                  <xsl:with-param name="mefId">RecipientSSNCS</xsl:with-param>
               </xsl:apply-templates>

               <xsl:apply-templates select="tsi:field[@id='HRECNAME']" mode="NoDashField">
                  <xsl:with-param name="mefId">RecipientNmCS</xsl:with-param>
               </xsl:apply-templates>

               <xsl:apply-templates select="tsi:field[@id='ACCTNUM']" mode="Field">
                  <xsl:with-param name="mefId">AccountNumCS</xsl:with-param>
               </xsl:apply-templates>

               <xsl:apply-templates select="tsi:field[@id='PAYERRTN']" mode="Field">
                  <xsl:with-param name="mefId">PayerRoutingTransitNumCS</xsl:with-param>
               </xsl:apply-templates>

               <xsl:apply-templates select="tsi:field[@id='L1']" mode="Field">
                  <xsl:with-param name="mefId">InterestIncomeAmtCS</xsl:with-param>
               </xsl:apply-templates>
               
               <xsl:apply-templates select="tsi:field[@id='L2']" mode="Field">
                  <xsl:with-param name="mefId">EarlyWithdrawalPenaltyAmtCS</xsl:with-param>
               </xsl:apply-templates>
               
               <xsl:apply-templates select="tsi:field[@id='L3']" mode="Field">
                  <xsl:with-param name="mefId">InterestOnBondsAndTreasuryAmtCS</xsl:with-param>
               </xsl:apply-templates>
               
               <xsl:apply-templates select="tsi:field[@id='L4']" mode="Field">
                  <xsl:with-param name="mefId">FederalIncomeTaxWithheldAmtCS</xsl:with-param>
               </xsl:apply-templates>
               
               <xsl:apply-templates select="tsi:field[@id='L5']" mode="Field">
                  <xsl:with-param name="mefId">InvestmentExpensesAmtCS</xsl:with-param>
               </xsl:apply-templates>
               
               <xsl:apply-templates select="tsi:field[@id='TAX']" mode="Field">
                  <xsl:with-param name="mefId">ForeignTaxPaidAmtCS</xsl:with-param>
               </xsl:apply-templates>
               
               <xsl:apply-templates select="tsi:field[@id='CTRY']" mode="Field">
                  <xsl:with-param name="mefId">CountryCdCS</xsl:with-param>
               </xsl:apply-templates>
               
               <xsl:apply-templates select="tsi:field[@id='EXINT']" mode="Field">
                  <xsl:with-param name="mefId">TaxExemptInterestAmtCS</xsl:with-param>
               </xsl:apply-templates>

               <xsl:apply-templates select="tsi:field[@id='INTP']" mode="Field">
                  <xsl:with-param name="mefId">ActivityBondInterestAmtCS</xsl:with-param>
               </xsl:apply-templates>
               
               <xsl:apply-templates select="tsi:field[@id='MDISC']" mode="Field">
                  <xsl:with-param name="mefId">MarketDiscountAmtCS</xsl:with-param>
               </xsl:apply-templates>
               
               <xsl:apply-templates select="tsi:field[@id='BPREM']" mode="Field">
                  <xsl:with-param name="mefId">BondPremiumAmtCS</xsl:with-param>
               </xsl:apply-templates>

               <xsl:apply-templates select="tsi:field[@id='CUSIP']" mode="Field">
                  <xsl:with-param name="mefId">TaxExemptCUSIPCS</xsl:with-param>
               </xsl:apply-templates>
               
      <xsl:if test="tsi:field[@id='STWH']">
        <F1099IntStateTaxGrpCS>
               <xsl:apply-templates select="tsi:field[@id='STWH']" mode="Field">
                  <xsl:with-param name="mefId">StateTaxWithheldAmtCS</xsl:with-param>
               </xsl:apply-templates>
               
               <xsl:apply-templates select="tsi:field[@id='ST2']" mode="Field">
                  <xsl:with-param name="mefId">StateAbbreviationCdCS</xsl:with-param>
               </xsl:apply-templates>
               
               <xsl:apply-templates select="tsi:field[@id='STATEID']" mode="Field">
                  <xsl:with-param name="mefId">PayersStateIdNumCS</xsl:with-param>
               </xsl:apply-templates>
        </F1099IntStateTaxGrpCS>
      </xsl:if>

      <xsl:if test="tsi:field[@id='STWH2']">
        <F1099IntStateTaxGrpCS>
               <xsl:apply-templates select="tsi:field[@id='STWH2']" mode="Field">
                  <xsl:with-param name="mefId">StateTaxWithheldAmtCS</xsl:with-param>
               </xsl:apply-templates>
               
               <xsl:apply-templates select="tsi:field[@id='STAT2']" mode="Field">
                  <xsl:with-param name="mefId">StateAbbreviationCdCS</xsl:with-param>
               </xsl:apply-templates>
               
               <xsl:apply-templates select="tsi:field[@id='STATEID2']" mode="Field">
                  <xsl:with-param name="mefId">PayersStateIdNumCS</xsl:with-param>
               </xsl:apply-templates>
        </F1099IntStateTaxGrpCS>
      </xsl:if>
               
      </IRS1099INTCS>
   </xsl:template>
    
    <!-- Mapping for IRS8965 -->
    <xsl:template match="tsi:form[@id='F8965'] | tsi:form[@id='FINFOWKS']" mode="IRS8965" name="IRS8965">
        <IRS8965>
            <xsl:apply-templates select="tsi:form[@id='F8965']" mode="IRS8965-F8965"/>
            <xsl:apply-templates select="tsi:form[@id='FINFOWKS']" mode="IRS8965-FINFOWKS"/>
        </IRS8965>
    </xsl:template>
    <xsl:template match="tsi:form[@id='FINFOWKS']" mode="IRS8965-FINFOWKS">
        <!-- PRO only field -->
        <xsl:if test="/tsi:FormML/tsi:formset[contains(@id,'1040PRO')]">
            <xsl:if test="tsi:field[@id='HCY']">
                <HealthCareRspnsCoverageIndInputPP>true</HealthCareRspnsCoverageIndInputPP>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tsi:form[@id='F8965']" mode="IRS8965-F8965">
            <xsl:copy-of select="@uuid"/>
            <xsl:if test="tsi:field[@id='MECPNSUM']">
                <SharedRespHshldCoverageWksPP>
                    <xsl:apply-templates select="tsi:field[@id='MECPNSUM']" mode="Field">
                        <xsl:with-param name="mefId">PenaltyAmountPP</xsl:with-param>
                    </xsl:apply-templates>
                </SharedRespHshldCoverageWksPP>
            </xsl:if>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='HIBELFTY']">
                    <HsldIncmBelowFlngThresholdInd>true</HsldIncmBelowFlngThresholdInd>
                </xsl:when>
                <xsl:when test="tsi:field[@id='HIBELFTN']">
                    <HsldIncmBelowFlngThresholdInd>false</HsldIncmBelowFlngThresholdInd>
                </xsl:when>
            </xsl:choose>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='GIBELFTY']">
                    <GrossIncmBelowFlngThresholdInd>true</GrossIncmBelowFlngThresholdInd>
                </xsl:when>
                <xsl:when test="tsi:field[@id='GIBELFTN']">
                    <GrossIncmBelowFlngThresholdInd>false</GrossIncmBelowFlngThresholdInd>
                </xsl:when>
            </xsl:choose>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='HANYOBY']">
                    <HaveAnyObtainedExemption>true</HaveAnyObtainedExemption>
                </xsl:when>
                <xsl:when test="tsi:field[@id='HANYOBN']">
                    <HaveAnyObtainedExemption>false</HaveAnyObtainedExemption>
                </xsl:when>
            </xsl:choose>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='HMOROBY']">
                    <HaveAnyMoreObtainedExemption>true</HaveAnyMoreObtainedExemption>
                </xsl:when>
                <xsl:when test="tsi:field[@id='HMOROBN']">
                    <HaveAnyMoreObtainedExemption>false</HaveAnyMoreObtainedExemption>
                </xsl:when>
            </xsl:choose>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='HANYRQY']">
                    <HaveAnyRequestExemption>true</HaveAnyRequestExemption>
                </xsl:when>
                <xsl:when test="tsi:field[@id='HANYRQN']">
                    <HaveAnyRequestExemption>false</HaveAnyRequestExemption>
                </xsl:when>
            </xsl:choose>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='HMORRQY']">
                    <HaveAnyMoreRequestExemption>true</HaveAnyMoreRequestExemption>
                </xsl:when>
                <xsl:when test="tsi:field[@id='HMORRQN']">
                    <HaveAnyMoreRequestExemption>false</HaveAnyMoreRequestExemption>
                </xsl:when>
            </xsl:choose>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='HCCVINDY']">
                    <HealthCareRspnsCoverageIndPP>true</HealthCareRspnsCoverageIndPP>
                </xsl:when>
                <xsl:when test="tsi:field[@id='HCCVINDY']">
                    <HealthCareRspnsCoverageIndPP>false</HealthCareRspnsCoverageIndPP>
                </xsl:when>
            </xsl:choose>
            <xsl:choose> <!-- YES-NO field -->
                <xsl:when test="tsi:field[@id='HSHDRSPC']">
                    <ACARefundMonitorControlPP>true</ACARefundMonitorControlPP>
                </xsl:when>
                <xsl:when test="tsi:field[@id='HSHDRSPN']">
                    <ACARefundMonitorControlPP>false</ACARefundMonitorControlPP>
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates select="tsi:field[@id='__POR__']" mode="Boolean01">
                <xsl:with-param name="mefId">PartOfReturnPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='DEMODAGI']" mode="Field">
                <xsl:with-param name="mefId">TotalDependentsModifiedAGIAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:for-each select="tsi:table[@id = 'OBTNEXEM']/tsi:row">
                <ObtndExemptCvrTaxHsldGrp>
                    <xsl:copy-of select="@uuid"/>
                    <xsl:apply-templates select="tsi:field[@id='PERSNAME']" mode="Field">
                        <xsl:with-param name="mefId">PersonNm</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='SSN']" mode="Field">
                        <xsl:with-param name="mefId">SSN</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='EXEMCERT']" mode="Field">
                        <xsl:with-param name="mefId">ExemptionCertificateNum</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='ESTRMTH']" mode="Field">
                        <xsl:with-param name="mefId">StartMonthNumberCdPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='EENDMTH']" mode="Field">
                        <xsl:with-param name="mefId">EndMonthNumberCdPP</xsl:with-param>
                    </xsl:apply-templates>
                </ObtndExemptCvrTaxHsldGrp>
            </xsl:for-each>
            <xsl:for-each select="tsi:table[@id = 'RECTHG']/tsi:row">
                <RequestExemptCvrTaxHsldGrp>
                    <xsl:copy-of select="@uuid"/>
                    <xsl:apply-templates select="tsi:field[@id='RPERSNAM']" mode="Field">
                        <xsl:with-param name="mefId">PersonNm</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='REXEMSSN']" mode="Field">
                        <xsl:with-param name="mefId">SSN</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='REXEMCD']" mode="Field">
                        <xsl:with-param name="mefId">ExemptionReasonCd</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:choose>
                        <xsl:when test="tsi:field[@id='REQEXEAY']">
                            <xsl:apply-templates select="tsi:field[@id='REQEXEAY']" mode="Field">
                                <xsl:with-param name="mefId">AllYearInd</xsl:with-param>
                            </xsl:apply-templates>
                        </xsl:when>
                        <xsl:otherwise>
                            <MonthIndicatorGrp>
                                <xsl:apply-templates select="tsi:field[@id='REJAN']" mode="Field">
                                    <xsl:with-param name="mefId">JanuaryInd</xsl:with-param>
                                </xsl:apply-templates>
                                <xsl:apply-templates select="tsi:field[@id='REFEB']" mode="Field">
                                    <xsl:with-param name="mefId">FebruaryInd</xsl:with-param>
                                </xsl:apply-templates>
                                <xsl:apply-templates select="tsi:field[@id='REMAR']" mode="Field">
                                    <xsl:with-param name="mefId">MarchInd</xsl:with-param>
                                </xsl:apply-templates>
                                <xsl:apply-templates select="tsi:field[@id='REAPR']" mode="Field">
                                    <xsl:with-param name="mefId">AprilInd</xsl:with-param>
                                </xsl:apply-templates>
                                <xsl:apply-templates select="tsi:field[@id='REMAY']" mode="Field">
                                    <xsl:with-param name="mefId">MayInd</xsl:with-param>
                                </xsl:apply-templates>
                                <xsl:apply-templates select="tsi:field[@id='REJUN']" mode="Field">
                                    <xsl:with-param name="mefId">JuneInd</xsl:with-param>
                                </xsl:apply-templates>
                                <xsl:apply-templates select="tsi:field[@id='REJUL']" mode="Field">
                                    <xsl:with-param name="mefId">JulyInd</xsl:with-param>
                                </xsl:apply-templates>
                                <xsl:apply-templates select="tsi:field[@id='REAUG']" mode="Field">
                                    <xsl:with-param name="mefId">AugustInd</xsl:with-param>
                                </xsl:apply-templates>
                                <xsl:apply-templates select="tsi:field[@id='RESEP']" mode="Field">
                                    <xsl:with-param name="mefId">SeptemberInd</xsl:with-param>
                                </xsl:apply-templates>
                                <xsl:apply-templates select="tsi:field[@id='REOCT']" mode="Field">
                                    <xsl:with-param name="mefId">OctoberInd</xsl:with-param>
                                </xsl:apply-templates>
                                <xsl:apply-templates select="tsi:field[@id='RENOV']" mode="Field">
                                    <xsl:with-param name="mefId">NovemberInd</xsl:with-param>
                                </xsl:apply-templates>
                                <xsl:apply-templates select="tsi:field[@id='REDEC']" mode="Field">
                                    <xsl:with-param name="mefId">DecemberInd</xsl:with-param>
                                </xsl:apply-templates>
                            </MonthIndicatorGrp>
                        </xsl:otherwise>
                    </xsl:choose>                    
                </RequestExemptCvrTaxHsldGrp>
            </xsl:for-each>
            <xsl:for-each select="tsi:table[@id = 'IRECTHG']/tsi:row">
                <NonCalculatedExemptCvrTaxHsldGrpPP>
                    <xsl:copy-of select="@uuid"/>
                    <xsl:apply-templates select="tsi:field[@id='IRPERNAM']" mode="Field">
                        <xsl:with-param name="mefId">PersonNmPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='IREXMSSN']" mode="Field">
                        <xsl:with-param name="mefId">SSNPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='IREXEMCD']" mode="Field">
                        <xsl:with-param name="mefId">ExemptionReasonCdPP</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:choose>
                        <xsl:when test="tsi:field[@id='IREQEXAY']">
                            <xsl:apply-templates select="tsi:field[@id='IREQEXAY']" mode="Field">
                                <xsl:with-param name="mefId">AllYearIndPP</xsl:with-param>
                            </xsl:apply-templates>
                        </xsl:when>
                        <xsl:otherwise>
                            <MonthIndicatorGrpPP>
                                <xsl:apply-templates select="tsi:field[@id='IREJAN']" mode="Field">
                                    <xsl:with-param name="mefId">JanuaryIndPP</xsl:with-param>
                                </xsl:apply-templates>
                                <xsl:apply-templates select="tsi:field[@id='IREFEB']" mode="Field">
                                    <xsl:with-param name="mefId">FebruaryIndPP</xsl:with-param>
                                </xsl:apply-templates>
                                <xsl:apply-templates select="tsi:field[@id='IREMAR']" mode="Field">
                                    <xsl:with-param name="mefId">MarchIndPP</xsl:with-param>
                                </xsl:apply-templates>
                                <xsl:apply-templates select="tsi:field[@id='IREAPR']" mode="Field">
                                    <xsl:with-param name="mefId">AprilIndPP</xsl:with-param>
                                </xsl:apply-templates>
                                <xsl:apply-templates select="tsi:field[@id='IREMAY']" mode="Field">
                                    <xsl:with-param name="mefId">MayIndPP</xsl:with-param>
                                </xsl:apply-templates>
                                <xsl:apply-templates select="tsi:field[@id='IREJUN']" mode="Field">
                                    <xsl:with-param name="mefId">JuneIndPP</xsl:with-param>
                                </xsl:apply-templates>
                                <xsl:apply-templates select="tsi:field[@id='IREJUL']" mode="Field">
                                    <xsl:with-param name="mefId">JulyIndPP</xsl:with-param>
                                </xsl:apply-templates>
                                <xsl:apply-templates select="tsi:field[@id='IREAUG']" mode="Field">
                                    <xsl:with-param name="mefId">AugustIndPP</xsl:with-param>
                                </xsl:apply-templates>
                                <xsl:apply-templates select="tsi:field[@id='IRESEP']" mode="Field">
                                    <xsl:with-param name="mefId">SeptemberIndPP</xsl:with-param>
                                </xsl:apply-templates>
                                <xsl:apply-templates select="tsi:field[@id='IREOCT']" mode="Field">
                                    <xsl:with-param name="mefId">OctoberIndPP</xsl:with-param>
                                </xsl:apply-templates>
                                <xsl:apply-templates select="tsi:field[@id='IRENOV']" mode="Field">
                                    <xsl:with-param name="mefId">NovemberIndPP</xsl:with-param>
                                </xsl:apply-templates>
                                <xsl:apply-templates select="tsi:field[@id='IREDEC']" mode="Field">
                                    <xsl:with-param name="mefId">DecemberIndPP</xsl:with-param>
                                </xsl:apply-templates>
                            </MonthIndicatorGrpPP>
                        </xsl:otherwise>
                    </xsl:choose>                    
                </NonCalculatedExemptCvrTaxHsldGrpPP>
            </xsl:for-each>
    </xsl:template>
    
    <!-- Mapping of IRS2255 -->
    <xsl:template match="tsi:form[@id='F25553T']" mode="IRS2555">
        <xsl:variable name="UUID_T" select="'030fe199-5af6-4e81-a477-01dac7ffd546'"/>
        <IRS2555>
            <xsl:attribute name="uuid">
                <xsl:value-of select="$UUID_T" />
            </xsl:attribute> 
            <xsl:apply-templates select="tsi:field[@id='L48']" mode="Field">
                <xsl:with-param name="mefId">HousingDeductionAmt</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L43']" mode="Field">
                <xsl:with-param name="mefId">TotalIncomeExclusionAmt</xsl:with-param>
            </xsl:apply-templates>
        </IRS2555>
    </xsl:template>
    <xsl:template match="tsi:form[@id='F25553S']" mode="IRS2555">
        <xsl:variable name="UUID_S" select="'b490e139-6295-4e84-8da2-087c0355ab09'"/>
        <IRS2555>
            <xsl:attribute name="uuid">
                <xsl:value-of select="$UUID_S" />
            </xsl:attribute> 
            <xsl:apply-templates select="tsi:field[@id='L48']" mode="Field">
                <xsl:with-param name="mefId">HousingDeductionAmt</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L43']" mode="Field">
                <xsl:with-param name="mefId">TotalIncomeExclusionAmt</xsl:with-param>
            </xsl:apply-templates>
        </IRS2555>
    </xsl:template>
    
    <!-- Mapping for IRS1040ScheduleC -->
    <xsl:template match="tsi:form[@id='FSCHC']" mode="IRS1040ScheduleC">
        <IRS1040ScheduleC>
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="tsi:field[@id='L1']" mode="Field">
                <xsl:with-param name="mefId">TotalGrossReceiptsAmt</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:form[@id='FW26C']" mode="FW26C"/>
        </IRS1040ScheduleC>
    </xsl:template>
    <xsl:template match="tsi:form[@id='FSCHC']/tsi:form[@id='FW26C']" mode="FW26C">
        <SelfEmpHealthInsDedPP>
            <xsl:apply-templates select="tsi:field[@id='LA']" mode="Field">
                <xsl:with-param name="mefId">HealthAndLongTermCareInsPremAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L9']" mode="Field">
                <xsl:with-param name="mefId">NetProfitFromBusinessAmtPP</xsl:with-param>
            </xsl:apply-templates>
        </SelfEmpHealthInsDedPP>
    </xsl:template>
    
    <!-- Mapping for IRS1040ScheduleF -->
    <xsl:template match="tsi:form[@id='FSCHF']" mode="IRS1040ScheduleF">
        <IRS1040ScheduleF>
            <xsl:copy-of select="@uuid"/>
            <xsl:if test="tsi:field[@id='L11']">
                <FarmIncomeCashMethodGrp>
                    <xsl:apply-templates select="tsi:field[@id='L11']" mode="Field">
                        <xsl:with-param name="mefId">GrossIncomeAmt</xsl:with-param>
                    </xsl:apply-templates>
                </FarmIncomeCashMethodGrp>
            </xsl:if>
            <xsl:apply-templates select="tsi:form[@id='FW26F']" mode="FW26F"/>
        </IRS1040ScheduleF>
    </xsl:template>
    <xsl:template match="tsi:form[@id='FSCHF']/tsi:form[@id='FW26F']" mode="FW26F">
        <SelfEmpHealthInsDedPP>
            <xsl:apply-templates select="tsi:field[@id='LA']" mode="Field">
                <xsl:with-param name="mefId">HealthAndLongTermCareInsPremAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L9']" mode="Field">
                <xsl:with-param name="mefId">NetProfitFromBusinessAmtPP</xsl:with-param>
            </xsl:apply-templates>
        </SelfEmpHealthInsDedPP>
    </xsl:template>
    
    <!-- Mapping for IRS1065ScheduleK1 -->
    <xsl:template match="tsi:form[@id='FK1PW']" mode="IRS1065ScheduleK1">
        <IRS1065ScheduleK1>
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="tsi:field[@id='L4D']" mode="Field">
                <xsl:with-param name="mefId">NetSTCapitalGainOrLossAmt</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L4E']" mode="Field">
                <xsl:with-param name="mefId">NetLTCapitalGainOrLossAmt</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:form[@id='FW26P']" mode="FW26P"/>
        </IRS1065ScheduleK1>
    </xsl:template>
    <xsl:template match="tsi:form[@id='FK1PW']/tsi:form[@id='FW26P']" mode="FW26P">
        <SelfEmpHealthInsDedPP>
            <xsl:apply-templates select="tsi:field[@id='LA']" mode="Field">
                <xsl:with-param name="mefId">HealthAndLongTermCareInsPremAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L9']" mode="Field">
                <xsl:with-param name="mefId">NetProfitFromBusinessAmtPP</xsl:with-param>
            </xsl:apply-templates>
        </SelfEmpHealthInsDedPP>
    </xsl:template>
    
    <!-- Mapping for IRS1120SScheduleK1 -->
    <xsl:template match="tsi:form[@id='FK1SW']" mode="IRS1120SScheduleK1">
        <IRS1120SScheduleK1>
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="tsi:field[@id='L4D']" mode="Field">
                <xsl:with-param name="mefId">NetSTCapitalGainOrLossAmt</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L4E']" mode="Field">
                <xsl:with-param name="mefId">NetLTCapitalGainOrLossAmt</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:form[@id='FW26S']" mode="FW26S"/>
        </IRS1120SScheduleK1>
    </xsl:template>
    <xsl:template match="tsi:form[@id='FK1SW']/tsi:form[@id='FW26S']" mode="FW26S">
        <SelfEmpHealthInsDedPP>
            <xsl:apply-templates select="tsi:field[@id='LA']" mode="Field">
                <xsl:with-param name="mefId">HealthAndLongTermCareInsPremAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='S4']" mode="Field">
                <xsl:with-param name="mefId">NetProfitFromBusinessAmtPP</xsl:with-param>
            </xsl:apply-templates>
        </SelfEmpHealthInsDedPP>
    </xsl:template>
    
    <!-- Mapping for IRS2119 -->
    <xsl:template match="tsi:form[@id='F2119']" mode="IRS2119">
        <IRS2119>
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="tsi:field[@id='L5']" mode="Field">
                <xsl:with-param name="mefId">GrossGainOrLossOnSaleAmtPP</xsl:with-param>
            </xsl:apply-templates>
        </IRS2119>
    </xsl:template>
 
    <xsl:template match="tsi:form[@id='FINFOWKS']" mode="FINFOWKS-PPReturnInformation">     
        <xsl:apply-templates select="tsi:field[@id='HMARSTAT']" mode="Field">
            <xsl:with-param name="mefId">DetailedMaritalStatusPP</xsl:with-param>
        </xsl:apply-templates>     
        <xsl:apply-templates select="tsi:field[@id='HMFSTAT']" mode="Field">
            <xsl:with-param name="mefId">hMarriedFilingStatusPP</xsl:with-param>
        </xsl:apply-templates>  
        <xsl:for-each select="tsi:table[@id = 'NONRES']/tsi:row[tsi:field[@id='NONRESST']]">
            <NonResidentStateTablePP>
                <xsl:copy-of select="@uuid"/>
                <xsl:apply-templates select="tsi:field[@id='NONRESST']" mode="Field">
                    <xsl:with-param name="mefId">NonResidentStatePP</xsl:with-param>
                </xsl:apply-templates>
            </NonResidentStateTablePP>
        </xsl:for-each>                     
        <xsl:apply-templates select="tsi:field[@id='HHASRDP']" mode="Boolean01">
            <xsl:with-param name="mefId">HasRDPPP</xsl:with-param>
        </xsl:apply-templates>  
        <xsl:apply-templates select="tsi:field[@id='HHASCU']" mode="Boolean01">
            <xsl:with-param name="mefId">HasCivilUnionPP</xsl:with-param>
        </xsl:apply-templates>  
        <xsl:apply-templates select="tsi:field[@id='HRDPORCU']" mode="Boolean01">
            <xsl:with-param name="mefId">HasRDPorCUPP</xsl:with-param>
        </xsl:apply-templates>           
        <ForeignAddressPP>
            <xsl:copy-of select="@uuid"/>                              
            <xsl:apply-templates select="tsi:field[@id='ADDR']" mode="Field">
                <xsl:with-param name="mefId">AddressLine1Txt</xsl:with-param>
            </xsl:apply-templates>                
            <xsl:apply-templates select="tsi:field[@id='APT']" mode="Field">
                <xsl:with-param name="mefId">AddressLine2Txt</xsl:with-param>
            </xsl:apply-templates>  
            <xsl:apply-templates select="tsi:field[@id='FPC']" mode="Field">
                <xsl:with-param name="mefId">CityNm</xsl:with-param>
            </xsl:apply-templates> 
            <xsl:apply-templates select="tsi:field[@id='FPC']" mode="Field">
                <xsl:with-param name="mefId">ProvinceOrStateNm</xsl:with-param>
            </xsl:apply-templates>  
            <xsl:apply-templates select="tsi:field[@id='FCCODE']" mode="Field">
                <xsl:with-param name="mefId">CountryCd</xsl:with-param>
            </xsl:apply-templates>    
            <xsl:apply-templates select="tsi:field[@id='FZIP']" mode="Field">                
                <xsl:with-param name="mefId">ForeignPostalCd</xsl:with-param>
            </xsl:apply-templates>  
            <xsl:apply-templates select="tsi:field[@id='CITY']" mode="Field">                
                <xsl:with-param name="mefId">CityNm</xsl:with-param>
            </xsl:apply-templates>  
        </ForeignAddressPP>         
        <USAddressPP>
            <xsl:copy-of select="@uuid"/> 
            <xsl:apply-templates select="tsi:field[@id='ADDR']" mode="Field">
                <xsl:with-param name="mefId">AddressLine1Txt</xsl:with-param>
            </xsl:apply-templates>                
            <xsl:apply-templates select="tsi:field[@id='APT']" mode="Field">
                <xsl:with-param name="mefId">AddressLine2Txt</xsl:with-param>
            </xsl:apply-templates>        
            <xsl:apply-templates select="tsi:field[@id='CITY']" mode="Field">
                <xsl:with-param name="mefId">CityNm</xsl:with-param>
            </xsl:apply-templates>  
            <xsl:apply-templates select="tsi:field[@id='ST']" mode="Field">
                <xsl:with-param name="mefId">StateAbbreviationCd</xsl:with-param>
            </xsl:apply-templates> 
            <xsl:apply-templates select="tsi:field[@id='ZIP']" mode="Field">
                <xsl:with-param name="mefId">ZIPCd</xsl:with-param>
            </xsl:apply-templates> 
        </USAddressPP>        
    </xsl:template>
    
    <xsl:template match="tsi:form[@id='FONLINE']" mode="FONLINE-PPReturnInformation">   
        <!--
        <xsl:apply-templates select="tsi:field[@id='FOREIGN']" mode="Field">
            <xsl:with-param name="mefId">ForeignPossessionPP</xsl:with-param>
        </xsl:apply-templates>    
        -->   
    </xsl:template>
    
    <xsl:template match="tsi:form[@id='FPERSWKS' and @copy = '1']" mode="FPERSWKSCopy1-PPReturnInformation">    
        <xsl:apply-templates select="tsi:field[@id='PHONE']" mode="Field">               
            <xsl:with-param name="mefId">DayTimePhoneNumberPP</xsl:with-param>
        </xsl:apply-templates>          
        <xsl:apply-templates select="tsi:field[@id='EXTN']" mode="Field">               
            <xsl:with-param name="mefId">PhoneNumberExtPP</xsl:with-param>
        </xsl:apply-templates>          
        <xsl:apply-templates select="tsi:field[@id='MARITAL']" mode="Field">
            <xsl:with-param name="mefId">MaritalStatusPP</xsl:with-param>
        </xsl:apply-templates>        
    </xsl:template>
    
    <xsl:template name="PPReturnInformation">
        <xsl:if test="tsi:form[@id='FINFOWKS'] | tsi:form[@id='FINFOWKS' and @copy = '1'] | tsi:form[@id='FONLINE']">
            <PPReturnInformation>      
                <xsl:copy-of select="@uuid"/>           
                <xsl:apply-templates select="tsi:form[@id='FINFOWKS']" mode="FINFOWKS-PPReturnInformation"></xsl:apply-templates>
                <xsl:apply-templates select="tsi:form[@id='FONLINE']" mode="FONLINE-PPReturnInformation"></xsl:apply-templates>
                <xsl:apply-templates select="tsi:form[@id='FPERSWKS' and @copy = '1']" mode="FPERSWKSCopy1-PPReturnInformation"></xsl:apply-templates>       
            </PPReturnInformation>
        </xsl:if>
    </xsl:template>
    
     <!-- Mapping for PPPerson -->
    <xsl:template name="PPPerson">
        <xsl:if test="tsi:form[@id='FPERSWKS' and @copy = '1'] | tsi:form[@id='FONLINE']">
           <PPPerson>
               <xsl:for-each select="tsi:form[@id='FPERSWKS']">
                   <xsl:if test="@copy='1'">
                       <xsl:apply-templates select="current()" mode="TaxpayerFilerInfoPP"></xsl:apply-templates>
                   </xsl:if>
                   <xsl:if test="@copy='2'">
                       <xsl:apply-templates select="current()" mode="SpouseFilerInfoPP"></xsl:apply-templates>
                   </xsl:if>
               </xsl:for-each>
          </PPPerson>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="tsi:form[@id='FPERSWKS' and @copy='1']" mode="TaxpayerFilerInfoPP" name="TaxpayerFilerInfoPP">
        <TaxpayerFilerInfoPP>
            <xsl:apply-templates select="current()" mode="FilerInfoTemplate"></xsl:apply-templates>
            <!-- widowed year is only mapped to taxpayer for now -->
            <xsl:apply-templates select="tsi:field[@id='YX0']" mode="EnumField">
                <xsl:with-param name="mefId">WidowedInYearPP</xsl:with-param>
                <xsl:with-param name="value">PriorTwoPriorTaxYr</xsl:with-param>
            </xsl:apply-templates>        
            <xsl:apply-templates select="tsi:field[@id='YX1']" mode="EnumField">
                <xsl:with-param name="mefId">WidowedInYearPP</xsl:with-param>
                <xsl:with-param name="value">TwoPriorTaxYr</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='YX2']" mode="EnumField">
                <xsl:with-param name="mefId">WidowedInYearPP</xsl:with-param>
                <xsl:with-param name="value">PriorTaxYr</xsl:with-param>
            </xsl:apply-templates> 
            <xsl:apply-templates select="tsi:field[@id='YX3']" mode="EnumField">
                <xsl:with-param name="mefId">WidowedInYearPP</xsl:with-param>
                <xsl:with-param name="value">TaxYr</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='YX4']" mode="EnumField">
                <xsl:with-param name="mefId">WidowedInYearPP</xsl:with-param>
                <xsl:with-param name="value">NextTaxYr</xsl:with-param>
            </xsl:apply-templates>          
            <xsl:apply-templates select="current()/../tsi:form[@id='FONLINE']/tsi:field[@id='TPMILDOD']" mode="CheckBoxBoolean-TrueIfChecked">
                <xsl:with-param name="mefId">MilitaryRelatedDeathPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="current()/../tsi:form[@id='FONLINE']/tsi:field[@id='TPDEAD']" mode="CheckBoxBoolean-TrueIfChecked">
                <xsl:with-param name="mefId">IsDeadPP</xsl:with-param>
            </xsl:apply-templates>
        </TaxpayerFilerInfoPP>
    </xsl:template>
    
    <xsl:template match="tsi:form[@id='FPERSWKS' and @copy='2']" mode="SpouseFilerInfoPP" name="SpouseFilerInfoPP">
        <SpouseFilerInfoPP>
            <xsl:apply-templates select="current()" mode="FilerInfoTemplate"></xsl:apply-templates>
            <!-- note this only triggers if there is a copy 2 (a spouse is listed on the return) -->
            <xsl:apply-templates select="current()/../tsi:form[@id='FONLINE']/tsi:field[@id='SPMILDOD']" mode="CheckBoxBoolean-TrueIfChecked">
                <xsl:with-param name="mefId">MilitaryRelatedDeathPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="current()/../tsi:form[@id='FONLINE']/tsi:field[@id='SPDEAD']" mode="CheckBoxBoolean-TrueIfChecked">
                <xsl:with-param name="mefId">IsDeadPP</xsl:with-param>
            </xsl:apply-templates>
        </SpouseFilerInfoPP>
    </xsl:template>
    
    <xsl:template match="tsi:form[@id='FPERSWKS']" name="FilerInfoTemplate" mode="FilerInfoTemplate">
        <xsl:copy-of select="@uuid"/>
        <xsl:apply-templates select="tsi:field[@id='NICKNAME']" mode="Field">
            <xsl:with-param name="mefId">PersonNicknamePP</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='INITIAL']" mode="Field">
            <xsl:with-param name="mefId">PersonMiddleInitialPP</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='SUFFIX']" mode="Field">
            <xsl:with-param name="mefId">PersonSuffixPP</xsl:with-param>
        </xsl:apply-templates>           
        <xsl:apply-templates select="tsi:field[@id='SSN']" mode="Field">
            <xsl:with-param name="mefId">SSNPP</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='DOB']" mode="Date">
            <xsl:with-param name="mefId">DateOfBirthPP</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='DOD']" mode="Date">
            <xsl:with-param name="mefId">DateOfDeathPP</xsl:with-param>
        </xsl:apply-templates>               
        <xsl:choose>
            <xsl:when test="tsi:field[@id='DXT']">
                <CanBeClaimedAsDependentIndPP>true</CanBeClaimedAsDependentIndPP>
            </xsl:when>
            <xsl:when test="tsi:field[@id='DXTN']">
                <CanBeClaimedAsDependentIndPP>false</CanBeClaimedAsDependentIndPP>
            </xsl:when>
        </xsl:choose>                
        <xsl:choose> <!-- YES-NO field -->
            <xsl:when test="tsi:field[@id='DEPTY']">
                <WillBeClaimedAsDependentIndPP>true</WillBeClaimedAsDependentIndPP>
            </xsl:when>
            <xsl:when test="tsi:field[@id='DEPTN']">
                <WillBeClaimedAsDependentIndPP>false</WillBeClaimedAsDependentIndPP>
            </xsl:when>
        </xsl:choose>
        <xsl:apply-templates select="tsi:field[@id='RSTA']" mode="Field">
            <xsl:with-param name="mefId">StateOfResidencePP</xsl:with-param>
        </xsl:apply-templates>            
        <xsl:apply-templates select="tsi:field[@id='WHERE']" mode="Field">
            <xsl:with-param name="mefId">FormerPlaceOfResidencePP</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='RESDATE']" mode="Date">
            <xsl:with-param name="mefId">DateOfStateResidencePP</xsl:with-param>
        </xsl:apply-templates>       
        <xsl:apply-templates select="tsi:field[@id='BLXT']" mode="CheckBoxBoolean-TrueIfChecked">
            <xsl:with-param name="mefId">LegallyBlindIndPP</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='OCCUP']" mode="Field">
            <xsl:with-param name="mefId">OccupationPP</xsl:with-param>
        </xsl:apply-templates>           
        <!-- mutually exclusive boxes -->
        <xsl:choose>
            <xsl:when test="tsi:field[@id='RESP']">
                <LivedInAnotherStatePP>true</LivedInAnotherStatePP>
            </xsl:when>
            <xsl:when test="tsi:field[@id='RESF']">
                <LivedInAnotherStatePP>false</LivedInAnotherStatePP>
            </xsl:when>
        </xsl:choose>  
        <xsl:choose>
            <xsl:when test="tsi:field[@id='NMIL']">
                <MilitaryIndPP>false</MilitaryIndPP>
            </xsl:when>
            <xsl:when test="tsi:field[@id='YMIL']">
                <MilitaryIndPP>true</MilitaryIndPP>
            </xsl:when>
        </xsl:choose>              
        <PersonFullNamePP>
            <xsl:apply-templates select="tsi:field[@id='FIRSTNAM']" mode="Field">
                <xsl:with-param name="mefId">PersonFirstNm</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='LASTNAM']" mode="Field">
                <xsl:with-param name="mefId">PersonLastNm</xsl:with-param>
            </xsl:apply-templates>
        </PersonFullNamePP>        
    </xsl:template>

    <!-- Mapping for OtherIncome -->
    <xsl:template match="tsi:form[@id='FOTHINC']" mode="OtherIncome">
        <OtherIncome>
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="tsi:field[@id='L16T']" mode="Field">
                <xsl:with-param name="mefId">TotalOtherIncomePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L16S']" mode="Field">
                <xsl:with-param name="mefId">TotalOtherIncomeSpousePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L12T']" mode="Field">
                <xsl:with-param name="mefId">TaxpayerJuryDutyPayPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L12S']" mode="Field">
                <xsl:with-param name="mefId">SpouseJuryDutyPayPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L6T']" mode="Field">
                <xsl:with-param name="mefId">ForeignIncomeExclusionPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L6S']" mode="Field">
                <xsl:with-param name="mefId">ForeignIncomeExclusionSpousePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L7T']" mode="Field">
                <xsl:with-param name="mefId">NetOperatingLossPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L7S']" mode="Field">
                <xsl:with-param name="mefId">NetOperatingLossSpousePP</xsl:with-param>
            </xsl:apply-templates>            
            <xsl:apply-templates select="tsi:field[@id='L2BT']" mode="Field">
                <xsl:with-param name="mefId">TaxpayerWinningsNotReportedOnFormPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L13T']" mode="Field">
                <xsl:with-param name="mefId">TaxpayerBarteringIncomePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L13S']" mode="Field">
                <xsl:with-param name="mefId">SpouseBarteringIncomePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L14T']" mode="Field">
                <xsl:with-param name="mefId">TaxpayerPersonalPropertyRentalIncomePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L14S']" mode="Field">
                <xsl:with-param name="mefId">SpousePersonalPropertyRentalIncomePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L2BS']" mode="Field">
                <xsl:with-param name="mefId">SpouseWinningsNotReportedOnFormPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='HTOTL2']" mode="Field">
                <xsl:with-param name="mefId">TotalWinningsPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='PRZWNG']" mode="Field">
                <xsl:with-param name="mefId">PrizeWinningsPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:for-each select="tsi:table[@id='LN15PER']/tsi:row">
                <OtherTaxableIncomeGrpPP>
                  <xsl:copy-of select="@uuid"/>
                  <xsl:apply-templates select="tsi:field[@id='L15DES']" mode="Field">
                     <xsl:with-param name="mefId">OtherTaxableIncomeDescriptionPP</xsl:with-param>
                  </xsl:apply-templates>
                  <xsl:apply-templates select="tsi:field[@id='L15TP']" mode="Field">
                     <xsl:with-param name="mefId">TaxpayerOtherTaxableIncomeAmtPP</xsl:with-param>
                  </xsl:apply-templates>
                  <xsl:apply-templates select="tsi:field[@id='L15SP']" mode="Field">
                      <xsl:with-param name="mefId">SpouseOtherTaxableIncomeAmtPP</xsl:with-param>
                  </xsl:apply-templates>                                  
                </OtherTaxableIncomeGrpPP>
            </xsl:for-each>
            <xsl:apply-templates select="tsi:field[@id='HOBBYT']" mode="Field">
                <xsl:with-param name="mefId">TaxpayerHobbyIncomePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='HOBBYS']" mode="Field">
                <xsl:with-param name="mefId">SpouseHobbyIncomePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L11T']" mode="Field">
                <xsl:with-param name="mefId">TaxpayerRecoveryOfPriorYearBadDebtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L11S']" mode="Field">
                <xsl:with-param name="mefId">SpouseRecoveryOfPriorYearBadDebtPP</xsl:with-param>
            </xsl:apply-templates>
        </OtherIncome>    
    </xsl:template>
    
    <!-- Mapping for IRS1040ScheduleD -->
    <xsl:template match="tsi:form[@id='FSCHD']" mode="IRS1040ScheduleD">
        <IRS1040ScheduleD>
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="tsi:field[@id='S6252']" mode="Field">
                <xsl:with-param name="mefId">STInstallmentSaleIncomeAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L6252']" mode="Field">
                <xsl:with-param name="mefId">LTInstallmentSaleIncomeAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L2439']" mode="Field">
                <xsl:with-param name="mefId">UndistributedLTCapitalGainAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L13F']" mode="Field">
                <xsl:with-param name="mefId">CapitalGainDistributionsAmt</xsl:with-param>
            </xsl:apply-templates>
        </IRS1040ScheduleD>
    </xsl:template>
    
    <!-- Mapping for IRS8949 -->
    <xsl:template match="tsi:form[@id='F8949']" mode="IRS8949">
        <IRS8949>
            <xsl:copy-of select="@uuid"/>
            <xsl:for-each select="tsi:table[@id='SHORTTBL']/tsi:row">
                <ShortTermCapitalGainAndLossGrp>
                    <xsl:copy-of select="@uuid"/>
                    <xsl:apply-templates select="tsi:field[@id='L1H']" mode="Field">
                        <xsl:with-param name="mefId">TotalGainOrLossAmt</xsl:with-param>
                    </xsl:apply-templates>
                </ShortTermCapitalGainAndLossGrp>
            </xsl:for-each>
            <xsl:for-each select="tsi:table[@id='LONGTBL']/tsi:row">
                <LongTermCapitalGainAndLossGrp>
                    <xsl:copy-of select="@uuid"/>
                    <xsl:apply-templates select="tsi:field[@id='L3H']" mode="Field">
                        <xsl:with-param name="mefId">TotalGainOrLossAmt</xsl:with-param>
                    </xsl:apply-templates>
                </LongTermCapitalGainAndLossGrp>
            </xsl:for-each>
        </IRS8949>
    </xsl:template>
    
    <!-- Mapping for IRS6781 -->
    <xsl:template match="tsi:form[@id='F6781']" mode="IRS6781">
        <IRS6781>
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="tsi:field[@id='L13A']" mode="Field">
                <xsl:with-param name="mefId">ShortTermPortionOfGainAmt</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L13B']" mode="Field">
                <xsl:with-param name="mefId">LongTermPortionOfGainAmt</xsl:with-param>
            </xsl:apply-templates>
        </IRS6781>
    </xsl:template>
    
    <!-- Mapping for IRS4797 -->
    <xsl:template match="tsi:form[@id='F4797']" mode="IRS4797">
        <IRS4797>
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="tsi:field[@id='L3G']" mode="Field">
                <xsl:with-param name="mefId">GainForm4684Amt</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L4G']" mode="Field">
                <xsl:with-param name="mefId">GainInstallmentSalesFrm6252Amt</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L5G']" mode="Field">
                <xsl:with-param name="mefId">GainLossForm8824Amt</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L6G']" mode="Field">
                <xsl:with-param name="mefId">GainOthThanCasualtyOrTheftAmt</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L14G']" mode="Field">
                <xsl:with-param name="mefId">TotalSectionPropertyAmt</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L17G']" mode="Field">
                <xsl:with-param name="mefId">OrdinaryGainLossForm8824Amt</xsl:with-param>
            </xsl:apply-templates>
            <xsl:for-each select="tsi:table[@id='LINE2']/tsi:row[tsi:field[@id='L2G']]">
                <PropertySaleOrExchange>
                    <xsl:copy-of select="@uuid"/>
                    <xsl:apply-templates select="tsi:field[@id='L2G']" mode="Field">
                        <xsl:with-param name="mefId">GainOrLossAmt</xsl:with-param>
                    </xsl:apply-templates>
                </PropertySaleOrExchange>
            </xsl:for-each>
            <xsl:for-each select="tsi:table[@id='LINE11']/tsi:row[tsi:field[@id='L11G']]">
                <OrdinaryGainLoss>
                    <xsl:copy-of select="@uuid"/>
                    <xsl:apply-templates select="tsi:field[@id='L11G']" mode="Field">
                        <xsl:with-param name="mefId">GainOrLossAmt</xsl:with-param>
                    </xsl:apply-templates>
                </OrdinaryGainLoss>
            </xsl:for-each>
        </IRS4797>
    </xsl:template>
    
    <!-- Mapping for IRS4835 -->
    <xsl:template match="tsi:form[@id='F4835']" mode="IRS4835">
        <IRS4835>
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="tsi:field[@id='L7']" mode="Field">
                <xsl:with-param name="mefId">GrossFarmRentalIncomeAmt</xsl:with-param>
            </xsl:apply-templates>
        </IRS4835>
    </xsl:template>
    
    <!-- Mapping for IRS1041 -->
    <xsl:template match="tsi:form[@id='FK1EW']" mode="IRS1041">
        <IRS1041>
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="tsi:field[@id='L3A']" mode="Field">
                <xsl:with-param name="mefId">NetSTCapitalGainOrLossAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L3B']" mode="Field">
                <xsl:with-param name="mefId">NetLTCapitalGainOrLossAmtPP</xsl:with-param>
            </xsl:apply-templates>
        </IRS1041>
    </xsl:template>
    
    <!-- Mapping for IRS4684 -->
    <xsl:template match="tsi:form[@id='TKEHAVE']" mode="IRS4684">
        <xsl:for-each select="tsi:table[@id='F4684']/tsi:row">
            <IRS4684>
                <xsl:copy-of select="@uuid"/>
                <xsl:apply-templates select="tsi:field[@id='L15P1']" mode="Field">
                    <xsl:with-param name="mefId">TotalTheftGainLessTotalLossAmt</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='L36P2']" mode="Field">
                    <xsl:with-param name="mefId">LongTermTotalGainsTheftAmt</xsl:with-param>
                </xsl:apply-templates>  
                <xsl:apply-templates select="tsi:field[@id='L30CP2']" mode="Field">
                    <xsl:with-param name="mefId">ShortTermTotalGainsTheftAmt</xsl:with-param>
                </xsl:apply-templates>  
            </IRS4684>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Mapping for ScheduleSEAdjustments -->
    <xsl:template match="tsi:form[@id='FSEADJ']" mode="ScheduleSEAdjustments">
        <ScheduleSEAdjustments>
        	<xsl:apply-templates select="tsi:table[@id='A170']/tsi:row[@copy='1']/tsi:field[@id='OTHWAGES']" mode="Field">
                <xsl:with-param name="mefId">TaxpayerSEReportedIncomePP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:table[@id='A170']/tsi:row[@copy='2']/tsi:field[@id='OTHWAGES']" mode="Field">
                <xsl:with-param name="mefId">SpouseSEReportedIncomePP</xsl:with-param>
            </xsl:apply-templates>
        </ScheduleSEAdjustments>
    </xsl:template>
    
    <!-- Mapping for IRSW2G -->
    <xsl:template match="tsi:form[@id='FW2G']" mode="IRSW2G">
        <IRSW2G>
            <xsl:copy-of select="@uuid" />
            <!-- Need to make this mutually exclusive in PT - Spouse or Taxpayer -->
            <xsl:if test="tsi:field[@id='SPBX']/tsi:value[translate(text(),'x','X')='X' or translate(text(),'true','TRUE')='TRUE']">
                <xsl:apply-templates select="tsi:field[@id='SPBX']" mode="EnumField">
                    <xsl:with-param name="mefId">SpouseW2GIndPP</xsl:with-param>
                    <xsl:with-param name="value">true</xsl:with-param>
                </xsl:apply-templates>
            </xsl:if>
            <xsl:if test="tsi:field[@id='OVRX']/tsi:value[translate(text(),'x','X')='X' or translate(text(),'true','TRUE')='TRUE']">
                <xsl:apply-templates select="tsi:field[@id='OVRX']" mode="EnumField">
                    <xsl:with-param name="mefId">WinnerCopyInfoIndPPR2</xsl:with-param>
                    <xsl:with-param name="value">true</xsl:with-param>
                </xsl:apply-templates>
            </xsl:if>
            <xsl:apply-templates select="tsi:field[@id='CORRX']" mode="Field">
                <xsl:with-param name="mefId">CorrectedW2GInd</xsl:with-param>
            </xsl:apply-templates>
            <xsl:if test="tsi:field[@id='PNAM'] | tsi:field[@id='PNAM2']">
                <PayerName>
                    <xsl:apply-templates select="tsi:field[@id='PNAM']" mode="Field">
                        <xsl:with-param name="mefId">BusinessNameLine1Txt</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tsi:field[@id='PNAM2']" mode="Field">
                        <xsl:with-param name="mefId">BusinessNameLine2Txt</xsl:with-param>
                    </xsl:apply-templates>
                </PayerName>
            </xsl:if>
            <xsl:choose>
                <xsl:when
                    test="tsi:field[@id='FRNX']/tsi:value[translate(text(),'x','X')='X' or translate(text(),'true','TRUE')='TRUE']">
                    <xsl:apply-templates select="tsi:field[@id='FRNX']" mode="EnumField">
                        <xsl:with-param name="mefId">PayerForeignAddressIndPP</xsl:with-param>
                        <xsl:with-param name="value">true</xsl:with-param>
                    </xsl:apply-templates>
                    <PayerForeignAddress>
                        <xsl:apply-templates select="tsi:field[@id='PADD']" mode="Field">
                            <xsl:with-param name="mefId">AddressLine1Txt</xsl:with-param>
                        </xsl:apply-templates>
                        <xsl:apply-templates select="tsi:field[@id='PCTY']" mode="Field">
                            <xsl:with-param name="mefId">CityNm</xsl:with-param>
                        </xsl:apply-templates>
                        <xsl:apply-templates select="tsi:field[@id='PST']" mode="Field">
                            <xsl:with-param name="mefId">ProvinceOrStateNm</xsl:with-param>
                        </xsl:apply-templates>
                        <xsl:apply-templates select="tsi:field[@id='PZIP']" mode="Field">
                            <xsl:with-param name="mefId">ForeignPostalCd</xsl:with-param>
                        </xsl:apply-templates>
                    </PayerForeignAddress>
                </xsl:when>
                <xsl:when test="tsi:field[@id='PADD'] | tsi:field[@id='PCTY'] | 
                    tsi:field[@id='PST'] | tsi:field[@id='PZIP']">
                    <PayerUSAddress>
                        <xsl:apply-templates select="tsi:field[@id='PADD']" mode="Field">
                            <xsl:with-param name="mefId">AddressLine1Txt</xsl:with-param>
                        </xsl:apply-templates>
                        <xsl:apply-templates select="tsi:field[@id='PCTY']" mode="Field">
                            <xsl:with-param name="mefId">CityNm</xsl:with-param>
                        </xsl:apply-templates>
                        <xsl:apply-templates select="tsi:field[@id='PST']" mode="Field">
                            <xsl:with-param name="mefId">StateAbbreviationCd</xsl:with-param>
                        </xsl:apply-templates>
                        <xsl:apply-templates select="tsi:field[@id='PZIP']" mode="Field">
                            <xsl:with-param name="mefId">ZIPCd</xsl:with-param>
                        </xsl:apply-templates>
                    </PayerUSAddress>
                </xsl:when>
            </xsl:choose>       
            <xsl:apply-templates select="tsi:field[@id='SSN']" mode="Field">
                <xsl:with-param name="mefId">PayerSSN</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='PFIN']" mode="Field">
                <xsl:with-param name="mefId">PayerEIN</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='PHONE']" mode="Field">
                <xsl:with-param name="mefId">PayerTelephoneNum</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L1']" mode="Field">
                <xsl:with-param name="mefId">GamblingWinGrossWinningAmt</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L2']" mode="Field">
                <xsl:with-param name="mefId">FederalIncomeTaxWithheldAmt</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L3']" mode="Field">
                <xsl:with-param name="mefId">GamblingWinWagerTypeCd</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L4']" mode="Date">
                <xsl:with-param name="mefId">GamblingWinningDt</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L5']" mode="Field">
                <xsl:with-param name="mefId">GamblingWinningTransactionDesc</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L6']" mode="Field">
                <xsl:with-param name="mefId">GamblingWinningEventDesc</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L7']" mode="Field">
                <xsl:with-param name="mefId">GamblingWinFromIdntclWagersAmt</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L8']" mode="Field">
                <xsl:with-param name="mefId">GamblingWinCashierId</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='WNAM']" mode="Field">
                <xsl:with-param name="mefId">RecipientNm</xsl:with-param>
            </xsl:apply-templates>
            <xsl:choose>
                <xsl:when test="tsi:field[@id='EFRNX']/tsi:value[translate(text(),'x','X')='X' or translate(text(),'true','TRUE')='TRUE']">
                    <xsl:apply-templates select="tsi:field[@id='EFRNX']" mode="EnumField">
                        <xsl:with-param name="mefId">WinnerForeignAddressIndPP</xsl:with-param>
                        <xsl:with-param name="value">true</xsl:with-param>
                    </xsl:apply-templates>
                    <RecipientForeignAddress>
                        <xsl:apply-templates select="tsi:field[@id='WADD']" mode="Field">
                            <xsl:with-param name="mefId">AddressLine1Txt</xsl:with-param>
                        </xsl:apply-templates>
                        <xsl:apply-templates select="tsi:field[@id='WCTY']" mode="Field">
                            <xsl:with-param name="mefId">CityNm</xsl:with-param>
                        </xsl:apply-templates>
                        <xsl:apply-templates select="tsi:field[@id='WST']" mode="Field">
                            <xsl:with-param name="mefId">ProvinceOrStateNm</xsl:with-param>
                        </xsl:apply-templates>
                        <xsl:apply-templates select="tsi:field[@id='WZIP']" mode="Field">
                            <xsl:with-param name="mefId">ForeignPostalCd</xsl:with-param>
                        </xsl:apply-templates>
                    </RecipientForeignAddress>
                </xsl:when>
                <xsl:when test="tsi:field[@id='WADD'] | tsi:field[@id='WCTY'] | 
                    tsi:field[@id='WST'] | tsi:field[@id='WZIP']">
                    <RecipientUSAddress>
                        <xsl:apply-templates select="tsi:field[@id='WADD']" mode="Field">
                            <xsl:with-param name="mefId">AddressLine1Txt</xsl:with-param>
                        </xsl:apply-templates>
                        <xsl:apply-templates select="tsi:field[@id='WCTY']" mode="Field">
                            <xsl:with-param name="mefId">CityNm</xsl:with-param>
                        </xsl:apply-templates>
                        <xsl:apply-templates select="tsi:field[@id='WST']" mode="Field">
                            <xsl:with-param name="mefId">StateAbbreviationCd</xsl:with-param>
                        </xsl:apply-templates>
                        <xsl:apply-templates select="tsi:field[@id='WZIP']" mode="Field">
                            <xsl:with-param name="mefId">ZIPCd</xsl:with-param>
                        </xsl:apply-templates>
                    </RecipientUSAddress>
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates select="tsi:field[@id='L9']" mode="Field">
                <xsl:with-param name="mefId">RecipientSSN</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L10']" mode="Field">
                <xsl:with-param name="mefId">GamblingWinWindowNum</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L11']" mode="Field">
                <xsl:with-param name="mefId">RecipientFirstAdditionalIdNum</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:field[@id='L12']" mode="Field">
                <xsl:with-param name="mefId">RecipientSecondAdditionalIdNum</xsl:with-param>
            </xsl:apply-templates>
            <xsl:if test="tsi:field[@id='L13A'] | tsi:field[@id='L13B'] |
                tsi:field[@id='L14'] | tsi:field[@id='L14B']">
                <W2GStateLocalTaxGrp>
                    <xsl:call-template name="W2GStateLocalTaxGrp"/>
                </W2GStateLocalTaxGrp>
            </xsl:if>
        </IRSW2G> 
    </xsl:template>
    <xsl:template match="node()" mode="W2GStateLocalTaxGrp" name="W2GStateLocalTaxGrp">
        <xsl:apply-templates select="tsi:field[@id='L13A']" mode="Field">
            <xsl:with-param name="mefId">StateAbbreviationCd</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L13B']" mode="Field">
            <xsl:with-param name="mefId">PayerStateIdNum</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L14']" mode="Field">
            <xsl:with-param name="mefId">StateTaxWithheldAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L14B']" mode="Field">
            <xsl:with-param name="mefId">GamblingWinningAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:if test="tsi:field[@id='L15'] | tsi:field[@id='L16'] | 
            tsi:field[@id='L16B']">
            <W2GLocalTaxGrp>
                <xsl:call-template name="W2GLocalTaxGrp"/>
            </W2GLocalTaxGrp>
        </xsl:if>
    </xsl:template>
    <xsl:template match="node()" mode="W2GLocalTaxGrp" name="W2GLocalTaxGrp">
        <xsl:apply-templates select="tsi:field[@id='L15']" mode="Field">
            <xsl:with-param name="mefId">LocalityNm</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L16']" mode="Field">
            <xsl:with-param name="mefId">LocalIncomeTaxAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L16B']" mode="Field">
            <xsl:with-param name="mefId">GamblingWinningAmt</xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>
    
    <!-- Mapping for IRS1040ScheduleE -->
    <xsl:template match="tsi:form[@id='TKEHAVE'] | tsi:form[@id='FSCHE2']" mode="IRS1040ScheduleE" name="IRS1040ScheduleE">
        <IRS1040ScheduleE>
            <xsl:apply-templates select="tsi:form[@id='TKEHAVE']" mode="IRS1040ScheduleE-FSCHE1"/>
            <xsl:apply-templates select="tsi:form[@id='FSCHE2']" mode="IRS1040ScheduleE-FSCHE2"/>
        </IRS1040ScheduleE>
    </xsl:template>
    <xsl:template match="tsi:form[@id='TKEHAVE']" mode="IRS1040ScheduleE-FSCHE1">
        <xsl:for-each select="tsi:table[@id='FSCHE1']/tsi:row">
            <PropertyRealEstAndRoyaltyGroup>
                <xsl:copy-of select="@uuid"/>
                <xsl:apply-templates select="tsi:field[@id='SCHEP1L3']" mode="Field">
                    <xsl:with-param name="mefId">RentsReceivedAmt</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="tsi:field[@id='SCHEP1L4']" mode="Field">
                    <xsl:with-param name="mefId">TotalRoyaltiesReceivedAmt</xsl:with-param>
                </xsl:apply-templates>
            </PropertyRealEstAndRoyaltyGroup>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="tsi:form[@id='FSCHE2']" mode="IRS1040ScheduleE-FSCHE2">
        
        
        <xsl:apply-templates select="tsi:field[@id='L29']" mode="Field">
            <xsl:with-param name="mefId">TotalPrtshpSCorpIncomeAmt</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="tsi:field[@id='L34']" mode="Field">
            <xsl:with-param name="mefId">TotalEstateOrTrustIncomeAmt</xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>
    
    
    
    
    
    <!-- Mapping for Federal Carryover Worksheet -->
    <xsl:template match="tsi:form[@id='FCO13']" mode="FederalCarryoverWorksheet">
        <FederalCarryoverWksPP>
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="tsi:table[@id = 'A193']/tsi:row[@copy=1]/tsi:field[@id='L32A']" mode="Field">
                <xsl:with-param name="mefId">PriorYrOtherProperty50PercentContributionCarryOverAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:table[@id = 'A193']/tsi:row[@copy=2]/tsi:field[@id='L32A']" mode="Field">
                <xsl:with-param name="mefId">PriorYrOtherProperty30PercentContributionCarryOverAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:table[@id = 'A193']/tsi:row[@copy=3]/tsi:field[@id='L32A']" mode="Field">
                <xsl:with-param name="mefId">PriorYrCapitalGain30PercentContributionCarryOverAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:table[@id = 'A193']/tsi:row[@copy=4]/tsi:field[@id='L32A']" mode="Field">
                <xsl:with-param name="mefId">PriorYrCapitalGain20PercentContributionCarryOverAmtPP</xsl:with-param>
            </xsl:apply-templates>
            
            <xsl:apply-templates select="tsi:table[@id = 'A194']/tsi:row[@copy=1]/tsi:field[@id='L32B']" mode="Field">
                <xsl:with-param name="mefId">TwoYrOtherProperty50PercentContributionCarryOverAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:table[@id = 'A194']/tsi:row[@copy=2]/tsi:field[@id='L32B']" mode="Field">
                <xsl:with-param name="mefId">TwoYrOtherProperty30PercentContributionCarryOverAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:table[@id = 'A194']/tsi:row[@copy=3]/tsi:field[@id='L32B']" mode="Field">
                <xsl:with-param name="mefId">TwoYrCapitalGain30PercentContributionCarryOverAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:table[@id = 'A194']/tsi:row[@copy=4]/tsi:field[@id='L32B']" mode="Field">
                <xsl:with-param name="mefId">TwoYrCapitalGain20PercentContributionCarryOverAmtPP</xsl:with-param>
            </xsl:apply-templates>
            
            <xsl:apply-templates select="tsi:table[@id = 'A200']/tsi:row[@copy=1]/tsi:field[@id='L32C']" mode="Field">
                <xsl:with-param name="mefId">ThreeYrOtherProperty50PercentContributionCarryOverAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:table[@id = 'A200']/tsi:row[@copy=2]/tsi:field[@id='L32C']" mode="Field">
                <xsl:with-param name="mefId">ThreeYrOtherProperty30PercentContributionCarryOverAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:table[@id = 'A200']/tsi:row[@copy=3]/tsi:field[@id='L32C']" mode="Field">
                <xsl:with-param name="mefId">ThreeYrCapitalGain30PercentContributionCarryOverAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:table[@id = 'A200']/tsi:row[@copy=4]/tsi:field[@id='L32C']" mode="Field">
                <xsl:with-param name="mefId">ThreeYrCapitalGain20PercentContributionCarryOverAmtPP</xsl:with-param>
            </xsl:apply-templates>
            
            <xsl:apply-templates select="tsi:table[@id = 'A202']/tsi:row[@copy=1]/tsi:field[@id='L32D']" mode="Field">
                <xsl:with-param name="mefId">FourYrOtherProperty50PercentContributionCarryOverAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:table[@id = 'A202']/tsi:row[@copy=2]/tsi:field[@id='L32D']" mode="Field">
                <xsl:with-param name="mefId">FourYrOtherProperty30PercentContributionCarryOverAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:table[@id = 'A202']/tsi:row[@copy=3]/tsi:field[@id='L32D']" mode="Field">
                <xsl:with-param name="mefId">FourYrCapitalGain30PercentContributionCarryOverAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:table[@id = 'A202']/tsi:row[@copy=4]/tsi:field[@id='L32D']" mode="Field">
                <xsl:with-param name="mefId">FourYrCapitalGain20PercentContributionCarryOverAmtPP</xsl:with-param>
            </xsl:apply-templates>
 
            <xsl:apply-templates select="tsi:table[@id = 'A201']/tsi:row[@copy=1]/tsi:field[@id='L32E']" mode="Field">
                <xsl:with-param name="mefId">FiveYrOtherProperty50PercentContributionCarryOverAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:table[@id = 'A201']/tsi:row[@copy=2]/tsi:field[@id='L32E']" mode="Field">
                <xsl:with-param name="mefId">FiveYrOtherProperty30PercentContributionCarryOverAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:table[@id = 'A201']/tsi:row[@copy=3]/tsi:field[@id='L32E']" mode="Field">
                <xsl:with-param name="mefId">FiveYrCapitalGain30PercentContributionCarryOverAmtPP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="tsi:table[@id = 'A201']/tsi:row[@copy=4]/tsi:field[@id='L32E']" mode="Field">
                <xsl:with-param name="mefId">FiveYrCapitalGain20PercentContributionCarryOverAmtPP</xsl:with-param>
            </xsl:apply-templates>
 
            
        </FederalCarryoverWksPP>
    </xsl:template>
    
    
    
    
    
    
    <!-- ######################## Utility Templates ######################## -->
    
    <xsl:template match="node()" mode="MonthEnumField">
        <xsl:param name="mefId"/>
        <xsl:choose>
            <xsl:when test="tsi:value[text()='01']">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="mefId" select="$mefId"/>
                    <xsl:with-param name="value">JANUARY</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="tsi:value[text()='02']">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="mefId" select="$mefId"/>
                    <xsl:with-param name="value">FEBRUARY</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="tsi:value[text()='03']">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="mefId" select="$mefId"/>
                    <xsl:with-param name="value">MARCH</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="tsi:value[text()='04']">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="mefId" select="$mefId"/>
                    <xsl:with-param name="value">APRIL</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="tsi:value[text()='05']">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="mefId" select="$mefId"/>
                    <xsl:with-param name="value">MAY</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="tsi:value[text()='06']">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="mefId" select="$mefId"/>
                    <xsl:with-param name="value">JUNE</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="tsi:value[text()='07']">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="mefId" select="$mefId"/>
                    <xsl:with-param name="value">JULY</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="tsi:value[text()='08']">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="mefId" select="$mefId"/>
                    <xsl:with-param name="value">AUGUST</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="tsi:value[text()='09']">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="mefId" select="$mefId"/>
                    <xsl:with-param name="value">SEPTEMBER</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="tsi:value[text()='10']">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="mefId" select="$mefId"/>
                    <xsl:with-param name="value">OCTOBER</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="tsi:value[text()='11']">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="mefId" select="$mefId"/>
                    <xsl:with-param name="value">NOVEMBER</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="tsi:value[text()='12']">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="mefId" select="$mefId"/>
                    <xsl:with-param name="value">DECEMBER</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="node()" mode="EnumField">
        <xsl:param name="mefId"/>
        <xsl:param name="value"/>
        <xsl:element name="{$mefId}">
            <xsl:value-of select="$value"/>
        </xsl:element>
    </xsl:template>

    <!-- Field Template -->
    <xsl:template match="node()" mode="Field">
        <xsl:param name="mefId"/>
        <xsl:variable name="value"><xsl:value-of select="tsi:value"/></xsl:variable>
        <xsl:element name="{$mefId}">
            <xsl:choose>
                <!-- To remove . if it is at the end in cases like 100. -->
                <xsl:when test="substring($value, string-length($value)) = '.'">
                    <xsl:value-of select="substring($value,1,string-length($value)-1)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="tsi:value"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="node()" mode="Boolean01">
        <xsl:param name="mefId"/>
        <xsl:variable name="value"><xsl:value-of select="tsi:value"/></xsl:variable>
        <xsl:element name="{$mefId}">
            <xsl:choose>
                <xsl:when test="$value = '0'">
                    <xsl:value-of select="'false'"/>
                </xsl:when>
                <xsl:when test="$value = '1'">
                    <xsl:value-of select="'true'"/>
                </xsl:when>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    
    <!-- Date Template -->
    <xsl:template match="node()" mode="Date">
        <xsl:param name="mefId"/>
            <xsl:variable name="yyyy" select="substring(tsi:value,1,4)"/>
            <xsl:variable name="mm" select="substring(tsi:value,5,2)"/>
            <xsl:variable name="dd" select="substring(tsi:value,7,2)"/>
            <xsl:element name="{$mefId}">
                <xsl:value-of select="concat($yyyy,'-',$mm,'-',$dd)"/>
            </xsl:element>
    </xsl:template>

    <!-- TPS Check box to MeF Boolean : Will not map to MeF if field is unchecked(NOT present or Empty)-->
    <xsl:template match="node()" mode="CheckBoxBoolean-TrueIfChecked">
        <xsl:param name="mefId" />
        <xsl:if test="tsi:value[translate(text(),'x','X')='X' or translate(text(),'true','TRUE')='TRUE']">
            <xsl:element name="{$mefId}">
                <xsl:value-of select="'true'"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <!--Birth Date Template -->
    <!-- ###WARNING#### CURRENT TAX YEAR needs to change every year if we plan to use this xslt -->
    <xsl:variable name="CURRENT_TAX_YEAR">2014</xsl:variable>
    <xsl:template match="node()" mode="BirthDate">
        <xsl:param name="mefId"/>
        <xsl:variable name="yyyy" select="substring(tsi:value,1,4)"/>
        <xsl:variable name="mm" select="substring(tsi:value,5,2)"/>
        <xsl:variable name="dd" select="substring(tsi:value,7,2)"/>
        <xsl:element name="{$mefId}">
            <xsl:choose>
                <xsl:when test="$yyyy > $CURRENT_TAX_YEAR">
                    <xsl:text></xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat($yyyy,'-',$mm,'-',$dd)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    
    <!-- ConvertCheckboxField Template -->
   <xsl:template match="node()" mode="ConvertCheckboxField">
      <xsl:param name="mefId" />
      <xsl:param name="yesValue" />
      <xsl:param name="noValue" />
      <xsl:variable name="returnValue">
         <xsl:choose>
            <xsl:when test="tsi:value[translate(text(),'x','X')='X' or translate(text(),'true','TRUE')='TRUE']">
               <xsl:value-of select="$yesValue" />
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="$noValue" />
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:element name="{$mefId}">
         <xsl:value-of select="$returnValue" />
      </xsl:element>
   </xsl:template>

   <!--Checkbox Enum Template -->
   <xsl:template match="node()" mode="CheckboxField">
      <xsl:param name="mefId" />
      <xsl:if test="tsi:value = 'true'">
         <xsl:element name="{$mefId}">X</xsl:element>
      </xsl:if>
   </xsl:template>

   <!-- NoDashField Template -->
   <xsl:template match="node()" mode="NoDashField">
      <xsl:param name="mefId" />
      <xsl:element name="{$mefId}">
         <xsl:value-of select="translate(tsi:value, '-','')" />
      </xsl:element>
   </xsl:template>

   <!-- PayerNameControlTxtField business name -->
   <xsl:template match="node()" mode="PayerNameControlTxtField">
      <xsl:param name="mefId" />
      <xsl:variable name="returnValue">
               <xsl:call-template name="NameBusinessControl">
                  <xsl:with-param name="input" select="tsi:value" />
               </xsl:call-template>
      </xsl:variable>

      <xsl:element name="{$mefId}">
         <xsl:value-of select="$returnValue" />
      </xsl:element>
   </xsl:template>

   <xsl:template match="node()" mode="PayerNameField">
      <xsl:param name="mefId" />
      <xsl:element name="{$mefId}">
         <xsl:element name="BusinessNameLine1Txt">
            <xsl:value-of select="tsi:value" />
         </xsl:element>
      </xsl:element>
   </xsl:template>

   <!-- RoundedIntField Template -->
   <xsl:template match="node()" mode="RoundedIntField">
      <xsl:param name="mefId" />
      <xsl:element name="{$mefId}">
         <xsl:value-of select="round(tsi:value)" />
      </xsl:element>
   </xsl:template>

    <!--This template is used to conver the business name to four letters in all caps, also removes the word 'the' from the beginning if it is there-->
   <xsl:template name="NameBusinessControl">
      <xsl:param name="input" />
      <xsl:variable name="name" select="normalize-space($input)" />
      <xsl:variable name="name-upper">
         <xsl:call-template name="ConvertToUppercase">
            <xsl:with-param name="input" select="$name" />
         </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="first-four-chars-upper" select="substring($name-upper, 1, 4)" />
      <xsl:choose>
         <xsl:when test="$first-four-chars-upper = 'THE ' and substring($name-upper, 5, 1) != ' '">
            <xsl:value-of select="substring($name-upper, 5, 4)" />
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="substring(translate($name-upper, ' ', ''), 1, 4)" />
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template name="ConvertToUppercase">
      <xsl:param name="input" />
      <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
      <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
      <xsl:value-of select="translate($input, $smallcase, $uppercase)" />
   </xsl:template>
   
   <!-- This template calculates the xpath of the current node -->
   <xsl:template name="genPath">
       <xsl:param name="prevPath"/>
       <!-- Variable that determines if an attribute is needed in the xpath or not -->
       <xsl:variable name="selector">
           <xsl:choose>
               <xsl:when test="@uuid">
                   <xsl:value-of select="concat('[@uuid=',@uuid,']')"/>
               </xsl:when>
               <xsl:otherwise>
                   <xsl:choose>
                       <xsl:when test="count(preceding-sibling::*[name() = name(current())]) = 0">
                           <xsl:value-of select="''"/>
                       </xsl:when>
                       <xsl:otherwise>
                           <xsl:value-of select="concat('[', count(preceding-sibling::*[name() = name(current())])+1 ,']')"/>
                       </xsl:otherwise>
                   </xsl:choose>
               </xsl:otherwise>
           </xsl:choose>
       </xsl:variable>
       <!-- Variable that holds the value of the current Path -->
       <xsl:variable name="currPath" select="concat('/',name(), $selector ,$prevPath)"/>
       <xsl:for-each select="parent::*">
           <xsl:call-template name="genPath">
               <xsl:with-param name="prevPath" select="$currPath"/>
           </xsl:call-template>
       </xsl:for-each>
       <xsl:if test="not(parent::*)">
           <xsl:value-of select="$currPath"/>      
       </xsl:if>
   </xsl:template>
</xsl:stylesheet>