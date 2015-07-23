<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"

xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:mef="http://www.irs.gov/efile"
    xmlns="http://schemas.intuit.com/cg/services/calc" exclude-result-prefixes="mef" version="1.0">

    <xsl:output method="xml" omit-xml-declaration="no" indent="yes"/>

    <!-- Walk entire tree -->
    <xsl:template match="node()">
        <xsl:apply-templates select="node()"/>
    </xsl:template>

    <!-- ServiceBus MeF Root-->
    <xsl:template match="/returns/IRS1040">
        <FormML serviceImplementationVersion="mef-tsi-formml.2013.0">
            <formset id="FDI">
                <!-- Pass through the uuid if present -->
                <xsl:copy-of select="@uuid"/>
                <xsl:apply-templates select="mef:Return" mode="XLATE"/>
            </formset>
        </FormML>
    </xsl:template>

    <!-- Traditional MeF Root-->
    <xsl:template match="/mef:Return">
        <FormML serviceImplementationVersion="mef-tsi-formml.2013.0">
            <formset id="FDI">
                <xsl:copy-of select="@uuid"/>
                <xsl:call-template name="XLATE"/>
            </formset>
        </FormML>
    </xsl:template>
    
    <!-- Begin Translation of FORMS -->
    <xsl:template match="node()" mode="XLATE" name="XLATE">
        <xsl:apply-templates/>
        <!-- Call templates for tsi-forms whose data needs to be collected from different MeF forms -->
        <xsl:call-template name="TKEHAVE"/>
        <xsl:apply-templates select="/mef:Return/mef:ReturnData" mode="FORM-FONLINE"/>
        <xsl:call-template name="FORM-FINFOWKS"/>
        <xsl:call-template name="FORM-FPERSWKS-1"/>
        <xsl:call-template name="FORM-FPERSWKS-2"/>
    </xsl:template>    

    <!-- Mapping for TKEHAVE -->
    <xsl:template match="node()" mode="TKEHAVE" name="TKEHAVE">
        <xsl:if test="mef:ReturnHeader/mef:ACAPP | mef:ReturnData/mef:ACACntrlBitsPP | //*[mef:FieldAttributes] | mef:ReturnData/mef:IRS8962">
            <form id="TKEHAVE">
                <xsl:for-each select="mef:ReturnHeader/mef:ACAPP | mef:ReturnData/mef:ACACntrlBitsPP">
                    <xsl:apply-templates select="." mode="TKEHAVE-SUB"/>
                </xsl:for-each>
                <xsl:call-template name="CNTRLBITS"/>

                <!-- 12/15/2014 -->
                <xsl:for-each select="mef:ReturnData/mef:IRS8962">
                    <xsl:apply-templates select="mef:YearOfMarriageIndPP" mode="YesNoField">
                        <xsl:with-param name="yTpsId">TYMARRDY</xsl:with-param>
                        <xsl:with-param name="nTpsId">TYMARRDN</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="mef:DependentIncomeIndPP" mode="YesNoField">
                        <xsl:with-param name="yTpsId">DEPINCNY</xsl:with-param>
                        <xsl:with-param name="nTpsId">DEPINCNN</xsl:with-param>
                    </xsl:apply-templates>        
                    <xsl:apply-templates select="mef:SharedPolicyIndPP" mode="YesNoField">
                        <xsl:with-param name="yTpsId">SHRPOLCY</xsl:with-param>
                        <xsl:with-param name="nTpsId">SHRPOLCN</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="mef:SEMarketPlaceInsuranceIndPP" mode="YesNoField">
                        <xsl:with-param name="yTpsId">SEHLTHEY</xsl:with-param>
                        <xsl:with-param name="nTpsId">SEHLTHEN</xsl:with-param>
                    </xsl:apply-templates>
                </xsl:for-each>
            </form>
        </xsl:if>
    </xsl:template>
    <xsl:template match="mef:ACAPP" mode="TKEHAVE-SUB">
        <xsl:apply-templates select="mef:HshldCvrIndPP[child::text()='FULLYEAR']" mode="EnumField">
            <xsl:with-param name="tpsId">FULLYHI</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:HshldCvrIndPP[child::text()='PARTYEAR']" mode="EnumField">
            <xsl:with-param name="tpsId">PARTYHI</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:HshldCvrIndPP[child::text()='NONE']" mode="EnumField">
            <xsl:with-param name="tpsId">NONEHI</xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>
    <xsl:template match="mef:ACACntrlBitsPP" mode="TKEHAVE-SUB">
        <xsl:apply-templates select="mef:HaveAny1095APP" mode="YesNoField">
            <xsl:with-param name="yTpsId">HAY1095A</xsl:with-param>
            <xsl:with-param name="nTpsId">HAN1095A</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:HaveAnyMore1095APP" mode="YesNoField">
            <xsl:with-param name="yTpsId">HMY1095A</xsl:with-param>
            <xsl:with-param name="nTpsId">HMN1095A</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:HaveAny1095BPP" mode="YesNoField">
            <xsl:with-param name="yTpsId">HAY1095B</xsl:with-param>
            <xsl:with-param name="nTpsId">HAN1095B</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:HaveAnyMore1095BPP" mode="YesNoField">
            <xsl:with-param name="yTpsId">HMY1095B</xsl:with-param>
            <xsl:with-param name="nTpsId">HMN1095B</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:HaveAny1095CPP" mode="YesNoField">
            <xsl:with-param name="yTpsId">HAY1095C</xsl:with-param>
            <xsl:with-param name="nTpsId">HAN1095C</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:HaveAnyMore1095CPP" mode="YesNoField">
            <xsl:with-param name="yTpsId">HMY1095C</xsl:with-param>
            <xsl:with-param name="nTpsId">HMN1095C</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:Have8965PP" mode="YesNoField">
            <xsl:with-param name="yTpsId">HAY8965</xsl:with-param>
            <xsl:with-param name="nTpsId">HAN8965</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:ACAInterviewCompletionPP" mode="YesNoField">
            <xsl:with-param name="yTpsId">ACACOMPY</xsl:with-param>
            <xsl:with-param name="nTpsId">ACACOMPN</xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>
    <!-- Mappings for CNTRLBITS -->
    <xsl:template match="node()" mode="CNTRLBITS" name="CNTRLBITS">
        <xsl:if test="count(//*[mef:FieldAttributes]) > 0">
            <table id="FLDCVRGS">
                <xsl:for-each select="//*[mef:FieldAttributes]">
                    <xsl:if test="current()/descendant-or-self::mef:Covered">
                        <xsl:call-template name="FieldCoverage_CB"/>
                    </xsl:if>
                </xsl:for-each>
            </table>
        </xsl:if>
    </xsl:template>
    <!-- Covered constant -->
    <xsl:variable name="coveredBit"><xsl:text>COVERED</xsl:text></xsl:variable>
    <xsl:template match="node()" mode="FieldCoverage_CB" name="FieldCoverage_CB">
        <!-- Each Field inside of FieldAttributes that has Covered node-->
        <xsl:for-each select="mef:FieldAttributes/child::node()[descendant::mef:Covered]">
            <xsl:variable name="parentPath">
                <xsl:call-template name="genPath"/>
            </xsl:variable>
            <!-- Trim out the servicebus tags if any -->
            <xsl:variable name="mefParentPath">
                <xsl:value-of select="substring($parentPath,string-length(substring-before($parentPath,'/Return'))+1)"/>
            </xsl:variable>
            <row>
                <xsl:call-template name="ControlBitRow">
                    <xsl:with-param name="fldName">
                        <xsl:value-of select="name()"/>
                    </xsl:with-param>
                    <xsl:with-param name="parentPath">
                        <xsl:value-of select="substring-before($mefParentPath,'/FieldAttributes')"/>
                    </xsl:with-param>
                    <xsl:with-param name="controlBit">
                        <xsl:value-of select="$coveredBit"/>
                    </xsl:with-param>
                    <xsl:with-param name="bitValue">
                        <xsl:value-of select="mef:Covered"/>
                    </xsl:with-param>
                </xsl:call-template>
            </row>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="node()" mode="ControlBitRow" name="ControlBitRow">
        <xsl:param name="fldName"/>
        <xsl:param name="parentPath"/>
        <xsl:param name="controlBit"/>
        <xsl:param name="bitValue"/>
        <xsl:element name="field">
            <xsl:attribute name="id">
                <xsl:text>SFLDPATH</xsl:text>
            </xsl:attribute>
            <value>
                <xsl:value-of select="concat($parentPath,'/',$fldName)"/>
            </value>
        </xsl:element>
        <xsl:element name="field">
            <xsl:attribute name="id">
                <xsl:text>SFLDNAME</xsl:text>
            </xsl:attribute>
            <value>
                <xsl:value-of select="$fldName"/>
            </value>
        </xsl:element>
        <xsl:element name="field">
            <xsl:attribute name="id">
                <xsl:text>SPARENT</xsl:text>
            </xsl:attribute>
            <value>
                <xsl:value-of select="$parentPath"/>
            </value>
        </xsl:element>
        <xsl:element name="field">
            <xsl:attribute name="id">
                <xsl:choose>
                    <xsl:when test="$controlBit=$coveredBit">
                        <xsl:text>SCOVERED</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </xsl:attribute>
            <value>
                <xsl:value-of select="normalize-space($bitValue)"/>
            </value>
        </xsl:element>
    </xsl:template>

    <!-- Mapping for IRS1040 -->
    <xsl:template match="mef:ReturnData/mef:IRS1040">
        <form id="F1040">
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="mef:TaxpayerAlimonyReceivedAmtPP" mode="Field">
                <xsl:with-param name="tpsId">L11T</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:SpouseAlimonyReceivedAmtPP" mode="Field">
                <xsl:with-param name="tpsId">L11S</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AmountRepaidToEmployerJuryDutyPP" mode="Field">
                <xsl:with-param name="tpsId">L32C</xsl:with-param>
            </xsl:apply-templates>
            <xsl:if test="count(mef:AlimonyAmountGrp)>0">
                <table id="ALIM">
                    <xsl:for-each select="mef:AlimonyAmountGrp">
                        <xsl:apply-templates select="." mode="IRS1040-AlimonyAmountGrp"/>
                    </xsl:for-each>
                </table>
            </xsl:if>
            <xsl:apply-templates select="mef:HaveAnyAlimonyPaidPP" mode="Boolean01">
                <xsl:with-param name="tpsId">HHAVEAL</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:HaveAnyMoreAlimonyPaidPP" mode="Boolean01">
                <xsl:with-param name="tpsId">HMOREAL</xsl:with-param>
            </xsl:apply-templates>
        </form>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS1040/mef:AlimonyAmountGrp" mode="IRS1040-AlimonyAmountGrp">
    	<row>
			<xsl:copy-of select="@uuid"/>
			<xsl:apply-templates select="mef:RecipientNamePP" mode="Field">
				<xsl:with-param name="tpsId">ALNAME</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="mef:RecipientSSN" mode="Field">
				<xsl:with-param name="tpsId">MRSSN</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="mef:AlimonyPaidAmt" mode="Field">
				<xsl:with-param name="tpsId">L31AMT</xsl:with-param>
			</xsl:apply-templates>
    	</row>
    </xsl:template>

    <!--Coming from mef:PPPerson/mef:TaxpayerFilerInfoPP / FPERSWKS copy 1-->
    <xsl:template match="mef:ReturnData/mef:PPReturnInformation" name="FPERSWKS-PPReturnInformation" mode="FPERSWKS-PPReturnInformation">  
        <xsl:apply-templates select="mef:DayTimePhoneNumberPP" mode="Field">
            <xsl:with-param name="tpsId">PHONE</xsl:with-param>
        </xsl:apply-templates>   
        <xsl:apply-templates select="mef:PhoneNumberExtPP" mode="Field">
            <xsl:with-param name="tpsId">EXTN</xsl:with-param>
        </xsl:apply-templates> 
        <xsl:apply-templates select="mef:MaritalStatusPP" mode="Field">
            <xsl:with-param name="tpsId">MARITAL</xsl:with-param>
        </xsl:apply-templates>     
    </xsl:template>   
    
    <xsl:template match="mef:ReturnData/mef:PPReturnInformation" name="FINFOWKS-NonResidentStateTablePP" mode="FINFOWKS-NonResidentStateTablePP">
        <xsl:if test="count(mef:NonResidentStateTablePP) > 0">
            <table id="NONRES">
                <xsl:for-each select="mef:NonResidentStateTablePP">
                  <xsl:variable name="index" select="position()"/>               
                  <row>
                    <xsl:attribute name="copy"> 
                        <xsl:value-of select="$index" />
                    </xsl:attribute>                    
                    <xsl:copy-of select="@uuid"/>  
                    <xsl:apply-templates select="mef:NonResidentStatePP" mode="Field">
                        <xsl:with-param name="tpsId">NONRESST</xsl:with-param>
                    </xsl:apply-templates> 
                  </row>
              </xsl:for-each>
            </table>                   
        </xsl:if>
    </xsl:template>  
    
    <xsl:template match="mef:Return/mef:ReturnData" mode="FORM-FONLINE">
        <xsl:if test="mef:IRS1040 | mef:PPReturnInformation | mef:PPPerson">
            <form id="FONLINE">    
                <xsl:copy-of select="@uuid"/>  
                <xsl:apply-templates select="mef:IRS1040/mef:PersonalPropertyRentalExpenses" mode="FONLINE-PersonalProperty"/>                 
                <xsl:apply-templates select="mef:PPPerson" mode="FONLINE-PPPerson"/>         
            </form>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="mef:PPPerson" mode="FONLINE-PPPerson">
        <xsl:apply-templates select="mef:SpouseFilerInfoPP/mef:MilitaryRelatedDeathPP" mode="BoolToCheckBox">
            <xsl:with-param name="tpsId">SPMILDOD</xsl:with-param>           
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:TaxpayerFilerInfoPP/mef:MilitaryRelatedDeathPP" mode="BoolToCheckBox">
            <xsl:with-param name="tpsId">TPMILDOD</xsl:with-param>           
        </xsl:apply-templates> 
        <xsl:apply-templates select="mef:TaxpayerFilerInfoPP/mef:IsDeadPP" mode="BoolToCheckBox">
            <xsl:with-param name="tpsId">TPDEAD</xsl:with-param>           
        </xsl:apply-templates> 
        <xsl:apply-templates select="mef:SpouseFilerInfoPP/mef:IsDeadPP" mode="BoolToCheckBox">
            <xsl:with-param name="tpsId">SPDEAD</xsl:with-param>           
        </xsl:apply-templates> 
    </xsl:template>
    
    <xsl:template match="mef:ReturnData/mef:IRS1040/mef:PersonalPropertyRentalExpenses" mode="FONLINE-PersonalProperty">
        <xsl:if test="mef:TaxpayerPersonalPropertyRentalExpensePP | mef:SpousePersonalPropertyRentalExpensePP">
            <table id="A4533">
                <xsl:if test="mef:TaxpayerPersonalPropertyRentalExpensePP">
                    <row copy="1">
                        <xsl:apply-templates select="mef:TaxpayerPersonalPropertyRentalExpensePP" mode="Field">
                            <xsl:with-param name="tpsId">PPROPEX</xsl:with-param>
                        </xsl:apply-templates>
                    </row>
                </xsl:if>
                <xsl:if test="mef:SpousePersonalPropertyRentalExpensePP">
                    <row copy="2">
                        <xsl:apply-templates select="mef:SpousePersonalPropertyRentalExpensePP" mode="Field">
                            <xsl:with-param name="tpsId">PPROPEX</xsl:with-param>
                        </xsl:apply-templates>
                    </row>
                </xsl:if>
            </table>
        </xsl:if>
    </xsl:template>

    <xsl:template name="FORM-FINFOWKS">
        <xsl:if test="mef:ReturnData/mef:PPReturnInformation">
          <form id ="FINFOWKS">
              <xsl:copy-of select="@uuid"/>    
              <xsl:apply-templates select="mef:ReturnData/mef:PPReturnInformation" mode="FINFOWKS-PPReturnInformation"/>
              <xsl:apply-templates select="mef:ReturnData/mef:PPReturnInformation" mode="FINFOWKS-NonResidentStateTablePP"/>
          </form>     
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="FORM-FPERSWKS-1">
        <xsl:if test="mef:ReturnData/mef:PPPerson/mef:TaxpayerFilerInfoPP | mef:ReturnData/mef:PPReturnInformation">
          <form id="FPERSWKS" copy="1">
              <xsl:copy-of select="@uuid"/>
              <xsl:apply-templates select="mef:ReturnData/mef:PPReturnInformation"  mode="FPERSWKS-PPReturnInformation"/>
              <xsl:apply-templates select="mef:ReturnData/mef:PPPerson"             mode="TaxpayerFilerInfoPP"/>
          </form>  
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="FORM-FPERSWKS-2">
        <xsl:if test="mef:ReturnData/mef:PPPerson/mef:SpouseFilerInfoPP">
          <form id="FPERSWKS" copy="2">
              <xsl:copy-of select="@uuid"/>
              <xsl:apply-templates select="mef:ReturnData/mef:PPPerson" mode="SpouseFilerInfoPP"/>
          </form>    
        </xsl:if>
    </xsl:template>
    
    <!-- bindings that share the same tps fields, but different copies -->
    <xsl:template match="mef:SpouseFilerInfoPP | mef:TaxpayerFilerInfoPP" mode="FILERINFO">          
        <xsl:apply-templates select="mef:MilitaryIndPP" mode="YesNoField">
            <xsl:with-param name="yTpsId">YMIL</xsl:with-param>
            <xsl:with-param name="nTpsId">NMIL</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:PersonNicknamePP" mode="Field">
            <xsl:with-param name="tpsId">NICKNAME</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:PersonMiddleInitialPP" mode="Field">
            <xsl:with-param name="tpsId">INITIAL</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:PersonSuffixPP" mode="Field">
            <xsl:with-param name="tpsId">SUFFIX</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:SSNPP" mode="Field">
            <xsl:with-param name="tpsId">SSN</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:DateOfBirthPP" mode="Date">
            <xsl:with-param name="tpsId">DOB</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:DateOfDeathPP" mode="Date">
            <xsl:with-param name="tpsId">DOD</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:CanBeClaimedAsDependentIndPP" mode="YesNoField">
            <xsl:with-param name="yTpsId">DXT</xsl:with-param>
            <xsl:with-param name="nTpsId">DXTN</xsl:with-param>
        </xsl:apply-templates>       
        <xsl:apply-templates select="mef:WillBeClaimedAsDependentIndPP" mode="YesNoField">
            <xsl:with-param name="yTpsId">DEPTY</xsl:with-param>
            <xsl:with-param name="nTpsId">DEPTN</xsl:with-param>
        </xsl:apply-templates>             
        <xsl:apply-templates select="mef:StateOfResidencePP" mode="Field">
            <xsl:with-param name="tpsId">RSTA</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:FormerPlaceOfResidencePP" mode="Field">
            <xsl:with-param name="tpsId">WHERE</xsl:with-param>
        </xsl:apply-templates>      
        <xsl:apply-templates select="mef:LivedInAnotherStatePP" mode="YesNoField">
            <xsl:with-param name="yTpsId">RESP</xsl:with-param>
            <xsl:with-param name="nTpsId">RESF</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:DateOfStateResidencePP" mode="Date">
            <xsl:with-param name="tpsId">RESDATE</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:LegallyBlindIndPP" mode="BoolToCheckBox">
            <xsl:with-param name="tpsId">BLXT</xsl:with-param>
        </xsl:apply-templates>         
        <xsl:apply-templates select="mef:OccupationPP" mode="Field">
            <xsl:with-param name="tpsId">OCCUP</xsl:with-param>
        </xsl:apply-templates>  
        <xsl:apply-templates select="mef:PersonFullNamePP/mef:PersonFirstNm" mode="Field">
            <xsl:with-param name="tpsId">FIRSTNAM</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:PersonFullNamePP/mef:PersonLastNm" mode="Field">
            <xsl:with-param name="tpsId">LASTNAM</xsl:with-param>
        </xsl:apply-templates>         
    </xsl:template>
    
    <xsl:template match="mef:ReturnData/mef:PPPerson" mode="SpouseFilerInfoPP">
        <xsl:apply-templates select="mef:SpouseFilerInfoPP" mode="FILERINFO"/>
    </xsl:template>
    
    <xsl:template match="mef:ReturnData/mef:PPPerson" mode="TaxpayerFilerInfoPP">
        <xsl:apply-templates select="mef:TaxpayerFilerInfoPP/mef:WidowedInYearPP[text()='TaxYr']" mode="EnumField">
            <xsl:with-param name="tpsId">YX3</xsl:with-param>
            <xsl:with-param name="fieldValue">X</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:TaxpayerFilerInfoPP/mef:WidowedInYearPP[text()='TwoPriorTaxYr']" mode="EnumField">
            <xsl:with-param name="tpsId">YX1</xsl:with-param>
            <xsl:with-param name="fieldValue">X</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:TaxpayerFilerInfoPP/mef:WidowedInYearPP[text()='PriorTaxYr']" mode="EnumField">
            <xsl:with-param name="tpsId">YX2</xsl:with-param>
            <xsl:with-param name="fieldValue">X</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:TaxpayerFilerInfoPP/mef:WidowedInYearPP[text()='NextTaxYr']" mode="EnumField">
            <xsl:with-param name="tpsId">YX4</xsl:with-param>
            <xsl:with-param name="fieldValue">X</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>                  
        <xsl:apply-templates select="mef:TaxpayerFilerInfoPP/mef:WidowedInYearPP[text()='PriorTwoPriorTaxYr']" mode="EnumField">
            <xsl:with-param name="tpsId">YX0</xsl:with-param>
            <xsl:with-param name="fieldValue">X</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>  
        <xsl:apply-templates select="mef:TaxpayerFilerInfoPP" mode="FILERINFO"/>
    </xsl:template>
    
    <xsl:template match="mef:ReturnData/mef:PPReturnInformation" mode="FINFOWKS-PPReturnInformation"> 
        <xsl:apply-templates select="mef:DetailedMaritalStatusPP" mode="Field">
            <xsl:with-param name="tpsId">HMARSTAT</xsl:with-param>
        </xsl:apply-templates> 
        <xsl:apply-templates select="mef:hMarriedFilingStatusPP" mode="Field">
            <xsl:with-param name="tpsId">HMFSTAT</xsl:with-param>
        </xsl:apply-templates> 
        <xsl:apply-templates select="mef:USAddressPP/mef:AddressLine1Txt" mode="Field">
            <xsl:with-param name="tpsId">ADDR</xsl:with-param>
        </xsl:apply-templates>         
        <xsl:apply-templates select="mef:USAddressPP/mef:AddressLine2Txt" mode="Field">
            <xsl:with-param name="tpsId">APT</xsl:with-param>
        </xsl:apply-templates>       
        <xsl:apply-templates select="mef:USAddressPP/mef:CityNm" mode="Field">
            <xsl:with-param name="tpsId">CITY</xsl:with-param>
        </xsl:apply-templates>       
        <xsl:apply-templates select="mef:USAddressPP/mef:StateAbbreviationCd" mode="Field">
            <xsl:with-param name="tpsId">ST</xsl:with-param>
        </xsl:apply-templates>       
        <xsl:apply-templates select="mef:USAddressPP/mef:ZIPCd" mode="Field">
            <xsl:with-param name="tpsId">ZIP</xsl:with-param>
        </xsl:apply-templates>       
        <xsl:apply-templates select="mef:ForeignAddressPP/mef:AddressLine1Txt" mode="Field">
            <xsl:with-param name="tpsId">ADDR</xsl:with-param>
        </xsl:apply-templates>       
        <xsl:apply-templates select="mef:ForeignAddressPP/mef:AddressLine2Txt" mode="Field">
            <xsl:with-param name="tpsId">APT</xsl:with-param>
        </xsl:apply-templates>   
        <xsl:apply-templates select="mef:ForeignAddressPP/mef:ProvinceOrStateNm" mode="Field">
            <xsl:with-param name="tpsId">FPC</xsl:with-param>
        </xsl:apply-templates>       
        <xsl:apply-templates select="mef:ForeignAddressPP/mef:CountryCd" mode="Field">
            <xsl:with-param name="tpsId">FCCODE</xsl:with-param>
        </xsl:apply-templates>  
        <xsl:apply-templates select="mef:ForeignAddressPP/mef:CityNm" mode="Field">
            <xsl:with-param name="tpsId">CITY</xsl:with-param>
        </xsl:apply-templates>    
        <xsl:apply-templates select="mef:ForeignAddressPP/mef:ForeignPostalCd" mode="Field">
            <xsl:with-param name="tpsId">FZIP</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>              
        <xsl:apply-templates select="mef:HasRDPPP" mode="Boolean01">
            <xsl:with-param name="tpsId">HHASRDP</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>  
        <xsl:apply-templates select="mef:HasCivilUnionPP" mode="Boolean01">
            <xsl:with-param name="tpsId">HHASCU</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>  
        <xsl:apply-templates select="mef:HasRDPorCUPP" mode="Boolean01">
            <xsl:with-param name="tpsId">HRDPORCU</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>  
    </xsl:template>   

    <!-- Mapping for Other Income -->
    <xsl:template match="mef:ReturnData/mef:OtherIncome">
        <form id="FOTHINC">
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="mef:TaxpayerJuryDutyPayPP" mode="Field">
                <xsl:with-param name="tpsId">L12T</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:SpouseJuryDutyPayPP" mode="Field">
                <xsl:with-param name="tpsId">L12S</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:TaxpayerBarteringIncomePP" mode="Field">
                <xsl:with-param name="tpsId">L13T</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:SpouseBarteringIncomePP" mode="Field">
                <xsl:with-param name="tpsId">L13S</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:TaxpayerPersonalPropertyRentalIncomePP" mode="Field">
                <xsl:with-param name="tpsId">L14T</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:SpousePersonalPropertyRentalIncomePP" mode="Field">
                <xsl:with-param name="tpsId">L14S</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:TaxpayerWinningsNotReportedOnFormPP" mode="Field">
                <xsl:with-param name="tpsId">L2BT</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:SpouseWinningsNotReportedOnFormPP" mode="Field">
                <xsl:with-param name="tpsId">L2BS</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:TotalWinningsPP" mode="Field">
                <xsl:with-param name="tpsId">HTOTL2</xsl:with-param>
            </xsl:apply-templates>
           <xsl:if test="mef:OtherTaxableIncomeGrpPP">
                <table id="LN15PER">
                    <xsl:apply-templates select="mef:OtherTaxableIncomeGrpPP" mode="OtherTaxableIncomeGrpPP"/>
                </table>
            </xsl:if>
            <xsl:apply-templates select="mef:TaxpayerHobbyIncomePP" mode="Field">
                <xsl:with-param name="tpsId">HOBBYT</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:SpouseHobbyIncomePP" mode="Field">
                <xsl:with-param name="tpsId">HOBBYS</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:TaxpayerRecoveryOfPriorYearBadDebtPP" mode="Field">
                <xsl:with-param name="tpsId">L11T</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:SpouseRecoveryOfPriorYearBadDebtPP" mode="Field">
                <xsl:with-param name="tpsId">L11S</xsl:with-param>
            </xsl:apply-templates>
        </form>
    </xsl:template>
    
    <xsl:template match="mef:ReturnData/mef:OtherIncome/mef:OtherTaxableIncomeGrpPP" mode="OtherTaxableIncomeGrpPP">
        <row>
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="mef:OtherTaxableIncomeDescriptionPP" mode="Field">
                <xsl:with-param name="tpsId">L15DES</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:TaxpayerOtherTaxableIncomeAmtPP" mode="Field">
                <xsl:with-param name="tpsId">L15TP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:SpouseOtherTaxableIncomeAmtPP" mode="Field">
                <xsl:with-param name="tpsId">L15SP</xsl:with-param>
            </xsl:apply-templates>
        </row>
    </xsl:template>
    
    <!-- Mappings for IRS1040ScheduleA tables and fields -->
    <xsl:template match="mef:ReturnData/mef:IRS1040ScheduleA">
        <form id="FSCHATI">
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="mef:HaveAnyAutoRegistrationIndPP" mode="Field">
                <xsl:with-param name="tpsId">hAutoReg</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:HaveAnyMoreAutoRegistrationIndPP" mode="Field">
                <xsl:with-param name="tpsId">hAddAuto</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates/>
        </form>
        <xsl:call-template name="IRS1040ScheduleA-FSCHA19"/>
        <xsl:call-template name="IRS1040ScheduleA-FSCHA"/>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS1040ScheduleA/mef:AutoRegistrationGroupPP">
        <table id="DMVFEES">
            <row>
                <xsl:copy-of select="@uuid"/>
                <xsl:apply-templates select="mef:MakeModelDescriptionPP" mode="Field">
                    <xsl:with-param name="tpsId">L3A1</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:DeductibleRegistrationFeePP" mode="Field">
                    <xsl:with-param name="tpsId">L3A</xsl:with-param>
                </xsl:apply-templates>
            </row>
        </table>
    </xsl:template>



    <xsl:template match="mef:ReturnData/mef:IRS1040ScheduleA" name="IRS1040ScheduleA-FSCHA19" mode="IRS1040ScheduleA-FSCHA19">
       <!-- TODO: We should remove this if condition from here. This is a hack so that we do not
            change the mapping output for current AutoReg. Date - 04/09/2015-->
        <xsl:if test="mef:GamblingLossesPP | mef:LegalFeesPP | mef:TaxpayerHobbyExpensePP | mef:SpouseHobbyExpensePP">
            <form id="FSCHA19">
<!--                <xsl:copy-of select="@uuid"/>-->
                <xsl:apply-templates select="mef:GamblingLossesPP" mode="Field">
                    <xsl:with-param name="tpsId">L17</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:LegalFeesPP" mode="Field">
                    <xsl:with-param name="tpsId">L12B</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:TaxpayerHobbyExpensePP" mode="Field">
                    <xsl:with-param name="tpsId">HOBBYEXT</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:SpouseHobbyExpensePP" mode="Field">
                    <xsl:with-param name="tpsId">HOBBYEXS</xsl:with-param>
                </xsl:apply-templates>
            </form>
        </xsl:if>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS1040ScheduleA" name="IRS1040ScheduleA-FSCHA" mode="IRS1040ScheduleA-FSCHA">
       <!-- TODO: We should remove this if condition from here. This is a hack so that we do not
            change the mapping output for current AutoReg. Date - 04/09/2015-->
        <xsl:if test="mef:TaxPreparationFeesAmt">
            <form id="FSCHA">
<!--                <xsl:copy-of select="@uuid"/>-->
                <xsl:apply-templates select="mef:TaxPreparationFeesAmt" mode="Field">
                    <xsl:with-param name="tpsId">L21</xsl:with-param>
                </xsl:apply-templates>
            </form>
        </xsl:if>
    </xsl:template>
    
    <!-- Mappings for IRS1095A Fields -->
    <xsl:template match="mef:ReturnData/mef:IRS1095A">
        <form id="F1095A">
            <!-- Pass through the uuid if present -->
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="mef:PolicyIssuersNamePP" mode="Field">
                <xsl:with-param name="tpsId">PAYERNM1</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:Corrected1095AIndPP" mode="BoolToCheckBox">
                <xsl:with-param name="tpsId">CORRX</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MarketplaceIdentiferPP" mode="Field">
                <xsl:with-param name="tpsId">PAYERID</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:PolicyStartDatePP" mode="Date">
                <xsl:with-param name="tpsId">PLSTDATE</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:PolicyTerminationDatePP" mode="Date">
                <xsl:with-param name="tpsId">PLENDATE</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:RecipientFirstNamePP" mode="Field">
                <xsl:with-param name="tpsId">RFNAME</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:RecipientLastNamePP" mode="Field">
                <xsl:with-param name="tpsId">RLNAME</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:RecipientSSNPP" mode="Field">
                <xsl:with-param name="tpsId">RECIPSSN</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:RecipientBirthDtPP" mode="Date">
                <xsl:with-param name="tpsId">RDOB</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:RecipientAddressPP/mef:AddressLine1Txt" mode="Field">
                <xsl:with-param name="tpsId">RECIPADD</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:RecipientAddressPP/mef:CityNm" mode="Field">
                <xsl:with-param name="tpsId">RCTY</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:RecipientAddressPP/mef:StateAbbreviationCd" mode="Field">
                <xsl:with-param name="tpsId">RST</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:RecipientAddressPP/mef:ZIPCd" mode="Field">
                <xsl:with-param name="tpsId">RZIP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:RecipientSpouseFirstNamePP" mode="Field">
                <xsl:with-param name="tpsId">RSFNAME</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:RecipientSpouseLastNamePP" mode="Field">
                <xsl:with-param name="tpsId">RSLNAME</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:RecipientSpouseSSNPP" mode="Field">
                <xsl:with-param name="tpsId">RSSSN</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:RecipientSpouseBirthDtPP" mode="Date">
                <xsl:with-param name="tpsId">RSDOB</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MarketAssignedPolicyNumberPP" mode="Field">
                <xsl:with-param name="tpsId">PAYPOLID</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:TotalPlanPremiumAmtPP" mode="Field">
                <xsl:with-param name="tpsId">TOTPREM</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:TotalPremiumSLCSPAmtPP" mode="Field">
                <xsl:with-param name="tpsId">TOTSLCSP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:TotalAdvancedPTCAmtPP" mode="Field">
                <xsl:with-param name="tpsId">ADVCRED</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:HaveOtherCoveredIndivIndPP" mode="YesNoField">
                <xsl:with-param name="yTpsId">HOYCIND</xsl:with-param>
                <xsl:with-param name="nTpsId">HONCIND</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:HaveAnyMoreCoveredIndivIndPP" mode="YesNoField">
                <xsl:with-param name="yTpsId">HAMYCIND</xsl:with-param>
                <xsl:with-param name="nTpsId">HAMNCIND</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:LinkStartMonthNumberCdPP" mode="Field">
                <xsl:with-param name="tpsId">STRMTH</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:LinkEndMonthNumberCdPP" mode="Field">
                <xsl:with-param name="tpsId">ENDMTH</xsl:with-param>
            </xsl:apply-templates>
            <xsl:if test="count(mef:CoveredIndivInformationPP)>0">
                <table id="CVRGHSLD">
                    <xsl:for-each select="mef:CoveredIndivInformationPP">
                        <xsl:apply-templates select="." mode="CoveredIndivInformationPP"/>
                    </xsl:for-each>
                </table>
            </xsl:if>
            <xsl:if test="count(mef:MonthlyPTCInformationGrpPP)>0">
                <table id="MNTHLYCV">
                    <xsl:apply-templates select="mef:MonthlyPTCInformationGrpPP[mef:MonthCdPP='JANUARY']" mode="MonthlyPTCInformationGrpPP"/>
                    <xsl:apply-templates select="mef:MonthlyPTCInformationGrpPP[mef:MonthCdPP='FEBRUARY']" mode="MonthlyPTCInformationGrpPP"/>
                    <xsl:apply-templates select="mef:MonthlyPTCInformationGrpPP[mef:MonthCdPP='MARCH']" mode="MonthlyPTCInformationGrpPP"/>
                    <xsl:apply-templates select="mef:MonthlyPTCInformationGrpPP[mef:MonthCdPP='APRIL']" mode="MonthlyPTCInformationGrpPP"/>
                    <xsl:apply-templates select="mef:MonthlyPTCInformationGrpPP[mef:MonthCdPP='MAY']" mode="MonthlyPTCInformationGrpPP"/>
                    <xsl:apply-templates select="mef:MonthlyPTCInformationGrpPP[mef:MonthCdPP='JUNE']" mode="MonthlyPTCInformationGrpPP"/>
                    <xsl:apply-templates select="mef:MonthlyPTCInformationGrpPP[mef:MonthCdPP='JULY']" mode="MonthlyPTCInformationGrpPP"/>
                    <xsl:apply-templates select="mef:MonthlyPTCInformationGrpPP[mef:MonthCdPP='AUGUST']" mode="MonthlyPTCInformationGrpPP"/>
                    <xsl:apply-templates select="mef:MonthlyPTCInformationGrpPP[mef:MonthCdPP='SEPTEMBER']" mode="MonthlyPTCInformationGrpPP"/>
                    <xsl:apply-templates select="mef:MonthlyPTCInformationGrpPP[mef:MonthCdPP='OCTOBER']" mode="MonthlyPTCInformationGrpPP"/>
                    <xsl:apply-templates select="mef:MonthlyPTCInformationGrpPP[mef:MonthCdPP='NOVEMBER']" mode="MonthlyPTCInformationGrpPP"/>
                    <xsl:apply-templates select="mef:MonthlyPTCInformationGrpPP[mef:MonthCdPP='DECEMBER']" mode="MonthlyPTCInformationGrpPP"/>
                </table>
            </xsl:if>
            <xsl:apply-templates select="mef:SharedPolicyAllocationPP" mode="SharedPolicyAllocationPP"/>
            
            <xsl:apply-templates select="mef:FormCopyKeyForBusinessTypePP" mode="Field">
                <xsl:with-param name="tpsId">HACTCOPY</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:BusinessTypeIdPP" mode="Field">
                <xsl:with-param name="tpsId">HACTTYPE</xsl:with-param>
            </xsl:apply-templates> 
        </form>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS1095A/mef:MonthlyPTCInformationGrpPP" mode="MonthlyPTCInformationGrpPP">
            <row>
                <xsl:copy-of select="@uuid"/>
                <xsl:apply-templates select="mef:MonthCdPP" mode="Field">
                    <xsl:with-param name="tpsId">MONTHCD</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthlyPlanPremiumAmtPP" mode="Field">
                    <xsl:with-param name="tpsId">MTHPREM</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthlyPremiumSLCSPAmtPP" mode="Field">
                    <xsl:with-param name="tpsId">MTHSLCSP</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthlyAdvancedPTCAmtPP" mode="Field">
                    <xsl:with-param name="tpsId">MTHADVCR</xsl:with-param>
                </xsl:apply-templates>
            </row>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS1095A/mef:CoveredIndivInformationPP" mode="CoveredIndivInformationPP">
            <row>
                <xsl:copy-of select="@uuid"/>
                <xsl:apply-templates select="mef:CoveredIndivFirstNamePP" mode="Field">
                    <xsl:with-param name="tpsId">DFNAME</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:CoveredIndivLastNamePP" mode="Field">
                    <xsl:with-param name="tpsId">DLNAME</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:CoveredIndivSSNPP" mode="Field">
                    <xsl:with-param name="tpsId">DSSN</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:CoveredIndivBirthDtPP" mode="Date">
                    <xsl:with-param name="tpsId">DDOB</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:CoveredIndivStartDtPP" mode="Date">
                    <xsl:with-param name="tpsId">DSTRCVM</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:CoveredIndivEndDtPP" mode="Date">
                    <xsl:with-param name="tpsId">DENDCVRM</xsl:with-param>
                </xsl:apply-templates>
            </row>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS1095A/mef:SharedPolicyAllocationPP" mode="SharedPolicyAllocationPP">
        <xsl:apply-templates select="mef:SSNPP" mode="Field">
            <xsl:with-param name="tpsId">SHPOLSSN</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:StartMonthNumberCdPP" mode="Field">
            <xsl:with-param name="tpsId">SHPOLSM</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:EndMonthNumberCdPP" mode="Field">
            <xsl:with-param name="tpsId">SHPOLEM</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthlyPremiumPctPP" mode="Field">
            <xsl:with-param name="tpsId">SPMPPCT</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthlyPremiumSLCSPPctPP" mode="Field">
            <xsl:with-param name="tpsId">SPSLCSPP</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthlyAdvancedPTCPctPP" mode="Field">
            <xsl:with-param name="tpsId">SPADVPTC</xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>

    <!-- Mappings for IRS1095B Fields -->
    <xsl:template match="mef:ReturnData/mef:IRS1095B">
        <form id="F1095B">
            <!-- Pass through the uuid if present -->
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="mef:IssuerOrProviderNamePP" mode="Field">
                <xsl:with-param name="tpsId">PAYERNM1</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:IssuerOrProviderAddressPP/mef:AddressLine1Txt"
                mode="Field">
                <xsl:with-param name="tpsId">PAYADD1</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:IssuerOrProviderAddressPP/mef:CityNm" mode="Field">
                <xsl:with-param name="tpsId">PCTY</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:IssuerOrProviderAddressPP/mef:StateAbbreviationCd"
                mode="Field">
                <xsl:with-param name="tpsId">PST</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:IssuerOrProviderAddressPP/mef:ZIPCd" mode="Field">
                <xsl:with-param name="tpsId">PZIP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:IssuerOrProviderEINPP" mode="Field">
                <xsl:with-param name="tpsId">PAYERID</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:ContactPersonPhonePP" mode="Field">
                <xsl:with-param name="tpsId">PCONPHON</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:OriginOfPolicyCdPP" mode="Field">
                <xsl:with-param name="tpsId">POLORGCD</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployerNamePP" mode="Field">
                <xsl:with-param name="tpsId">EMPNAME</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployerAddressPP/mef:AddressLine1Txt" mode="Field">
                <xsl:with-param name="tpsId">EADDRESS</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployerAddressPP/mef:CityNm" mode="Field">
                <xsl:with-param name="tpsId">ECTY</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployerAddressPP/mef:StateAbbreviationCd" mode="Field">
                <xsl:with-param name="tpsId">EST</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployerAddressPP/mef:ZIPCd" mode="Field">
                <xsl:with-param name="tpsId">EZIP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployerEINPP" mode="Field">
                <xsl:with-param name="tpsId">EMPLOYID</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:PlanIsSHOPIndPP" mode="Field">
                <xsl:with-param name="tpsId">SHOPPLAN</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:SHOPIdentifierPP" mode="Field">
                <xsl:with-param name="tpsId">SHOPPLID</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:ResponsibleIndivNamePP" mode="Field">
                <xsl:with-param name="tpsId">RECIPNAM</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:ResponsibleIndivAddressPP/mef:AddressLine1Txt" mode="Field">
                <xsl:with-param name="tpsId">RECIPADD</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:ResponsibleIndivAddressPP/mef:CityNm" mode="Field">
                <xsl:with-param name="tpsId">RCTY</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:ResponsibleIndivAddressPP/mef:StateAbbreviationCd"
                mode="Field">
                <xsl:with-param name="tpsId">RST</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:ResponsibleIndivAddressPP/mef:ZIPCd" mode="Field">
                <xsl:with-param name="tpsId">RZIP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:ResponsibleIndivSSNPP" mode="Field">
                <xsl:with-param name="tpsId">RECIPSSN</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:ResponsibleIndivBirthDtPP" mode="Date">
                <xsl:with-param name="tpsId">RDOB</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:HaveOtherCoveredIndivIndPP" mode="YesNoField">
                <xsl:with-param name="yTpsId">HOYCIND</xsl:with-param>
                <xsl:with-param name="nTpsId">HONCIND</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:HaveAnyMoreCoveredIndivIndPP" mode="YesNoField">
                <xsl:with-param name="yTpsId">HAMYCIND</xsl:with-param>
                <xsl:with-param name="nTpsId">HAMNCIND</xsl:with-param>
            </xsl:apply-templates>
            <xsl:if test="count(mef:CoveredIndivGrpPP)>0">
                <table id="COVINDIV">
                    <xsl:for-each select="mef:CoveredIndivGrpPP">
                        <xsl:apply-templates select="." mode="CoveredIndivGrpPP"/>
                    </xsl:for-each>
                </table>
            </xsl:if>
        </form>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS1095B/mef:CoveredIndivGrpPP" mode="CoveredIndivGrpPP">
            <row>
                <xsl:copy-of select="@uuid"/>
                <xsl:apply-templates select="mef:PersonNmPP" mode="Field">
                    <xsl:with-param name="tpsId">COVFNAM</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:SSNPP" mode="Field">
                    <xsl:with-param name="tpsId">COVSSN</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:PersonBirthDtPP" mode="Date">
                    <xsl:with-param name="tpsId">COVDOB</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:AllYearIndPP" mode="Field">
                    <xsl:with-param name="tpsId">COV12MTH</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:JanuaryIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIM1</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:FebruaryIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIM2</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MarchIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIM3</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:AprilIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIM4</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MayIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIM5</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:JuneIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIM6</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:JulyIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIM7</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:AugustIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIM8</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:SeptemberIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIM9</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:OctoberIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIM10</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:NovemberIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIM11</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:DecemberIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIM12</xsl:with-param>
                </xsl:apply-templates>
            </row>
    </xsl:template>

    <!-- Mappings for IRS1095C Fields -->
    <xsl:template match="mef:ReturnData/mef:IRS1095C">
        <form id="F1095C">
            <!-- Pass through the uuid if present -->
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="mef:ALENamePP" mode="Field">
                <xsl:with-param name="tpsId">ERNAME</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:ALEEINPP" mode="Field">
                <xsl:with-param name="tpsId">ERID</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:ALEPhoneNumberPP" mode="Field">
                <xsl:with-param name="tpsId">ERPHONE</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployeeNamePP" mode="Field">
                <xsl:with-param name="tpsId">EEFNAME</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployeeSSNPP" mode="Field">
                <xsl:with-param name="tpsId">EESSN</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployeeAddressPP/mef:AddressLine1Txt" mode="Field">
                <xsl:with-param name="tpsId">EEADDRES</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployeeAddressPP/mef:CityNm" mode="Field">
                <xsl:with-param name="tpsId">EECTY</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployeeAddressPP/mef:StateAbbreviationCd" mode="Field">
                <xsl:with-param name="tpsId">EEST</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployeeAddressPP/mef:ZIPCd" mode="Field">
                <xsl:with-param name="tpsId">EEZIP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:ALEAddressPP/mef:AddressLine1Txt" mode="Field">
                <xsl:with-param name="tpsId">ERADDRES</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:ALEAddressPP/mef:CityNm" mode="Field">
                <xsl:with-param name="tpsId">ERCTY</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:ALEAddressPP/mef:StateAbbreviationCd" mode="Field">
                <xsl:with-param name="tpsId">ERST</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:ALEAddressPP/mef:ZIPCd" mode="Field">
                <xsl:with-param name="tpsId">ERZIP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AnnualCoverageOfferedCdPP" mode="Field">
                <xsl:with-param name="tpsId">AOFRCOV</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AnnualMonthlyPremiumAmtPP" mode="Field">
                <xsl:with-param name="tpsId">AESHRPR</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AnnualSafeHarborCdPP" mode="Field">
                <xsl:with-param name="tpsId">ASFHARBR</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:HaveOtherCoveredIndivIndPP" mode="YesNoField">
                <xsl:with-param name="yTpsId">HOYCIND</xsl:with-param>
                <xsl:with-param name="nTpsId">HONCIND</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:HaveAnyMoreCoveredIndivIndPP" mode="YesNoField">
                <xsl:with-param name="yTpsId">HAMYCIND</xsl:with-param>
                <xsl:with-param name="nTpsId">HAMNCIND</xsl:with-param>
            </xsl:apply-templates>
            <xsl:if test="count(mef:CoveredIndivGrpPP)>0">
                <table id="COVINDIV">
                    <xsl:for-each select="mef:CoveredIndivGrpPP">
                        <xsl:apply-templates select="." mode="CoveredIndivGrpPP"/>
                    </xsl:for-each>
                </table>
            </xsl:if>
            <xsl:if test="count(mef:PartIIGrpPP)>0">
                <table id="MNTHLY">
                    <xsl:apply-templates select="mef:PartIIGrpPP[mef:MonthNamePP='JANUARY']" mode="PartIIGrpPP"/>
                    <xsl:apply-templates select="mef:PartIIGrpPP[mef:MonthNamePP='FEBRUARY']" mode="PartIIGrpPP"/>
                    <xsl:apply-templates select="mef:PartIIGrpPP[mef:MonthNamePP='MARCH']" mode="PartIIGrpPP"/>
                    <xsl:apply-templates select="mef:PartIIGrpPP[mef:MonthNamePP='APRIL']" mode="PartIIGrpPP"/>
                    <xsl:apply-templates select="mef:PartIIGrpPP[mef:MonthNamePP='MAY']" mode="PartIIGrpPP"/>
                    <xsl:apply-templates select="mef:PartIIGrpPP[mef:MonthNamePP='JUNE']" mode="PartIIGrpPP"/>
                    <xsl:apply-templates select="mef:PartIIGrpPP[mef:MonthNamePP='JULY']" mode="PartIIGrpPP"/>
                    <xsl:apply-templates select="mef:PartIIGrpPP[mef:MonthNamePP='AUGUST']" mode="PartIIGrpPP"/>
                    <xsl:apply-templates select="mef:PartIIGrpPP[mef:MonthNamePP='SEPTEMBER']" mode="PartIIGrpPP"/>
                    <xsl:apply-templates select="mef:PartIIGrpPP[mef:MonthNamePP='OCTOBER']" mode="PartIIGrpPP"/>
                    <xsl:apply-templates select="mef:PartIIGrpPP[mef:MonthNamePP='NOVEMBER']" mode="PartIIGrpPP"/>
                    <xsl:apply-templates select="mef:PartIIGrpPP[mef:MonthNamePP='DECEMBER']" mode="PartIIGrpPP"/>
                </table>
            </xsl:if>
        </form>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS1095C/mef:CoveredIndivGrpPP" mode="CoveredIndivGrpPP">
            <row>
                <xsl:copy-of select="@uuid"/>
                <xsl:apply-templates select="mef:PersonNmPP" mode="Field">
                    <xsl:with-param name="tpsId">COVFNAM</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:SSNPP" mode="Field">
                    <xsl:with-param name="tpsId">COVSSN</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:PersonBirthDtPP" mode="Date">
                    <xsl:with-param name="tpsId">COVDOB</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:AllYearIndPP" mode="Field">
                    <xsl:with-param name="tpsId">COV12MTH</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:JanuaryIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIMJAN</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:FebruaryIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIMFEB</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MarchIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIMMAR</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:AprilIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIMAPR</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MayIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIMMAY</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:JuneIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIMJUN</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:JulyIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIMJUL</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:AugustIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIMAUG</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:SeptemberIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIMSEP</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:OctoberIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIMOCT</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:NovemberIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIMNOV</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:DecemberIndPP" mode="Field">
                    <xsl:with-param name="tpsId">CIMDEC</xsl:with-param>
                </xsl:apply-templates>
            </row>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS1095C/mef:PartIIGrpPP" mode="PartIIGrpPP">
            <row>
                <xsl:copy-of select="@uuid"/>
                <xsl:apply-templates select="mef:MonthNamePP" mode="Field">
                    <xsl:with-param name="tpsId">MONTHCD</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:CoverageOfferedCdPP" mode="Field">
                    <xsl:with-param name="tpsId">OFRCOV</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthlyPremiumAmtPP" mode="Field">
                    <xsl:with-param name="tpsId">ESHRPREM</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:SafeHarborCdPP" mode="Field">
                    <xsl:with-param name="tpsId">SFHARBOR</xsl:with-param>
                </xsl:apply-templates>
            </row>
    </xsl:template>

    <!-- Mappings for IRS1095Other Fields -->
    <xsl:template match="mef:ReturnData/mef:IRS1095Other">
        <form id="F1095OTH">
            <!-- Pass through the uuid if present -->
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="mef:HaveOtherCoveredIndivIndPP" mode="YesNoField">
                <xsl:with-param name="yTpsId">HOYCIND</xsl:with-param>
                <xsl:with-param name="nTpsId">HONCIND</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:HaveAnyMoreCoveredIndivIndPP" mode="YesNoField">
                <xsl:with-param name="yTpsId">HAMYCIND</xsl:with-param>
                <xsl:with-param name="nTpsId">HAMNCIND</xsl:with-param>
            </xsl:apply-templates>
            <xsl:if test="count(mef:CoveredIndivGrpPP)>0">
                <table id="COVINDIV">
                    <xsl:for-each select="mef:CoveredIndivGrpPP">
                        <xsl:apply-templates select="." mode="CoveredIndivGrpPP"/>
                    </xsl:for-each>
        </table>
            </xsl:if>
        </form>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS1095Other/mef:CoveredIndivGrpPP" mode="CoveredIndivGrpPP">
        <row>
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="mef:PersonNmPP" mode="Field">
                <xsl:with-param name="tpsId">COVFNAM</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:SSNPP" mode="Field">
                <xsl:with-param name="tpsId">COVSSN</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:PersonBirthDtPP" mode="Date">
                <xsl:with-param name="tpsId">COVDOB</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AllYearIndPP" mode="Field">
                <xsl:with-param name="tpsId">COV12MTH</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:JanuaryIndPP" mode="Field">
                <xsl:with-param name="tpsId">CIMJAN</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:FebruaryIndPP" mode="Field">
                <xsl:with-param name="tpsId">CIMFEB</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MarchIndPP" mode="Field">
                <xsl:with-param name="tpsId">CIMMAR</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AprilIndPP" mode="Field">
                <xsl:with-param name="tpsId">CIMAPR</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MayIndPP" mode="Field">
                <xsl:with-param name="tpsId">CIMMAY</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:JuneIndPP" mode="Field">
                <xsl:with-param name="tpsId">CIMJUN</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:JulyIndPP" mode="Field">
                <xsl:with-param name="tpsId">CIMJUL</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AugustIndPP" mode="Field">
                <xsl:with-param name="tpsId">CIMAUG</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:SeptemberIndPP" mode="Field">
                <xsl:with-param name="tpsId">CIMSEP</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:OctoberIndPP" mode="Field">
                <xsl:with-param name="tpsId">CIMOCT</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:NovemberIndPP" mode="Field">
                <xsl:with-param name="tpsId">CIMNOV</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:DecemberIndPP" mode="Field">
                <xsl:with-param name="tpsId">CIMDEC</xsl:with-param>
            </xsl:apply-templates>
        </row>
    </xsl:template>

    <!-- Mappings for IRS8962 Fields -->
    <xsl:template match="mef:ReturnData/mef:IRS8962">
        <form id="F8962">
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="mef:ReliefInd" mode="Field">
                <xsl:with-param name="tpsId">HSHIPIND</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:TotalExemptionsCnt" mode="Field">
                <xsl:with-param name="tpsId">TOTEXCNT</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:ModifiedAGIAmt" mode="Field">
                <xsl:with-param name="tpsId">MODAGI</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:TotalDependentsModifiedAGIAmt" mode="Field">
                <xsl:with-param name="tpsId">DMODAGI</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:HouseholdIncomeAmt" mode="Field">
                <xsl:with-param name="tpsId">HSHLDINC</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:PovertyLevelAmt" mode="Field">
                <xsl:with-param name="tpsId">PVRTYLVL</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:FederalPovertyTableLocCd[child::text()='A']" mode="EnumField">
                <xsl:with-param name="tpsId">AK</xsl:with-param>
                <xsl:with-param name="fieldValue">X</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:FederalPovertyTableLocCd[child::text()='B']" mode="EnumField">
                <xsl:with-param name="tpsId">HI</xsl:with-param>
                <xsl:with-param name="fieldValue">X</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:FederalPovertyTableLocCd[child::text()='C']" mode="EnumField">
                <xsl:with-param name="tpsId">OTH48DC</xsl:with-param>
                <xsl:with-param name="fieldValue">X</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:FederalPovertyLevelPct" mode="Field">
                <xsl:with-param name="tpsId">PVRTYPCT</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:HshldIncmBelowPTCThresholdInd" mode="YesNoField">
                <xsl:with-param name="yTpsId">HILTPVRT</xsl:with-param>
                <xsl:with-param name="nTpsId">M400PCT</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:ApplicableFigureRt" mode="Field">
                <xsl:with-param name="tpsId">APPFIGRT</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AnnualContributionAmt" mode="Field">
                <xsl:with-param name="tpsId">ANNCONTR</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyContriHealthCareCvrAmt" mode="Field">
                <xsl:with-param name="tpsId">MTHCONTR</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:SharePolicyMarriedAltCalcInd" mode="YesNoField">
                <xsl:with-param name="yTpsId">APORACMI</xsl:with-param>
                <xsl:with-param name="nTpsId">APRACMIN</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:Form1095ASameMonthlyAmtInd" mode="YesNoField">
                <xsl:with-param name="yTpsId">F1095ASM</xsl:with-param>
                <xsl:with-param name="nTpsId">F1095ANO</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AnnualPTCCalculationGrp/mef:AnnualPremiumAmt" mode="Field">
                <xsl:with-param name="tpsId">ANNPREM</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AnnualPTCCalculationGrp/mef:AnnualPremiumSLCSPAmt" mode="Field">
                <xsl:with-param name="tpsId">APSLCSP</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AnnualPTCCalculationGrp/mef:AnnualContributionAmt" mode="Field">
                <xsl:with-param name="tpsId">ANNCONT</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AnnualPTCCalculationGrp/mef:AnnualMaxPremiumAssistanceAmt" mode="Field">
                <xsl:with-param name="tpsId">ANNMXAST</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AnnualPTCCalculationGrp/mef:AnnualPremiumTaxCreditAllwAmt" mode="Field">
                <xsl:with-param name="tpsId">ANNTXCR</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AnnualPTCCalculationGrp/mef:AnnualAdvancedPTCAmt" mode="Field">
                <xsl:with-param name="tpsId">ANNADVCR</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:TotalPremiumTaxCreditAmt" mode="Field">
                <xsl:with-param name="tpsId">TOTPTC</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:TotalAdvancedPTCAmt" mode="Field">
                <xsl:with-param name="tpsId">TOTADPTC</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:ReconciledPremiumTaxCreditAmt" mode="Field">
                <xsl:with-param name="tpsId">RECONPTC</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:ExcessAdvncPaymentAmt" mode="Field">
                <xsl:with-param name="tpsId">EXADVPMT</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AdditionalTaxLimitationAmt" mode="Field">
                <xsl:with-param name="tpsId">ADDTXLIM</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:PremiumTaxCreditTaxLiabAmt" mode="Field">
                <xsl:with-param name="tpsId">PTCLIABL</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:SharedPolicyAllocationInfoInd" mode="YesNoField">
                <xsl:with-param name="yTpsId">SPALLIND</xsl:with-param>
                <xsl:with-param name="nTpsId">SPALLNO</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AltCalcForMarriagePrimaryGrp/mef:FamilySizeCnt" mode="Field">
                <xsl:with-param name="tpsId">TPFAMSZ</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AltCalcForMarriagePrimaryGrp/mef:MonthlyContributionAmt" mode="Field">
                <xsl:with-param name="tpsId">TPMTHCNT</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AltCalcForMarriagePrimaryGrp/mef:StartMonthNumberCd" mode="Field">
                <xsl:with-param name="tpsId">TPSTRMTH</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AltCalcForMarriagePrimaryGrp/mef:EndMonthNumberCd" mode="Field">
                <xsl:with-param name="tpsId">TPENDMTH</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AltCalcForMarriageSpouseGrp/mef:FamilySizeCnt" mode="Field">
                <xsl:with-param name="tpsId">SPFAMSZ</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AltCalcForMarriageSpouseGrp/mef:MonthlyContributionAmt" mode="Field">
                <xsl:with-param name="tpsId">SPMTHCNT</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AltCalcForMarriageSpouseGrp/mef:StartMonthNumberCd" mode="Field">
                <xsl:with-param name="tpsId">SPSTRMTH</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AltCalcForMarriageSpouseGrp/mef:EndMonthNumberCd" mode="Field">
                <xsl:with-param name="tpsId">SPENDMTH</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AltCalcForMarriageInputsPrimaryCalcGrpPP/mef:FamilySizeCntPP" mode="Field">
                <xsl:with-param name="tpsId">ATFAMSZ</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AltCalcForMarriageInputsPrimaryCalcGrpPP/mef:StartMonthNumberCdPP" mode="Field">
                <xsl:with-param name="tpsId">ATSTRMTH</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AltCalcForMarriageInputsPrimaryCalcGrpPP/mef:EndMonthNumberCdPP" mode="Field">
                <xsl:with-param name="tpsId">ATENDMTH</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AltCalcForMarriageInputsSpouseCalcGrpPP/mef:FamilySizeCntPP" mode="Field">
                <xsl:with-param name="tpsId">ASFAMSZ</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AltCalcForMarriageInputsSpouseCalcGrpPP/mef:StartMonthNumberCdPP" mode="Field">
                <xsl:with-param name="tpsId">ASSTRMTH</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:AltCalcForMarriageInputsSpouseCalcGrpPP/mef:EndMonthNumberCdPP" mode="Field">
                <xsl:with-param name="tpsId">ASENDMTH</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:PartOfReturnPP" mode="Boolean01">
                <xsl:with-param name="tpsId">__POR__</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:SelfEmployedHealthInsDedAmtPP" mode="Field">
                <xsl:with-param name="tpsId">SEIDTOTA</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:SelfEmployedExchangeHealthInsDedAmtPP" mode="Field">
                <xsl:with-param name="tpsId">SEIDEXCH</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:ACAPTCRefundMonitorControlPP" mode="YesNoField">
                <xsl:with-param name="yTpsId">HCPTCY</xsl:with-param>
                <xsl:with-param name="nTpsId">HCPTCN</xsl:with-param>
            </xsl:apply-templates>
            
            <!-- New 12/15/2014 -->
            <xsl:apply-templates select="mef:ExchangeHealthInsItemizedDedAmtPP" mode="Field">
                <xsl:with-param name="tpsId">SEIDOVER</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:StateSelfEmployedExchangeHealthInsDedAmtPP" mode="Field">
                <xsl:with-param name="tpsId">SEIDSTEX</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:StateExchangeHealthInsItemizedDedAmtPP" mode="Field">
                <xsl:with-param name="tpsId">SEIDSTOV</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthOfMarriagePP" mode="Field">
                <xsl:with-param name="tpsId">MARDATE</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:SpousalAbuseIndPP" mode="YesNoField">
                <xsl:with-param name="yTpsId">SPABUSEY</xsl:with-param>
                <xsl:with-param name="nTpsId">SPABUSEN</xsl:with-param>
            </xsl:apply-templates>
             
             
            <xsl:if test="count(mef:MonthlyPTCCalculationGrp)>0">
                <table id="MNTHGRP">
                    <xsl:apply-templates select="mef:MonthlyPTCCalculationGrp[mef:MonthCd='JANUARY']" mode="MonthlyPTCCalculationGrp"/>
                    <xsl:apply-templates select="mef:MonthlyPTCCalculationGrp[mef:MonthCd='FEBRUARY']" mode="MonthlyPTCCalculationGrp"/>
                    <xsl:apply-templates select="mef:MonthlyPTCCalculationGrp[mef:MonthCd='MARCH']" mode="MonthlyPTCCalculationGrp"/>
                    <xsl:apply-templates select="mef:MonthlyPTCCalculationGrp[mef:MonthCd='APRIL']" mode="MonthlyPTCCalculationGrp"/>
                    <xsl:apply-templates select="mef:MonthlyPTCCalculationGrp[mef:MonthCd='MAY']" mode="MonthlyPTCCalculationGrp"/>
                    <xsl:apply-templates select="mef:MonthlyPTCCalculationGrp[mef:MonthCd='JUNE']" mode="MonthlyPTCCalculationGrp"/>
                    <xsl:apply-templates select="mef:MonthlyPTCCalculationGrp[mef:MonthCd='JULY']" mode="MonthlyPTCCalculationGrp"/>
                    <xsl:apply-templates select="mef:MonthlyPTCCalculationGrp[mef:MonthCd='AUGUST']" mode="MonthlyPTCCalculationGrp"/>
                    <xsl:apply-templates select="mef:MonthlyPTCCalculationGrp[mef:MonthCd='SEPTEMBER']" mode="MonthlyPTCCalculationGrp"/>
                    <xsl:apply-templates select="mef:MonthlyPTCCalculationGrp[mef:MonthCd='OCTOBER']" mode="MonthlyPTCCalculationGrp"/>
                    <xsl:apply-templates select="mef:MonthlyPTCCalculationGrp[mef:MonthCd='NOVEMBER']" mode="MonthlyPTCCalculationGrp"/>
                    <xsl:apply-templates select="mef:MonthlyPTCCalculationGrp[mef:MonthCd='DECEMBER']" mode="MonthlyPTCCalculationGrp"/>
                </table>
            </xsl:if>
            <xsl:if test="count(mef:SharedPolicyAllocationGrp)>0">
                <table id="SHDPOLAL">
                    <xsl:apply-templates select="mef:SharedPolicyAllocationGrp" mode="SharedPolicyAllocationGrp"/>
                </table>
            </xsl:if>
            <xsl:apply-templates select="mef:AltCalcForMarriageEligibilityWksPP" mode="AltCalcForMarriageEligibilityWksPP"/>
            <xsl:apply-templates select="mef:SelfEmploymentCalculationDataPP" mode="SelfEmploymentCalculationDataPP"/>
        </form>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS8962/mef:MonthlyPTCCalculationGrp" mode="MonthlyPTCCalculationGrp">
            <row>
                <xsl:copy-of select="@uuid"/>
                <xsl:apply-templates select="mef:MonthCd" mode="Field">
                    <xsl:with-param name="tpsId">MONTHCD</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthlyPremiumAmt" mode="Field">
                    <xsl:with-param name="tpsId">MTHPREM</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthlyPremiumSLCSPAmt" mode="Field">
                    <xsl:with-param name="tpsId">MTHSLCSP</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthlyContributionAmt" mode="Field">
                    <xsl:with-param name="tpsId">MTHCONT</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthlyMaxPremiumAssistanceAmt" mode="Field">
                    <xsl:with-param name="tpsId">MTHMXAST</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthlyPremiumTaxCreditAllwAmt" mode="Field">
                    <xsl:with-param name="tpsId">MTHTXCR</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthlyAdvancedPTCAmt" mode="Field">
                    <xsl:with-param name="tpsId">MTHADVCR</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
            </row>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS8962/mef:SharedPolicyAllocationGrp" mode="SharedPolicyAllocationGrp">
            <row>
                <xsl:copy-of select="@uuid"/>
                <!--<xsl:apply-templates select="mef:GroupNumberCd" mode="Field">
                    <xsl:with-param name="tpsId">GRPNUM</xsl:with-param>
                </xsl:apply-templates>-->
                <xsl:apply-templates select="mef:PolicyNum" mode="Field">
                    <xsl:with-param name="tpsId">POLCYNUM</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:SSN" mode="Field">
                    <xsl:with-param name="tpsId">SHPOLSSN</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:StartMonthNumberCd" mode="Field">
                    <xsl:with-param name="tpsId">SHPOLSM</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:EndMonthNumberCd" mode="Field">
                    <xsl:with-param name="tpsId">SHPOLEM</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthlyPremiumPct" mode="Field">
                    <xsl:with-param name="tpsId">SPMPPCT</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthlyPremiumSLCSPPct" mode="Field">
                    <xsl:with-param name="tpsId">SPSLCSPP</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthlyAdvancedPTCPct" mode="Field">
                    <xsl:with-param name="tpsId">SPADVPTC</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
            </row>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS8962/mef:AltCalcForMarriageEligibilityWksPP" mode="AltCalcForMarriageEligibilityWksPP">
        <xsl:apply-templates select="mef:TotalPremiumTaxCreditAmtPP" mode="Field">
            <xsl:with-param name="tpsId">ATMTXCR</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:TotalAdvancedPTCAmtPP" mode="Field">
            <xsl:with-param name="tpsId">ATMADVCR</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:EligibilityIndPP" mode="YesNoField">
            <xsl:with-param name="yTpsId">YESINC</xsl:with-param>
            <xsl:with-param name="nTpsId">NOINC</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:AltCalcForMarriageEligibilityGrpPP" mode="AltCalcForMarriageEligibilityGrpPP"/>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS8962/mef:AltCalcForMarriageEligibilityWksPP/mef:AltCalcForMarriageEligibilityGrpPP" mode="AltCalcForMarriageEligibilityGrpPP">
        <table id="AMNTHGRP">
            <xsl:apply-templates select="mef:MonthlyAltCalcForMarriageEligibilityPP[translate(mef:MonthCdPP,'january','JANUARY')='JANUARY']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
            <xsl:apply-templates select="mef:MonthlyAltCalcForMarriageEligibilityPP[translate(mef:MonthCdPP,'february','FEBRUARY')='FEBRUARY']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
            <xsl:apply-templates select="mef:MonthlyAltCalcForMarriageEligibilityPP[translate(mef:MonthCdPP,'march','MARCH')='MARCH']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
            <xsl:apply-templates select="mef:MonthlyAltCalcForMarriageEligibilityPP[translate(mef:MonthCdPP,'april','APRIL')='APRIL']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
            <xsl:apply-templates select="mef:MonthlyAltCalcForMarriageEligibilityPP[translate(mef:MonthCdPP,'may','MAY')='MAY']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
            <xsl:apply-templates select="mef:MonthlyAltCalcForMarriageEligibilityPP[translate(mef:MonthCdPP,'june','JUNE')='JUNE']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
            <xsl:apply-templates select="mef:MonthlyAltCalcForMarriageEligibilityPP[translate(mef:MonthCdPP,'july','JULY')='JULY']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
            <xsl:apply-templates select="mef:MonthlyAltCalcForMarriageEligibilityPP[translate(mef:MonthCdPP,'august','AUGUST')='AUGUST']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
            <xsl:apply-templates select="mef:MonthlyAltCalcForMarriageEligibilityPP[translate(mef:MonthCdPP,'september','SEPTEMBER')='SEPTEMBER']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
            <xsl:apply-templates select="mef:MonthlyAltCalcForMarriageEligibilityPP[translate(mef:MonthCdPP,'october','OCTOBER')='OCTOBER']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
            <xsl:apply-templates select="mef:MonthlyAltCalcForMarriageEligibilityPP[translate(mef:MonthCdPP,'november','NOVEMBER')='NOVEMBER']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
            <xsl:apply-templates select="mef:MonthlyAltCalcForMarriageEligibilityPP[translate(mef:MonthCdPP,'december','DECEMBER')='DECEMBER']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
        </table>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS8962/mef:AltCalcForMarriageEligibilityWksPP/mef:AltCalcForMarriageEligibilityGrpPP/mef:MonthlyAltCalcForMarriageEligibilityPP" mode="MonthlyAltCalcForMarriageEligibilityPP">
        <row>
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="mef:MonthCdPP" mode="Field">
                <xsl:with-param name="tpsId">AMONTHCD</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyPremiumAmtPP" mode="Field">
                <xsl:with-param name="tpsId">AMTHPREM</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyPremiumSLCSPAmtPP" mode="Field">
                <xsl:with-param name="tpsId">AMTSLCSP</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyContributionAmtPP" mode="Field">
                <xsl:with-param name="tpsId">AMTHCONT</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyMaxPremiumAssistanceAmtPP" mode="Field">
                <xsl:with-param name="tpsId">AMTMXAST</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyPremiumTaxCreditAllwAmtPP" mode="Field">
                <xsl:with-param name="tpsId">AMTHTXCR</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyAdvancedPTCAmtPP" mode="Field">
                <xsl:with-param name="tpsId">AMTADVCR</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
        </row>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS8962/mef:SelfEmploymentCalculationDataPP" mode="SelfEmploymentCalculationDataPP">
        <xsl:apply-templates select="mef:NextIterationSetDeductionBlankPP" mode="Boolean01">
            <xsl:with-param name="tpsId">HBLANKNI</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:NextExchangeSelfEmploymentDeductionPP" mode="Field">
            <xsl:with-param name="tpsId">HSEDNEXT</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:NextIterationNumberPP" mode="Field">
            <xsl:with-param name="tpsId">HNUMNI</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:NextLastIterationDeductionPP" mode="Field">
            <xsl:with-param name="tpsId">HDEDNLI</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:NextLastIterationPTCPP" mode="Field">
            <xsl:with-param name="tpsId">HPTCNLI</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:NextAlternateDeductionPP" mode="Field">
            <xsl:with-param name="tpsId">HDEDNA</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>
    
    <!-- Mappings for IRS8965 Fields -->
    <xsl:template match="mef:ReturnData/mef:IRS8965">
        <form id="F8965">
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="mef:HsldIncmBelowFlngThresholdInd" mode="YesNoField">
                <xsl:with-param name="yTpsId">HIBELFTY</xsl:with-param>
                <xsl:with-param name="nTpsId">HIBELFTN</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:GrossIncmBelowFlngThresholdInd" mode="YesNoField">
                <xsl:with-param name="yTpsId">GIBELFTY</xsl:with-param>
                <xsl:with-param name="nTpsId">GIBELFTN</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:PartOfReturnPP" mode="Boolean01">
                <xsl:with-param name="tpsId">__POR__</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:HealthCareRspnsCoverageIndPP" mode="YesNoField">
                <xsl:with-param name="yTpsId">HCCVINDY</xsl:with-param>
                <xsl:with-param name="nTpsId">HCCVINDN</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:HaveAnyObtainedExemption" mode="YesNoField">
                <xsl:with-param name="yTpsId">HANYOBY</xsl:with-param>
                <xsl:with-param name="nTpsId">HANYOBN</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:HaveAnyMoreObtainedExemption" mode="YesNoField">
                <xsl:with-param name="yTpsId">HMOROBY</xsl:with-param>
                <xsl:with-param name="nTpsId">HMOROBN</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:HaveAnyRequestExemption" mode="YesNoField">
                <xsl:with-param name="yTpsId">HANYRQY</xsl:with-param>
                <xsl:with-param name="nTpsId">HANYRQN</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:HaveAnyMoreRequestExemption" mode="YesNoField">
                <xsl:with-param name="yTpsId">HMORRQY</xsl:with-param>
                <xsl:with-param name="nTpsId">HMORRQN</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:ACARefundMonitorControlPP" mode="YesNoField">
                <xsl:with-param name="yTpsId">HSHDRSPC</xsl:with-param>
                <xsl:with-param name="nTpsId">HSHDRSPN</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:TotalDependentsModifiedAGIAmtPP" mode="Field">
                <xsl:with-param name="tpsId">DEMODAGI</xsl:with-param>
            </xsl:apply-templates>
            <xsl:if test="count(mef:ObtndExemptCvrTaxHsldGrp)>0">
                <table id="OBTNEXEM">
                    <xsl:apply-templates select="mef:ObtndExemptCvrTaxHsldGrp" mode="ObtndExemptCvrTaxHsldGrp"/>
                </table>
            </xsl:if>
            <xsl:if test="count(mef:RequestExemptCvrTaxHsldGrp)>0">
                <table id="RECTHG">
                    <xsl:apply-templates select="mef:RequestExemptCvrTaxHsldGrp" mode="RequestExemptCvrTaxHsldGrp">
                        <xsl:sort select="mef:SortIdPP"/>
                    </xsl:apply-templates>
                </table>
            </xsl:if>
            <xsl:if test="count(mef:NonCalculatedExemptCvrTaxHsldGrpPP)>0">
                <table id="IRECTHG">
                    <xsl:apply-templates select="mef:NonCalculatedExemptCvrTaxHsldGrpPP" mode="NonCalculatedExemptCvrTaxHsldGrpPP">
                        <xsl:sort select="@uuid"/>
                    </xsl:apply-templates>
                </table>
            </xsl:if>
            <xsl:if test="count(mef:HealthCareCoverageAndExemptionsPP)>0">
                <table id="COVERAGE">
                    <xsl:apply-templates select="mef:HealthCareCoverageAndExemptionsPP[contains(mef:PersonIdPP,'PrimaryFullNamePP')]" mode="HealthCareCoverageAndExemptionsPP"/>
                    <xsl:apply-templates select="mef:HealthCareCoverageAndExemptionsPP[contains(mef:PersonIdPP,'SpouseFullNamePP')]" mode="HealthCareCoverageAndExemptionsPP"/>
                    <xsl:apply-templates select="mef:HealthCareCoverageAndExemptionsPP[contains(mef:PersonIdPP,'DependentFirstNm')]" mode="HealthCareCoverageAndExemptionsPP">
                        <xsl:sort select="mef:PersonIdPP"/>
                    </xsl:apply-templates>
                </table>
            </xsl:if>
            <xsl:apply-templates select="mef:SharedRespHshldCoverageWksPP" mode="SharedRespHshldCoverageWksPP"/>
            <xsl:apply-templates select="mef:FlatDollarAmountWksPP" mode="FlatDollarAmountWksPP"/>
        </form>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS8965/mef:ObtndExemptCvrTaxHsldGrp" mode="ObtndExemptCvrTaxHsldGrp">
            <row>
                <xsl:copy-of select="@uuid"/>
                <xsl:apply-templates select="mef:PersonNm" mode="Field">
                    <xsl:with-param name="tpsId">PERSNAME</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:SSN" mode="Field">
                    <xsl:with-param name="tpsId">SSN</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:ExemptionCertificateNum" mode="Field">
                    <xsl:with-param name="tpsId">EXEMCERT</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:StartMonthNumberCdPP" mode="Field">
                    <xsl:with-param name="tpsId">ESTRMTH</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:EndMonthNumberCdPP" mode="Field">
                    <xsl:with-param name="tpsId">EENDMTH</xsl:with-param>
                </xsl:apply-templates>
            </row>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS8965/mef:RequestExemptCvrTaxHsldGrp" mode="RequestExemptCvrTaxHsldGrp">
            <row>
                <xsl:copy-of select="@uuid"/>
                <xsl:apply-templates select="mef:PersonNm" mode="Field">
                    <xsl:with-param name="tpsId">RPERSNAM</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:SSN" mode="Field">
                    <xsl:with-param name="tpsId">REXEMSSN</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:ExemptionReasonCd" mode="Field">
                    <xsl:with-param name="tpsId">REXEMCD</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:AllYearInd" mode="Field">
                    <xsl:with-param name="tpsId">REQEXEAY</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrp/mef:JanuaryInd" mode="Field">
                    <xsl:with-param name="tpsId">REJAN</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrp/mef:FebruaryInd" mode="Field">
                    <xsl:with-param name="tpsId">REFEB</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrp/mef:MarchInd" mode="Field">
                    <xsl:with-param name="tpsId">REMAR</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrp/mef:AprilInd" mode="Field">
                    <xsl:with-param name="tpsId">REAPR</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrp/mef:MayInd" mode="Field">
                    <xsl:with-param name="tpsId">REMAY</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrp/mef:JuneInd" mode="Field">
                    <xsl:with-param name="tpsId">REJUN</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrp/mef:JulyInd" mode="Field">
                    <xsl:with-param name="tpsId">REJUL</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrp/mef:AugustInd" mode="Field">
                    <xsl:with-param name="tpsId">REAUG</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrp/mef:SeptemberInd" mode="Field">
                    <xsl:with-param name="tpsId">RESEP</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrp/mef:OctoberInd" mode="Field">
                    <xsl:with-param name="tpsId">REOCT</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrp/mef:NovemberInd" mode="Field">
                    <xsl:with-param name="tpsId">RENOV</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrp/mef:DecemberInd" mode="Field">
                    <xsl:with-param name="tpsId">REDEC</xsl:with-param>
                    <xsl:with-param name="src">computed</xsl:with-param>
                </xsl:apply-templates>
            </row>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS8965/mef:NonCalculatedExemptCvrTaxHsldGrpPP" mode="NonCalculatedExemptCvrTaxHsldGrpPP">
            <row>
                <xsl:copy-of select="@uuid"/>
                <xsl:apply-templates select="mef:PersonNmPP" mode="Field">
                    <xsl:with-param name="tpsId">IRPERNAM</xsl:with-param>
                    <xsl:with-param name="src">dropAssign</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:SSNPP" mode="Field">
                    <xsl:with-param name="tpsId">IREXMSSN</xsl:with-param>
                    <xsl:with-param name="src">dropAssign</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:ExemptionReasonCdPP" mode="Field">
                    <xsl:with-param name="tpsId">IREXEMCD</xsl:with-param>
                    <xsl:with-param name="src">dropAssign</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:AllYearIndPP" mode="Field">
                    <xsl:with-param name="tpsId">IREQEXAY</xsl:with-param>
                    <xsl:with-param name="src">dropAssign</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrpPP/mef:JanuaryIndPP" mode="Field">
                    <xsl:with-param name="tpsId">IREJAN</xsl:with-param>
                    <xsl:with-param name="src">dropAssign</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrpPP/mef:FebruaryIndPP" mode="Field">
                    <xsl:with-param name="tpsId">IREFEB</xsl:with-param>
                    <xsl:with-param name="src">dropAssign</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrpPP/mef:MarchIndPP" mode="Field">
                    <xsl:with-param name="tpsId">IREMAR</xsl:with-param>
                    <xsl:with-param name="src">dropAssign</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrpPP/mef:AprilIndPP" mode="Field">
                    <xsl:with-param name="tpsId">IREAPR</xsl:with-param>
                    <xsl:with-param name="src">dropAssign</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrpPP/mef:MayIndPP" mode="Field">
                    <xsl:with-param name="tpsId">IREMAY</xsl:with-param>
                    <xsl:with-param name="src">dropAssign</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrpPP/mef:JuneIndPP" mode="Field">
                    <xsl:with-param name="tpsId">IREJUN</xsl:with-param>
                    <xsl:with-param name="src">dropAssign</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrpPP/mef:JulyIndPP" mode="Field">
                    <xsl:with-param name="tpsId">IREJUL</xsl:with-param>
                    <xsl:with-param name="src">dropAssign</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrpPP/mef:AugustIndPP" mode="Field">
                    <xsl:with-param name="tpsId">IREAUG</xsl:with-param>
                    <xsl:with-param name="src">dropAssign</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrpPP/mef:SeptemberIndPP" mode="Field">
                    <xsl:with-param name="tpsId">IRESEP</xsl:with-param>
                    <xsl:with-param name="src">dropAssign</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrpPP/mef:OctoberIndPP" mode="Field">
                    <xsl:with-param name="tpsId">IREOCT</xsl:with-param>
                    <xsl:with-param name="src">dropAssign</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrpPP/mef:NovemberIndPP" mode="Field">
                    <xsl:with-param name="tpsId">IRENOV</xsl:with-param>
                    <xsl:with-param name="src">dropAssign</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:MonthIndicatorGrpPP/mef:DecemberIndPP" mode="Field">
                    <xsl:with-param name="tpsId">IREDEC</xsl:with-param>
                    <xsl:with-param name="src">dropAssign</xsl:with-param>
                </xsl:apply-templates>
            </row>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS8965/mef:HealthCareCoverageAndExemptionsPP" mode="HealthCareCoverageAndExemptionsPP">
        <row>
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="mef:PersonFirstNamePP" mode="Field">
                <xsl:with-param name="tpsId">COVDNAME</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:PersonSSNPP" mode="Field">
                <xsl:with-param name="tpsId">COVDSSN</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:PersonBirthDtPP" mode="Date">
                <xsl:with-param name="tpsId">CDOB</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyStatusGrpPP/mef:MonthPP[mef:MonthCdPP='JANUARY']/mef:StatusPP" mode="Field">
                <xsl:with-param name="tpsId">CJAN</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyStatusGrpPP/mef:MonthPP[mef:MonthCdPP='FEBRUARY']/mef:StatusPP" mode="Field">
                <xsl:with-param name="tpsId">CFEB</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyStatusGrpPP/mef:MonthPP[mef:MonthCdPP='MARCH']/mef:StatusPP" mode="Field">
                <xsl:with-param name="tpsId">CMAR</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyStatusGrpPP/mef:MonthPP[mef:MonthCdPP='APRIL']/mef:StatusPP" mode="Field">
                <xsl:with-param name="tpsId">CAPR</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyStatusGrpPP/mef:MonthPP[mef:MonthCdPP='MAY']/mef:StatusPP" mode="Field">
                <xsl:with-param name="tpsId">CMAY</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyStatusGrpPP/mef:MonthPP[mef:MonthCdPP='JUNE']/mef:StatusPP" mode="Field">
                <xsl:with-param name="tpsId">CJUN</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyStatusGrpPP/mef:MonthPP[mef:MonthCdPP='JULY']/mef:StatusPP" mode="Field">
                <xsl:with-param name="tpsId">CJUL</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyStatusGrpPP/mef:MonthPP[mef:MonthCdPP='AUGUST']/mef:StatusPP" mode="Field">
                <xsl:with-param name="tpsId">CAUG</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyStatusGrpPP/mef:MonthPP[mef:MonthCdPP='SEPTEMBER']/mef:StatusPP" mode="Field">
                <xsl:with-param name="tpsId">CSEP</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyStatusGrpPP/mef:MonthPP[mef:MonthCdPP='OCTOBER']/mef:StatusPP" mode="Field">
                <xsl:with-param name="tpsId">COCT</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyStatusGrpPP/mef:MonthPP[mef:MonthCdPP='NOVEMBER']/mef:StatusPP" mode="Field">
                <xsl:with-param name="tpsId">CNOV</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyStatusGrpPP/mef:MonthPP[mef:MonthCdPP='DECEMBER']/mef:StatusPP" mode="Field">
                <xsl:with-param name="tpsId">CDEC</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
        </row>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS8965/mef:SharedRespHshldCoverageWksPP" mode="SharedRespHshldCoverageWksPP">
        <xsl:apply-templates select="mef:TotalBronzePlanCountPP" mode="Field">
            <xsl:with-param name="tpsId">SUMOFXS</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:HshldIncmAmtPP" mode="Field">
            <xsl:with-param name="tpsId">HSHLDINC</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:FlngThresholdAmtPP" mode="Field">
            <xsl:with-param name="tpsId">FILETHRS</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:ExcessHshldIncmAmtPP" mode="Field">
            <xsl:with-param name="tpsId">EXCESINC</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:ExcessHshldIncmPenaltyAmtPP" mode="Field">
            <xsl:with-param name="tpsId">EXCINCPN</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:PenaltyOnlyHshldIncmIndPP" mode="YesNoField">
            <xsl:with-param name="yTpsId">YESINC</xsl:with-param>
            <xsl:with-param name="nTpsId">NOINC</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:IncmOrFlatDollarX12AmtPP" mode="Field">
            <xsl:with-param name="tpsId">INCORFLT</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:IncmOrFlatDollarAmtPP" mode="Field">
            <xsl:with-param name="tpsId">ANNUALIZ</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:BronzeCapAmtPP" mode="Field">
            <xsl:with-param name="tpsId">BRONZCAP</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:PenaltyAmountPP" mode="Field">
            <xsl:with-param name="tpsId">MECPNSUM</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:if test="mef:SharedRespHshldCoverageGrpPP">
            <table id="SRPWUNCV">
                <xsl:apply-templates select="mef:SharedRespHshldCoverageGrpPP/mef:SharedRespHshldCoveragePP" mode="SharedRespHshldCoveragePP">
                    <xsl:sort select="mef:PersonIdPP"/>
                </xsl:apply-templates>
            </table>
        </xsl:if>
        <xsl:apply-templates select="mef:BronzePlanCountPP" mode="BronzePlanCountPP"/>
        <xsl:apply-templates select="mef:AdultCountPP" mode="AdultCountPP"/>
        <xsl:apply-templates select="mef:HalfOfTotalMinorsCountPP" mode="HalfOfTotalMinorsCountPP"/>
        <xsl:apply-templates select="mef:FlatDollarPeopleCountPP" mode="FlatDollarPeopleCountPP"/>
        <xsl:apply-templates select="mef:FlatDollarAmtPP" mode="FlatDollarAmtPP"/>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS8965/mef:SharedRespHshldCoverageWksPP/mef:SharedRespHshldCoverageGrpPP/mef:SharedRespHshldCoveragePP" mode="SharedRespHshldCoveragePP">
        <row>
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="mef:PersonNamePP" mode="Field">
                <xsl:with-param name="tpsId">SRPWNAME</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyCoverageGrpPP[mef:MonthCdPP='JANUARY']/mef:NoCoverageIndPP" mode="Field">
                <xsl:with-param name="tpsId">SRPWJAN</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyCoverageGrpPP[mef:MonthCdPP='FEBRUARY']/mef:NoCoverageIndPP" mode="Field">
                <xsl:with-param name="tpsId">SRPWFEB</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyCoverageGrpPP[mef:MonthCdPP='MARCH']/mef:NoCoverageIndPP" mode="Field">
                <xsl:with-param name="tpsId">SRPWMAR</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyCoverageGrpPP[mef:MonthCdPP='APRIL']/mef:NoCoverageIndPP" mode="Field">
                <xsl:with-param name="tpsId">SRPWAPR</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyCoverageGrpPP[mef:MonthCdPP='MAY']/mef:NoCoverageIndPP" mode="Field">
                <xsl:with-param name="tpsId">SRPWMAY</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyCoverageGrpPP[mef:MonthCdPP='JUNE']/mef:NoCoverageIndPP" mode="Field">
                <xsl:with-param name="tpsId">SRPWJUN</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyCoverageGrpPP[mef:MonthCdPP='JULY']/mef:NoCoverageIndPP" mode="Field">
                <xsl:with-param name="tpsId">SRPWJUL</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyCoverageGrpPP[mef:MonthCdPP='AUGUST']/mef:NoCoverageIndPP" mode="Field">
                <xsl:with-param name="tpsId">SRPWAUG</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyCoverageGrpPP[mef:MonthCdPP='SEPTEMBER']/mef:NoCoverageIndPP" mode="Field">
                <xsl:with-param name="tpsId">SRPWSEP</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyCoverageGrpPP[mef:MonthCdPP='OCTOBER']/mef:NoCoverageIndPP" mode="Field">
                <xsl:with-param name="tpsId">SRPWOCT</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyCoverageGrpPP[mef:MonthCdPP='NOVEMBER']/mef:NoCoverageIndPP" mode="Field">
                <xsl:with-param name="tpsId">SRPWNOV</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:MonthlyCoverageGrpPP[mef:MonthCdPP='DECEMBER']/mef:NoCoverageIndPP" mode="Field">
                <xsl:with-param name="tpsId">SRPWDEC</xsl:with-param>
                <xsl:with-param name="src">computed</xsl:with-param>
            </xsl:apply-templates>
        </row>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS8965/mef:SharedRespHshldCoverageWksPP/mef:BronzePlanCountPP" mode="BronzePlanCountPP">
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='JANUARY']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW1JAN</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='FEBRUARY']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW1FEB</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='MARCH']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW1MAR</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='APRIL']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW1APR</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='MAY']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW1MAY</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='JUNE']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW1JUN</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='JULY']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW1JUL</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='AUGUST']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW1AUG</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='SEPTEMBER']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW1SEP</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='OCTOBER']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW1OCT</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='NOVEMBER']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW1NOV</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='DECEMBER']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW1DEC</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS8965/mef:SharedRespHshldCoverageWksPP/mef:AdultCountPP" mode="AdultCountPP">
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='JANUARY']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW2JAN</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='FEBRUARY']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW2FEB</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='MARCH']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW2MAR</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='APRIL']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW2APR</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='MAY']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW2MAY</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='JUNE']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW2JUN</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='JULY']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW2JUL</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='AUGUST']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW2AUG</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='SEPTEMBER']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW2SEP</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='OCTOBER']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW2OCT</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='NOVEMBER']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW2NOV</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='DECEMBER']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW2DEC</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS8965/mef:SharedRespHshldCoverageWksPP/mef:HalfOfTotalMinorsCountPP" mode="HalfOfTotalMinorsCountPP">
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='JANUARY']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW3JAN</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='FEBRUARY']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW3FEB</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='MARCH']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW3MAR</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='APRIL']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW3APR</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='MAY']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW3MAY</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='JUNE']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW3JUN</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='JULY']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW3JUL</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='AUGUST']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW3AUG</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='SEPTEMBER']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW3SEP</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='OCTOBER']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW3OCT</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='NOVEMBER']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW3NOV</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='DECEMBER']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW3DEC</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS8965/mef:SharedRespHshldCoverageWksPP/mef:FlatDollarPeopleCountPP" mode="FlatDollarPeopleCountPP">
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='JANUARY']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW4JAN</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='FEBRUARY']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW4FEB</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='MARCH']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW4MAR</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='APRIL']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW4APR</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='MAY']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW4MAY</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='JUNE']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW4JUN</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='JULY']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW4JUL</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='AUGUST']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW4AUG</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='SEPTEMBER']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW4SEP</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='OCTOBER']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW4OCT</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='NOVEMBER']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW4NOV</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='DECEMBER']/mef:CountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW4DEC</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS8965/mef:SharedRespHshldCoverageWksPP/mef:FlatDollarAmtPP" mode="FlatDollarAmtPP">
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='JANUARY']/mef:AmountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW5JAN</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='FEBRUARY']/mef:AmountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW5FEB</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='MARCH']/mef:AmountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW5MAR</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='APRIL']/mef:AmountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW5APR</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='MAY']/mef:AmountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW5MAY</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='JUNE']/mef:AmountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW5JUN</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='JULY']/mef:AmountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW5JUL</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='AUGUST']/mef:AmountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW5AUG</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='SEPTEMBER']/mef:AmountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW5SEP</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='OCTOBER']/mef:AmountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW5OCT</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='NOVEMBER']/mef:AmountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW5NOV</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:MonthPP[mef:MonthCdPP='DECEMBER']/mef:AmountPP" mode="Field">
            <xsl:with-param name="tpsId">SRPW5DEC</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS8965/mef:FlatDollarAmountWksPP" mode="FlatDollarAmountWksPP">
        <xsl:apply-templates select="mef:FlatDollarOrExcessHshldIncmGrpPP/mef:MonthlyFlatDollarOrExcessHshldIncmPP[mef:MonthCdPP='JANUARY']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <xsl:apply-templates select="mef:FlatDollarOrExcessHshldIncmGrpPP/mef:MonthlyFlatDollarOrExcessHshldIncmPP[mef:MonthCdPP='FEBRUARY']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <xsl:apply-templates select="mef:FlatDollarOrExcessHshldIncmGrpPP/mef:MonthlyFlatDollarOrExcessHshldIncmPP[mef:MonthCdPP='MARCH']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <xsl:apply-templates select="mef:FlatDollarOrExcessHshldIncmGrpPP/mef:MonthlyFlatDollarOrExcessHshldIncmPP[mef:MonthCdPP='APRIL']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <xsl:apply-templates select="mef:FlatDollarOrExcessHshldIncmGrpPP/mef:MonthlyFlatDollarOrExcessHshldIncmPP[mef:MonthCdPP='MAY']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <xsl:apply-templates select="mef:FlatDollarOrExcessHshldIncmGrpPP/mef:MonthlyFlatDollarOrExcessHshldIncmPP[mef:MonthCdPP='JUNE']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <xsl:apply-templates select="mef:FlatDollarOrExcessHshldIncmGrpPP/mef:MonthlyFlatDollarOrExcessHshldIncmPP[mef:MonthCdPP='JULY']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <xsl:apply-templates select="mef:FlatDollarOrExcessHshldIncmGrpPP/mef:MonthlyFlatDollarOrExcessHshldIncmPP[mef:MonthCdPP='AUGUST']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <xsl:apply-templates select="mef:FlatDollarOrExcessHshldIncmGrpPP/mef:MonthlyFlatDollarOrExcessHshldIncmPP[mef:MonthCdPP='SEPTEMBER']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <xsl:apply-templates select="mef:FlatDollarOrExcessHshldIncmGrpPP/mef:MonthlyFlatDollarOrExcessHshldIncmPP[mef:MonthCdPP='OCTOBER']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <xsl:apply-templates select="mef:FlatDollarOrExcessHshldIncmGrpPP/mef:MonthlyFlatDollarOrExcessHshldIncmPP[mef:MonthCdPP='NOVEMBER']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <xsl:apply-templates select="mef:FlatDollarOrExcessHshldIncmGrpPP/mef:MonthlyFlatDollarOrExcessHshldIncmPP[mef:MonthCdPP='DECEMBER']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <xsl:apply-templates select="mef:TotalFlatDollarAmtPP" mode="Field">
            <xsl:with-param name="tpsId">FTOTAL</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:TotalExcessHshldIncmAmtPP" mode="Field">
            <xsl:with-param name="tpsId">ITOTAL</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:TotalExcessHshldIncmAndFlatDollarAmtPP" mode="Field">
            <xsl:with-param name="tpsId">FDWKSHT</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS8965/mef:FlatDollarAmountWksPP/mef:FlatDollarOrExcessHshldIncmGrpPP/mef:MonthlyFlatDollarOrExcessHshldIncmPP" mode="MonthlyFlatDollarOrExcessHshldIncmPP">
        <xsl:apply-templates select="current()[mef:MonthCdPP='JANUARY']/mef:FlatDollarAmtPP" mode="Field">
            <xsl:with-param name="tpsId">FJAN</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='JANUARY']/mef:ExcessHshldIncmAmtPP" mode="Field">
            <xsl:with-param name="tpsId">IJAN</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='FEBRUARY']/mef:FlatDollarAmtPP" mode="Field">
            <xsl:with-param name="tpsId">FFEB</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='FEBRUARY']/mef:ExcessHshldIncmAmtPP" mode="Field">
            <xsl:with-param name="tpsId">IFEB</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='MARCH']/mef:FlatDollarAmtPP" mode="Field">
            <xsl:with-param name="tpsId">FMAR</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='MARCH']/mef:ExcessHshldIncmAmtPP" mode="Field">
            <xsl:with-param name="tpsId">IMAR</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='APRIL']/mef:FlatDollarAmtPP" mode="Field">
            <xsl:with-param name="tpsId">FAPR</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='APRIL']/mef:ExcessHshldIncmAmtPP" mode="Field">
            <xsl:with-param name="tpsId">IAPR</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='MAY']/mef:FlatDollarAmtPP" mode="Field">
            <xsl:with-param name="tpsId">FMAY</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='MAY']/mef:ExcessHshldIncmAmtPP" mode="Field">
            <xsl:with-param name="tpsId">IMAY</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='JUNE']/mef:FlatDollarAmtPP" mode="Field">
            <xsl:with-param name="tpsId">FJUN</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='JUNE']/mef:ExcessHshldIncmAmtPP" mode="Field">
            <xsl:with-param name="tpsId">IJUN</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='JULY']/mef:FlatDollarAmtPP" mode="Field">
            <xsl:with-param name="tpsId">FJUL</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='JULY']/mef:ExcessHshldIncmAmtPP" mode="Field">
            <xsl:with-param name="tpsId">IJUL</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='AUGUST']/mef:FlatDollarAmtPP" mode="Field">
            <xsl:with-param name="tpsId">FAUG</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='AUGUST']/mef:ExcessHshldIncmAmtPP" mode="Field">
            <xsl:with-param name="tpsId">IAUG</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='SEPTEMBER']/mef:FlatDollarAmtPP" mode="Field">
            <xsl:with-param name="tpsId">FSEP</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='SEPTEMBER']/mef:ExcessHshldIncmAmtPP" mode="Field">
            <xsl:with-param name="tpsId">ISEP</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='OCTOBER']/mef:FlatDollarAmtPP" mode="Field">
            <xsl:with-param name="tpsId">FOCT</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='OCTOBER']/mef:ExcessHshldIncmAmtPP" mode="Field">
            <xsl:with-param name="tpsId">IOCT</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='NOVEMBER']/mef:FlatDollarAmtPP" mode="Field">
            <xsl:with-param name="tpsId">FNOV</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='NOVEMBER']/mef:ExcessHshldIncmAmtPP" mode="Field">
            <xsl:with-param name="tpsId">INOV</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='DECEMBER']/mef:FlatDollarAmtPP" mode="Field">
            <xsl:with-param name="tpsId">FDEC</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()[mef:MonthCdPP='DECEMBER']/mef:ExcessHshldIncmAmtPP" mode="Field">
            <xsl:with-param name="tpsId">IDEC</xsl:with-param>
            <xsl:with-param name="src">computed</xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>
    
    <!-- Mappings for IRS1040ScheduleC Fields -->
    <xsl:template match="mef:ReturnData/mef:IRS1040ScheduleC">
        <form id="FSCHC">
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates/>
        </form>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS1040ScheduleC/mef:SelfEmpHealthInsDedPP">
        <form id="FW26C" type="Associated">
            <xsl:apply-templates select="mef:HealthAndLongTermCareInsPremAmtPP" mode="Field">
                <xsl:with-param name="tpsId">LA</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:NetProfitFromBusinessAmtPP" mode="Field">
                <xsl:with-param name="tpsId">L9</xsl:with-param>
            </xsl:apply-templates>
        </form>
    </xsl:template>
    
    <!-- Mappings for IRS1040ScheduleF Fields -->
    <xsl:template match="mef:ReturnData/mef:IRS1040ScheduleF">
        <form id="FSCHF">
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates/>
        </form>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS1040ScheduleF/mef:SelfEmpHealthInsDedPP">
        <form id="FW26F" type="Associated">
            <xsl:apply-templates select="mef:HealthAndLongTermCareInsPremAmtPP" mode="Field">
                <xsl:with-param name="tpsId">LA</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:NetProfitFromBusinessAmtPP" mode="Field">
                <xsl:with-param name="tpsId">L9</xsl:with-param>
            </xsl:apply-templates>
        </form>
    </xsl:template>
    
    <!-- Mappings for IRS1065ScheduleK1 Fields -->
    <xsl:template match="mef:ReturnData/mef:IRS1065ScheduleK1">
        <form id="FK1PW">
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates/>
        </form>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS1065ScheduleK1/mef:SelfEmpHealthInsDedPP">
        <form id="FW26P" type="Associated">
            <xsl:apply-templates select="mef:HealthAndLongTermCareInsPremAmtPP" mode="Field">
                <xsl:with-param name="tpsId">LA</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:NetProfitFromBusinessAmtPP" mode="Field">
                <xsl:with-param name="tpsId">L9</xsl:with-param>
            </xsl:apply-templates>
        </form>
    </xsl:template>
    
    <!-- Mappings for IRS1120SScheduleK1 Fields -->
    <xsl:template match="mef:ReturnData/mef:IRS1120SScheduleK1">
        <form id="FK1SW">
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates/>
        </form>
    </xsl:template>
    <xsl:template match="mef:ReturnData/mef:IRS1120SScheduleK1/mef:SelfEmpHealthInsDedPP">
        <form id="FW26S" type="Associated">
            <xsl:apply-templates select="mef:HealthAndLongTermCareInsPremAmtPP" mode="Field">
                <xsl:with-param name="tpsId">LA</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:NetProfitFromBusinessAmtPP" mode="Field">
                <xsl:with-param name="tpsId">S4</xsl:with-param>
            </xsl:apply-templates>
        </form>
    </xsl:template>

    <!-- Mappings for IRS2119 -->
    <xsl:template match="mef:ReturnData/mef:IRS2119">
        <form id="F2119">
            <xsl:copy-of select="@uuid"/>
            <xsl:apply-templates select="mef:GrossGainOrLossOnSaleAmtPP" mode="Field">
                <xsl:with-param name="tpsId">L5</xsl:with-param>
            </xsl:apply-templates>
        </form>
    </xsl:template>
    
    <!-- Mapping for ScheduleSEAdjustments -->
    
    <xsl:template match="mef:ReturnData/mef:ScheduleSEAdjustments">
        <form id="FSEADJ">
            <xsl:if test="mef:TaxpayerSEReportedIncomePP | mef:SpouseSEReportedIncomePP">
                <table id="A170">
                    <xsl:if test="mef:TaxpayerSEReportedIncomePP">
                        <row copy="1">
                            <xsl:apply-templates select="mef:TaxpayerSEReportedIncomePP" mode="Field">
                                <xsl:with-param name="tpsId">OTHWAGES</xsl:with-param>
                            </xsl:apply-templates>
                        </row>
                    </xsl:if>
                    <xsl:if test="mef:SpouseSEReportedIncomePP">
                        <row copy="2">
                            <xsl:apply-templates select="mef:SpouseSEReportedIncomePP" mode="Field">
                                <xsl:with-param name="tpsId">OTHWAGES</xsl:with-param>
                            </xsl:apply-templates>
                        </row>
                    </xsl:if>
                </table>
            </xsl:if>
        </form>
    </xsl:template>
    
    <!-- Mappings for ISRSW2G -->
    <xsl:template match="mef:ReturnData/mef:IRSW2G">
        <form id="FW2G">
            <xsl:copy-of select="@uuid"/>
            <xsl:if test="mef:PayerForeignAddressIndPP[text()='true']">
                <xsl:apply-templates select="mef:PayerForeignAddressIndPP" mode="EnumField">
                    <xsl:with-param name="tpsId">FRNX</xsl:with-param>
                    <xsl:with-param name="fieldValue">X</xsl:with-param>
                </xsl:apply-templates>
            </xsl:if>
            <xsl:if test="mef:WinnerForeignAddressIndPP[text()='true']">
                <xsl:apply-templates select="mef:WinnerForeignAddressIndPP" mode="EnumField">
                    <xsl:with-param name="tpsId">EFRNX</xsl:with-param>
                    <xsl:with-param name="fieldValue">X</xsl:with-param>
                </xsl:apply-templates>
            </xsl:if>
            <xsl:if test="mef:SpouseW2GIndPP[text()='true']">
                <xsl:apply-templates select="mef:SpouseW2GIndPP" mode="EnumField">
                    <xsl:with-param name="tpsId">SPBX</xsl:with-param>
                    <xsl:with-param name="fieldValue">X</xsl:with-param>
                </xsl:apply-templates>
            </xsl:if>
            <xsl:if test="mef:WinnerCopyInfoIndPPR2[text()='true']">
                <xsl:apply-templates select="mef:WinnerCopyInfoIndPPR2" mode="EnumField">
                    <xsl:with-param name="tpsId">OVRX</xsl:with-param>
                    <xsl:with-param name="fieldValue">X</xsl:with-param>
                </xsl:apply-templates>
            </xsl:if>
            <xsl:apply-templates select="mef:CorrectedW2GInd" mode="Field">
                <xsl:with-param name="tpsId">CORRX</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:PayerName/mef:BusinessNameLine1Txt" mode="Field">
                <xsl:with-param name="tpsId">PNAM</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:PayerName/mef:BusinessNameLine2Txt" mode="Field">
                <xsl:with-param name="tpsId">PNAM2</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:PayerSSN" mode="Field">
                <xsl:with-param name="tpsId">SSN</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:PayerEIN" mode="Field">
                <xsl:with-param name="tpsId">PFIN</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:PayerTelephoneNum" mode="Field">
                <xsl:with-param name="tpsId">PHONE</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:GamblingWinGrossWinningAmt" mode="Field">
                <xsl:with-param name="tpsId">L1</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:FederalIncomeTaxWithheldAmt" mode="Field">
                <xsl:with-param name="tpsId">L2</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:GamblingWinWagerTypeCd" mode="Field">
                <xsl:with-param name="tpsId">L3</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:GamblingWinningDt" mode="Date">
                <xsl:with-param name="tpsId">L4</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:GamblingWinningTransactionDesc" mode="Field">
                <xsl:with-param name="tpsId">L5</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:GamblingWinningEventDesc" mode="Field">
                <xsl:with-param name="tpsId">L6</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:GamblingWinFromIdntclWagersAmt" mode="Field">
                <xsl:with-param name="tpsId">L7</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:GamblingWinCashierId" mode="Field">
                <xsl:with-param name="tpsId">L8</xsl:with-param>
            </xsl:apply-templates>
            <xsl:choose>
                <xsl:when test="mef:PayerForeignAddressIndPP[contains(translate(text(),'true','TRUE'),'TRUE')]">
                    <xsl:apply-templates select="mef:PayerForeignAddress/mef:AddressLine1Txt" mode="Field">
                        <xsl:with-param name="tpsId">PADD</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="mef:PayerForeignAddress/mef:CityNm" mode="Field">
                        <xsl:with-param name="tpsId">PCTY</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="mef:PayerForeignAddress/mef:ProvinceOrStateNm" mode="Field">
                        <xsl:with-param name="tpsId">PST</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="mef:PayerForeignAddress/mef:ForeignPostalCd" mode="Field">
                        <xsl:with-param name="tpsId">PZIP</xsl:with-param>
                    </xsl:apply-templates>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="mef:PayerUSAddress/mef:AddressLine1Txt" mode="Field">
                        <xsl:with-param name="tpsId">PADD</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="mef:PayerUSAddress/mef:CityNm" mode="Field">
                        <xsl:with-param name="tpsId">PCTY</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="mef:PayerUSAddress/mef:StateAbbreviationCd" mode="Field">
                        <xsl:with-param name="tpsId">PST</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="mef:PayerUSAddress/mef:ZIPCd" mode="Field">
                        <xsl:with-param name="tpsId">PZIP</xsl:with-param>
                    </xsl:apply-templates>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="mef:RecipientNm" mode="Field">
                <xsl:with-param name="tpsId">WNAM</xsl:with-param>
            </xsl:apply-templates>
            <xsl:choose>
                <xsl:when test="mef:WinnerForeignAddressIndPP[contains(translate(text(),'true','TRUE'),'TRUE')]">
                    <xsl:apply-templates select="mef:RecipientForeignAddress/mef:AddressLine1Txt" mode="Field">
                        <xsl:with-param name="tpsId">WADD</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="mef:RecipientForeignAddress/mef:CityNm" mode="Field">
                        <xsl:with-param name="tpsId">WCTY</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="mef:RecipientForeignAddress/mef:ProvinceOrStateNm" mode="Field">
                        <xsl:with-param name="tpsId">WST</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="mef:RecipientForeignAddress/mef:ForeignPostalCd" mode="Field">
                        <xsl:with-param name="tpsId">WZIP</xsl:with-param>
                    </xsl:apply-templates>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="mef:RecipientUSAddress/mef:AddressLine1Txt" mode="Field">
                        <xsl:with-param name="tpsId">WADD</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="mef:RecipientUSAddress/mef:CityNm" mode="Field">
                        <xsl:with-param name="tpsId">WCTY</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="mef:RecipientUSAddress/mef:StateAbbreviationCd" mode="Field">
                        <xsl:with-param name="tpsId">WST</xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="mef:RecipientUSAddress/mef:ZIPCd" mode="Field">
                        <xsl:with-param name="tpsId">WZIP</xsl:with-param>
                    </xsl:apply-templates>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="mef:RecipientSSN" mode="Field">
                <xsl:with-param name="tpsId">L9</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:GamblingWinWindowNum" mode="Field">
                <xsl:with-param name="tpsId">L10</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:RecipientFirstAdditionalIdNum" mode="Field">
                <xsl:with-param name="tpsId">L11</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:RecipientSecondAdditionalIdNum" mode="Field">
                <xsl:with-param name="tpsId">L12</xsl:with-param>
            </xsl:apply-templates>
            <!-- StateLocalTaxGrp -->
            <xsl:apply-templates select="mef:W2GStateLocalTaxGrp" mode="W2GStateLocalTaxGrp"/>
        </form>
    </xsl:template>      
    <xsl:template match="mef:W2GStateLocalTaxGrp" mode="W2GStateLocalTaxGrp">
        <xsl:apply-templates select="mef:StateAbbreviationCd" mode="Field">
            <xsl:with-param name="tpsId">L13A</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:PayerStateIdNum" mode="Field">
            <xsl:with-param name="tpsId">L13B</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:StateTaxWithheldAmt" mode="Field">
            <xsl:with-param name="tpsId">L14</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:GamblingWinningAmt" mode="Field">
            <xsl:with-param name="tpsId">L14B</xsl:with-param>
        </xsl:apply-templates>
        <!-- LocalTaxGrp -->
        <xsl:apply-templates select="mef:W2GLocalTaxGrp" mode="W2GLocalTaxGrp"/>
    </xsl:template>
    <xsl:template match="mef:W2GLocalTaxGrp" mode="W2GLocalTaxGrp">
        <xsl:apply-templates select="mef:LocalityNm" mode="Field">
            <xsl:with-param name="tpsId">L15</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:LocalIncomeTaxAmt" mode="Field">
            <xsl:with-param name="tpsId">L16</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="mef:GamblingWinningAmt" mode="Field">
            <xsl:with-param name="tpsId">L16B</xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>
    
    <!-- Mapping for IRSW2 -->
    <xsl:template match="mef:IRSW2">
      <form id="FW2">
         <xsl:copy-of select="@uuid" />
         <xsl:apply-templates select="mef:CorrectedW2Ind" mode="FormMLField">
            <xsl:with-param name="formmlId">CORRX</xsl:with-param>
            <xsl:with-param name="type">Boolean</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:EmployeeSSN" mode="FormMLField">
            <xsl:with-param name="formmlId">D</xsl:with-param>
            <xsl:with-param name="type">Text</xsl:with-param>
         </xsl:apply-templates>
         <!--<xsl:apply-templates select="mef:EmployeeSSN" mode="FormMLField">
            <xsl:with-param name="formmlId">recipSSN</xsl:with-param>
            <xsl:with-param name="type">Text</xsl:with-param>
         </xsl:apply-templates> -->
         <xsl:apply-templates select="mef:EmployerEIN" mode="FormMLField">
            <xsl:with-param name="formmlId">EIN</xsl:with-param>
            <xsl:with-param name="type">Text</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:EmployerName/mef:BusinessNameLine1Txt" mode="FormMLField">
            <xsl:with-param name="formmlId">CA</xsl:with-param>
            <xsl:with-param name="type">Text</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:EmployerName/mef:BusinessNameLine2Txt" mode="FormMLField">
            <xsl:with-param name="formmlId">CA2</xsl:with-param>
            <xsl:with-param name="type">Text</xsl:with-param>
         </xsl:apply-templates>
         <!--EmployerUSAddress/EmployerForeignAddress should go here -->
         <xsl:if test="mef:EmployerUSAddress">
            <xsl:apply-templates select="mef:EmployerUSAddress/mef:AddressLine1Txt" mode="FormMLField">
               <xsl:with-param name="formmlId">CB</xsl:with-param>
               <xsl:with-param name="type">Text</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployerUSAddress/mef:CityNm" mode="FormMLField">
               <xsl:with-param name="formmlId">CADDR</xsl:with-param>
               <xsl:with-param name="type">Text</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployerUSAddress/mef:StateAbbreviationCd" mode="FormMLField">
               <xsl:with-param name="formmlId">CST</xsl:with-param>
               <xsl:with-param name="type">Text</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployerUSAddress/mef:ZIPCd" mode="FormMLField">
               <xsl:with-param name="formmlId">CZIP</xsl:with-param>
               <xsl:with-param name="type">Text</xsl:with-param>
            </xsl:apply-templates>
         </xsl:if>
         <xsl:if test="mef:EmployerForeignAddress">
            <xsl:apply-templates select="mef:EmployerForeignAddress/mef:AddressLine1Txt" mode="FormMLField">
               <xsl:with-param name="formmlId">CB</xsl:with-param>
               <xsl:with-param name="type">Text</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployerForeignAddress/mef:CityNm" mode="FormMLField">
               <xsl:with-param name="formmlId">CADDR</xsl:with-param>
               <xsl:with-param name="type">Text</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployerForeignAddress/mef:ProvinceOrStateNm" mode="FormMLField">
               <xsl:with-param name="formmlId">CST</xsl:with-param>
               <xsl:with-param name="type">Text</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployerForeignAddress/mef:CountryCd" mode="FormMLField">
               <xsl:with-param name="formmlId">CCOUNTRY</xsl:with-param>
               <xsl:with-param name="type">Text</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployerForeignAddress/mef:ForeignPostalCd" mode="FormMLField">
               <xsl:with-param name="formmlId">CZIP</xsl:with-param>
               <xsl:with-param name="type">Text</xsl:with-param>
            </xsl:apply-templates>
         </xsl:if>
         <xsl:apply-templates select="mef:ControlNum" mode="FormMLField">
            <xsl:with-param name="formmlId">A</xsl:with-param>
            <xsl:with-param name="type">Text</xsl:with-param>
         </xsl:apply-templates>
         <!--Will try and use the CS fields for the parts of the employee name if they exist, else just put the full name as first name (not going to try and split)-->
         <xsl:choose>
            <xsl:when test="mef:EmployeeNmCS/mef:PersonFirstNm or mef:EmployeeNmCS/mef:PersonMiddleNm or mef:EmployeeNmCS/mef:PersonLastNm or mef:EmployeeNmCS/mef:PersonNmSuffix">
                <xsl:apply-templates select="mef:EmployeeNmCS/mef:PersonFirstNm" mode="FormMLField">
                    <xsl:with-param name="formmlId">EFIRST</xsl:with-param>
                    <xsl:with-param name="type">Text</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:EmployeeNmCS/mef:PersonMiddleNm" mode="FormMLField">
                    <xsl:with-param name="formmlId">EMI</xsl:with-param>
                    <xsl:with-param name="type">Text</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:EmployeeNmCS/mef:PersonLastNm" mode="FormMLField">
                    <xsl:with-param name="formmlId">ELAST</xsl:with-param>
                    <xsl:with-param name="type">Text</xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="mef:EmployeeNmCS/mef:PersonNmSuffix" mode="FormMLField">
                    <xsl:with-param name="formmlId">ESF</xsl:with-param>
                    <xsl:with-param name="type">Text</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="mef:EmployeeNm" mode="FormMLField">
                    <xsl:with-param name="formmlId">EFIRST</xsl:with-param>
                    <xsl:with-param name="type">Text</xsl:with-param>
                </xsl:apply-templates>
            </xsl:otherwise>
         </xsl:choose>
         <!--EmployeeUSAddress/EmployeeForeignAddress should go here -->
         <xsl:if test="mef:EmployeeUSAddress">
            <xsl:apply-templates select="mef:EmployeeUSAddress/mef:AddressLine1Txt" mode="FormMLField">
               <xsl:with-param name="formmlId">FA</xsl:with-param>
               <xsl:with-param name="type">Text</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployeeUSAddress/mef:CityNm" mode="FormMLField">
               <xsl:with-param name="formmlId">FADDR</xsl:with-param>
               <xsl:with-param name="type">Text</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployeeUSAddress/mef:StateAbbreviationCd" mode="FormMLField">
               <xsl:with-param name="formmlId">FST</xsl:with-param>
               <xsl:with-param name="type">Text</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployeeUSAddress/mef:ZIPCd" mode="FormMLField">
               <xsl:with-param name="formmlId">FZIP</xsl:with-param>
               <xsl:with-param name="type">Text</xsl:with-param>
            </xsl:apply-templates>
         </xsl:if>
         <xsl:if test="mef:EmployeeForeignAddress">
            <xsl:apply-templates select="mef:EmployeeForeignAddress/mef:AddressLine1Txt" mode="FormMLField">
               <xsl:with-param name="formmlId">FA</xsl:with-param>
               <xsl:with-param name="type">Text</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployeeForeignAddress/mef:CityNm" mode="FormMLField">
               <xsl:with-param name="formmlId">FADDR</xsl:with-param>
               <xsl:with-param name="type">Text</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployeeForeignAddress/mef:ProvinceOrStateNm" mode="FormMLField">
               <xsl:with-param name="formmlId">FST</xsl:with-param>
               <xsl:with-param name="type">Text</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployeeForeignAddress/mef:CountryCd" mode="FormMLField">
               <xsl:with-param name="formmlId">ECOUNTRY</xsl:with-param>
               <xsl:with-param name="type">Text</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select="mef:EmployeeForeignAddress/mef:ForeignPostalCd" mode="FormMLField">
               <xsl:with-param name="formmlId">FZIP</xsl:with-param>
               <xsl:with-param name="type">Text</xsl:with-param>
            </xsl:apply-templates>
         </xsl:if>
         <xsl:apply-templates select="mef:WagesAmt" mode="FormMLFieldCS">
            <xsl:with-param name="formmlId">WAGES</xsl:with-param>
            <xsl:with-param name="type">Cent</xsl:with-param>
            <xsl:with-param name="CSVal">
                <xsl:value-of select="mef:WagesAmtCS"/>
            </xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:WithholdingAmt" mode="FormMLFieldCS">
            <xsl:with-param name="formmlId">FEDTAX</xsl:with-param>
            <xsl:with-param name="type">Cent</xsl:with-param>
            <xsl:with-param name="CSVal">
                <xsl:value-of select="mef:WithholdingAmtCS"/>
            </xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:SocialSecurityWagesAmt" mode="FormMLFieldCS">
            <xsl:with-param name="formmlId">SSWAGES</xsl:with-param>
            <xsl:with-param name="type">Cent</xsl:with-param>
            <xsl:with-param name="CSVal">
                <xsl:value-of select="mef:SocialSecurityWagesAmtCS"/>
            </xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:SocialSecurityTaxAmt" mode="FormMLFieldCS">
            <xsl:with-param name="formmlId">SSTAX</xsl:with-param>
            <xsl:with-param name="type">Cent</xsl:with-param>
            <xsl:with-param name="CSVal">
                <xsl:value-of select="mef:SocialSecurityTaxAmtCS"/>
            </xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:MedicareTaxWithheldAmt" mode="FormMLFieldCS">
            <xsl:with-param name="formmlId">MEDTAX</xsl:with-param>
            <xsl:with-param name="type">Cent</xsl:with-param>
            <xsl:with-param name="CSVal">
                <xsl:value-of select="mef:MedicareTaxWithheldAmtCS"/>
            </xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:MedicareWagesAndTipsAmt" mode="FormMLFieldCS">
            <xsl:with-param name="formmlId">MEDWAGES</xsl:with-param>
            <xsl:with-param name="type">Cent</xsl:with-param>
            <xsl:with-param name="CSVal">
                <xsl:value-of select="mef:MedicareWagesAndTipsAmtCS"/>
            </xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:SocialSecurityTipsAmt" mode="FormMLFieldCS">
            <xsl:with-param name="formmlId">SSTIPS</xsl:with-param>
            <xsl:with-param name="type">Cent</xsl:with-param>
            <xsl:with-param name="CSVal">
                <xsl:value-of select="mef:SocialSecurityTipsAmtCS"/>
            </xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:AllocatedTipsAmt" mode="FormMLFieldCS">
            <xsl:with-param name="formmlId">ALLOCTIP</xsl:with-param>
            <xsl:with-param name="type">Cent</xsl:with-param>
            <xsl:with-param name="CSVal">
                <xsl:value-of select="mef:AllocatedTipsAmtCS"/>
            </xsl:with-param>
         </xsl:apply-templates>
          <xsl:apply-templates select="mef:UnreportedMoreThanTwentyDollarsTipsAmtPP" mode="Field">
              <xsl:with-param name="tpsId">MT20</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="mef:UnreportedLessThanTwentyDollarsTipsAmtPP" mode="Field">
              <xsl:with-param name="tpsId">LT20</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="mef:UnreportedNonCashTipsAmtPP" mode="Field">
              <xsl:with-param name="tpsId">NONCASH</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="mef:UnreportedActualAllocatedTipsAmtPP" mode="Field">
              <xsl:with-param name="tpsId">ACTALLOC</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="mef:UnreportedSharedTipsAmtPP" mode="Field">
              <xsl:with-param name="tpsId">SHARING</xsl:with-param>
          </xsl:apply-templates>
          <xsl:if test="mef:UnreportedTipsGovEmployeeIndPP[text()='true']">
              <xsl:apply-templates select="mef:UnreportedTipsGovEmployeeIndPP" mode="EnumField">
                  <xsl:with-param name="tpsId">GOVX</xsl:with-param>
                  <xsl:with-param name="fieldValue">X</xsl:with-param>
              </xsl:apply-templates>
          </xsl:if>     
         <xsl:apply-templates select="mef:DependentCareBenefitsAmt" mode="FormMLFieldCS">
            <xsl:with-param name="formmlId">DCB</xsl:with-param>
            <xsl:with-param name="type">Cent</xsl:with-param>
            <xsl:with-param name="CSVal">
                <xsl:value-of select="mef:DependentCareBenefitsAmtCS"/>
            </xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:NonqualifiedPlansAmt" mode="FormMLFieldCS">
            <xsl:with-param name="formmlId">NQAMOUNT</xsl:with-param>
            <xsl:with-param name="type">Cent</xsl:with-param>
            <xsl:with-param name="CSVal">
                <xsl:value-of select="mef:NonqualifiedPlansAmtCS"/>
            </xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:NonQualifiedPlansDistributionAmtPP" mode="Field">
              <xsl:with-param name="tpsId">NQPLANS</xsl:with-param>
          </xsl:apply-templates>
         <xsl:if test="mef:EmployersUseGrp">
            <xsl:element name="table">
               <xsl:attribute name="id">CODES</xsl:attribute>
               <xsl:for-each select="mef:EmployersUseGrp">
                  <xsl:element name="row">
                     <xsl:attribute name="copy">
                        <xsl:value-of select="position()" />
                     </xsl:attribute>
                     <xsl:apply-templates select="mef:EmployersUseCd" mode="FormMLField">
                        <xsl:with-param name="formmlId">CODESC</xsl:with-param>
                        <xsl:with-param name="type">Text</xsl:with-param>
                     </xsl:apply-templates>
                     <xsl:apply-templates select="mef:EmployersUseAmt" mode="FormMLFieldCS">
                        <xsl:with-param name="formmlId">CODESA</xsl:with-param>
                        <xsl:with-param name="type">Cent</xsl:with-param>
                        <xsl:with-param name="CSVal">
                            <xsl:value-of select="mef:EmployersUseAmtCS"/>
                        </xsl:with-param>
                     </xsl:apply-templates>
                  </xsl:element>
               </xsl:for-each>
            </xsl:element>
         </xsl:if>
         <!--Only a value of 'X' is true, everything else including not existing is seen as false-->
         <xsl:choose>
            <xsl:when test="mef:StatutoryEmployeeInd">
                <xsl:call-template name="CheckboxField">
                  <xsl:with-param name="input" select="mef:StatutoryEmployeeInd"/>
                  <xsl:with-param name="formmlId">STATX</xsl:with-param>
                  <xsl:with-param name="type">Boolean</xsl:with-param>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="CheckboxField">
                  <xsl:with-param name="input" select="mef:StatutoryEmployeeInd"/>
                  <xsl:with-param name="formmlId">STATX</xsl:with-param>
                  <xsl:with-param name="type">Boolean</xsl:with-param>
               </xsl:call-template>
            </xsl:otherwise>
         </xsl:choose>
         <!--Only a value of 'X' is true, everything else including not existing is seen as false-->
         <xsl:choose>
            <xsl:when test="mef:RetirementPlanInd">
                <xsl:call-template name="CheckboxField">
                  <xsl:with-param name="input" select="mef:RetirementPlanInd"/>
                  <xsl:with-param name="formmlId">PPX</xsl:with-param>
                  <xsl:with-param name="type">Boolean</xsl:with-param>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="CheckboxField">
                  <xsl:with-param name="input" select="mef:RetirementPlanInd"/>
                  <xsl:with-param name="formmlId">PPX</xsl:with-param>
                  <xsl:with-param name="type">Boolean</xsl:with-param>
               </xsl:call-template>
            </xsl:otherwise>
         </xsl:choose>
         <!--Only a value of 'X' is true, everything else including not existing is seen as false-->
         <xsl:choose>
            <xsl:when test="mef:ThirdPartySickPayInd">
                <xsl:call-template name="CheckboxField">
                  <xsl:with-param name="input" select="mef:ThirdPartySickPayInd"/>
                  <xsl:with-param name="formmlId">SICKPAYX</xsl:with-param>
                  <xsl:with-param name="type">Boolean</xsl:with-param>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="CheckboxField">
                  <xsl:with-param name="input" select="mef:ThirdPartySickPayInd"/>
                  <xsl:with-param name="formmlId">SICKPAYX</xsl:with-param>
                  <xsl:with-param name="type">Boolean</xsl:with-param>
               </xsl:call-template>
            </xsl:otherwise>
         </xsl:choose>
         <xsl:choose>
           <xsl:when test="mef:OtherDeductionsBenefitsGrpCS">
              <xsl:element name="table">
                 <xsl:attribute name="id">OTHR</xsl:attribute>
                 <xsl:for-each select="mef:OtherDeductionsBenefitsGrpCS">
                    <xsl:element name="row">
                       <xsl:attribute name="copy">
                          <xsl:value-of select="position()" />
                       </xsl:attribute>
                       <xsl:apply-templates select="mef:Desc" mode="FormMLField">
                          <xsl:with-param name="formmlId">OTHERD</xsl:with-param>
                          <xsl:with-param name="type">Text</xsl:with-param>
                       </xsl:apply-templates>
                       <xsl:apply-templates select="mef:Amt" mode="FormMLField">
                          <xsl:with-param name="formmlId">OTHERA</xsl:with-param>
                          <xsl:with-param name="type">Cent</xsl:with-param>
                       </xsl:apply-templates>
                    </xsl:element>
                 </xsl:for-each>
              </xsl:element>
           </xsl:when>
           <xsl:otherwise>
              <xsl:element name="table">
                 <xsl:attribute name="id">OTHR</xsl:attribute>
                 <xsl:for-each select="mef:OtherDeductionsBenefitsGrp">
                    <xsl:element name="row">
                       <xsl:attribute name="copy">
                          <xsl:value-of select="position()" />
                       </xsl:attribute>
                       <xsl:apply-templates select="mef:Desc" mode="FormMLField">
                          <xsl:with-param name="formmlId">OTHERD</xsl:with-param>
                          <xsl:with-param name="type">Text</xsl:with-param>
                       </xsl:apply-templates>
                       <xsl:apply-templates select="mef:Amt" mode="FormMLField">
                          <xsl:with-param name="formmlId">OTHERA</xsl:with-param>
                          <xsl:with-param name="type">Cent</xsl:with-param>
                       </xsl:apply-templates>
                    </xsl:element>
                 </xsl:for-each>
              </xsl:element>
           </xsl:otherwise>
         </xsl:choose>
         <!--W2StateLocalTaxGrp should go here -->
         <xsl:if test="mef:W2StateLocalTaxGrp/mef:W2StateTaxGrp/mef:StateAbbreviationCd or mef:W2StateLocalTaxGrp/mef:W2StateTaxGrp/mef:EmployerStateIdNum or mef:W2StateLocalTaxGrp/mef:W2StateTaxGrp/mef:StateWagesAmt or mef:W2StateLocalTaxGrp/mef:W2StateTaxGrp/mef:StateIncomeTaxAmt">
            <xsl:element name="table">
               <xsl:attribute name="id">STATE</xsl:attribute>
               <xsl:for-each select="mef:W2StateLocalTaxGrp/mef:W2StateTaxGrp">
                  <!--We don't check for StateAbbreviationCd because if that's the only FormMLField this was probably created just for the Local Section-->
                <xsl:if test="mef:EmployerStateIdNum or mef:StateWagesAmt or mef:StateIncomeTaxAmt or mef:StateAbbreviationCd">
                     <xsl:element name="row">
                        <xsl:attribute name="copy">
                           <xsl:value-of select="position()"/>
                        </xsl:attribute>
                        <xsl:apply-templates select="mef:StateAbbreviationCd" mode="FormMLField">
                           <xsl:with-param name="formmlId">STATEST</xsl:with-param>
                           <xsl:with-param name="type">Text</xsl:with-param>
                        </xsl:apply-templates>
                        <xsl:apply-templates select="mef:EmployerStateIdNum" mode="FormMLField">
                           <xsl:with-param name="formmlId">STATEID</xsl:with-param>
                           <xsl:with-param name="type">Text</xsl:with-param>
                        </xsl:apply-templates>
                        <xsl:apply-templates select="mef:StateWagesAmt" mode="FormMLFieldCS">
                           <xsl:with-param name="formmlId">STATEWAG</xsl:with-param>
                           <xsl:with-param name="type">Cent</xsl:with-param>
                           <xsl:with-param name="CSVal">
                              <xsl:value-of select="mef:StateWagesAmtCS"/>
                           </xsl:with-param>
                        </xsl:apply-templates>
                        <xsl:apply-templates select="mef:StateIncomeTaxAmt" mode="FormMLFieldCS">
                           <xsl:with-param name="formmlId">STATETAX</xsl:with-param>
                           <xsl:with-param name="type">Cent</xsl:with-param>
                           <xsl:with-param name="CSVal">
                              <xsl:value-of select="mef:StateIncomeTaxAmtCS"/>
                           </xsl:with-param>
                        </xsl:apply-templates>
                     </xsl:element>
                 </xsl:if>
               </xsl:for-each>
            </xsl:element>
         </xsl:if>
         <xsl:if test="mef:W2StateLocalTaxGrp/mef:W2StateTaxGrp/mef:W2LocalTaxGrp/mef:LocalWagesAndTipsAmt or mef:W2StateLocalTaxGrp/mef:W2StateTaxGrp/mef:W2LocalTaxGrp/mef:LocalIncomeTaxAmt or mef:W2StateLocalTaxGrp/mef:W2StateTaxGrp/mef:W2LocalTaxGrp/mef:LocalityNm"> 
            <xsl:element name="table">
                <xsl:attribute name="id">LOCAL</xsl:attribute>
                <xsl:for-each select="mef:W2StateLocalTaxGrp/mef:W2StateTaxGrp/mef:W2LocalTaxGrp">
                    <xsl:if test="mef:LocalWagesAndTipsAmt or mef:LocalIncomeTaxAmt or mef:LocalityNm">
                        <xsl:element name="row">
                            <xsl:attribute name="copy">
                                <xsl:value-of select="position()"/>
                            </xsl:attribute>
                            <xsl:apply-templates select="mef:LocalityNm" mode="FormMLField">
                           <xsl:with-param name="formmlId">LCLNAME</xsl:with-param>
                           <xsl:with-param name="type">Text</xsl:with-param>
                        </xsl:apply-templates>
                        <xsl:apply-templates select="mef:LocalWagesAndTipsAmt" mode="FormMLFieldCS">
                           <xsl:with-param name="formmlId">LCLWAGES</xsl:with-param>
                           <xsl:with-param name="type">Cent</xsl:with-param>
                           <xsl:with-param name="CSVal">
                              <xsl:value-of select="mef:LocalWagesAndTipsAmtCS"/>
                           </xsl:with-param>
                        </xsl:apply-templates>
                        <xsl:apply-templates select="mef:LocalIncomeTaxAmt" mode="FormMLFieldCS">
                           <xsl:with-param name="formmlId">LCLTAX</xsl:with-param>
                           <xsl:with-param name="type">Cent</xsl:with-param>
                           <xsl:with-param name="CSVal">
                              <xsl:value-of select="mef:LocalIncomeTaxAmtCS"/>
                           </xsl:with-param>
                        </xsl:apply-templates>
                        <xsl:apply-templates select="../mef:StateAbbreviationCd" mode="FormMLField">
                           <xsl:with-param name="formmlId">LCLSTATE</xsl:with-param>
                           <xsl:with-param name="type">Text</xsl:with-param>
                        </xsl:apply-templates>
                        </xsl:element>
                    </xsl:if>
                </xsl:for-each>
            </xsl:element>
         </xsl:if>
         <xsl:apply-templates select="mef:StandardOrNonStandardCd" mode="ResolveStandardField">
            <xsl:with-param name="formmlId">NSX</xsl:with-param>
            <xsl:with-param name="type">Text</xsl:with-param>
         </xsl:apply-templates>
                
          <!-- Clergy Sub flow mappings -->
          <xsl:apply-templates select="mef:ClergyDesignatedHousingAmtPP" mode="Field">
              <xsl:with-param name="tpsId">CHA</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="mef:ClergySmallestHousingAmtPP" mode="Field">
              <xsl:with-param name="tpsId">CUHA</xsl:with-param>
          </xsl:apply-templates>      
          <xsl:apply-templates select="mef:ClergySelfEmploymentTaxCdPP[child::text()='ClergySETaxonHousing']" mode="EnumField">
              <xsl:with-param name="tpsId">CLHAX</xsl:with-param>
              <xsl:with-param name="fieldValue">X</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="mef:ClergySelfEmploymentTaxCdPP[child::text()='ClergySETaxonW2']" mode="EnumField">
              <xsl:with-param name="tpsId">CLW2X</xsl:with-param>
              <xsl:with-param name="fieldValue">X</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="mef:ClergySelfEmploymentTaxCdPP[child::text()='ClergySETaxonHousingandW2']" mode="EnumField">
              <xsl:with-param name="tpsId">CLHAW2X</xsl:with-param>
              <xsl:with-param name="fieldValue">X</xsl:with-param>
          </xsl:apply-templates>        
          <xsl:apply-templates select="mef:ClergySelfEmploymentTaxCdPP[child::text()='ClergyExpemptfromSETax']" mode="EnumField">
              <xsl:with-param name="tpsId">CLEX</xsl:with-param>
              <xsl:with-param name="fieldValue">X</xsl:with-param>
          </xsl:apply-templates>   
          <xsl:apply-templates select="mef:ClergySelfEmploymentTaxCdPP[child::text()='NonClergySETaxonW2']" mode="EnumField">
              <xsl:with-param name="tpsId">NCLW2X</xsl:with-param>
              <xsl:with-param name="fieldValue">X</xsl:with-param>
          </xsl:apply-templates>   
          <xsl:apply-templates select="mef:ClergySelfEmploymentTaxCdPP[child::text()='NonClergyExpemptfromSETax']" mode="EnumField">
              <xsl:with-param name="tpsId">NCLEX</xsl:with-param>
              <xsl:with-param name="fieldValue">X</xsl:with-param>
          </xsl:apply-templates>  
          <xsl:apply-templates select="mef:ClergySelfEmploymentTaxCdPP[child::text()='NoSSAndMedicareTax']" mode="EnumField">
              <xsl:with-param name="tpsId">CLNONE</xsl:with-param>
              <xsl:with-param name="fieldValue">X</xsl:with-param>
          </xsl:apply-templates> 
          <xsl:apply-templates select="mef:W2ClergyFirstChoicePPR2" mode="Field">
              <xsl:with-param name="tpsId">HCLTYPE</xsl:with-param>
          </xsl:apply-templates>   
          <xsl:apply-templates select="mef:HaveClergyChurchRelSectIncomeIndPP" mode="Boolean01">
              <xsl:with-param name="tpsId">HCLINC</xsl:with-param>
          </xsl:apply-templates> 
          
          <!-- Other Uncommon Situations mappings -->
          <xsl:apply-templates select="mef:WorkedOutsideUSIndPP" mode="BoolToCheckBox">
              <xsl:with-param name="tpsId">FSX</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="mef:PaidFamilyLeaveIndPP" mode="BoolToCheckBox">
              <xsl:with-param name="tpsId">PFLX</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="mef:InmateIndPP" mode="BoolToCheckBox">
              <xsl:with-param name="tpsId">INMATEX</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="mef:SpouseCopyIndPP" mode="BoolToCheckBox">
              <xsl:with-param name="tpsId">SPBX</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="mef:ActiveDutyMilitaryIndPP" mode="BoolToCheckBox">
              <xsl:with-param name="tpsId">MILPAYX</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="mef:SubstituteFormIndPP" mode="Boolean01">
              <xsl:with-param name="tpsId">HNEED4852</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="mef:InternationalOrgIndPP" mode="Boolean01">
              <xsl:with-param name="tpsId">GOTW2SE</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="mef:UnreportedTipsIndPP" mode="Boolean01">
              <xsl:with-param name="tpsId">GOTTIPS</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="mef:TotalTipsPP" mode="Field">
              <xsl:with-param name="tpsId">HTOTTIP</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="mef:MilitaryEINIndPP" mode="Boolean01">
              <xsl:with-param name="tpsId">HMILEIN</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="mef:PensionPlanIndPP" mode="Boolean01">
              <xsl:with-param name="tpsId">HPENSION</xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="mef:ImportedEmployerIndPPR2" mode="Boolean01">
              <xsl:with-param name="tpsId">HEMPIMP</xsl:with-param>
          </xsl:apply-templates>
          
      </form>
   </xsl:template>

   <!-- Mappings for IRS1095Int Fields -->
   <xsl:template match="mef:IRS1099INTCS">
        <form id="F1099INT" refId="payer name" description="">
            <!-- Pass through the uuid if present -->
            <xsl:copy-of select="@uuid"/>
         <xsl:apply-templates select="mef:PayerNameCS/mef:BusinessNameLine1Txt" mode="ConcatFieldSpace">
            <xsl:with-param name="formmlId">PNA1</xsl:with-param>
            <xsl:with-param name="type">Text</xsl:with-param>
            <xsl:with-param name="name2" select="mef:PayerNameCS/mef:BusinessNameLine2Txt"/>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:RecipientSSNCS" mode="FieldWithType">
            <xsl:with-param name="formmlId">RECIPSSN</xsl:with-param>
            <xsl:with-param name="type">Text</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:RecipientNmCS" mode="FieldWithType">
            <xsl:with-param name="formmlId">HRECNAME</xsl:with-param>
            <xsl:with-param name="type">Text</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:AccountNumCS" mode="FieldWithType">
            <xsl:with-param name="formmlId">ACCTNUM</xsl:with-param>
            <xsl:with-param name="type">Text</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:PayerRoutingTransitNumCS" mode="FieldWithType">
            <xsl:with-param name="formmlId">PAYERRTN</xsl:with-param>
            <xsl:with-param name="type">Text</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:InterestIncomeAmtCS" mode="FieldWithType">
            <xsl:with-param name="formmlId">L1</xsl:with-param>
            <xsl:with-param name="type">Cent</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:EarlyWithdrawalPenaltyAmtCS" mode="FieldWithType">
            <xsl:with-param name="formmlId">L2</xsl:with-param>
            <xsl:with-param name="type">Cent</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:InterestOnBondsAndTreasuryAmtCS" mode="FieldWithType">
            <xsl:with-param name="formmlId">L3</xsl:with-param>
            <xsl:with-param name="type">Cent</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:FederalIncomeTaxWithheldAmtCS" mode="FieldWithType">
            <xsl:with-param name="formmlId">L4</xsl:with-param>
            <xsl:with-param name="type">Cent</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:InvestmentExpensesAmtCS" mode="FieldWithType">
            <xsl:with-param name="formmlId">L5</xsl:with-param>
            <xsl:with-param name="type">Cent</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:ForeignTaxPaidAmtCS" mode="FieldWithType">
            <xsl:with-param name="formmlId">TAX</xsl:with-param>
            <xsl:with-param name="type">Cent</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:CountryCdCS" mode="FieldWithType">
            <xsl:with-param name="formmlId">CTRY</xsl:with-param>
            <xsl:with-param name="type">Cent</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:TaxExemptInterestAmtCS" mode="FieldWithType">
            <xsl:with-param name="formmlId">EXINT</xsl:with-param>
            <xsl:with-param name="type">Cent</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:ActivityBondInterestAmtCS" mode="FieldWithType">
            <xsl:with-param name="formmlId">INTP</xsl:with-param>
            <xsl:with-param name="type">Cent</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:MarketDiscountAmtCS" mode="FieldWithType">
            <xsl:with-param name="formmlId">MDISC</xsl:with-param>
            <xsl:with-param name="type">Cent</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:BondPremiumAmtCS" mode="FieldWithType">
            <xsl:with-param name="formmlId">BPREM</xsl:with-param>
            <xsl:with-param name="type">Cent</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:TaxExemptCUSIPCS" mode="FieldWithType">
            <xsl:with-param name="formmlId">CUSIP</xsl:with-param>
            <xsl:with-param name="type">Text</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:F1099IntStateTaxGrpCS[1]" mode="StateField">
            <xsl:with-param name="taxAmt">STWH</xsl:with-param>
            <xsl:with-param name="taxAmtType">Cent</xsl:with-param>
            <xsl:with-param name="stateCode">ST2</xsl:with-param>
            <xsl:with-param name="stateCodeType">Text</xsl:with-param>
            <xsl:with-param name="stateId">STATEID</xsl:with-param>
            <xsl:with-param name="stateIdType">Text</xsl:with-param>
         </xsl:apply-templates>
         <xsl:apply-templates select="mef:F1099IntStateTaxGrpCS[2]" mode="StateField">
            <xsl:with-param name="taxAmt">STWH2</xsl:with-param>
            <xsl:with-param name="taxAmtType">Cent</xsl:with-param>
            <xsl:with-param name="stateCode">STAT2</xsl:with-param>
            <xsl:with-param name="stateCodeType">Text</xsl:with-param>
            <xsl:with-param name="stateId">STATEID2</xsl:with-param>
            <xsl:with-param name="stateIdType">Text</xsl:with-param>
         </xsl:apply-templates>
      </form>
   </xsl:template>

    <!-- Mappings for IRS2119 -->
    <xsl:template match="mef:ReturnData/mef:FederalCarryoverWksPP">
        <form id="FCO13">
            <xsl:if test=" mef:PriorYrOtherProperty50PercentContributionCarryOverAmtPP| mef:PriorYrOtherProperty30PercentContributionCarryOverAmtPP |  mef:PriorYrCapitalGain30PercentContributionCarryOverAmtPP | mef:PriorYrCapitalGain20PercentContributionCarryOverAmtPP">
            <table id="A193">
                <xsl:if test="mef:PriorYrOtherProperty50PercentContributionCarryOverAmtPP">
                    <row copy="1">
                        <xsl:apply-templates select="mef:PriorYrOtherProperty50PercentContributionCarryOverAmtPP" mode="Field">
                            <xsl:with-param name="tpsId">L32A</xsl:with-param>
                        </xsl:apply-templates>
                    </row>
                </xsl:if>
                <xsl:if test="mef:PriorYrOtherProperty30PercentContributionCarryOverAmtPP">
                    <row copy="2">
                        <xsl:apply-templates select="mef:PriorYrOtherProperty30PercentContributionCarryOverAmtPP" mode="Field">
                            <xsl:with-param name="tpsId">L32A</xsl:with-param>
                        </xsl:apply-templates>
                    </row>
                </xsl:if>
                <xsl:if test="mef:PriorYrCapitalGain30PercentContributionCarryOverAmtPP">
                    <row copy="3">
                        <xsl:apply-templates select="mef:PriorYrCapitalGain30PercentContributionCarryOverAmtPP" mode="Field">
                            <xsl:with-param name="tpsId">L32A</xsl:with-param>
                        </xsl:apply-templates>
                    </row>
                </xsl:if>
                <xsl:if test="mef:PriorYrCapitalGain20PercentContributionCarryOverAmtPP">
                    <row copy="4">
                        <xsl:apply-templates select="mef:PriorYrCapitalGain20PercentContributionCarryOverAmtPP" mode="Field">
                            <xsl:with-param name="tpsId">L32A</xsl:with-param>
                        </xsl:apply-templates>
                    </row>
                </xsl:if>
            </table>
            </xsl:if>
            
            <xsl:if test=" mef:TwoYrOtherProperty50PercentContributionCarryOverAmtPP| mef:TwoYrOtherProperty30PercentContributionCarryOverAmtPP |  mef:TwoYrCapitalGain30PercentContributionCarryOverAmtPP | mef:TwoYrCapitalGain20PercentContributionCarryOverAmtPP">
                <table id="A194">
                    <xsl:if test="mef:TwoYrOtherProperty50PercentContributionCarryOverAmtPP">
                        <row copy="1">
                            <xsl:apply-templates select="mef:TwoYrOtherProperty50PercentContributionCarryOverAmtPP" mode="Field">
                                <xsl:with-param name="tpsId">L32B</xsl:with-param>
                            </xsl:apply-templates>
                        </row>
                    </xsl:if>
                    <xsl:if test="mef:TwoYrOtherProperty30PercentContributionCarryOverAmtPP">
                        <row copy="2">
                            <xsl:apply-templates select="mef:TwoYrOtherProperty30PercentContributionCarryOverAmtPP" mode="Field">
                                <xsl:with-param name="tpsId">L32B</xsl:with-param>
                            </xsl:apply-templates>
                        </row>
                    </xsl:if>
                    <xsl:if test="mef:TwoYrCapitalGain30PercentContributionCarryOverAmtPP">
                        <row copy="3">
                            <xsl:apply-templates select="mef:TwoYrCapitalGain30PercentContributionCarryOverAmtPP" mode="Field">
                                <xsl:with-param name="tpsId">L32B</xsl:with-param>
                            </xsl:apply-templates>
                        </row>
                    </xsl:if>
                    <xsl:if test="mef:TwoYrCapitalGain20PercentContributionCarryOverAmtPP">
                        <row copy="4">
                            <xsl:apply-templates select="mef:TwoYrCapitalGain20PercentContributionCarryOverAmtPP" mode="Field">
                                <xsl:with-param name="tpsId">L32B</xsl:with-param>
                            </xsl:apply-templates>
                        </row>
                    </xsl:if>
                </table>
            </xsl:if>
            
            <xsl:if test=" mef:ThreeYrOtherProperty50PercentContributionCarryOverAmtPP| mef:ThreeYrOtherProperty30PercentContributionCarryOverAmtPP |  mef:ThreeYrCapitalGain30PercentContributionCarryOverAmtPP | mef:ThreeYrCapitalGain20PercentContributionCarryOverAmtPP">
                <table id="A200">
                    <xsl:if test="mef:ThreeYrOtherProperty50PercentContributionCarryOverAmtPP">
                        <row copy="1">
                            <xsl:apply-templates select="mef:ThreeYrOtherProperty50PercentContributionCarryOverAmtPP" mode="Field">
                                <xsl:with-param name="tpsId">L32C</xsl:with-param>
                            </xsl:apply-templates>
                        </row>
                    </xsl:if>
                    <xsl:if test="mef:ThreeYrOtherProperty30PercentContributionCarryOverAmtPP">
                        <row copy="2">
                            <xsl:apply-templates select="mef:ThreeYrOtherProperty30PercentContributionCarryOverAmtPP" mode="Field">
                                <xsl:with-param name="tpsId">L32C</xsl:with-param>
                            </xsl:apply-templates>
                        </row>
                    </xsl:if>
                    <xsl:if test="mef:ThreeYrCapitalGain30PercentContributionCarryOverAmtPP">
                        <row copy="3">
                            <xsl:apply-templates select="mef:ThreeYrCapitalGain30PercentContributionCarryOverAmtPP" mode="Field">
                                <xsl:with-param name="tpsId">L32C</xsl:with-param>
                            </xsl:apply-templates>
                        </row>
                    </xsl:if>
                    <xsl:if test="mef:ThreeYrCapitalGain20PercentContributionCarryOverAmtPP">
                        <row copy="4">
                            <xsl:apply-templates select="mef:ThreeYrCapitalGain20PercentContributionCarryOverAmtPP" mode="Field">
                                <xsl:with-param name="tpsId">L32C</xsl:with-param>
                            </xsl:apply-templates>
                        </row>
                    </xsl:if>
                </table>
            </xsl:if>
            
            <xsl:if test=" mef:FourYrOtherProperty50PercentContributionCarryOverAmtPP| mef:FourYrOtherProperty30PercentContributionCarryOverAmtPP |  mef:FourYrCapitalGain30PercentContributionCarryOverAmtPP | mef:FourYrCapitalGain20PercentContributionCarryOverAmtPP">
                <table id="A202">
                    <xsl:if test="mef:FourYrOtherProperty50PercentContributionCarryOverAmtPP">
                        <row copy="1">
                            <xsl:apply-templates select="mef:FourYrOtherProperty50PercentContributionCarryOverAmtPP" mode="Field">
                                <xsl:with-param name="tpsId">L32D</xsl:with-param>
                            </xsl:apply-templates>
                        </row>
                    </xsl:if>
                    <xsl:if test="mef:FourYrOtherProperty30PercentContributionCarryOverAmtPP">
                        <row copy="2">
                            <xsl:apply-templates select="mef:FourYrOtherProperty30PercentContributionCarryOverAmtPP" mode="Field">
                                <xsl:with-param name="tpsId">L32D</xsl:with-param>
                            </xsl:apply-templates>
                        </row>
                    </xsl:if>
                    <xsl:if test="mef:FourYrCapitalGain30PercentContributionCarryOverAmtPP">
                        <row copy="3">
                            <xsl:apply-templates select="mef:FourYrCapitalGain30PercentContributionCarryOverAmtPP" mode="Field">
                                <xsl:with-param name="tpsId">L32D</xsl:with-param>
                            </xsl:apply-templates>
                        </row>
                    </xsl:if>
                    <xsl:if test="mef:FourYrCapitalGain20PercentContributionCarryOverAmtPP">
                        <row copy="4">
                            <xsl:apply-templates select="mef:FourYrCapitalGain20PercentContributionCarryOverAmtPP" mode="Field">
                                <xsl:with-param name="tpsId">L32D</xsl:with-param>
                            </xsl:apply-templates>
                        </row>
                    </xsl:if>
                </table>
            </xsl:if>
            
            <xsl:if test=" mef:FiveYrOtherProperty50PercentContributionCarryOverAmtPP| mef:FiveYrOtherProperty30PercentContributionCarryOverAmtPP |  mef:FiveYrCapitalGain30PercentContributionCarryOverAmtPP | mef:FiveYrCapitalGain20PercentContributionCarryOverAmtPP">
                <table id="A201">
                    <xsl:if test="mef:FiveYrOtherProperty50PercentContributionCarryOverAmtPP">
                        <row copy="1">
                            <xsl:apply-templates select="mef:FiveYrOtherProperty50PercentContributionCarryOverAmtPP" mode="Field">
                                <xsl:with-param name="tpsId">L32E</xsl:with-param>
                            </xsl:apply-templates>
                        </row>
                    </xsl:if>
                    <xsl:if test="mef:FiveYrOtherProperty30PercentContributionCarryOverAmtPP">
                        <row copy="2">
                            <xsl:apply-templates select="mef:FiveYrOtherProperty30PercentContributionCarryOverAmtPP" mode="Field">
                                <xsl:with-param name="tpsId">L32E</xsl:with-param>
                            </xsl:apply-templates>
                        </row>
                    </xsl:if>
                    <xsl:if test="mef:FiveYrCapitalGain30PercentContributionCarryOverAmtPP">
                        <row copy="3">
                            <xsl:apply-templates select="mef:FiveYrCapitalGain30PercentContributionCarryOverAmtPP" mode="Field">
                                <xsl:with-param name="tpsId">L32E</xsl:with-param>
                            </xsl:apply-templates>
                        </row>
                    </xsl:if>
                    <xsl:if test="mef:FiveYrCapitalGain20PercentContributionCarryOverAmtPP">
                        <row copy="4">
                            <xsl:apply-templates select="mef:FiveYrCapitalGain20PercentContributionCarryOverAmtPP" mode="Field">
                                <xsl:with-param name="tpsId">L32E</xsl:with-param>
                            </xsl:apply-templates>
                        </row>
                    </xsl:if>
                </table>
            </xsl:if>
            
        </form>
    </xsl:template>



    <!-- ######################## Utility Templates ######################## -->
    
    <xsl:template match="node()" mode="MonthEnumField">
        <xsl:param name="tpsId"/>
        <xsl:param name="src"/>
        <xsl:choose>
            <xsl:when test="text()='JANUARY'">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="tpsId" select="$tpsId"/>
                    <xsl:with-param name="src" select="$src"/>
                    <xsl:with-param name="fieldValue">01</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="text()='FEBRUARY'">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="tpsId" select="$tpsId"/>
                    <xsl:with-param name="src" select="$src"/>
                    <xsl:with-param name="fieldValue">02</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="text()='MARCH'">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="tpsId" select="$tpsId"/>
                    <xsl:with-param name="src" select="$src"/>
                    <xsl:with-param name="fieldValue">03</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="text()='APRIL'">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="tpsId" select="$tpsId"/>
                    <xsl:with-param name="src" select="$src"/>
                    <xsl:with-param name="fieldValue">04</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="text()='MAY'">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="tpsId" select="$tpsId"/>
                    <xsl:with-param name="src" select="$src"/>
                    <xsl:with-param name="fieldValue">05</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="text()='JUNE'">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="tpsId" select="$tpsId"/>
                    <xsl:with-param name="src" select="$src"/>
                    <xsl:with-param name="fieldValue">06</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="text()='JULY'">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="tpsId" select="$tpsId"/>
                    <xsl:with-param name="src" select="$src"/>
                    <xsl:with-param name="fieldValue">07</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="text()='AUGUST'">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="tpsId" select="$tpsId"/>
                    <xsl:with-param name="src" select="$src"/>
                    <xsl:with-param name="fieldValue">08</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="text()='SEPTEMBER'">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="tpsId" select="$tpsId"/>
                    <xsl:with-param name="src" select="$src"/>
                    <xsl:with-param name="fieldValue">09</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="text()='OCTOBER'">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="tpsId" select="$tpsId"/>
                    <xsl:with-param name="src" select="$src"/>
                    <xsl:with-param name="fieldValue">10</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="text()='NOVEMBER'">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="tpsId" select="$tpsId"/>
                    <xsl:with-param name="src" select="$src"/>
                    <xsl:with-param name="fieldValue">11</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="text()='DECEMBER'">
                <xsl:apply-templates select="." mode="EnumField">
                    <xsl:with-param name="tpsId" select="$tpsId"/>
                    <xsl:with-param name="src" select="$src"/>
                    <xsl:with-param name="fieldValue">12</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="node()" mode="EnumField">
        <xsl:param name="tpsId"/>
        <xsl:param name="src"/>
        <xsl:param name="fieldValue"/>
        <xsl:element name="field">
            <xsl:if test="attribute::code">
                <xsl:attribute name="code">
                    <xsl:value-of select="@code"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="attribute::message">
                <xsl:attribute name="message">
                    <xsl:value-of select="@message"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="attribute::hasError">
                <xsl:attribute name="hasError">
                    <xsl:value-of select="@hasError"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="id">
                 <xsl:value-of select="$tpsId"/>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="$fieldValue">
                    <value>
                        <xsl:if test="$src">
                            <xsl:attribute name="source">
                                <xsl:value-of select="$src"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:value-of select="$fieldValue"/>
                    </value>
                </xsl:when>
                <xsl:otherwise>
                    <value>
                        <xsl:if test="$src">
                            <xsl:attribute name="source">
                                <xsl:value-of select="$src"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:text>true</xsl:text>
                    </value>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>

    <!-- Field Template -->
    <xsl:template match="node()" mode="Field">
        <xsl:param name="tpsId"/>
        <xsl:param name="src"/>
        <xsl:element name="field">
            <xsl:attribute name="id">
                <xsl:value-of select="$tpsId"/>
            </xsl:attribute>
            <xsl:if test="attribute::code">
                <xsl:attribute name="code">
                    <xsl:value-of select="@code"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="attribute::message">
                <xsl:attribute name="message">
                    <xsl:value-of select="@message"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="attribute::hasError">
                <xsl:attribute name="hasError">
                    <xsl:value-of select="@hasError"/>
                </xsl:attribute>
            </xsl:if>
            <value>
                <xsl:if test="$src">
                    <xsl:attribute name="source">
                        <xsl:value-of select="$src"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>
            </value>
        </xsl:element>
    </xsl:template>

    <!-- Mef typs is Boolean Tps type is Checkbox. Map 'X' if Mef=true; else if Mef=false map '' -->
    <xsl:template match="node()" mode="BoolToCheckBox">
        <xsl:param name="tpsId"/>
        <xsl:param name="src"/>
        <xsl:element name="field">
            <xsl:attribute name="id">
                <xsl:value-of select="$tpsId"/>
            </xsl:attribute>
            <xsl:if test="attribute::code">
                <xsl:attribute name="code">
                    <xsl:value-of select="@code"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="attribute::message">
                <xsl:attribute name="message">
                    <xsl:value-of select="@message"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="attribute::hasError">
                <xsl:attribute name="hasError">
                    <xsl:value-of select="@hasError"/>
                </xsl:attribute>
            </xsl:if>
            <value>
                <xsl:if test="$src">
                    <xsl:attribute name="source">
                        <xsl:value-of select="$src"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:choose>
                    <xsl:when test="contains(translate(text(),'true','TRUE'),'TRUE')">
                        <xsl:text>X</xsl:text>
                    </xsl:when>
                    <xsl:when test="contains(translate(text(),'false','FALSE'),'FALSE')">
                        <xsl:value-of select="''"/>
                    </xsl:when>
                </xsl:choose>
            </value>
        </xsl:element>
    </xsl:template>

    <!-- StateField Template -->
    <xsl:template match="node()" mode="StateField">
        <xsl:param name="taxAmt"/>
        <xsl:param name="taxAmtType"/>
        <xsl:param name="stateCode"/>
        <xsl:param name="stateCodeType"/>
        <xsl:param name="stateId"/>
        <xsl:param name="stateIdType"/>
        <xsl:apply-templates select="current()/mef:StateTaxWithheldAmtCS" mode="FieldWithType">
            <xsl:with-param name="formmlId"><xsl:value-of select="$taxAmt"/></xsl:with-param>
            <xsl:with-param name="type"><xsl:value-of select="$taxAmtType"/></xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()/mef:StateAbbreviationCdCS" mode="FieldWithType">
            <xsl:with-param name="formmlId"><xsl:value-of select="$stateCode"/></xsl:with-param>
            <xsl:with-param name="type"><xsl:value-of select="$stateCodeType"/></xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="current()/mef:PayersStateIdNumCS" mode="FieldWithType">
            <xsl:with-param name="formmlId"><xsl:value-of select="$stateId"/></xsl:with-param>
            <xsl:with-param name="type"><xsl:value-of select="$stateIdType"/></xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>

    <!-- FormMLField Template -->
    <xsl:template match="node()" mode="FormMLField">
        <xsl:param name="formmlId" />
        <xsl:param name="type" />
        <xsl:element name="field">
            <xsl:attribute name="xsi:type">
                <xsl:value-of select="$type" />
            </xsl:attribute>
            <xsl:attribute name="id">
                <xsl:value-of select="$formmlId" />
            </xsl:attribute>
            <value>
                <xsl:value-of select="current()" />
            </value>
        </xsl:element>
    </xsl:template>

    <!-- FormMLFieldCS Template tries to use the CS value if it is not empty-->
    <xsl:template match="node()" mode="FormMLFieldCS">
        <xsl:param name="formmlId" />
        <xsl:param name="type" />
        <xsl:param name="CSVal" />
        <xsl:element name="field">
            <xsl:attribute name="xsi:type">
                <xsl:value-of select="$type" />
            </xsl:attribute>
            <xsl:attribute name="id">
                <xsl:value-of select="$formmlId" />
            </xsl:attribute>
            <value>
                <xsl:choose>
                    <xsl:when test="not($CSVal = '')">
                        <xsl:value-of select="$CSVal"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="current()" />
                    </xsl:otherwise>
                </xsl:choose>
            </value>
        </xsl:element>
    </xsl:template>

    <!-- Field with "type" -->
   <xsl:template match="node()" mode="FieldWithType">
      <xsl:param name="formmlId" />
      <xsl:param name="type" />
      <xsl:element name="field">
         <xsl:attribute name="xsi:type">
            <xsl:value-of select="$type" />
         </xsl:attribute>
         <xsl:attribute name="id">
            <xsl:value-of select="$formmlId" />
         </xsl:attribute>
         <value>
            <xsl:attribute name="source">generalImport</xsl:attribute>
            <xsl:value-of select="current()" />
         </value>
      </xsl:element>
   </xsl:template>

    <!-- YesNoField Template -->
    <xsl:template match="node()" mode="YesNoField">
        <xsl:param name="yTpsId"/>
        <xsl:param name="nTpsId"/>
        <xsl:param name="src"/>
        <xsl:if test="contains(text(),'true') or contains(translate(text(),'x','X'),'X')">
            <xsl:element name="field">
                <xsl:attribute name="id">
                    <xsl:value-of select="$yTpsId"/>
                </xsl:attribute>
                <value>
                    <xsl:if test="$src">
                        <xsl:attribute name="source">
                            <xsl:value-of select="$src"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:text>X</xsl:text>
                </value>
            </xsl:element>
        </xsl:if>
        <xsl:if test="contains(text(),'false')">
            <xsl:element name="field">
                <xsl:attribute name="id">
                    <xsl:value-of select="$nTpsId"/>
                </xsl:attribute>
                <xsl:if test="attribute::code">
                    <xsl:attribute name="code">
                        <xsl:value-of select="@code"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="attribute::message">
                    <xsl:attribute name="message">
                        <xsl:value-of select="@message"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="attribute::hasError">
                    <xsl:attribute name="hasError">
                        <xsl:value-of select="@hasError"/>
                    </xsl:attribute>
                </xsl:if>
                <value>
                    <xsl:if test="$src">
                        <xsl:attribute name="source">
                            <xsl:value-of select="$src"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:text>X</xsl:text>
                </value>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <!-- Date Template -->
    <!-- Convert YYYY-MM-DD to YYYYMMDD -->
    <xsl:template match="node()" mode="Date">
        <xsl:param name="tpsId"/>
        <xsl:param name="src"/>
        <xsl:variable name="yyyy" select="substring(text(),1,4)"/>
        <xsl:variable name="mm" select="substring(text(),6,2)"/>
        <xsl:variable name="dd" select="substring(text(),9,2)"/>
        <xsl:element name="field">
            <xsl:attribute name="id">
                <xsl:value-of select="$tpsId"/>
            </xsl:attribute>
            <xsl:if test="attribute::code">
                <xsl:attribute name="code">
                    <xsl:value-of select="@code"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="attribute::message">
                <xsl:attribute name="message">
                    <xsl:value-of select="@message"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="attribute::hasError">
                <xsl:attribute name="hasError">
                    <xsl:value-of select="@hasError"/>
                </xsl:attribute>
            </xsl:if>
            <value>
                <xsl:if test="$src">
                    <xsl:attribute name="source">
                        <xsl:value-of select="$src"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="concat($yyyy,$mm,$dd)"/>
            </value>
        </xsl:element>
    </xsl:template>
    
    <!--The only valid value for true is X, all others are false based on the IRS spec for fields this is applied to-->
   <xsl:template name="CheckboxField">
      <xsl:param name="formmlId" />
      <xsl:param name="type" />
      <xsl:param name="input"/>
      <xsl:variable name="returnValue">
         <xsl:choose>
            <xsl:when test="$input = 'X'">true</xsl:when>
            <xsl:otherwise>false</xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:element name="field">
         <xsl:attribute name="xsi:type">
            <xsl:value-of select="$type" />
         </xsl:attribute>
         <xsl:attribute name="id">
            <xsl:value-of select="$formmlId" />
         </xsl:attribute>
         <value>
            <xsl:value-of select="$returnValue" />
         </value>
      </xsl:element>
   </xsl:template>

   <!--The only valid value for true is X, all others are false based on the IRS spec for fields this is applied to-->
   <xsl:template match="node()" mode="ResolveStandardField">
      <xsl:param name="formmlId" />
      <xsl:param name="type" />
      <xsl:variable name="returnValue">
         <xsl:choose>
            <xsl:when test="current() = 'N'">X</xsl:when>
            <xsl:otherwise></xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:element name="field">
         <xsl:attribute name="xsi:type">
            <xsl:value-of select="$type" />
         </xsl:attribute>
         <xsl:attribute name="id">
            <xsl:value-of select="$formmlId" />
         </xsl:attribute>
         <value>
            <xsl:value-of select="$returnValue" />
         </value>
      </xsl:element>
   </xsl:template>

   <!-- Concatenate 2nd field -->
   <xsl:template match="node()" mode="ConcatFieldSpace">
      <xsl:param name="formmlId" />
      <xsl:param name="type" />
      <xsl:param name="name2" />

      <xsl:element name="field">
         <xsl:attribute name="xsi:type">
            <xsl:value-of select="$type" />
         </xsl:attribute>
         <xsl:attribute name="id">
            <xsl:value-of select="$formmlId" />
         </xsl:attribute>
         <value>
            <xsl:attribute name="source">generalImport</xsl:attribute>
            <xsl:value-of select="current()" />
            <xsl:if test="$name2">
               <xsl:value-of select="' '" />
               <xsl:value-of select="$name2" />
            </xsl:if>
         </value>
      </xsl:element>
   </xsl:template>

   <xsl:template match="node()" mode="Boolean01">
       <xsl:param name="tpsId"/>
       <xsl:param name="src"/>
       <xsl:element name="field">
           <xsl:attribute name="id">
               <xsl:value-of select="$tpsId"/>
           </xsl:attribute>
           <xsl:if test="attribute::code">
               <xsl:attribute name="code">
                   <xsl:value-of select="@code"/>
               </xsl:attribute>
           </xsl:if>
           <xsl:if test="attribute::message">
               <xsl:attribute name="message">
                   <xsl:value-of select="@message"/>
               </xsl:attribute>
           </xsl:if>
           <xsl:if test="attribute::hasError">
                <xsl:attribute name="hasError">
                    <xsl:value-of select="@hasError"/>
                </xsl:attribute>
            </xsl:if>
           <value>
               <xsl:if test="$src">
                   <xsl:attribute name="source">
                       <xsl:value-of select="$src"/>
                   </xsl:attribute>
               </xsl:if>
               <xsl:choose>
                   <xsl:when test="contains(translate(text(),'true','TRUE'),'TRUE')">
                       <xsl:value-of select="1"/>
                   </xsl:when>
                   <xsl:when test="contains(translate(text(),'false','FALSE'),'FALSE')">
                       <xsl:value-of select="0"/>
                   </xsl:when>
               </xsl:choose>
           </value>
       </xsl:element>
   </xsl:template> 
    
    <xsl:template name="genPath">
        <xsl:param name="prevPath"/>
        <!-- Variable that determines if an attribute is needed in the xpath or not -->
        <xsl:variable name="selector">
            <xsl:choose>
                <xsl:when test="@uuid and (name() != 'ReturnData' and name() != 'ReturnHeader')">
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
