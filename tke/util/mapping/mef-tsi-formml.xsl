<?xml version="1.0" encoding="UTF-8"?>
<stylesheet version="1.0">

    <output method="xml" omit-xml-declaration="no" indent="yes"/>

    <!-- Walk entire tree -->
    <template match="node()">
        <apply-templates select="node()"/>
    </template>

    <!-- ServiceBus MeF Root-->
    <template match="/returns/IRS1040">
        <FormML serviceImplementationVersion="mef-tsi-formml.2013.0">
            <formset id="FDI">
                <!-- Pass through the uuid if present -->
                <copy-of select="@uuid"/>
                <apply-templates select="Return" mode="XLATE"/>
            </formset>
        </FormML>
    </template>

    <!-- Traditional MeF Root-->
    <template match="/Return">
        <FormML serviceImplementationVersion="mef-tsi-formml.2013.0">
            <formset id="FDI">
                <copy-of select="@uuid"/>
                <call-template name="XLATE"/>
            </formset>
        </FormML>
    </template>

    <!-- Begin Translation of FORMS -->
    <template match="node()" mode="XLATE" name="XLATE">
        <apply-templates/>
        <!-- Call templates for tsi-forms whose data needs to be collected from different MeF forms -->
        <call-template name="TKEHAVE"/>
        <call-template name="FONLINE"/>
        <call-template name="FINFOWKS"/>
        <call-template name="FPERSWKS"/>
        <call-template name="FSCHEICW"/>
        <call-template name="FSTDLOAN"/>
    </template>

    <!-- Mapping for TKEHAVE -->
    <template match="node()" mode="TKEHAVE" name="TKEHAVE">
        <if test="ReturnHeader/ACAPP | ReturnData/ACACntrlBitsPP | //*[FieldAttributes] | ReturnData/IRS8962">
            <form id="TKEHAVE">
                <for-each select="ReturnHeader/ACAPP | ReturnData/ACACntrlBitsPP">
                    <apply-templates select="." mode="TKEHAVE-SUB"/>
                </for-each>
                <call-template name="CNTRLBITS"/>

                <!-- 12/15/2014 -->
                <for-each select="ReturnData/IRS8962">
                    <apply-templates select="YearOfMarriageIndPP" mode="YesNoField">
                        <with-param name="yTpsId">TYMARRDY</with-param>
                        <with-param name="nTpsId">TYMARRDN</with-param>
                    </apply-templates>
                    <apply-templates select="DependentIncomeIndPP" mode="YesNoField">
                        <with-param name="yTpsId">DEPINCNY</with-param>
                        <with-param name="nTpsId">DEPINCNN</with-param>
                    </apply-templates>
                    <apply-templates select="SharedPolicyIndPP" mode="YesNoField">
                        <with-param name="yTpsId">SHRPOLCY</with-param>
                        <with-param name="nTpsId">SHRPOLCN</with-param>
                    </apply-templates>
                    <apply-templates select="SEMarketPlaceInsuranceIndPP" mode="YesNoField">
                        <with-param name="yTpsId">SEHLTHEY</with-param>
                        <with-param name="nTpsId">SEHLTHEN</with-param>
                    </apply-templates>
                </for-each>
            </form>
        </if>
    </template>
    <template match="ACAPP" mode="TKEHAVE-SUB">
        <apply-templates select="HshldCvrIndPP[child::text()='FULLYEAR']" mode="EnumField">
            <with-param name="tpsId">FULLYHI</with-param>
        </apply-templates>
        <apply-templates select="HshldCvrIndPP[child::text()='PARTYEAR']" mode="EnumField">
            <with-param name="tpsId">PARTYHI</with-param>
        </apply-templates>
        <apply-templates select="HshldCvrIndPP[child::text()='NONE']" mode="EnumField">
            <with-param name="tpsId">NONEHI</with-param>
        </apply-templates>
    </template>
    <template match="ACACntrlBitsPP" mode="TKEHAVE-SUB">
        <apply-templates select="HaveAny1095APP" mode="YesNoField">
            <with-param name="yTpsId">HAY1095A</with-param>
            <with-param name="nTpsId">HAN1095A</with-param>
        </apply-templates>
        <apply-templates select="HaveAnyMore1095APP" mode="YesNoField">
            <with-param name="yTpsId">HMY1095A</with-param>
            <with-param name="nTpsId">HMN1095A</with-param>
        </apply-templates>
        <apply-templates select="HaveAny1095BPP" mode="YesNoField">
            <with-param name="yTpsId">HAY1095B</with-param>
            <with-param name="nTpsId">HAN1095B</with-param>
        </apply-templates>
        <apply-templates select="HaveAnyMore1095BPP" mode="YesNoField">
            <with-param name="yTpsId">HMY1095B</with-param>
            <with-param name="nTpsId">HMN1095B</with-param>
        </apply-templates>
        <apply-templates select="HaveAny1095CPP" mode="YesNoField">
            <with-param name="yTpsId">HAY1095C</with-param>
            <with-param name="nTpsId">HAN1095C</with-param>
        </apply-templates>
        <apply-templates select="HaveAnyMore1095CPP" mode="YesNoField">
            <with-param name="yTpsId">HMY1095C</with-param>
            <with-param name="nTpsId">HMN1095C</with-param>
        </apply-templates>
        <apply-templates select="Have8965PP" mode="YesNoField">
            <with-param name="yTpsId">HAY8965</with-param>
            <with-param name="nTpsId">HAN8965</with-param>
        </apply-templates>
        <apply-templates select="ACAInterviewCompletionPP" mode="YesNoField">
            <with-param name="yTpsId">ACACOMPY</with-param>
            <with-param name="nTpsId">ACACOMPN</with-param>
        </apply-templates>
    </template>
    <!-- Mappings for CNTRLBITS -->
    <template match="node()" mode="CNTRLBITS" name="CNTRLBITS">
        <if test="count(//*[FieldAttributes]) > 0">
            <table id="FLDCVRGS">
                <for-each select="//*[FieldAttributes]">
                    <if test="current()/descendant-or-self::Covered">
                        <call-template name="FieldCoverage_CB"/>
                    </if>
                </for-each>
            </table>
        </if>
    </template>
    <!-- Covered constant -->
    <variable name="coveredBit"><text>COVERED</text></variable>
    <template match="node()" mode="FieldCoverage_CB" name="FieldCoverage_CB">
        <!-- Each Field inside of FieldAttributes that has Covered node-->
        <for-each select="FieldAttributes/child::node()[descendant::Covered]">
            <variable name="parentPath">
                <call-template name="genPath"/>
            </variable>
            <!-- Trim out the servicebus tags if any -->
            <variable name="mefParentPath">
                <value-of select="substring($parentPath,string-length(substring-before($parentPath,'/Return'))+1)"/>
            </variable>
            <row>
                <call-template name="ControlBitRow">
                    <with-param name="fldName">
                        <value-of select="name()"/>
                    </with-param>
                    <with-param name="parentPath">
                        <value-of select="substring-before($mefParentPath,'/FieldAttributes')"/>
                    </with-param>
                    <with-param name="controlBit">
                        <value-of select="$coveredBit"/>
                    </with-param>
                    <with-param name="bitValue">
                        <value-of select="Covered"/>
                    </with-param>
                </call-template>
            </row>
        </for-each>
    </template>
    <template match="node()" mode="ControlBitRow" name="ControlBitRow">
        <param name="fldName"/>
        <param name="parentPath"/>
        <param name="controlBit"/>
        <param name="bitValue"/>
        <element name="field">
            <attribute name="id">
                <text>SFLDPATH</text>
            </attribute>
            <value>
                <value-of select="concat($parentPath,'/',$fldName)"/>
            </value>
        </element>
        <element name="field">
            <attribute name="id">
                <text>SFLDNAME</text>
            </attribute>
            <value>
                <value-of select="$fldName"/>
            </value>
        </element>
        <element name="field">
            <attribute name="id">
                <text>SPARENT</text>
            </attribute>
            <value>
                <value-of select="$parentPath"/>
            </value>
        </element>
        <element name="field">
            <attribute name="id">
                <choose>
                    <when test="$controlBit=$coveredBit">
                        <text>SCOVERED</text>
                    </when>
                </choose>
            </attribute>
            <value>
                <value-of select="normalize-space($bitValue)"/>
            </value>
        </element>
    </template>

    <!-- Mapping for IRS1040 -->
    <template match="ReturnData/IRS1040">
        <form id="F1040">
            <copy-of select="@uuid"/>
            <apply-templates select="TaxpayerAlimonyReceivedAmtPP" mode="Field">
                <with-param name="tpsId">L11T</with-param>
            </apply-templates>
            <apply-templates select="SpouseAlimonyReceivedAmtPP" mode="Field">
                <with-param name="tpsId">L11S</with-param>
            </apply-templates>
            <apply-templates select="AmountRepaidToEmployerJuryDutyPP" mode="Field">
                <with-param name="tpsId">L32C</with-param>
            </apply-templates>
            <apply-templates select="EarnedIncomeCreditAmt" mode="Field">
                <with-param name="tpsId">L60</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="DisqualifiedFromEICLiteralPP" mode="Field">
                <with-param name="tpsId">L60W</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="ClergyEICLiteralPP" mode="Field">
                <with-param name="tpsId">L60C</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="EICEligibilityLiteralCd" mode="Field">
                <with-param name="tpsId">HEICL</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="NontxCombatPayElectionAmt" mode="Field">
                <with-param name="tpsId">NTCOMBAT</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <if test="count(AlimonyAmountGrp)>0">
                <table id="ALIM">
                    <for-each select="AlimonyAmountGrp">
                        <apply-templates select="." mode="IRS1040-AlimonyAmountGrp"/>
                    </for-each>
                </table>
            </if>
            <apply-templates select="HaveAnyAlimonyPaidPP" mode="Boolean01">
                <with-param name="tpsId">HHAVEAL</with-param>
            </apply-templates>
            <apply-templates select="HaveAnyMoreAlimonyPaidPP" mode="Boolean01">
                <with-param name="tpsId">HMOREAL</with-param>
            </apply-templates>
        </form>
        <apply-templates select="DependentWorksheetPP" mode="DependentWorksheetPP-FWDEPINF"/>
    </template>
    <template match="ReturnData/IRS1040/AlimonyAmountGrp" mode="IRS1040-AlimonyAmountGrp">
        <row>
            <copy-of select="@uuid"/>
            <apply-templates select="RecipientNamePP" mode="Field">
                <with-param name="tpsId">ALNAME</with-param>
            </apply-templates>
            <apply-templates select="RecipientSSN" mode="Field">
                <with-param name="tpsId">MRSSN</with-param>
            </apply-templates>
            <apply-templates select="AlimonyPaidAmt" mode="Field">
                <with-param name="tpsId">L31AMT</with-param>
            </apply-templates>
        </row>
    </template>
    <template match="ReturnData/IRS1040/DependentWorksheetPP" mode="DependentWorksheetPP-FWDEPINF">
        <form id="FWDEPINF">
            <copy-of select="@uuid"/>
            <apply-templates select="BirthDtPP" mode="Date">
                <with-param name="tpsId">DOB</with-param>
            </apply-templates>
            <apply-templates select="FirstNmPP" mode="Field">
                <with-param name="tpsId">FIRSTNAM</with-param>
            </apply-templates>
            <apply-templates select="LastNmPP" mode="Field">
                <with-param name="tpsId">LASTNAM</with-param>
            </apply-templates>
            <apply-templates select="SSNPP" mode="Field">
                <with-param name="tpsId">SSN</with-param>
            </apply-templates>
            <apply-templates select="DeathDtPP" mode="Date">
                <with-param name="tpsId">CHDOD</with-param>
            </apply-templates>
            <apply-templates select="DependentAgePP" mode="Field">
                <with-param name="tpsId">AGE</with-param>
            </apply-templates>
            <apply-templates select="DependentCodePP" mode="Field">
                <with-param name="tpsId">CD</with-param>
            </apply-templates>
            <apply-templates select="EICCodePP" mode="Field">
                <with-param name="tpsId">EIC</with-param>
            </apply-templates>
            <apply-templates select="MonthsPP" mode="Field">
                <with-param name="tpsId">MONTHS</with-param>
            </apply-templates>
            <apply-templates select="DependentMonthsLivedWithTaxpayerInUSPP" mode="Field">
                <with-param name="tpsId">MTHSINUS</with-param>
            </apply-templates>
            <apply-templates select="DependentRelationshipCdPP" mode="Field">
                <with-param name="tpsId">RELATION</with-param>
            </apply-templates>
            <apply-templates select="DependentDisabledIndPP" mode="BoolToCheckBox">
                <with-param name="tpsId">DISABX</with-param>
            </apply-templates>
            <apply-templates select="DependentAdoptedIndPP" mode="BoolToCheckBox">
                <with-param name="tpsId">ADOPTED</with-param>
            </apply-templates>
            <apply-templates select="DependentStudentIndPP" mode="YesNoField">
                <with-param name="yTpsId">YESSTU</with-param>
                <with-param name="nTpsId">NOSTU</with-param>
            </apply-templates>
            <apply-templates select="DependentMarriedIndPP" mode="YesNoField">
                <with-param name="yTpsId">YESMAR</with-param>
                <with-param name="nTpsId">NOMAR</with-param>
            </apply-templates>
            <apply-templates select="DependentYouProvideHalfIndPP" mode="YesNoField">
                <with-param name="yTpsId">OVRHALF</with-param>
                <with-param name="nTpsId">HALFLESS</with-param>
            </apply-templates>
            <apply-templates select="DependentLegalAgreementIndPP" mode="YesNoField">
                <with-param name="yTpsId">YESAGR</with-param>
                <with-param name="nTpsId">NOAGR</with-param>
            </apply-templates>
            <apply-templates select="IsDeceasedIndPP" mode="YesNoField">
                <with-param name="yTpsId">PASSDY</with-param>
                <with-param name="nTpsId">PASSDN</with-param>
            </apply-templates>
            <apply-templates select="DependentPaidMoreThanHalfIndPP" mode="YesNoField">
                <with-param name="yTpsId">YESSUP</with-param>
                <with-param name="nTpsId">NOSUP</with-param>
            </apply-templates>
            <apply-templates select="IncomeLessThanIndicatorPP" mode="YesNoField">
                <with-param name="yTpsId">GILESSY</with-param>
                <with-param name="nTpsId">GILESSN</with-param>
            </apply-templates>
            <apply-templates select="DependentCitizenIndPP" mode="YesNoField">
                <with-param name="yTpsId">USCIT</with-param>
                <with-param name="nTpsId">USCITN</with-param>
            </apply-templates>
            <apply-templates select="DependentLegalResIndPP" mode="YesNoField">
                <with-param name="yTpsId">CANMEX</with-param>
                <with-param name="nTpsId">CANMEXN</with-param>
            </apply-templates>
            <apply-templates select="DependentWhoWillClaimPP[text()='Taxpayer']" mode="EnumField">
                <with-param name="tpsId">IWILL</with-param>
                <with-param name="fieldValue">X</with-param>
            </apply-templates>
            <apply-templates select="DependentWhoWillClaimPP[text()='Other Parent']" mode="EnumField">
                <with-param name="tpsId">OTHPAR</with-param>
                <with-param name="fieldValue">X</with-param>
            </apply-templates>
            <apply-templates select="DependentWhoWillClaimPP[text()='Someone Else']" mode="EnumField">
                <with-param name="tpsId">SONEELSE</with-param>
                <with-param name="fieldValue">X</with-param>
            </apply-templates>
            <apply-templates select="DependentLegalParentsPP[text()='Taxpayer']" mode="EnumField">
                <with-param name="tpsId">TPPAR</with-param>
                <with-param name="fieldValue">X</with-param>
            </apply-templates>
            <apply-templates select="DependentLegalParentsPP[text()='Spouse']" mode="EnumField">
                <with-param name="tpsId">SPPAR</with-param>
                <with-param name="fieldValue">X</with-param>
            </apply-templates>
            <apply-templates select="DependentLegalParentsPP[text()='Both']" mode="EnumField">
                <with-param name="tpsId">BOTHPAR</with-param>
                <with-param name="fieldValue">X</with-param>
            </apply-templates>
            <apply-templates select="." mode="DependentWorksheetPP-FDEPWKS"/>
        </form>
    </template>
    <template match="ReturnData/IRS1040/DependentWorksheetPP" mode="DependentWorksheetPP-FDEPWKS">
        <form id="FDEPWKS">
            <copy-of select="@uuid"/>
            <apply-templates select="DependentFosterIndPP" mode="Field">
                <with-param name="tpsId">FOSTER</with-param>
            </apply-templates>
            <apply-templates select="DependentAllPaidHalfIndPP" mode="YesNoField">
                <with-param name="yTpsId">FIFTYY</with-param>
                <with-param name="nTpsId">FIFTYN</with-param>
            </apply-templates>
            <apply-templates select="DependentYouPayTenIndPP" mode="YesNoField">
                <with-param name="yTpsId">TENY</with-param>
                <with-param name="nTpsId">TENN</with-param>
            </apply-templates>
            <apply-templates select="DependentLetYouClaimIndPP" mode="YesNoField">
                <with-param name="yTpsId">YOUGETY</with-param>
                <with-param name="nTpsId">YOUGETN</with-param>
            </apply-templates>
            <apply-templates select="DependentLiveWithRelHalfIndPP" mode="YesNoField">
                <with-param name="yTpsId">YESSIX</with-param>
                <with-param name="nTpsId">NOSIX</with-param>
            </apply-templates>
            <apply-templates select="DependentRelMeetsQualsIndPP" mode="YesNoField">
                <with-param name="yTpsId">YESCLAIM</with-param>
                <with-param name="nTpsId">NOCLAIM</with-param>
            </apply-templates>
            <apply-templates select="DependentAdoptionFinalIndPP" mode="YesNoField">
                <with-param name="yTpsId">FINALY</with-param>
                <with-param name="nTpsId">FINALN</with-param>
            </apply-templates>
            <apply-templates select="DependentPlacedByAdoptionAgencyIndPP" mode="YesNoField">
                <with-param name="yTpsId">LATERY</with-param>
                <with-param name="nTpsId">LATERN</with-param>
            </apply-templates>
            <apply-templates select="DependentFosterPlacedByAgencyIndPP" mode="YesNoField">
                <with-param name="yTpsId">YESAUTH</with-param>
                <with-param name="nTpsId">NOAUTH</with-param>
            </apply-templates>
            <apply-templates select="DependentNumberOfNightsPP[text()='YouMore']" mode="EnumField">
                <with-param name="tpsId">TPTIME</with-param>
                <with-param name="fieldValue">X</with-param>
            </apply-templates>
            <apply-templates select="DependentNumberOfNightsPP[text()='OtherParentMore']" mode="EnumField">
                <with-param name="tpsId">OTHTIME</with-param>
                <with-param name="fieldValue">X</with-param>
            </apply-templates>
            <apply-templates select="DependentNumberOfNightsPP[text()='Same']" mode="EnumField">
                <with-param name="tpsId">SAMETIME</with-param>
                <with-param name="fieldValue">X</with-param>
            </apply-templates>
            <apply-templates select="DependentTPOrRelHigherPP[text()='Taxpayer']" mode="EnumField">
                <with-param name="tpsId">AGIMINE</with-param>
                <with-param name="fieldValue">X</with-param>
            </apply-templates>
            <apply-templates select="DependentTPOrRelHigherPP[text()='Rel']" mode="EnumField">
                <with-param name="tpsId">AGIOTH</with-param>
                <with-param name="fieldValue">X</with-param>
            </apply-templates>
            <apply-templates select="DependentHigherIncomePP[text()='YouHigher']" mode="EnumField">
                <with-param name="tpsId">MEHIGH</with-param>
                <with-param name="fieldValue">X</with-param>
            </apply-templates>
            <apply-templates select="DependentHigherIncomePP[text()='OtherParentHigher']" mode="EnumField">
                <with-param name="tpsId">OTHHIGH</with-param>
                <with-param name="fieldValue">X</with-param>
            </apply-templates>
            <apply-templates select="DependentRelHelpSupportIndPP" mode="YesNoField">
                <with-param name="yTpsId">YESHELP</with-param>
                <with-param name="nTpsId">NOHELP</with-param>
            </apply-templates>
            <apply-templates select="DependentRelParentIndPP" mode="YesNoField">
                <with-param name="yTpsId">RELPARY</with-param>
                <with-param name="nTpsId">RELPAYN</with-param>
            </apply-templates>
            <apply-templates select="DependentParentWaiveIndPP" mode="YesNoField">
                <with-param name="yTpsId">IMCL</with-param>
                <with-param name="nTpsId">IMNOTCL</with-param>
            </apply-templates>
        </form>
    </template>

    <!-- Mapping for FONLINE -->
    <template match="node()" mode="FONLINE" name="FONLINE">
        <if test="ReturnData/IRS1040/PersonalPropertyRentalExpenses | ReturnData/PPPerson | ReturnData/PPReturnInformation">
            <form id="FONLINE">
                <apply-templates select="ReturnData/IRS1040/PersonalPropertyRentalExpenses" mode="FONLINE-PersonalProperty"/>
                <apply-templates select="ReturnData/PPPerson" mode="FONLINE-PPPerson"/>
                <apply-templates select="ReturnData/PPReturnInformation" mode="FONLINE-PPReturnInformation"/>
            </form>
        </if>
    </template>
    <template match="ReturnData/IRS1040/PersonalPropertyRentalExpenses" mode="FONLINE-PersonalProperty">
        <if test="TaxpayerPersonalPropertyRentalExpensePP | SpousePersonalPropertyRentalExpensePP">
            <table id="A4533">
                <if test="TaxpayerPersonalPropertyRentalExpensePP">
                    <row copy="1">
                        <apply-templates select="TaxpayerPersonalPropertyRentalExpensePP" mode="Field">
                            <with-param name="tpsId">PPROPEX</with-param>
                        </apply-templates>
                    </row>
                </if>
                <if test="SpousePersonalPropertyRentalExpensePP">
                    <row copy="2">
                        <apply-templates select="SpousePersonalPropertyRentalExpensePP" mode="Field">
                            <with-param name="tpsId">PPROPEX</with-param>
                        </apply-templates>
                    </row>
                </if>
            </table>
        </if>
    </template>
    <template match="ReturnData/PPPerson" mode="FONLINE-PPPerson">
        <apply-templates select="TaxpayerFilerInfoPP/MilitaryRelatedDeathPP" mode="BoolToCheckBox">
            <with-param name="tpsId">TPMILDOD</with-param>
        </apply-templates>
        <apply-templates select="SpouseFilerInfoPP/MilitaryRelatedDeathPP" mode="BoolToCheckBox">
            <with-param name="tpsId">SPMILDOD</with-param>
        </apply-templates>
        <apply-templates select="TaxpayerFilerInfoPP/IsDeadPP" mode="BoolToCheckBox">
            <with-param name="tpsId">TPDEAD</with-param>
        </apply-templates>
        <apply-templates select="SpouseFilerInfoPP/IsDeadPP" mode="BoolToCheckBox">
            <with-param name="tpsId">SPDEAD</with-param>
        </apply-templates>
    </template>
    <template match="ReturnData/PPReturnInformation" mode="FONLINE-PPReturnInformation">
        <apply-templates select="CouldHaveFiledJointReturnIndPP" mode="YesNoField">
            <with-param name="yTpsId">QWJNTY</with-param>
            <with-param name="nTpsId">QWJNTN</with-param>
        </apply-templates>
        <apply-templates select="MaintainHalfHomeExpensesIndPP" mode="YesNoField">
            <with-param name="yTpsId">MTHOMEY</with-param>
            <with-param name="nTpsId">MTHOMEN</with-param>
        </apply-templates>
        <apply-templates select="LivedWithSpouseLastSixMonthsIndPP" mode="BoolToCheckBox">
            <with-param name="tpsId">CSUNWED</with-param>
        </apply-templates>
        <apply-templates select="SpouseNoGrossIncomeIndPP" mode="BoolToCheckBox">
            <with-param name="tpsId">SPNOINC</with-param>
        </apply-templates>
        <apply-templates select="SpouseNotFilingReturnIndPP" mode="BoolToCheckBox">
            <with-param name="tpsId">SPNOTAX</with-param>
        </apply-templates>
        <apply-templates select="HOHDependentIndPP" mode="BoolToCheckBox">
            <with-param name="tpsId">DEPHOH</with-param>
        </apply-templates>
        <apply-templates select="QWDependentIndPP" mode="BoolToCheckBox">
            <with-param name="tpsId">DEPQW</with-param>
        </apply-templates>
    </template>

    <!-- Mapping for FINFOWKS -->
    <template match="node()" mode="FINFOWKS" name="FINFOWKS">
        <if test="ReturnData/IRS1040 | ReturnData/PPReturnInformation | ReturnData/EIC">
            <form id ="FINFOWKS">
                <apply-templates select="ReturnData/PPReturnInformation" mode="FINFOWKS-PPReturnInformation"/>
                <apply-templates select="ReturnData/EIC" mode="FINFOWKS-EIC"/>
                <apply-templates select="ReturnData/IRS1040" mode="FINFOWKS-IRS1040"/>
            </form>
        </if>
    </template>
    <template match="ReturnData/PPReturnInformation" mode="FINFOWKS-PPReturnInformation">
        <apply-templates select="hMarriedFilingStatusPP" mode="Field">
            <with-param name="tpsId">HMFSTAT</with-param>
        </apply-templates>
        <apply-templates select="USAddressPP/AddressLine1Txt" mode="Field">
            <with-param name="tpsId">ADDR</with-param>
        </apply-templates>
        <apply-templates select="USAddressPP/AddressLine2Txt" mode="Field">
            <with-param name="tpsId">APT</with-param>
        </apply-templates>
        <apply-templates select="USAddressPP/CityNm" mode="Field">
            <with-param name="tpsId">CITY</with-param>
        </apply-templates>
        <apply-templates select="USAddressPP/StateAbbreviationCd" mode="Field">
            <with-param name="tpsId">ST</with-param>
        </apply-templates>
        <apply-templates select="USAddressPP/ZIPCd" mode="Field">
            <with-param name="tpsId">ZIP</with-param>
        </apply-templates>
        <apply-templates select="ForeignAddressPP/AddressLine1Txt" mode="Field">
            <with-param name="tpsId">ADDR</with-param>
        </apply-templates>
        <apply-templates select="ForeignAddressPP/AddressLine2Txt" mode="Field">
            <with-param name="tpsId">APT</with-param>
        </apply-templates>
        <apply-templates select="ForeignAddressPP/ProvinceOrStateNm" mode="Field">
            <with-param name="tpsId">FPC</with-param>
        </apply-templates>
        <apply-templates select="ForeignAddressPP/CountryCd" mode="Field">
            <with-param name="tpsId">FCCODE</with-param>
        </apply-templates>
        <apply-templates select="ForeignAddressPP/CityNm" mode="Field">
            <with-param name="tpsId">CITY</with-param>
        </apply-templates>
        <apply-templates select="ForeignAddressPP/ForeignPostalCd" mode="Field">
            <with-param name="tpsId">FZIP</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="HasRDPPP" mode="Boolean01">
            <with-param name="tpsId">HHASRDP</with-param>
        </apply-templates>
        <apply-templates select="HasCivilUnionPP" mode="Boolean01">
            <with-param name="tpsId">HHASCU</with-param>
        </apply-templates>
        <apply-templates select="HasRDPorCUPP" mode="Boolean01">
            <with-param name="tpsId">HRDPORCU</with-param>
        </apply-templates>
        <if test="NonResidentStateGrpPP">
            <table id="NONRES">
                <apply-templates select="NonResidentStateGrpPP/NonResidentStatePP" mode="FINFOWKS-NonResidentStateTablePP"/>
            </table>
        </if>
    </template>
    <template match="ReturnData/PPReturnInformation/NonResidentStateGrpPP/NonResidentStatePP" mode="FINFOWKS-NonResidentStateTablePP">
        <row>
            <copy-of select="@uuid"/>
            <apply-templates select="current()" mode="Field">
                <with-param name="tpsId">NONRESST</with-param>
            </apply-templates>
        </row>
    </template>
    <template match="ReturnData/IRS1040" mode="FINFOWKS-IRS1040">
        <apply-templates select="IndividualReturnFilingStatusCd[text()='1']" mode="EnumField">
            <with-param name="tpsId">FS1</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
        <apply-templates select="IndividualReturnFilingStatusCd[text()='2']" mode="EnumField">
            <with-param name="tpsId">FS2</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
        <apply-templates select="IndividualReturnFilingStatusCd[text()='3']" mode="EnumField">
            <with-param name="tpsId">FS3</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
        <apply-templates select="IndividualReturnFilingStatusCd[text()='4']" mode="EnumField">
            <with-param name="tpsId">FS4</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
        <apply-templates select="IndividualReturnFilingStatusCd[text()='5']" mode="EnumField">
            <with-param name="tpsId">FS5</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
    </template>

    <!-- Mapping for FPERSWKS -->
    <template match="node()" mode="FPERSWKS" name="FPERSWKS">
        <if test="ReturnData/PPPerson/TaxpayerFilerInfoPP | ReturnData/PPReturnInformation">
            <form id="FPERSWKS" copy="1">
                <copy-of select="ReturnData/PPPerson/TaxpayerFilerInfoPP/@uuid"/>
                <apply-templates select="ReturnData/PPReturnInformation"  mode="FPERSWKS-PPReturnInformation"/>
                <apply-templates select="ReturnData/PPPerson" mode="TaxpayerFilerInfoPP"/>
            </form>
        </if>
        <if test="ReturnData/PPPerson/SpouseFilerInfoPP">
            <form id="FPERSWKS" copy="2">
                <copy-of select="ReturnData/PPPerson/SpouseFilerInfoPP/@uuid"/>
                <apply-templates select="ReturnData/PPPerson" mode="SpouseFilerInfoPP"/>
            </form>
        </if>
    </template>
    <template match="ReturnData/PPReturnInformation" mode="FPERSWKS-PPReturnInformation">
        <apply-templates select="DayTimePhoneNumberPP" mode="Field">
            <with-param name="tpsId">PHONE</with-param>
        </apply-templates>
        <apply-templates select="PhoneNumberExtPP" mode="Field">
            <with-param name="tpsId">EXTN</with-param>
        </apply-templates>
        <apply-templates select="MaritalStatusPP" mode="Field">
            <with-param name="tpsId">MARITAL</with-param>
        </apply-templates>
    </template>
    <template match="ReturnData/PPPerson" mode="TaxpayerFilerInfoPP">
        <apply-templates select="TaxpayerFilerInfoPP/WidowedInYearPP[text()='PriorTwoPriorTaxYear']" mode="EnumField">
            <with-param name="tpsId">YX0</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
        <apply-templates select="TaxpayerFilerInfoPP/WidowedInYearPP[text()='TwoPriorTaxYear']" mode="EnumField">
            <with-param name="tpsId">YX1</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
        <apply-templates select="TaxpayerFilerInfoPP/WidowedInYearPP[text()='PriorTaxYear']" mode="EnumField">
            <with-param name="tpsId">YX2</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
        <apply-templates select="TaxpayerFilerInfoPP/WidowedInYearPP[text()='TaxYear']" mode="EnumField">
            <with-param name="tpsId">YX3</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
        <apply-templates select="TaxpayerFilerInfoPP/WidowedInYearPP[text()='NextTaxYear']" mode="EnumField">
            <with-param name="tpsId">YX4</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
        <apply-templates select="TaxpayerFilerInfoPP" mode="FILERINFO"/>
    </template>
    <template match="ReturnData/PPPerson" mode="SpouseFilerInfoPP">
        <apply-templates select="SpouseFilerInfoPP" mode="FILERINFO"/>
    </template>
    <template match="SpouseFilerInfoPP | TaxpayerFilerInfoPP" mode="FILERINFO">
        <apply-templates select="MilitaryIndPP" mode="YesNoField">
            <with-param name="yTpsId">YMIL</with-param>
            <with-param name="nTpsId">NMIL</with-param>
        </apply-templates>
        <apply-templates select="PresidentialElectionCampaignIndPP" mode="YesNoField">
            <with-param name="yTpsId">PECY</with-param>
            <with-param name="nTpsId">PECN</with-param>
        </apply-templates>
        <apply-templates select="PersonNicknamePP" mode="Field">
            <with-param name="tpsId">NICKNAME</with-param>
        </apply-templates>
        <apply-templates select="PersonMiddleInitialPP" mode="Field">
            <with-param name="tpsId">INITIAL</with-param>
        </apply-templates>
        <apply-templates select="PersonSuffixPP" mode="Field">
            <with-param name="tpsId">SUFFIX</with-param>
        </apply-templates>
        <apply-templates select="SSNPP" mode="Field">
            <with-param name="tpsId">SSN</with-param>
        </apply-templates>
        <apply-templates select="DateOfBirthPP" mode="Date">
            <with-param name="tpsId">DOB</with-param>
        </apply-templates>
        <apply-templates select="DateOfDeathPP" mode="Date">
            <with-param name="tpsId">DOD</with-param>
        </apply-templates>
        <apply-templates select="CanBeClaimedAsDependentIndPP" mode="YesNoField">
            <with-param name="yTpsId">DXT</with-param>
            <with-param name="nTpsId">DXTN</with-param>
        </apply-templates>
        <apply-templates select="WillBeClaimedAsDependentIndPP" mode="YesNoField">
            <with-param name="yTpsId">DEPTY</with-param>
            <with-param name="nTpsId">DEPTN</with-param>
        </apply-templates>
        <apply-templates select="UnderSixteenFirstTimeFilerIndPP" mode="YesNoField">
            <with-param name="yTpsId">SIXTEENY</with-param>
            <with-param name="nTpsId">SIXTEENN</with-param>
        </apply-templates>
        <apply-templates select="StateOfResidencePP" mode="Field">
            <with-param name="tpsId">RSTA</with-param>
        </apply-templates>
        <apply-templates select="FormerPlaceOfResidencePP" mode="Field">
            <with-param name="tpsId">WHERE</with-param>
        </apply-templates>
        <apply-templates select="LivedInAnotherStatePP" mode="YesNoField">
            <with-param name="yTpsId">RESP</with-param>
            <with-param name="nTpsId">RESF</with-param>
        </apply-templates>
        <apply-templates select="DateOfStateResidencePP" mode="Date">
            <with-param name="tpsId">RESDATE</with-param>
        </apply-templates>
        <apply-templates select="LegallyBlindIndPP" mode="BoolToCheckBox">
            <with-param name="tpsId">BLXT</with-param>
        </apply-templates>
        <apply-templates select="OccupationPP" mode="Field">
            <with-param name="tpsId">OCCUP</with-param>
        </apply-templates>
        <apply-templates select="PersonFullNamePP/PersonFirstNm" mode="Field">
            <with-param name="tpsId">FIRSTNAM</with-param>
        </apply-templates>
        <apply-templates select="PersonFullNamePP/PersonLastNm" mode="Field">
            <with-param name="tpsId">LASTNAM</with-param>
        </apply-templates>
    </template>

    <!-- Mapping for FEFHDSUM -->
    <template match="ReturnData/PPPerson">
        <form id="FEFHDSUM">
            <apply-templates select="TaxpayerFilerInfoPP/CombatZoneDateOfDeploymentPP" mode="Date">
                <with-param name="tpsId">CZDATE</with-param>
            </apply-templates>
            <apply-templates select="TaxpayerFilerInfoPP/ActiveDutyCombatZonePP" mode="CombatZones"/>
        </form>
    </template>
    <template match="ActiveDutyCombatZonePP" mode="CombatZones">
        <apply-templates select="current()[text()='Operation Iraqi Freedom']" mode="EnumField">
            <with-param name="tpsId">MIL00</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
        <apply-templates select="current()[text()='Kosovo Operation']" mode="EnumField">
            <with-param name="tpsId">MIL01</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
        <apply-templates select="current()[text()='Afghanistan']" mode="EnumField">
            <with-param name="tpsId">MIL0</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
        <apply-templates select="current()[text()='Desert Storm']" mode="EnumField">
            <with-param name="tpsId">MIL1</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
        <apply-templates select="current()[text()='Haiti']" mode="EnumField">
            <with-param name="tpsId">MIL2</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
        <apply-templates select="current()[text()='Former Yugoslavia']" mode="EnumField">
            <with-param name="tpsId">MIL4</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
        <apply-templates select="current()[text()='UN Operation']" mode="EnumField">
            <with-param name="tpsId">MIL5</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
        <apply-templates select="current()[text()='Joint Guard']" mode="EnumField">
            <with-param name="tpsId">MIL6</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
        <apply-templates select="current()[text()='Operation Joint Forge']" mode="EnumField">
            <with-param name="tpsId">MIL7</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
        <apply-templates select="current()[text()='Northern Watch']" mode="EnumField">
            <with-param name="tpsId">MIL8</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
        <apply-templates select="current()[text()='Operation Allied Forces']" mode="EnumField">
            <with-param name="tpsId">MIL9</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
        <apply-templates select="current()[text()='Northern Forge']" mode="EnumField">
            <with-param name="tpsId">MIL10</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
        <apply-templates select="current()[text()='Other Combat Zone']" mode="EnumField">
            <with-param name="tpsId">MIL11</with-param>
            <with-param name="fieldValue">X</with-param>
        </apply-templates>
    </template>

    <!-- Mapping for Other Income -->
    <template match="ReturnData/OtherIncome">
        <form id="FOTHINC">
            <copy-of select="@uuid"/>
            <apply-templates select="TaxpayerJuryDutyPayPP" mode="Field">
                <with-param name="tpsId">L12T</with-param>
            </apply-templates>
            <apply-templates select="SpouseJuryDutyPayPP" mode="Field">
                <with-param name="tpsId">L12S</with-param>
            </apply-templates>
            <apply-templates select="TaxpayerBarteringIncomePP" mode="Field">
                <with-param name="tpsId">L13T</with-param>
            </apply-templates>
            <apply-templates select="SpouseBarteringIncomePP" mode="Field">
                <with-param name="tpsId">L13S</with-param>
            </apply-templates>
            <apply-templates select="TaxpayerPersonalPropertyRentalIncomePP" mode="Field">
                <with-param name="tpsId">L14T</with-param>
            </apply-templates>
            <apply-templates select="SpousePersonalPropertyRentalIncomePP" mode="Field">
                <with-param name="tpsId">L14S</with-param>
            </apply-templates>
            <apply-templates select="TaxpayerWinningsNotReportedOnFormPP" mode="Field">
                <with-param name="tpsId">L2BT</with-param>
            </apply-templates>
            <apply-templates select="SpouseWinningsNotReportedOnFormPP" mode="Field">
                <with-param name="tpsId">L2BS</with-param>
            </apply-templates>
            <apply-templates select="TotalWinningsPP" mode="Field">
                <with-param name="tpsId">HTOTL2</with-param>
            </apply-templates>
            <if test="OtherTaxableIncomeGrpPP">
                <table id="LN15PER">
                    <apply-templates select="OtherTaxableIncomeGrpPP" mode="OtherTaxableIncomeGrpPP"/>
                </table>
            </if>
            <apply-templates select="TaxpayerHobbyIncomePP" mode="Field">
                <with-param name="tpsId">HOBBYT</with-param>
            </apply-templates>
            <apply-templates select="SpouseHobbyIncomePP" mode="Field">
                <with-param name="tpsId">HOBBYS</with-param>
            </apply-templates>
            <apply-templates select="TaxpayerRecoveryOfPriorYearBadDebtPP" mode="Field">
                <with-param name="tpsId">L11T</with-param>
            </apply-templates>
            <apply-templates select="SpouseRecoveryOfPriorYearBadDebtPP" mode="Field">
                <with-param name="tpsId">L11S</with-param>
            </apply-templates>
        </form>
    </template>
    <template match="ReturnData/OtherIncome/OtherTaxableIncomeGrpPP" mode="OtherTaxableIncomeGrpPP">
        <row>
            <copy-of select="@uuid"/>
            <apply-templates select="OtherTaxableIncomeDescriptionPP" mode="Field">
                <with-param name="tpsId">L15DES</with-param>
            </apply-templates>
            <apply-templates select="TaxpayerOtherTaxableIncomeAmtPP" mode="Field">
                <with-param name="tpsId">L15TP</with-param>
            </apply-templates>
            <apply-templates select="SpouseOtherTaxableIncomeAmtPP" mode="Field">
                <with-param name="tpsId">L15SP</with-param>
            </apply-templates>
        </row>
    </template>

    <!-- Mappings for IRS1040ScheduleA tables and fields -->
    <template match="ReturnData/IRS1040ScheduleA">
        <form id="FSCHATI">
            <copy-of select="@uuid"/>
            <apply-templates select="HaveAnyAutoRegistrationIndPP" mode="Field">
                <with-param name="tpsId">hAutoReg</with-param>
            </apply-templates>
            <apply-templates select="HaveAnyMoreAutoRegistrationIndPP" mode="Field">
                <with-param name="tpsId">hAddAuto</with-param>
            </apply-templates>
            <apply-templates/>
        </form>
        <call-template name="IRS1040ScheduleA-FSCHA19"/>
        <call-template name="IRS1040ScheduleA-FSCHA"/>
    </template>
    <template match="ReturnData/IRS1040ScheduleA/AutoRegistrationGroupPP">
        <table id="DMVFEES">
            <row>
                <copy-of select="@uuid"/>
                <apply-templates select="MakeModelDescriptionPP" mode="Field">
                    <with-param name="tpsId">L3A1</with-param>
                </apply-templates>
                <apply-templates select="DeductibleRegistrationFeePP" mode="Field">
                    <with-param name="tpsId">L3A</with-param>
                </apply-templates>
            </row>
        </table>
    </template>
    <template match="ReturnData/IRS1040ScheduleA" name="IRS1040ScheduleA-FSCHA19" mode="IRS1040ScheduleA-FSCHA19">
        <!-- TODO: We should remove this if condition from here. This is a hack so that we do not
             change the mapping output for current AutoReg. Date - 04/09/2015-->
        <if test="GamblingLossesPP | LegalFeesPP | TaxpayerHobbyExpensePP | SpouseHobbyExpensePP">
            <form id="FSCHA19">
                <!--                <copy-of select="@uuid"/>-->
                <apply-templates select="GamblingLossesPP" mode="Field">
                    <with-param name="tpsId">L17</with-param>
                </apply-templates>
                <apply-templates select="LegalFeesPP" mode="Field">
                    <with-param name="tpsId">L12B</with-param>
                </apply-templates>
                <apply-templates select="TaxpayerHobbyExpensePP" mode="Field">
                    <with-param name="tpsId">HOBBYEXT</with-param>
                </apply-templates>
                <apply-templates select="SpouseHobbyExpensePP" mode="Field">
                    <with-param name="tpsId">HOBBYEXS</with-param>
                </apply-templates>
            </form>
        </if>
    </template>
    <template match="ReturnData/IRS1040ScheduleA" name="IRS1040ScheduleA-FSCHA" mode="IRS1040ScheduleA-FSCHA">
        <!-- TODO: We should remove this if condition from here. This is a hack so that we do not
             change the mapping output for current AutoReg. Date - 04/09/2015-->
        <if test="TaxPreparationFeesAmt">
            <form id="FSCHA">
                <!--                <copy-of select="@uuid"/>-->
                <apply-templates select="TaxPreparationFeesAmt" mode="Field">
                    <with-param name="tpsId">L21</with-param>
                </apply-templates>
            </form>
        </if>
    </template>

    <!-- Mappings for IRS1095A Fields -->
    <template match="ReturnData/IRS1095A">
        <form id="F1095A">
            <!-- Pass through the uuid if present -->
            <copy-of select="@uuid"/>
            <apply-templates select="PolicyIssuersNamePP" mode="Field">
                <with-param name="tpsId">PAYERNM1</with-param>
            </apply-templates>
            <apply-templates select="Corrected1095AIndPP" mode="BoolToCheckBox">
                <with-param name="tpsId">CORRX</with-param>
            </apply-templates>
            <apply-templates select="MarketplaceIdentiferPP" mode="Field">
                <with-param name="tpsId">PAYERID</with-param>
            </apply-templates>
            <apply-templates select="PolicyStartDatePP" mode="Date">
                <with-param name="tpsId">PLSTDATE</with-param>
            </apply-templates>
            <apply-templates select="PolicyTerminationDatePP" mode="Date">
                <with-param name="tpsId">PLENDATE</with-param>
            </apply-templates>
            <apply-templates select="RecipientFirstNamePP" mode="Field">
                <with-param name="tpsId">RFNAME</with-param>
            </apply-templates>
            <apply-templates select="RecipientLastNamePP" mode="Field">
                <with-param name="tpsId">RLNAME</with-param>
            </apply-templates>
            <apply-templates select="RecipientSSNPP" mode="Field">
                <with-param name="tpsId">RECIPSSN</with-param>
            </apply-templates>
            <apply-templates select="RecipientBirthDtPP" mode="Date">
                <with-param name="tpsId">RDOB</with-param>
            </apply-templates>
            <apply-templates select="RecipientAddressPP/AddressLine1Txt" mode="Field">
                <with-param name="tpsId">RECIPADD</with-param>
            </apply-templates>
            <apply-templates select="RecipientAddressPP/CityNm" mode="Field">
                <with-param name="tpsId">RCTY</with-param>
            </apply-templates>
            <apply-templates select="RecipientAddressPP/StateAbbreviationCd" mode="Field">
                <with-param name="tpsId">RST</with-param>
            </apply-templates>
            <apply-templates select="RecipientAddressPP/ZIPCd" mode="Field">
                <with-param name="tpsId">RZIP</with-param>
            </apply-templates>
            <apply-templates select="RecipientSpouseFirstNamePP" mode="Field">
                <with-param name="tpsId">RSFNAME</with-param>
            </apply-templates>
            <apply-templates select="RecipientSpouseLastNamePP" mode="Field">
                <with-param name="tpsId">RSLNAME</with-param>
            </apply-templates>
            <apply-templates select="RecipientSpouseSSNPP" mode="Field">
                <with-param name="tpsId">RSSSN</with-param>
            </apply-templates>
            <apply-templates select="RecipientSpouseBirthDtPP" mode="Date">
                <with-param name="tpsId">RSDOB</with-param>
            </apply-templates>
            <apply-templates select="MarketAssignedPolicyNumberPP" mode="Field">
                <with-param name="tpsId">PAYPOLID</with-param>
            </apply-templates>
            <apply-templates select="TotalPlanPremiumAmtPP" mode="Field">
                <with-param name="tpsId">TOTPREM</with-param>
            </apply-templates>
            <apply-templates select="TotalPremiumSLCSPAmtPP" mode="Field">
                <with-param name="tpsId">TOTSLCSP</with-param>
            </apply-templates>
            <apply-templates select="TotalAdvancedPTCAmtPP" mode="Field">
                <with-param name="tpsId">ADVCRED</with-param>
            </apply-templates>
            <apply-templates select="HaveOtherCoveredIndivIndPP" mode="YesNoField">
                <with-param name="yTpsId">HOYCIND</with-param>
                <with-param name="nTpsId">HONCIND</with-param>
            </apply-templates>
            <apply-templates select="HaveAnyMoreCoveredIndivIndPP" mode="YesNoField">
                <with-param name="yTpsId">HAMYCIND</with-param>
                <with-param name="nTpsId">HAMNCIND</with-param>
            </apply-templates>
            <apply-templates select="LinkStartMonthNumberCdPP" mode="Field">
                <with-param name="tpsId">STRMTH</with-param>
            </apply-templates>
            <apply-templates select="LinkEndMonthNumberCdPP" mode="Field">
                <with-param name="tpsId">ENDMTH</with-param>
            </apply-templates>
            <if test="count(CoveredIndivInformationPP)>0">
                <table id="CVRGHSLD">
                    <for-each select="CoveredIndivInformationPP">
                        <apply-templates select="." mode="CoveredIndivInformationPP"/>
                    </for-each>
                </table>
            </if>
            <if test="count(MonthlyPTCInformationGrpPP)>0">
                <table id="MNTHLYCV">
                    <apply-templates select="MonthlyPTCInformationGrpPP[MonthCdPP='JANUARY']" mode="MonthlyPTCInformationGrpPP"/>
                    <apply-templates select="MonthlyPTCInformationGrpPP[MonthCdPP='FEBRUARY']" mode="MonthlyPTCInformationGrpPP"/>
                    <apply-templates select="MonthlyPTCInformationGrpPP[MonthCdPP='MARCH']" mode="MonthlyPTCInformationGrpPP"/>
                    <apply-templates select="MonthlyPTCInformationGrpPP[MonthCdPP='APRIL']" mode="MonthlyPTCInformationGrpPP"/>
                    <apply-templates select="MonthlyPTCInformationGrpPP[MonthCdPP='MAY']" mode="MonthlyPTCInformationGrpPP"/>
                    <apply-templates select="MonthlyPTCInformationGrpPP[MonthCdPP='JUNE']" mode="MonthlyPTCInformationGrpPP"/>
                    <apply-templates select="MonthlyPTCInformationGrpPP[MonthCdPP='JULY']" mode="MonthlyPTCInformationGrpPP"/>
                    <apply-templates select="MonthlyPTCInformationGrpPP[MonthCdPP='AUGUST']" mode="MonthlyPTCInformationGrpPP"/>
                    <apply-templates select="MonthlyPTCInformationGrpPP[MonthCdPP='SEPTEMBER']" mode="MonthlyPTCInformationGrpPP"/>
                    <apply-templates select="MonthlyPTCInformationGrpPP[MonthCdPP='OCTOBER']" mode="MonthlyPTCInformationGrpPP"/>
                    <apply-templates select="MonthlyPTCInformationGrpPP[MonthCdPP='NOVEMBER']" mode="MonthlyPTCInformationGrpPP"/>
                    <apply-templates select="MonthlyPTCInformationGrpPP[MonthCdPP='DECEMBER']" mode="MonthlyPTCInformationGrpPP"/>
                </table>
            </if>
            <apply-templates select="SharedPolicyAllocationPP" mode="SharedPolicyAllocationPP"/>

            <apply-templates select="FormCopyKeyForBusinessTypePP" mode="Field">
                <with-param name="tpsId">HACTCOPY</with-param>
            </apply-templates>
            <apply-templates select="BusinessTypeIdPP" mode="Field">
                <with-param name="tpsId">HACTTYPE</with-param>
            </apply-templates>
        </form>
    </template>
    <template match="ReturnData/IRS1095A/MonthlyPTCInformationGrpPP" mode="MonthlyPTCInformationGrpPP">
        <row>
            <copy-of select="@uuid"/>
            <apply-templates select="MonthCdPP" mode="Field">
                <with-param name="tpsId">MONTHCD</with-param>
            </apply-templates>
            <apply-templates select="MonthlyPlanPremiumAmtPP" mode="Field">
                <with-param name="tpsId">MTHPREM</with-param>
            </apply-templates>
            <apply-templates select="MonthlyPremiumSLCSPAmtPP" mode="Field">
                <with-param name="tpsId">MTHSLCSP</with-param>
            </apply-templates>
            <apply-templates select="MonthlyAdvancedPTCAmtPP" mode="Field">
                <with-param name="tpsId">MTHADVCR</with-param>
            </apply-templates>
        </row>
    </template>
    <template match="ReturnData/IRS1095A/CoveredIndivInformationPP" mode="CoveredIndivInformationPP">
        <row>
            <copy-of select="@uuid"/>
            <apply-templates select="CoveredIndivFirstNamePP" mode="Field">
                <with-param name="tpsId">DFNAME</with-param>
            </apply-templates>
            <apply-templates select="CoveredIndivLastNamePP" mode="Field">
                <with-param name="tpsId">DLNAME</with-param>
            </apply-templates>
            <apply-templates select="CoveredIndivSSNPP" mode="Field">
                <with-param name="tpsId">DSSN</with-param>
            </apply-templates>
            <apply-templates select="CoveredIndivBirthDtPP" mode="Date">
                <with-param name="tpsId">DDOB</with-param>
            </apply-templates>
            <apply-templates select="CoveredIndivStartDtPP" mode="Date">
                <with-param name="tpsId">DSTRCVM</with-param>
            </apply-templates>
            <apply-templates select="CoveredIndivEndDtPP" mode="Date">
                <with-param name="tpsId">DENDCVRM</with-param>
            </apply-templates>
        </row>
    </template>
    <template match="ReturnData/IRS1095A/SharedPolicyAllocationPP" mode="SharedPolicyAllocationPP">
        <apply-templates select="SSNPP" mode="Field">
            <with-param name="tpsId">SHPOLSSN</with-param>
        </apply-templates>
        <apply-templates select="StartMonthNumberCdPP" mode="Field">
            <with-param name="tpsId">SHPOLSM</with-param>
        </apply-templates>
        <apply-templates select="EndMonthNumberCdPP" mode="Field">
            <with-param name="tpsId">SHPOLEM</with-param>
        </apply-templates>
        <apply-templates select="MonthlyPremiumPctPP" mode="Field">
            <with-param name="tpsId">SPMPPCT</with-param>
        </apply-templates>
        <apply-templates select="MonthlyPremiumSLCSPPctPP" mode="Field">
            <with-param name="tpsId">SPSLCSPP</with-param>
        </apply-templates>
        <apply-templates select="MonthlyAdvancedPTCPctPP" mode="Field">
            <with-param name="tpsId">SPADVPTC</with-param>
        </apply-templates>
    </template>

    <!-- Mappings for IRS1095B Fields -->
    <template match="ReturnData/IRS1095B">
        <form id="F1095B">
            <!-- Pass through the uuid if present -->
            <copy-of select="@uuid"/>
            <apply-templates select="IssuerOrProviderNamePP" mode="Field">
                <with-param name="tpsId">PAYERNM1</with-param>
            </apply-templates>
            <apply-templates select="IssuerOrProviderAddressPP/AddressLine1Txt"
                                 mode="Field">
                <with-param name="tpsId">PAYADD1</with-param>
            </apply-templates>
            <apply-templates select="IssuerOrProviderAddressPP/CityNm" mode="Field">
                <with-param name="tpsId">PCTY</with-param>
            </apply-templates>
            <apply-templates select="IssuerOrProviderAddressPP/StateAbbreviationCd"
                                 mode="Field">
                <with-param name="tpsId">PST</with-param>
            </apply-templates>
            <apply-templates select="IssuerOrProviderAddressPP/ZIPCd" mode="Field">
                <with-param name="tpsId">PZIP</with-param>
            </apply-templates>
            <apply-templates select="IssuerOrProviderEINPP" mode="Field">
                <with-param name="tpsId">PAYERID</with-param>
            </apply-templates>
            <apply-templates select="ContactPersonPhonePP" mode="Field">
                <with-param name="tpsId">PCONPHON</with-param>
            </apply-templates>
            <apply-templates select="OriginOfPolicyCdPP" mode="Field">
                <with-param name="tpsId">POLORGCD</with-param>
            </apply-templates>
            <apply-templates select="EmployerNamePP" mode="Field">
                <with-param name="tpsId">EMPNAME</with-param>
            </apply-templates>
            <apply-templates select="EmployerAddressPP/AddressLine1Txt" mode="Field">
                <with-param name="tpsId">EADDRESS</with-param>
            </apply-templates>
            <apply-templates select="EmployerAddressPP/CityNm" mode="Field">
                <with-param name="tpsId">ECTY</with-param>
            </apply-templates>
            <apply-templates select="EmployerAddressPP/StateAbbreviationCd" mode="Field">
                <with-param name="tpsId">EST</with-param>
            </apply-templates>
            <apply-templates select="EmployerAddressPP/ZIPCd" mode="Field">
                <with-param name="tpsId">EZIP</with-param>
            </apply-templates>
            <apply-templates select="EmployerEINPP" mode="Field">
                <with-param name="tpsId">EMPLOYID</with-param>
            </apply-templates>
            <apply-templates select="PlanIsSHOPIndPP" mode="Field">
                <with-param name="tpsId">SHOPPLAN</with-param>
            </apply-templates>
            <apply-templates select="SHOPIdentifierPP" mode="Field">
                <with-param name="tpsId">SHOPPLID</with-param>
            </apply-templates>
            <apply-templates select="ResponsibleIndivNamePP" mode="Field">
                <with-param name="tpsId">RECIPNAM</with-param>
            </apply-templates>
            <apply-templates select="ResponsibleIndivAddressPP/AddressLine1Txt" mode="Field">
                <with-param name="tpsId">RECIPADD</with-param>
            </apply-templates>
            <apply-templates select="ResponsibleIndivAddressPP/CityNm" mode="Field">
                <with-param name="tpsId">RCTY</with-param>
            </apply-templates>
            <apply-templates select="ResponsibleIndivAddressPP/StateAbbreviationCd"
                                 mode="Field">
                <with-param name="tpsId">RST</with-param>
            </apply-templates>
            <apply-templates select="ResponsibleIndivAddressPP/ZIPCd" mode="Field">
                <with-param name="tpsId">RZIP</with-param>
            </apply-templates>
            <apply-templates select="ResponsibleIndivSSNPP" mode="Field">
                <with-param name="tpsId">RECIPSSN</with-param>
            </apply-templates>
            <apply-templates select="ResponsibleIndivBirthDtPP" mode="Date">
                <with-param name="tpsId">RDOB</with-param>
            </apply-templates>
            <apply-templates select="HaveOtherCoveredIndivIndPP" mode="YesNoField">
                <with-param name="yTpsId">HOYCIND</with-param>
                <with-param name="nTpsId">HONCIND</with-param>
            </apply-templates>
            <apply-templates select="HaveAnyMoreCoveredIndivIndPP" mode="YesNoField">
                <with-param name="yTpsId">HAMYCIND</with-param>
                <with-param name="nTpsId">HAMNCIND</with-param>
            </apply-templates>
            <if test="count(CoveredIndivGrpPP)>0">
                <table id="COVINDIV">
                    <for-each select="CoveredIndivGrpPP">
                        <apply-templates select="." mode="CoveredIndivGrpPP"/>
                    </for-each>
                </table>
            </if>
        </form>
    </template>
    <template match="ReturnData/IRS1095B/CoveredIndivGrpPP" mode="CoveredIndivGrpPP">
        <row>
            <copy-of select="@uuid"/>
            <apply-templates select="PersonNmPP" mode="Field">
                <with-param name="tpsId">COVFNAM</with-param>
            </apply-templates>
            <apply-templates select="SSNPP" mode="Field">
                <with-param name="tpsId">COVSSN</with-param>
            </apply-templates>
            <apply-templates select="PersonBirthDtPP" mode="Date">
                <with-param name="tpsId">COVDOB</with-param>
            </apply-templates>
            <apply-templates select="AllYearIndPP" mode="Field">
                <with-param name="tpsId">COV12MTH</with-param>
            </apply-templates>
            <apply-templates select="JanuaryIndPP" mode="Field">
                <with-param name="tpsId">CIM1</with-param>
            </apply-templates>
            <apply-templates select="FebruaryIndPP" mode="Field">
                <with-param name="tpsId">CIM2</with-param>
            </apply-templates>
            <apply-templates select="MarchIndPP" mode="Field">
                <with-param name="tpsId">CIM3</with-param>
            </apply-templates>
            <apply-templates select="AprilIndPP" mode="Field">
                <with-param name="tpsId">CIM4</with-param>
            </apply-templates>
            <apply-templates select="MayIndPP" mode="Field">
                <with-param name="tpsId">CIM5</with-param>
            </apply-templates>
            <apply-templates select="JuneIndPP" mode="Field">
                <with-param name="tpsId">CIM6</with-param>
            </apply-templates>
            <apply-templates select="JulyIndPP" mode="Field">
                <with-param name="tpsId">CIM7</with-param>
            </apply-templates>
            <apply-templates select="AugustIndPP" mode="Field">
                <with-param name="tpsId">CIM8</with-param>
            </apply-templates>
            <apply-templates select="SeptemberIndPP" mode="Field">
                <with-param name="tpsId">CIM9</with-param>
            </apply-templates>
            <apply-templates select="OctoberIndPP" mode="Field">
                <with-param name="tpsId">CIM10</with-param>
            </apply-templates>
            <apply-templates select="NovemberIndPP" mode="Field">
                <with-param name="tpsId">CIM11</with-param>
            </apply-templates>
            <apply-templates select="DecemberIndPP" mode="Field">
                <with-param name="tpsId">CIM12</with-param>
            </apply-templates>
        </row>
    </template>

    <!-- Mappings for IRS1095C Fields -->
    <template match="ReturnData/IRS1095C">
        <form id="F1095C">
            <!-- Pass through the uuid if present -->
            <copy-of select="@uuid"/>
            <apply-templates select="ALENamePP" mode="Field">
                <with-param name="tpsId">ERNAME</with-param>
            </apply-templates>
            <apply-templates select="ALEEINPP" mode="Field">
                <with-param name="tpsId">ERID</with-param>
            </apply-templates>
            <apply-templates select="ALEPhoneNumberPP" mode="Field">
                <with-param name="tpsId">ERPHONE</with-param>
            </apply-templates>
            <apply-templates select="EmployeeNamePP" mode="Field">
                <with-param name="tpsId">EEFNAME</with-param>
            </apply-templates>
            <apply-templates select="EmployeeSSNPP" mode="Field">
                <with-param name="tpsId">EESSN</with-param>
            </apply-templates>
            <apply-templates select="EmployeeAddressPP/AddressLine1Txt" mode="Field">
                <with-param name="tpsId">EEADDRES</with-param>
            </apply-templates>
            <apply-templates select="EmployeeAddressPP/CityNm" mode="Field">
                <with-param name="tpsId">EECTY</with-param>
            </apply-templates>
            <apply-templates select="EmployeeAddressPP/StateAbbreviationCd" mode="Field">
                <with-param name="tpsId">EEST</with-param>
            </apply-templates>
            <apply-templates select="EmployeeAddressPP/ZIPCd" mode="Field">
                <with-param name="tpsId">EEZIP</with-param>
            </apply-templates>
            <apply-templates select="ALEAddressPP/AddressLine1Txt" mode="Field">
                <with-param name="tpsId">ERADDRES</with-param>
            </apply-templates>
            <apply-templates select="ALEAddressPP/CityNm" mode="Field">
                <with-param name="tpsId">ERCTY</with-param>
            </apply-templates>
            <apply-templates select="ALEAddressPP/StateAbbreviationCd" mode="Field">
                <with-param name="tpsId">ERST</with-param>
            </apply-templates>
            <apply-templates select="ALEAddressPP/ZIPCd" mode="Field">
                <with-param name="tpsId">ERZIP</with-param>
            </apply-templates>
            <apply-templates select="AnnualCoverageOfferedCdPP" mode="Field">
                <with-param name="tpsId">AOFRCOV</with-param>
            </apply-templates>
            <apply-templates select="AnnualMonthlyPremiumAmtPP" mode="Field">
                <with-param name="tpsId">AESHRPR</with-param>
            </apply-templates>
            <apply-templates select="AnnualSafeHarborCdPP" mode="Field">
                <with-param name="tpsId">ASFHARBR</with-param>
            </apply-templates>
            <apply-templates select="HaveOtherCoveredIndivIndPP" mode="YesNoField">
                <with-param name="yTpsId">HOYCIND</with-param>
                <with-param name="nTpsId">HONCIND</with-param>
            </apply-templates>
            <apply-templates select="HaveAnyMoreCoveredIndivIndPP" mode="YesNoField">
                <with-param name="yTpsId">HAMYCIND</with-param>
                <with-param name="nTpsId">HAMNCIND</with-param>
            </apply-templates>
            <if test="count(CoveredIndivGrpPP)>0">
                <table id="COVINDIV">
                    <for-each select="CoveredIndivGrpPP">
                        <apply-templates select="." mode="CoveredIndivGrpPP"/>
                    </for-each>
                </table>
            </if>
            <if test="count(PartIIGrpPP)>0">
                <table id="MNTHLY">
                    <apply-templates select="PartIIGrpPP[MonthNamePP='JANUARY']" mode="PartIIGrpPP"/>
                    <apply-templates select="PartIIGrpPP[MonthNamePP='FEBRUARY']" mode="PartIIGrpPP"/>
                    <apply-templates select="PartIIGrpPP[MonthNamePP='MARCH']" mode="PartIIGrpPP"/>
                    <apply-templates select="PartIIGrpPP[MonthNamePP='APRIL']" mode="PartIIGrpPP"/>
                    <apply-templates select="PartIIGrpPP[MonthNamePP='MAY']" mode="PartIIGrpPP"/>
                    <apply-templates select="PartIIGrpPP[MonthNamePP='JUNE']" mode="PartIIGrpPP"/>
                    <apply-templates select="PartIIGrpPP[MonthNamePP='JULY']" mode="PartIIGrpPP"/>
                    <apply-templates select="PartIIGrpPP[MonthNamePP='AUGUST']" mode="PartIIGrpPP"/>
                    <apply-templates select="PartIIGrpPP[MonthNamePP='SEPTEMBER']" mode="PartIIGrpPP"/>
                    <apply-templates select="PartIIGrpPP[MonthNamePP='OCTOBER']" mode="PartIIGrpPP"/>
                    <apply-templates select="PartIIGrpPP[MonthNamePP='NOVEMBER']" mode="PartIIGrpPP"/>
                    <apply-templates select="PartIIGrpPP[MonthNamePP='DECEMBER']" mode="PartIIGrpPP"/>
                </table>
            </if>
        </form>
    </template>
    <template match="ReturnData/IRS1095C/CoveredIndivGrpPP" mode="CoveredIndivGrpPP">
        <row>
            <copy-of select="@uuid"/>
            <apply-templates select="PersonNmPP" mode="Field">
                <with-param name="tpsId">COVFNAM</with-param>
            </apply-templates>
            <apply-templates select="SSNPP" mode="Field">
                <with-param name="tpsId">COVSSN</with-param>
            </apply-templates>
            <apply-templates select="PersonBirthDtPP" mode="Date">
                <with-param name="tpsId">COVDOB</with-param>
            </apply-templates>
            <apply-templates select="AllYearIndPP" mode="Field">
                <with-param name="tpsId">COV12MTH</with-param>
            </apply-templates>
            <apply-templates select="JanuaryIndPP" mode="Field">
                <with-param name="tpsId">CIMJAN</with-param>
            </apply-templates>
            <apply-templates select="FebruaryIndPP" mode="Field">
                <with-param name="tpsId">CIMFEB</with-param>
            </apply-templates>
            <apply-templates select="MarchIndPP" mode="Field">
                <with-param name="tpsId">CIMMAR</with-param>
            </apply-templates>
            <apply-templates select="AprilIndPP" mode="Field">
                <with-param name="tpsId">CIMAPR</with-param>
            </apply-templates>
            <apply-templates select="MayIndPP" mode="Field">
                <with-param name="tpsId">CIMMAY</with-param>
            </apply-templates>
            <apply-templates select="JuneIndPP" mode="Field">
                <with-param name="tpsId">CIMJUN</with-param>
            </apply-templates>
            <apply-templates select="JulyIndPP" mode="Field">
                <with-param name="tpsId">CIMJUL</with-param>
            </apply-templates>
            <apply-templates select="AugustIndPP" mode="Field">
                <with-param name="tpsId">CIMAUG</with-param>
            </apply-templates>
            <apply-templates select="SeptemberIndPP" mode="Field">
                <with-param name="tpsId">CIMSEP</with-param>
            </apply-templates>
            <apply-templates select="OctoberIndPP" mode="Field">
                <with-param name="tpsId">CIMOCT</with-param>
            </apply-templates>
            <apply-templates select="NovemberIndPP" mode="Field">
                <with-param name="tpsId">CIMNOV</with-param>
            </apply-templates>
            <apply-templates select="DecemberIndPP" mode="Field">
                <with-param name="tpsId">CIMDEC</with-param>
            </apply-templates>
        </row>
    </template>
    <template match="ReturnData/IRS1095C/PartIIGrpPP" mode="PartIIGrpPP">
        <row>
            <copy-of select="@uuid"/>
            <apply-templates select="MonthNamePP" mode="Field">
                <with-param name="tpsId">MONTHCD</with-param>
            </apply-templates>
            <apply-templates select="CoverageOfferedCdPP" mode="Field">
                <with-param name="tpsId">OFRCOV</with-param>
            </apply-templates>
            <apply-templates select="MonthlyPremiumAmtPP" mode="Field">
                <with-param name="tpsId">ESHRPREM</with-param>
            </apply-templates>
            <apply-templates select="SafeHarborCdPP" mode="Field">
                <with-param name="tpsId">SFHARBOR</with-param>
            </apply-templates>
        </row>
    </template>

    <!-- Mappings for IRS1095Other Fields -->
    <template match="ReturnData/IRS1095Other">
        <form id="F1095OTH">
            <!-- Pass through the uuid if present -->
            <copy-of select="@uuid"/>
            <apply-templates select="HaveOtherCoveredIndivIndPP" mode="YesNoField">
                <with-param name="yTpsId">HOYCIND</with-param>
                <with-param name="nTpsId">HONCIND</with-param>
            </apply-templates>
            <apply-templates select="HaveAnyMoreCoveredIndivIndPP" mode="YesNoField">
                <with-param name="yTpsId">HAMYCIND</with-param>
                <with-param name="nTpsId">HAMNCIND</with-param>
            </apply-templates>
            <if test="count(CoveredIndivGrpPP)>0">
                <table id="COVINDIV">
                    <for-each select="CoveredIndivGrpPP">
                        <apply-templates select="." mode="CoveredIndivGrpPP"/>
                    </for-each>
                </table>
            </if>
        </form>
    </template>
    <template match="ReturnData/IRS1095Other/CoveredIndivGrpPP" mode="CoveredIndivGrpPP">
        <row>
            <copy-of select="@uuid"/>
            <apply-templates select="PersonNmPP" mode="Field">
                <with-param name="tpsId">COVFNAM</with-param>
            </apply-templates>
            <apply-templates select="SSNPP" mode="Field">
                <with-param name="tpsId">COVSSN</with-param>
            </apply-templates>
            <apply-templates select="PersonBirthDtPP" mode="Date">
                <with-param name="tpsId">COVDOB</with-param>
            </apply-templates>
            <apply-templates select="AllYearIndPP" mode="Field">
                <with-param name="tpsId">COV12MTH</with-param>
            </apply-templates>
            <apply-templates select="JanuaryIndPP" mode="Field">
                <with-param name="tpsId">CIMJAN</with-param>
            </apply-templates>
            <apply-templates select="FebruaryIndPP" mode="Field">
                <with-param name="tpsId">CIMFEB</with-param>
            </apply-templates>
            <apply-templates select="MarchIndPP" mode="Field">
                <with-param name="tpsId">CIMMAR</with-param>
            </apply-templates>
            <apply-templates select="AprilIndPP" mode="Field">
                <with-param name="tpsId">CIMAPR</with-param>
            </apply-templates>
            <apply-templates select="MayIndPP" mode="Field">
                <with-param name="tpsId">CIMMAY</with-param>
            </apply-templates>
            <apply-templates select="JuneIndPP" mode="Field">
                <with-param name="tpsId">CIMJUN</with-param>
            </apply-templates>
            <apply-templates select="JulyIndPP" mode="Field">
                <with-param name="tpsId">CIMJUL</with-param>
            </apply-templates>
            <apply-templates select="AugustIndPP" mode="Field">
                <with-param name="tpsId">CIMAUG</with-param>
            </apply-templates>
            <apply-templates select="SeptemberIndPP" mode="Field">
                <with-param name="tpsId">CIMSEP</with-param>
            </apply-templates>
            <apply-templates select="OctoberIndPP" mode="Field">
                <with-param name="tpsId">CIMOCT</with-param>
            </apply-templates>
            <apply-templates select="NovemberIndPP" mode="Field">
                <with-param name="tpsId">CIMNOV</with-param>
            </apply-templates>
            <apply-templates select="DecemberIndPP" mode="Field">
                <with-param name="tpsId">CIMDEC</with-param>
            </apply-templates>
        </row>
    </template>

    <!-- Mappings for IRS8962 Fields -->
    <template match="ReturnData/IRS8962">
        <form id="F8962">
            <copy-of select="@uuid"/>
            <apply-templates select="ReliefInd" mode="Field">
                <with-param name="tpsId">HSHIPIND</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="TotalExemptionsCnt" mode="Field">
                <with-param name="tpsId">TOTEXCNT</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="ModifiedAGIAmt" mode="Field">
                <with-param name="tpsId">MODAGI</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="TotalDependentsModifiedAGIAmt" mode="Field">
                <with-param name="tpsId">DMODAGI</with-param>
            </apply-templates>
            <apply-templates select="HouseholdIncomeAmt" mode="Field">
                <with-param name="tpsId">HSHLDINC</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="PovertyLevelAmt" mode="Field">
                <with-param name="tpsId">PVRTYLVL</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="FederalPovertyTableLocCd[child::text()='A']" mode="EnumField">
                <with-param name="tpsId">AK</with-param>
                <with-param name="fieldValue">X</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="FederalPovertyTableLocCd[child::text()='B']" mode="EnumField">
                <with-param name="tpsId">HI</with-param>
                <with-param name="fieldValue">X</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="FederalPovertyTableLocCd[child::text()='C']" mode="EnumField">
                <with-param name="tpsId">OTH48DC</with-param>
                <with-param name="fieldValue">X</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="FederalPovertyLevelPct" mode="Field">
                <with-param name="tpsId">PVRTYPCT</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="HshldIncmBelowPTCThresholdInd" mode="YesNoField">
                <with-param name="yTpsId">HILTPVRT</with-param>
                <with-param name="nTpsId">M400PCT</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="ApplicableFigureRt" mode="Field">
                <with-param name="tpsId">APPFIGRT</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="AnnualContributionAmt" mode="Field">
                <with-param name="tpsId">ANNCONTR</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyContriHealthCareCvrAmt" mode="Field">
                <with-param name="tpsId">MTHCONTR</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="SharePolicyMarriedAltCalcInd" mode="YesNoField">
                <with-param name="yTpsId">APORACMI</with-param>
                <with-param name="nTpsId">APRACMIN</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="Form1095ASameMonthlyAmtInd" mode="YesNoField">
                <with-param name="yTpsId">F1095ASM</with-param>
                <with-param name="nTpsId">F1095ANO</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="AnnualPTCCalculationGrp/AnnualPremiumAmt" mode="Field">
                <with-param name="tpsId">ANNPREM</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="AnnualPTCCalculationGrp/AnnualPremiumSLCSPAmt" mode="Field">
                <with-param name="tpsId">APSLCSP</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="AnnualPTCCalculationGrp/AnnualContributionAmt" mode="Field">
                <with-param name="tpsId">ANNCONT</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="AnnualPTCCalculationGrp/AnnualMaxPremiumAssistanceAmt" mode="Field">
                <with-param name="tpsId">ANNMXAST</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="AnnualPTCCalculationGrp/AnnualPremiumTaxCreditAllwAmt" mode="Field">
                <with-param name="tpsId">ANNTXCR</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="AnnualPTCCalculationGrp/AnnualAdvancedPTCAmt" mode="Field">
                <with-param name="tpsId">ANNADVCR</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="TotalPremiumTaxCreditAmt" mode="Field">
                <with-param name="tpsId">TOTPTC</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="TotalAdvancedPTCAmt" mode="Field">
                <with-param name="tpsId">TOTADPTC</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="ReconciledPremiumTaxCreditAmt" mode="Field">
                <with-param name="tpsId">RECONPTC</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="ExcessAdvncPaymentAmt" mode="Field">
                <with-param name="tpsId">EXADVPMT</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="AdditionalTaxLimitationAmt" mode="Field">
                <with-param name="tpsId">ADDTXLIM</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="PremiumTaxCreditTaxLiabAmt" mode="Field">
                <with-param name="tpsId">PTCLIABL</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="SharedPolicyAllocationInfoInd" mode="YesNoField">
                <with-param name="yTpsId">SPALLIND</with-param>
                <with-param name="nTpsId">SPALLNO</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="AltCalcForMarriagePrimaryGrp/FamilySizeCnt" mode="Field">
                <with-param name="tpsId">TPFAMSZ</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="AltCalcForMarriagePrimaryGrp/MonthlyContributionAmt" mode="Field">
                <with-param name="tpsId">TPMTHCNT</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="AltCalcForMarriagePrimaryGrp/StartMonthNumberCd" mode="Field">
                <with-param name="tpsId">TPSTRMTH</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="AltCalcForMarriagePrimaryGrp/EndMonthNumberCd" mode="Field">
                <with-param name="tpsId">TPENDMTH</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="AltCalcForMarriageSpouseGrp/FamilySizeCnt" mode="Field">
                <with-param name="tpsId">SPFAMSZ</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="AltCalcForMarriageSpouseGrp/MonthlyContributionAmt" mode="Field">
                <with-param name="tpsId">SPMTHCNT</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="AltCalcForMarriageSpouseGrp/StartMonthNumberCd" mode="Field">
                <with-param name="tpsId">SPSTRMTH</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="AltCalcForMarriageSpouseGrp/EndMonthNumberCd" mode="Field">
                <with-param name="tpsId">SPENDMTH</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="AltCalcForMarriageInputsPrimaryCalcGrpPP/FamilySizeCntPP" mode="Field">
                <with-param name="tpsId">ATFAMSZ</with-param>
            </apply-templates>
            <apply-templates select="AltCalcForMarriageInputsPrimaryCalcGrpPP/StartMonthNumberCdPP" mode="Field">
                <with-param name="tpsId">ATSTRMTH</with-param>
            </apply-templates>
            <apply-templates select="AltCalcForMarriageInputsPrimaryCalcGrpPP/EndMonthNumberCdPP" mode="Field">
                <with-param name="tpsId">ATENDMTH</with-param>
            </apply-templates>
            <apply-templates select="AltCalcForMarriageInputsSpouseCalcGrpPP/FamilySizeCntPP" mode="Field">
                <with-param name="tpsId">ASFAMSZ</with-param>
            </apply-templates>
            <apply-templates select="AltCalcForMarriageInputsSpouseCalcGrpPP/StartMonthNumberCdPP" mode="Field">
                <with-param name="tpsId">ASSTRMTH</with-param>
            </apply-templates>
            <apply-templates select="AltCalcForMarriageInputsSpouseCalcGrpPP/EndMonthNumberCdPP" mode="Field">
                <with-param name="tpsId">ASENDMTH</with-param>
            </apply-templates>
            <apply-templates select="PartOfReturnPP" mode="Boolean01">
                <with-param name="tpsId">__POR__</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="SelfEmployedHealthInsDedAmtPP" mode="Field">
                <with-param name="tpsId">SEIDTOTA</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="SelfEmployedExchangeHealthInsDedAmtPP" mode="Field">
                <with-param name="tpsId">SEIDEXCH</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="ACAPTCRefundMonitorControlPP" mode="YesNoField">
                <with-param name="yTpsId">HCPTCY</with-param>
                <with-param name="nTpsId">HCPTCN</with-param>
            </apply-templates>

            <!-- New 12/15/2014 -->
            <apply-templates select="ExchangeHealthInsItemizedDedAmtPP" mode="Field">
                <with-param name="tpsId">SEIDOVER</with-param>
            </apply-templates>
            <apply-templates select="StateSelfEmployedExchangeHealthInsDedAmtPP" mode="Field">
                <with-param name="tpsId">SEIDSTEX</with-param>
            </apply-templates>
            <apply-templates select="StateExchangeHealthInsItemizedDedAmtPP" mode="Field">
                <with-param name="tpsId">SEIDSTOV</with-param>
            </apply-templates>
            <apply-templates select="MonthOfMarriagePP" mode="Field">
                <with-param name="tpsId">MARDATE</with-param>
            </apply-templates>
            <apply-templates select="SpousalAbuseIndPP" mode="YesNoField">
                <with-param name="yTpsId">SPABUSEY</with-param>
                <with-param name="nTpsId">SPABUSEN</with-param>
            </apply-templates>


            <if test="count(MonthlyPTCCalculationGrp)>0">
                <table id="MNTHGRP">
                    <apply-templates select="MonthlyPTCCalculationGrp[MonthCd='JANUARY']" mode="MonthlyPTCCalculationGrp"/>
                    <apply-templates select="MonthlyPTCCalculationGrp[MonthCd='FEBRUARY']" mode="MonthlyPTCCalculationGrp"/>
                    <apply-templates select="MonthlyPTCCalculationGrp[MonthCd='MARCH']" mode="MonthlyPTCCalculationGrp"/>
                    <apply-templates select="MonthlyPTCCalculationGrp[MonthCd='APRIL']" mode="MonthlyPTCCalculationGrp"/>
                    <apply-templates select="MonthlyPTCCalculationGrp[MonthCd='MAY']" mode="MonthlyPTCCalculationGrp"/>
                    <apply-templates select="MonthlyPTCCalculationGrp[MonthCd='JUNE']" mode="MonthlyPTCCalculationGrp"/>
                    <apply-templates select="MonthlyPTCCalculationGrp[MonthCd='JULY']" mode="MonthlyPTCCalculationGrp"/>
                    <apply-templates select="MonthlyPTCCalculationGrp[MonthCd='AUGUST']" mode="MonthlyPTCCalculationGrp"/>
                    <apply-templates select="MonthlyPTCCalculationGrp[MonthCd='SEPTEMBER']" mode="MonthlyPTCCalculationGrp"/>
                    <apply-templates select="MonthlyPTCCalculationGrp[MonthCd='OCTOBER']" mode="MonthlyPTCCalculationGrp"/>
                    <apply-templates select="MonthlyPTCCalculationGrp[MonthCd='NOVEMBER']" mode="MonthlyPTCCalculationGrp"/>
                    <apply-templates select="MonthlyPTCCalculationGrp[MonthCd='DECEMBER']" mode="MonthlyPTCCalculationGrp"/>
                </table>
            </if>
            <if test="count(SharedPolicyAllocationGrp)>0">
                <table id="SHDPOLAL">
                    <apply-templates select="SharedPolicyAllocationGrp" mode="SharedPolicyAllocationGrp"/>
                </table>
            </if>
            <apply-templates select="AltCalcForMarriageEligibilityWksPP" mode="AltCalcForMarriageEligibilityWksPP"/>
            <apply-templates select="SelfEmploymentCalculationDataPP" mode="SelfEmploymentCalculationDataPP"/>
        </form>
    </template>
    <template match="ReturnData/IRS8962/MonthlyPTCCalculationGrp" mode="MonthlyPTCCalculationGrp">
        <row>
            <copy-of select="@uuid"/>
            <apply-templates select="MonthCd" mode="Field">
                <with-param name="tpsId">MONTHCD</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyPremiumAmt" mode="Field">
                <with-param name="tpsId">MTHPREM</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyPremiumSLCSPAmt" mode="Field">
                <with-param name="tpsId">MTHSLCSP</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyContributionAmt" mode="Field">
                <with-param name="tpsId">MTHCONT</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyMaxPremiumAssistanceAmt" mode="Field">
                <with-param name="tpsId">MTHMXAST</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyPremiumTaxCreditAllwAmt" mode="Field">
                <with-param name="tpsId">MTHTXCR</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyAdvancedPTCAmt" mode="Field">
                <with-param name="tpsId">MTHADVCR</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
        </row>
    </template>
    <template match="ReturnData/IRS8962/SharedPolicyAllocationGrp" mode="SharedPolicyAllocationGrp">
        <row>
            <copy-of select="@uuid"/>
            <!--<apply-templates select="GroupNumberCd" mode="Field">
                <with-param name="tpsId">GRPNUM</with-param>
            </apply-templates>-->
            <apply-templates select="PolicyNum" mode="Field">
                <with-param name="tpsId">POLCYNUM</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="SSN" mode="Field">
                <with-param name="tpsId">SHPOLSSN</with-param>
            </apply-templates>
            <apply-templates select="StartMonthNumberCd" mode="Field">
                <with-param name="tpsId">SHPOLSM</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="EndMonthNumberCd" mode="Field">
                <with-param name="tpsId">SHPOLEM</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyPremiumPct" mode="Field">
                <with-param name="tpsId">SPMPPCT</with-param>
            </apply-templates>
            <apply-templates select="MonthlyPremiumSLCSPPct" mode="Field">
                <with-param name="tpsId">SPSLCSPP</with-param>
            </apply-templates>
            <apply-templates select="MonthlyAdvancedPTCPct" mode="Field">
                <with-param name="tpsId">SPADVPTC</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
        </row>
    </template>
    <template match="ReturnData/IRS8962/AltCalcForMarriageEligibilityWksPP" mode="AltCalcForMarriageEligibilityWksPP">
        <apply-templates select="TotalPremiumTaxCreditAmtPP" mode="Field">
            <with-param name="tpsId">ATMTXCR</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="TotalAdvancedPTCAmtPP" mode="Field">
            <with-param name="tpsId">ATMADVCR</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="EligibilityIndPP" mode="YesNoField">
            <with-param name="yTpsId">YESINC</with-param>
            <with-param name="nTpsId">NOINC</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="AltCalcForMarriageEligibilityGrpPP" mode="AltCalcForMarriageEligibilityGrpPP"/>
    </template>
    <template match="ReturnData/IRS8962/AltCalcForMarriageEligibilityWksPP/AltCalcForMarriageEligibilityGrpPP" mode="AltCalcForMarriageEligibilityGrpPP">
        <table id="AMNTHGRP">
            <apply-templates select="MonthlyAltCalcForMarriageEligibilityPP[translate(MonthCdPP,'january','JANUARY')='JANUARY']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
            <apply-templates select="MonthlyAltCalcForMarriageEligibilityPP[translate(MonthCdPP,'february','FEBRUARY')='FEBRUARY']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
            <apply-templates select="MonthlyAltCalcForMarriageEligibilityPP[translate(MonthCdPP,'march','MARCH')='MARCH']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
            <apply-templates select="MonthlyAltCalcForMarriageEligibilityPP[translate(MonthCdPP,'april','APRIL')='APRIL']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
            <apply-templates select="MonthlyAltCalcForMarriageEligibilityPP[translate(MonthCdPP,'may','MAY')='MAY']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
            <apply-templates select="MonthlyAltCalcForMarriageEligibilityPP[translate(MonthCdPP,'june','JUNE')='JUNE']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
            <apply-templates select="MonthlyAltCalcForMarriageEligibilityPP[translate(MonthCdPP,'july','JULY')='JULY']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
            <apply-templates select="MonthlyAltCalcForMarriageEligibilityPP[translate(MonthCdPP,'august','AUGUST')='AUGUST']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
            <apply-templates select="MonthlyAltCalcForMarriageEligibilityPP[translate(MonthCdPP,'september','SEPTEMBER')='SEPTEMBER']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
            <apply-templates select="MonthlyAltCalcForMarriageEligibilityPP[translate(MonthCdPP,'october','OCTOBER')='OCTOBER']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
            <apply-templates select="MonthlyAltCalcForMarriageEligibilityPP[translate(MonthCdPP,'november','NOVEMBER')='NOVEMBER']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
            <apply-templates select="MonthlyAltCalcForMarriageEligibilityPP[translate(MonthCdPP,'december','DECEMBER')='DECEMBER']" mode="MonthlyAltCalcForMarriageEligibilityPP"/>
        </table>
    </template>
    <template match="ReturnData/IRS8962/AltCalcForMarriageEligibilityWksPP/AltCalcForMarriageEligibilityGrpPP/MonthlyAltCalcForMarriageEligibilityPP" mode="MonthlyAltCalcForMarriageEligibilityPP">
        <row>
            <copy-of select="@uuid"/>
            <apply-templates select="MonthCdPP" mode="Field">
                <with-param name="tpsId">AMONTHCD</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyPremiumAmtPP" mode="Field">
                <with-param name="tpsId">AMTHPREM</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyPremiumSLCSPAmtPP" mode="Field">
                <with-param name="tpsId">AMTSLCSP</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyContributionAmtPP" mode="Field">
                <with-param name="tpsId">AMTHCONT</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyMaxPremiumAssistanceAmtPP" mode="Field">
                <with-param name="tpsId">AMTMXAST</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyPremiumTaxCreditAllwAmtPP" mode="Field">
                <with-param name="tpsId">AMTHTXCR</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyAdvancedPTCAmtPP" mode="Field">
                <with-param name="tpsId">AMTADVCR</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
        </row>
    </template>
    <template match="ReturnData/IRS8962/SelfEmploymentCalculationDataPP" mode="SelfEmploymentCalculationDataPP">
        <apply-templates select="NextIterationSetDeductionBlankPP" mode="Boolean01">
            <with-param name="tpsId">HBLANKNI</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="NextExchangeSelfEmploymentDeductionPP" mode="Field">
            <with-param name="tpsId">HSEDNEXT</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="NextIterationNumberPP" mode="Field">
            <with-param name="tpsId">HNUMNI</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="NextLastIterationDeductionPP" mode="Field">
            <with-param name="tpsId">HDEDNLI</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="NextLastIterationPTCPP" mode="Field">
            <with-param name="tpsId">HPTCNLI</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="NextAlternateDeductionPP" mode="Field">
            <with-param name="tpsId">HDEDNA</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
    </template>

    <!-- Mappings for IRS8965 Fields -->
    <template match="ReturnData/IRS8965">
        <form id="F8965">
            <copy-of select="@uuid"/>
            <apply-templates select="HsldIncmBelowFlngThresholdInd" mode="YesNoField">
                <with-param name="yTpsId">HIBELFTY</with-param>
                <with-param name="nTpsId">HIBELFTN</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="GrossIncmBelowFlngThresholdInd" mode="YesNoField">
                <with-param name="yTpsId">GIBELFTY</with-param>
                <with-param name="nTpsId">GIBELFTN</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="PartOfReturnPP" mode="Boolean01">
                <with-param name="tpsId">__POR__</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="HealthCareRspnsCoverageIndPP" mode="YesNoField">
                <with-param name="yTpsId">HCCVINDY</with-param>
                <with-param name="nTpsId">HCCVINDN</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="HaveAnyObtainedExemption" mode="YesNoField">
                <with-param name="yTpsId">HANYOBY</with-param>
                <with-param name="nTpsId">HANYOBN</with-param>
            </apply-templates>
            <apply-templates select="HaveAnyMoreObtainedExemption" mode="YesNoField">
                <with-param name="yTpsId">HMOROBY</with-param>
                <with-param name="nTpsId">HMOROBN</with-param>
            </apply-templates>
            <apply-templates select="HaveAnyRequestExemption" mode="YesNoField">
                <with-param name="yTpsId">HANYRQY</with-param>
                <with-param name="nTpsId">HANYRQN</with-param>
            </apply-templates>
            <apply-templates select="HaveAnyMoreRequestExemption" mode="YesNoField">
                <with-param name="yTpsId">HMORRQY</with-param>
                <with-param name="nTpsId">HMORRQN</with-param>
            </apply-templates>
            <apply-templates select="ACARefundMonitorControlPP" mode="YesNoField">
                <with-param name="yTpsId">HSHDRSPC</with-param>
                <with-param name="nTpsId">HSHDRSPN</with-param>
            </apply-templates>
            <apply-templates select="TotalDependentsModifiedAGIAmtPP" mode="Field">
                <with-param name="tpsId">DEMODAGI</with-param>
            </apply-templates>
            <if test="count(ObtndExemptCvrTaxHsldGrp)>0">
                <table id="OBTNEXEM">
                    <apply-templates select="ObtndExemptCvrTaxHsldGrp" mode="ObtndExemptCvrTaxHsldGrp"/>
                </table>
            </if>
            <if test="count(RequestExemptCvrTaxHsldGrp)>0">
                <table id="RECTHG">
                    <apply-templates select="RequestExemptCvrTaxHsldGrp" mode="RequestExemptCvrTaxHsldGrp">
                        <sort select="SortIdPP"/>
                    </apply-templates>
                </table>
            </if>
            <if test="count(NonCalculatedExemptCvrTaxHsldGrpPP)>0">
                <table id="IRECTHG">
                    <apply-templates select="NonCalculatedExemptCvrTaxHsldGrpPP" mode="NonCalculatedExemptCvrTaxHsldGrpPP">
                        <sort select="@uuid"/>
                    </apply-templates>
                </table>
            </if>
            <if test="count(HealthCareCoverageAndExemptionsPP)>0">
                <table id="COVERAGE">
                    <apply-templates select="HealthCareCoverageAndExemptionsPP[contains(PersonIdPP,'PrimaryFullNamePP')]" mode="HealthCareCoverageAndExemptionsPP"/>
                    <apply-templates select="HealthCareCoverageAndExemptionsPP[contains(PersonIdPP,'SpouseFullNamePP')]" mode="HealthCareCoverageAndExemptionsPP"/>
                    <apply-templates select="HealthCareCoverageAndExemptionsPP[contains(PersonIdPP,'DependentFirstNm')]" mode="HealthCareCoverageAndExemptionsPP">
                        <sort select="PersonIdPP"/>
                    </apply-templates>
                </table>
            </if>
            <apply-templates select="SharedRespHshldCoverageWksPP" mode="SharedRespHshldCoverageWksPP"/>
            <apply-templates select="FlatDollarAmountWksPP" mode="FlatDollarAmountWksPP"/>
        </form>
    </template>
    <template match="ReturnData/IRS8965/ObtndExemptCvrTaxHsldGrp" mode="ObtndExemptCvrTaxHsldGrp">
        <row>
            <copy-of select="@uuid"/>
            <apply-templates select="PersonNm" mode="Field">
                <with-param name="tpsId">PERSNAME</with-param>
            </apply-templates>
            <apply-templates select="SSN" mode="Field">
                <with-param name="tpsId">SSN</with-param>
            </apply-templates>
            <apply-templates select="ExemptionCertificateNum" mode="Field">
                <with-param name="tpsId">EXEMCERT</with-param>
            </apply-templates>
            <apply-templates select="StartMonthNumberCdPP" mode="Field">
                <with-param name="tpsId">ESTRMTH</with-param>
            </apply-templates>
            <apply-templates select="EndMonthNumberCdPP" mode="Field">
                <with-param name="tpsId">EENDMTH</with-param>
            </apply-templates>
        </row>
    </template>
    <template match="ReturnData/IRS8965/RequestExemptCvrTaxHsldGrp" mode="RequestExemptCvrTaxHsldGrp">
        <row>
            <copy-of select="@uuid"/>
            <apply-templates select="PersonNm" mode="Field">
                <with-param name="tpsId">RPERSNAM</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="SSN" mode="Field">
                <with-param name="tpsId">REXEMSSN</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="ExemptionReasonCd" mode="Field">
                <with-param name="tpsId">REXEMCD</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="AllYearInd" mode="Field">
                <with-param name="tpsId">REQEXEAY</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrp/JanuaryInd" mode="Field">
                <with-param name="tpsId">REJAN</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrp/FebruaryInd" mode="Field">
                <with-param name="tpsId">REFEB</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrp/MarchInd" mode="Field">
                <with-param name="tpsId">REMAR</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrp/AprilInd" mode="Field">
                <with-param name="tpsId">REAPR</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrp/MayInd" mode="Field">
                <with-param name="tpsId">REMAY</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrp/JuneInd" mode="Field">
                <with-param name="tpsId">REJUN</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrp/JulyInd" mode="Field">
                <with-param name="tpsId">REJUL</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrp/AugustInd" mode="Field">
                <with-param name="tpsId">REAUG</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrp/SeptemberInd" mode="Field">
                <with-param name="tpsId">RESEP</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrp/OctoberInd" mode="Field">
                <with-param name="tpsId">REOCT</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrp/NovemberInd" mode="Field">
                <with-param name="tpsId">RENOV</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrp/DecemberInd" mode="Field">
                <with-param name="tpsId">REDEC</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
        </row>
    </template>
    <template match="ReturnData/IRS8965/NonCalculatedExemptCvrTaxHsldGrpPP" mode="NonCalculatedExemptCvrTaxHsldGrpPP">
        <row>
            <copy-of select="@uuid"/>
            <apply-templates select="PersonNmPP" mode="Field">
                <with-param name="tpsId">IRPERNAM</with-param>
                <with-param name="src">dropAssign</with-param>
            </apply-templates>
            <apply-templates select="SSNPP" mode="Field">
                <with-param name="tpsId">IREXMSSN</with-param>
                <with-param name="src">dropAssign</with-param>
            </apply-templates>
            <apply-templates select="ExemptionReasonCdPP" mode="Field">
                <with-param name="tpsId">IREXEMCD</with-param>
                <with-param name="src">dropAssign</with-param>
            </apply-templates>
            <apply-templates select="AllYearIndPP" mode="Field">
                <with-param name="tpsId">IREQEXAY</with-param>
                <with-param name="src">dropAssign</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrpPP/JanuaryIndPP" mode="Field">
                <with-param name="tpsId">IREJAN</with-param>
                <with-param name="src">dropAssign</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrpPP/FebruaryIndPP" mode="Field">
                <with-param name="tpsId">IREFEB</with-param>
                <with-param name="src">dropAssign</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrpPP/MarchIndPP" mode="Field">
                <with-param name="tpsId">IREMAR</with-param>
                <with-param name="src">dropAssign</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrpPP/AprilIndPP" mode="Field">
                <with-param name="tpsId">IREAPR</with-param>
                <with-param name="src">dropAssign</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrpPP/MayIndPP" mode="Field">
                <with-param name="tpsId">IREMAY</with-param>
                <with-param name="src">dropAssign</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrpPP/JuneIndPP" mode="Field">
                <with-param name="tpsId">IREJUN</with-param>
                <with-param name="src">dropAssign</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrpPP/JulyIndPP" mode="Field">
                <with-param name="tpsId">IREJUL</with-param>
                <with-param name="src">dropAssign</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrpPP/AugustIndPP" mode="Field">
                <with-param name="tpsId">IREAUG</with-param>
                <with-param name="src">dropAssign</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrpPP/SeptemberIndPP" mode="Field">
                <with-param name="tpsId">IRESEP</with-param>
                <with-param name="src">dropAssign</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrpPP/OctoberIndPP" mode="Field">
                <with-param name="tpsId">IREOCT</with-param>
                <with-param name="src">dropAssign</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrpPP/NovemberIndPP" mode="Field">
                <with-param name="tpsId">IRENOV</with-param>
                <with-param name="src">dropAssign</with-param>
            </apply-templates>
            <apply-templates select="MonthIndicatorGrpPP/DecemberIndPP" mode="Field">
                <with-param name="tpsId">IREDEC</with-param>
                <with-param name="src">dropAssign</with-param>
            </apply-templates>
        </row>
    </template>
    <template match="ReturnData/IRS8965/HealthCareCoverageAndExemptionsPP" mode="HealthCareCoverageAndExemptionsPP">
        <row>
            <copy-of select="@uuid"/>
            <apply-templates select="PersonFirstNamePP" mode="Field">
                <with-param name="tpsId">COVDNAME</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="PersonSSNPP" mode="Field">
                <with-param name="tpsId">COVDSSN</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="PersonBirthDtPP" mode="Date">
                <with-param name="tpsId">CDOB</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyStatusGrpPP/MonthPP[MonthCdPP='JANUARY']/StatusPP" mode="Field">
                <with-param name="tpsId">CJAN</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyStatusGrpPP/MonthPP[MonthCdPP='FEBRUARY']/StatusPP" mode="Field">
                <with-param name="tpsId">CFEB</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyStatusGrpPP/MonthPP[MonthCdPP='MARCH']/StatusPP" mode="Field">
                <with-param name="tpsId">CMAR</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyStatusGrpPP/MonthPP[MonthCdPP='APRIL']/StatusPP" mode="Field">
                <with-param name="tpsId">CAPR</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyStatusGrpPP/MonthPP[MonthCdPP='MAY']/StatusPP" mode="Field">
                <with-param name="tpsId">CMAY</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyStatusGrpPP/MonthPP[MonthCdPP='JUNE']/StatusPP" mode="Field">
                <with-param name="tpsId">CJUN</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyStatusGrpPP/MonthPP[MonthCdPP='JULY']/StatusPP" mode="Field">
                <with-param name="tpsId">CJUL</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyStatusGrpPP/MonthPP[MonthCdPP='AUGUST']/StatusPP" mode="Field">
                <with-param name="tpsId">CAUG</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyStatusGrpPP/MonthPP[MonthCdPP='SEPTEMBER']/StatusPP" mode="Field">
                <with-param name="tpsId">CSEP</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyStatusGrpPP/MonthPP[MonthCdPP='OCTOBER']/StatusPP" mode="Field">
                <with-param name="tpsId">COCT</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyStatusGrpPP/MonthPP[MonthCdPP='NOVEMBER']/StatusPP" mode="Field">
                <with-param name="tpsId">CNOV</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyStatusGrpPP/MonthPP[MonthCdPP='DECEMBER']/StatusPP" mode="Field">
                <with-param name="tpsId">CDEC</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
        </row>
    </template>
    <template match="ReturnData/IRS8965/SharedRespHshldCoverageWksPP" mode="SharedRespHshldCoverageWksPP">
        <apply-templates select="TotalBronzePlanCountPP" mode="Field">
            <with-param name="tpsId">SUMOFXS</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="HshldIncmAmtPP" mode="Field">
            <with-param name="tpsId">HSHLDINC</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="FlngThresholdAmtPP" mode="Field">
            <with-param name="tpsId">FILETHRS</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="ExcessHshldIncmAmtPP" mode="Field">
            <with-param name="tpsId">EXCESINC</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="ExcessHshldIncmPenaltyAmtPP" mode="Field">
            <with-param name="tpsId">EXCINCPN</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="PenaltyOnlyHshldIncmIndPP" mode="YesNoField">
            <with-param name="yTpsId">YESINC</with-param>
            <with-param name="nTpsId">NOINC</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="IncmOrFlatDollarX12AmtPP" mode="Field">
            <with-param name="tpsId">INCORFLT</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="IncmOrFlatDollarAmtPP" mode="Field">
            <with-param name="tpsId">ANNUALIZ</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="BronzeCapAmtPP" mode="Field">
            <with-param name="tpsId">BRONZCAP</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="PenaltyAmountPP" mode="Field">
            <with-param name="tpsId">MECPNSUM</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <if test="SharedRespHshldCoverageGrpPP">
            <table id="SRPWUNCV">
                <apply-templates select="SharedRespHshldCoverageGrpPP/SharedRespHshldCoveragePP" mode="SharedRespHshldCoveragePP">
                    <sort select="PersonIdPP"/>
                </apply-templates>
            </table>
        </if>
        <apply-templates select="BronzePlanCountPP" mode="BronzePlanCountPP"/>
        <apply-templates select="AdultCountPP" mode="AdultCountPP"/>
        <apply-templates select="HalfOfTotalMinorsCountPP" mode="HalfOfTotalMinorsCountPP"/>
        <apply-templates select="FlatDollarPeopleCountPP" mode="FlatDollarPeopleCountPP"/>
        <apply-templates select="FlatDollarAmtPP" mode="FlatDollarAmtPP"/>
    </template>
    <template match="ReturnData/IRS8965/SharedRespHshldCoverageWksPP/SharedRespHshldCoverageGrpPP/SharedRespHshldCoveragePP" mode="SharedRespHshldCoveragePP">
        <row>
            <copy-of select="@uuid"/>
            <apply-templates select="PersonNamePP" mode="Field">
                <with-param name="tpsId">SRPWNAME</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyCoverageGrpPP[MonthCdPP='JANUARY']/NoCoverageIndPP" mode="Field">
                <with-param name="tpsId">SRPWJAN</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyCoverageGrpPP[MonthCdPP='FEBRUARY']/NoCoverageIndPP" mode="Field">
                <with-param name="tpsId">SRPWFEB</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyCoverageGrpPP[MonthCdPP='MARCH']/NoCoverageIndPP" mode="Field">
                <with-param name="tpsId">SRPWMAR</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyCoverageGrpPP[MonthCdPP='APRIL']/NoCoverageIndPP" mode="Field">
                <with-param name="tpsId">SRPWAPR</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyCoverageGrpPP[MonthCdPP='MAY']/NoCoverageIndPP" mode="Field">
                <with-param name="tpsId">SRPWMAY</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyCoverageGrpPP[MonthCdPP='JUNE']/NoCoverageIndPP" mode="Field">
                <with-param name="tpsId">SRPWJUN</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyCoverageGrpPP[MonthCdPP='JULY']/NoCoverageIndPP" mode="Field">
                <with-param name="tpsId">SRPWJUL</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyCoverageGrpPP[MonthCdPP='AUGUST']/NoCoverageIndPP" mode="Field">
                <with-param name="tpsId">SRPWAUG</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyCoverageGrpPP[MonthCdPP='SEPTEMBER']/NoCoverageIndPP" mode="Field">
                <with-param name="tpsId">SRPWSEP</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyCoverageGrpPP[MonthCdPP='OCTOBER']/NoCoverageIndPP" mode="Field">
                <with-param name="tpsId">SRPWOCT</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyCoverageGrpPP[MonthCdPP='NOVEMBER']/NoCoverageIndPP" mode="Field">
                <with-param name="tpsId">SRPWNOV</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
            <apply-templates select="MonthlyCoverageGrpPP[MonthCdPP='DECEMBER']/NoCoverageIndPP" mode="Field">
                <with-param name="tpsId">SRPWDEC</with-param>
                <with-param name="src">computed</with-param>
            </apply-templates>
        </row>
    </template>
    <template match="ReturnData/IRS8965/SharedRespHshldCoverageWksPP/BronzePlanCountPP" mode="BronzePlanCountPP">
        <apply-templates select="MonthPP[MonthCdPP='JANUARY']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW1JAN</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='FEBRUARY']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW1FEB</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='MARCH']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW1MAR</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='APRIL']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW1APR</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='MAY']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW1MAY</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='JUNE']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW1JUN</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='JULY']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW1JUL</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='AUGUST']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW1AUG</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='SEPTEMBER']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW1SEP</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='OCTOBER']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW1OCT</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='NOVEMBER']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW1NOV</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='DECEMBER']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW1DEC</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
    </template>
    <template match="ReturnData/IRS8965/SharedRespHshldCoverageWksPP/AdultCountPP" mode="AdultCountPP">
        <apply-templates select="MonthPP[MonthCdPP='JANUARY']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW2JAN</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='FEBRUARY']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW2FEB</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='MARCH']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW2MAR</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='APRIL']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW2APR</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='MAY']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW2MAY</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='JUNE']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW2JUN</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='JULY']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW2JUL</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='AUGUST']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW2AUG</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='SEPTEMBER']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW2SEP</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='OCTOBER']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW2OCT</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='NOVEMBER']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW2NOV</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='DECEMBER']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW2DEC</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
    </template>
    <template match="ReturnData/IRS8965/SharedRespHshldCoverageWksPP/HalfOfTotalMinorsCountPP" mode="HalfOfTotalMinorsCountPP">
        <apply-templates select="MonthPP[MonthCdPP='JANUARY']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW3JAN</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='FEBRUARY']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW3FEB</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='MARCH']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW3MAR</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='APRIL']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW3APR</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='MAY']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW3MAY</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='JUNE']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW3JUN</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='JULY']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW3JUL</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='AUGUST']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW3AUG</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='SEPTEMBER']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW3SEP</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='OCTOBER']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW3OCT</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='NOVEMBER']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW3NOV</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='DECEMBER']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW3DEC</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
    </template>
    <template match="ReturnData/IRS8965/SharedRespHshldCoverageWksPP/FlatDollarPeopleCountPP" mode="FlatDollarPeopleCountPP">
        <apply-templates select="MonthPP[MonthCdPP='JANUARY']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW4JAN</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='FEBRUARY']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW4FEB</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='MARCH']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW4MAR</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='APRIL']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW4APR</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='MAY']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW4MAY</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='JUNE']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW4JUN</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='JULY']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW4JUL</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='AUGUST']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW4AUG</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='SEPTEMBER']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW4SEP</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='OCTOBER']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW4OCT</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='NOVEMBER']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW4NOV</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='DECEMBER']/CountPP" mode="Field">
            <with-param name="tpsId">SRPW4DEC</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
    </template>
    <template match="ReturnData/IRS8965/SharedRespHshldCoverageWksPP/FlatDollarAmtPP" mode="FlatDollarAmtPP">
        <apply-templates select="MonthPP[MonthCdPP='JANUARY']/AmountPP" mode="Field">
            <with-param name="tpsId">SRPW5JAN</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='FEBRUARY']/AmountPP" mode="Field">
            <with-param name="tpsId">SRPW5FEB</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='MARCH']/AmountPP" mode="Field">
            <with-param name="tpsId">SRPW5MAR</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='APRIL']/AmountPP" mode="Field">
            <with-param name="tpsId">SRPW5APR</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='MAY']/AmountPP" mode="Field">
            <with-param name="tpsId">SRPW5MAY</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='JUNE']/AmountPP" mode="Field">
            <with-param name="tpsId">SRPW5JUN</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='JULY']/AmountPP" mode="Field">
            <with-param name="tpsId">SRPW5JUL</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='AUGUST']/AmountPP" mode="Field">
            <with-param name="tpsId">SRPW5AUG</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='SEPTEMBER']/AmountPP" mode="Field">
            <with-param name="tpsId">SRPW5SEP</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='OCTOBER']/AmountPP" mode="Field">
            <with-param name="tpsId">SRPW5OCT</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='NOVEMBER']/AmountPP" mode="Field">
            <with-param name="tpsId">SRPW5NOV</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="MonthPP[MonthCdPP='DECEMBER']/AmountPP" mode="Field">
            <with-param name="tpsId">SRPW5DEC</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
    </template>
    <template match="ReturnData/IRS8965/FlatDollarAmountWksPP" mode="FlatDollarAmountWksPP">
        <apply-templates select="FlatDollarOrExcessHshldIncmGrpPP/MonthlyFlatDollarOrExcessHshldIncmPP[MonthCdPP='JANUARY']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <apply-templates select="FlatDollarOrExcessHshldIncmGrpPP/MonthlyFlatDollarOrExcessHshldIncmPP[MonthCdPP='FEBRUARY']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <apply-templates select="FlatDollarOrExcessHshldIncmGrpPP/MonthlyFlatDollarOrExcessHshldIncmPP[MonthCdPP='MARCH']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <apply-templates select="FlatDollarOrExcessHshldIncmGrpPP/MonthlyFlatDollarOrExcessHshldIncmPP[MonthCdPP='APRIL']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <apply-templates select="FlatDollarOrExcessHshldIncmGrpPP/MonthlyFlatDollarOrExcessHshldIncmPP[MonthCdPP='MAY']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <apply-templates select="FlatDollarOrExcessHshldIncmGrpPP/MonthlyFlatDollarOrExcessHshldIncmPP[MonthCdPP='JUNE']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <apply-templates select="FlatDollarOrExcessHshldIncmGrpPP/MonthlyFlatDollarOrExcessHshldIncmPP[MonthCdPP='JULY']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <apply-templates select="FlatDollarOrExcessHshldIncmGrpPP/MonthlyFlatDollarOrExcessHshldIncmPP[MonthCdPP='AUGUST']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <apply-templates select="FlatDollarOrExcessHshldIncmGrpPP/MonthlyFlatDollarOrExcessHshldIncmPP[MonthCdPP='SEPTEMBER']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <apply-templates select="FlatDollarOrExcessHshldIncmGrpPP/MonthlyFlatDollarOrExcessHshldIncmPP[MonthCdPP='OCTOBER']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <apply-templates select="FlatDollarOrExcessHshldIncmGrpPP/MonthlyFlatDollarOrExcessHshldIncmPP[MonthCdPP='NOVEMBER']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <apply-templates select="FlatDollarOrExcessHshldIncmGrpPP/MonthlyFlatDollarOrExcessHshldIncmPP[MonthCdPP='DECEMBER']" mode="MonthlyFlatDollarOrExcessHshldIncmPP"/>
        <apply-templates select="TotalFlatDollarAmtPP" mode="Field">
            <with-param name="tpsId">FTOTAL</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="TotalExcessHshldIncmAmtPP" mode="Field">
            <with-param name="tpsId">ITOTAL</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="TotalExcessHshldIncmAndFlatDollarAmtPP" mode="Field">
            <with-param name="tpsId">FDWKSHT</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
    </template>
    <template match="ReturnData/IRS8965/FlatDollarAmountWksPP/FlatDollarOrExcessHshldIncmGrpPP/MonthlyFlatDollarOrExcessHshldIncmPP" mode="MonthlyFlatDollarOrExcessHshldIncmPP">
        <apply-templates select="current()[MonthCdPP='JANUARY']/FlatDollarAmtPP" mode="Field">
            <with-param name="tpsId">FJAN</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='JANUARY']/ExcessHshldIncmAmtPP" mode="Field">
            <with-param name="tpsId">IJAN</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='FEBRUARY']/FlatDollarAmtPP" mode="Field">
            <with-param name="tpsId">FFEB</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='FEBRUARY']/ExcessHshldIncmAmtPP" mode="Field">
            <with-param name="tpsId">IFEB</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='MARCH']/FlatDollarAmtPP" mode="Field">
            <with-param name="tpsId">FMAR</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='MARCH']/ExcessHshldIncmAmtPP" mode="Field">
            <with-param name="tpsId">IMAR</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='APRIL']/FlatDollarAmtPP" mode="Field">
            <with-param name="tpsId">FAPR</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='APRIL']/ExcessHshldIncmAmtPP" mode="Field">
            <with-param name="tpsId">IAPR</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='MAY']/FlatDollarAmtPP" mode="Field">
            <with-param name="tpsId">FMAY</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='MAY']/ExcessHshldIncmAmtPP" mode="Field">
            <with-param name="tpsId">IMAY</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='JUNE']/FlatDollarAmtPP" mode="Field">
            <with-param name="tpsId">FJUN</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='JUNE']/ExcessHshldIncmAmtPP" mode="Field">
            <with-param name="tpsId">IJUN</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='JULY']/FlatDollarAmtPP" mode="Field">
            <with-param name="tpsId">FJUL</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='JULY']/ExcessHshldIncmAmtPP" mode="Field">
            <with-param name="tpsId">IJUL</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='AUGUST']/FlatDollarAmtPP" mode="Field">
            <with-param name="tpsId">FAUG</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='AUGUST']/ExcessHshldIncmAmtPP" mode="Field">
            <with-param name="tpsId">IAUG</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='SEPTEMBER']/FlatDollarAmtPP" mode="Field">
            <with-param name="tpsId">FSEP</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='SEPTEMBER']/ExcessHshldIncmAmtPP" mode="Field">
            <with-param name="tpsId">ISEP</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='OCTOBER']/FlatDollarAmtPP" mode="Field">
            <with-param name="tpsId">FOCT</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='OCTOBER']/ExcessHshldIncmAmtPP" mode="Field">
            <with-param name="tpsId">IOCT</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='NOVEMBER']/FlatDollarAmtPP" mode="Field">
            <with-param name="tpsId">FNOV</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='NOVEMBER']/ExcessHshldIncmAmtPP" mode="Field">
            <with-param name="tpsId">INOV</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='DECEMBER']/FlatDollarAmtPP" mode="Field">
            <with-param name="tpsId">FDEC</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
        <apply-templates select="current()[MonthCdPP='DECEMBER']/ExcessHshldIncmAmtPP" mode="Field">
            <with-param name="tpsId">IDEC</with-param>
            <with-param name="src">computed</with-param>
        </apply-templates>
    </template>

    <!-- Mappings for IRS1040ScheduleC Fields -->
    <template match="ReturnData/IRS1040ScheduleC">
        <form id="FSCHC">
            <copy-of select="@uuid"/>
            <apply-templates/>
        </form>
    </template>
    <template match="ReturnData/IRS1040ScheduleC/SelfEmpHealthInsDedPP">
        <form id="FW26C" type="Associated">
            <apply-templates select="HealthAndLongTermCareInsPremAmtPP" mode="Field">
                <with-param name="tpsId">LA</with-param>
            </apply-templates>
            <apply-templates select="NetProfitFromBusinessAmtPP" mode="Field">
                <with-param name="tpsId">L9</with-param>
            </apply-templates>
        </form>
    </template>

    <!-- Mappings for IRS1040ScheduleF Fields -->
    <template match="ReturnData/IRS1040ScheduleF">
        <form id="FSCHF">
            <copy-of select="@uuid"/>
            <apply-templates/>
        </form>
    </template>
    <template match="ReturnData/IRS1040ScheduleF/SelfEmpHealthInsDedPP">
        <form id="FW26F" type="Associated">
            <apply-templates select="HealthAndLongTermCareInsPremAmtPP" mode="Field">
                <with-param name="tpsId">LA</with-param>
            </apply-templates>
            <apply-templates select="NetProfitFromBusinessAmtPP" mode="Field">
                <with-param name="tpsId">L9</with-param>
            </apply-templates>
        </form>
    </template>

    <!-- Mappings for IRS1065ScheduleK1 Fields -->
    <template match="ReturnData/IRS1065ScheduleK1">
        <form id="FK1PW">
            <copy-of select="@uuid"/>
            <apply-templates/>
        </form>
    </template>
    <template match="ReturnData/IRS1065ScheduleK1/SelfEmpHealthInsDedPP">
        <form id="FW26P" type="Associated">
            <apply-templates select="HealthAndLongTermCareInsPremAmtPP" mode="Field">
                <with-param name="tpsId">LA</with-param>
            </apply-templates>
            <apply-templates select="NetProfitFromBusinessAmtPP" mode="Field">
                <with-param name="tpsId">L9</with-param>
            </apply-templates>
        </form>
    </template>

    <!-- Mappings for IRS1120SScheduleK1 Fields -->
    <template match="ReturnData/IRS1120SScheduleK1">
        <form id="FK1SW">
            <copy-of select="@uuid"/>
            <apply-templates/>
        </form>
    </template>
    <template match="ReturnData/IRS1120SScheduleK1/SelfEmpHealthInsDedPP">
        <form id="FW26S" type="Associated">
            <apply-templates select="HealthAndLongTermCareInsPremAmtPP" mode="Field">
                <with-param name="tpsId">LA</with-param>
            </apply-templates>
            <apply-templates select="NetProfitFromBusinessAmtPP" mode="Field">
                <with-param name="tpsId">S4</with-param>
            </apply-templates>
        </form>
    </template>

    <!-- Mappings for IRS2119 -->
    <template match="ReturnData/IRS2119">
        <form id="F2119">
            <copy-of select="@uuid"/>
            <apply-templates select="GrossGainOrLossOnSaleAmtPP" mode="Field">
                <with-param name="tpsId">L5</with-param>
            </apply-templates>
        </form>
    </template>

    <!-- Mapping for ScheduleSEAdjustments -->
    <template match="ReturnData/ScheduleSEAdjustments">
        <form id="FSEADJ">
            <if test="TaxpayerSEReportedIncomePP | SpouseSEReportedIncomePP">
                <table id="A170">
                    <if test="TaxpayerSEReportedIncomePP">
                        <row copy="1">
                            <apply-templates select="TaxpayerSEReportedIncomePP" mode="Field">
                                <with-param name="tpsId">OTHWAGES</with-param>
                            </apply-templates>
                        </row>
                    </if>
                    <if test="SpouseSEReportedIncomePP">
                        <row copy="2">
                            <apply-templates select="SpouseSEReportedIncomePP" mode="Field">
                                <with-param name="tpsId">OTHWAGES</with-param>
                            </apply-templates>
                        </row>
                    </if>
                </table>
            </if>
        </form>
    </template>

    <!-- Mappings for ISRSW2G -->
    <template match="ReturnData/IRSW2G">
        <form id="FW2G">
            <copy-of select="@uuid"/>
            <if test="PayerForeignAddressIndPP[text()='true']">
                <apply-templates select="PayerForeignAddressIndPP" mode="EnumField">
                    <with-param name="tpsId">FRNX</with-param>
                    <with-param name="fieldValue">X</with-param>
                </apply-templates>
            </if>
            <if test="WinnerForeignAddressIndPP[text()='true']">
                <apply-templates select="WinnerForeignAddressIndPP" mode="EnumField">
                    <with-param name="tpsId">EFRN</with-param>
                    <with-param name="fieldValue">X</with-param>
                </apply-templates>
            </if>
            <if test="SpouseW2GIndPP[text()='true']">
                <apply-templates select="SpouseW2GIndPP" mode="EnumField">
                    <with-param name="tpsId">SPBX</with-param>
                    <with-param name="fieldValue">X</with-param>
                </apply-templates>
            </if>
            <if test="WinnerCopyInfoIndPPR2[text()='true']">
                <apply-templates select="WinnerCopyInfoIndPPR2" mode="EnumField">
                    <with-param name="tpsId">OVRX</with-param>
                    <with-param name="fieldValue">X</with-param>
                </apply-templates>
            </if>
            <apply-templates select="CorrectedW2GInd" mode="Field">
                <with-param name="tpsId">CORRX</with-param>
            </apply-templates>
            <apply-templates select="PayerName/BusinessNameLine1Txt" mode="Field">
                <with-param name="tpsId">PNAM</with-param>
            </apply-templates>
            <apply-templates select="PayerName/BusinessNameLine2Txt" mode="Field">
                <with-param name="tpsId">PNAM2</with-param>
            </apply-templates>
            <apply-templates select="PayerSSN" mode="Field">
                <with-param name="tpsId">SSN</with-param>
            </apply-templates>
            <apply-templates select="PayerEIN" mode="Field">
                <with-param name="tpsId">PFIN</with-param>
            </apply-templates>
            <apply-templates select="PayerTelephoneNum" mode="Field">
                <with-param name="tpsId">PHONE</with-param>
            </apply-templates>
            <apply-templates select="GamblingWinGrossWinningAmt" mode="Field">
                <with-param name="tpsId">L1</with-param>
            </apply-templates>
            <apply-templates select="FederalIncomeTaxWithheldAmt" mode="Field">
                <with-param name="tpsId">L2</with-param>
            </apply-templates>
            <apply-templates select="GamblingWinWagerTypeCd" mode="Field">
                <with-param name="tpsId">L3</with-param>
            </apply-templates>
            <apply-templates select="GamblingWinningDt" mode="Date">
                <with-param name="tpsId">L4</with-param>
            </apply-templates>
            <apply-templates select="GamblingWinningTransactionDesc" mode="Field">
                <with-param name="tpsId">L5</with-param>
            </apply-templates>
            <apply-templates select="GamblingWinningEventDesc" mode="Field">
                <with-param name="tpsId">L6</with-param>
            </apply-templates>
            <apply-templates select="GamblingWinFromIdntclWagersAmt" mode="Field">
                <with-param name="tpsId">L7</with-param>
            </apply-templates>
            <apply-templates select="GamblingWinCashierId" mode="Field">
                <with-param name="tpsId">L8</with-param>
            </apply-templates>
            <choose>
                <when test="PayerForeignAddressIndPP[contains(translate(text(),'true','TRUE'),'TRUE')]">
                    <apply-templates select="PayerForeignAddress/AddressLine1Txt" mode="Field">
                        <with-param name="tpsId">PADD</with-param>
                    </apply-templates>
                    <apply-templates select="PayerForeignAddress/CityNm" mode="Field">
                        <with-param name="tpsId">PCTY</with-param>
                    </apply-templates>
                    <apply-templates select="PayerForeignAddress/ProvinceOrStateNm" mode="Field">
                        <with-param name="tpsId">PST</with-param>
                    </apply-templates>
                    <apply-templates select="PayerForeignAddress/ForeignPostalCd" mode="Field">
                        <with-param name="tpsId">PZIP</with-param>
                    </apply-templates>
                </when>
                <otherwise>
                    <apply-templates select="PayerUSAddress/AddressLine1Txt" mode="Field">
                        <with-param name="tpsId">PADD</with-param>
                    </apply-templates>
                    <apply-templates select="PayerUSAddress/CityNm" mode="Field">
                        <with-param name="tpsId">PCTY</with-param>
                    </apply-templates>
                    <apply-templates select="PayerUSAddress/StateAbbreviationCd" mode="Field">
                        <with-param name="tpsId">PST</with-param>
                    </apply-templates>
                    <apply-templates select="PayerUSAddress/ZIPCd" mode="Field">
                        <with-param name="tpsId">PZIP</with-param>
                    </apply-templates>
                </otherwise>
            </choose>
            <apply-templates select="RecipientNm" mode="Field">
                <with-param name="tpsId">WNAM</with-param>
            </apply-templates>
            <choose>
                <when test="WinnerForeignAddressIndPP[contains(translate(text(),'true','TRUE'),'TRUE')]">
                    <apply-templates select="RecipientForeignAddress/AddressLine1Txt" mode="Field">
                        <with-param name="tpsId">WADD</with-param>
                    </apply-templates>
                    <apply-templates select="RecipientForeignAddress/CityNm" mode="Field">
                        <with-param name="tpsId">WCTY</with-param>
                    </apply-templates>
                    <apply-templates select="RecipientForeignAddress/ProvinceOrStateNm" mode="Field">
                        <with-param name="tpsId">WST</with-param>
                    </apply-templates>
                    <apply-templates select="RecipientForeignAddress/ForeignPostalCd" mode="Field">
                        <with-param name="tpsId">WZIP</with-param>
                    </apply-templates>
                </when>
                <otherwise>
                    <apply-templates select="RecipientUSAddress/AddressLine1Txt" mode="Field">
                        <with-param name="tpsId">WADD</with-param>
                    </apply-templates>
                    <apply-templates select="RecipientUSAddress/CityNm" mode="Field">
                        <with-param name="tpsId">WCTY</with-param>
                    </apply-templates>
                    <apply-templates select="RecipientUSAddress/StateAbbreviationCd" mode="Field">
                        <with-param name="tpsId">WST</with-param>
                    </apply-templates>
                    <apply-templates select="RecipientUSAddress/ZIPCd" mode="Field">
                        <with-param name="tpsId">WZIP</with-param>
                    </apply-templates>
                </otherwise>
            </choose>
            <apply-templates select="RecipientSSN" mode="Field">
                <with-param name="tpsId">L9</with-param>
            </apply-templates>
            <apply-templates select="GamblingWinWindowNum" mode="Field">
                <with-param name="tpsId">L10</with-param>
            </apply-templates>
            <apply-templates select="RecipientFirstAdditionalIdNum" mode="Field">
                <with-param name="tpsId">L11</with-param>
            </apply-templates>
            <apply-templates select="RecipientSecondAdditionalIdNum" mode="Field">
                <with-param name="tpsId">L12</with-param>
            </apply-templates>
            <!-- StateLocalTaxGrp -->
            <apply-templates select="W2GStateLocalTaxGrp" mode="W2GStateLocalTaxGrp"/>
        </form>
    </template>
    <template match="W2GStateLocalTaxGrp" mode="W2GStateLocalTaxGrp">
        <apply-templates select="StateAbbreviationCd" mode="Field">
            <with-param name="tpsId">L13A</with-param>
        </apply-templates>
        <apply-templates select="PayerStateIdNum" mode="Field">
            <with-param name="tpsId">L13B</with-param>
        </apply-templates>
        <apply-templates select="StateTaxWithheldAmt" mode="Field">
            <with-param name="tpsId">L14</with-param>
        </apply-templates>
        <apply-templates select="GamblingWinningAmt" mode="Field">
            <with-param name="tpsId">L14B</with-param>
        </apply-templates>
        <!-- LocalTaxGrp -->
        <apply-templates select="W2GLocalTaxGrp" mode="W2GLocalTaxGrp"/>
    </template>
    <template match="W2GLocalTaxGrp" mode="W2GLocalTaxGrp">
        <apply-templates select="LocalityNm" mode="Field">
            <with-param name="tpsId">L15</with-param>
        </apply-templates>
        <apply-templates select="LocalIncomeTaxAmt" mode="Field">
            <with-param name="tpsId">L16</with-param>
        </apply-templates>
        <apply-templates select="GamblingWinningAmt" mode="Field">
            <with-param name="tpsId">L16B</with-param>
        </apply-templates>
    </template>

    <!-- Mapping for IRSW2 -->
    <template match="IRSW2">
        <form id="FW2">
            <copy-of select="@uuid" />
            <apply-templates select="CorrectedW2Ind" mode="FormMLField">
                <with-param name="formmlId">CORRX</with-param>
                <with-param name="type">Boolean</with-param>
            </apply-templates>
            <apply-templates select="EmployeeSSN" mode="FormMLField">
                <with-param name="formmlId">D</with-param>
                <with-param name="type">Text</with-param>
            </apply-templates>
            <!--<apply-templates select="EmployeeSSN" mode="FormMLField">
               <with-param name="formmlId">recipSSN</with-param>
               <with-param name="type">Text</with-param>
            </apply-templates> -->
            <apply-templates select="EmployerEIN" mode="FormMLField">
                <with-param name="formmlId">EIN</with-param>
                <with-param name="type">Text</with-param>
            </apply-templates>
            <apply-templates select="EmployerName/BusinessNameLine1Txt" mode="FormMLField">
                <with-param name="formmlId">CA</with-param>
                <with-param name="type">Text</with-param>
            </apply-templates>
            <apply-templates select="EmployerName/BusinessNameLine2Txt" mode="FormMLField">
                <with-param name="formmlId">CA2</with-param>
                <with-param name="type">Text</with-param>
            </apply-templates>
            <!--EmployerUSAddress/EmployerForeignAddress should go here -->
            <if test="EmployerUSAddress">
                <apply-templates select="EmployerUSAddress/AddressLine1Txt" mode="FormMLField">
                    <with-param name="formmlId">CB</with-param>
                    <with-param name="type">Text</with-param>
                </apply-templates>
                <apply-templates select="EmployerUSAddress/CityNm" mode="FormMLField">
                    <with-param name="formmlId">CADDR</with-param>
                    <with-param name="type">Text</with-param>
                </apply-templates>
                <apply-templates select="EmployerUSAddress/StateAbbreviationCd" mode="FormMLField">
                    <with-param name="formmlId">CST</with-param>
                    <with-param name="type">Text</with-param>
                </apply-templates>
                <apply-templates select="EmployerUSAddress/ZIPCd" mode="FormMLField">
                    <with-param name="formmlId">CZIP</with-param>
                    <with-param name="type">Text</with-param>
                </apply-templates>
            </if>
            <if test="EmployerForeignAddress">
                <apply-templates select="EmployerForeignAddress/AddressLine1Txt" mode="FormMLField">
                    <with-param name="formmlId">CB</with-param>
                    <with-param name="type">Text</with-param>
                </apply-templates>
                <apply-templates select="EmployerForeignAddress/CityNm" mode="FormMLField">
                    <with-param name="formmlId">CADDR</with-param>
                    <with-param name="type">Text</with-param>
                </apply-templates>
                <apply-templates select="EmployerForeignAddress/ProvinceOrStateNm" mode="FormMLField">
                    <with-param name="formmlId">CST</with-param>
                    <with-param name="type">Text</with-param>
                </apply-templates>
                <apply-templates select="EmployerForeignAddress/CountryCd" mode="FormMLField">
                    <with-param name="formmlId">CCOUNTRY</with-param>
                    <with-param name="type">Text</with-param>
                </apply-templates>
                <apply-templates select="EmployerForeignAddress/ForeignPostalCd" mode="FormMLField">
                    <with-param name="formmlId">CZIP</with-param>
                    <with-param name="type">Text</with-param>
                </apply-templates>
            </if>
            <apply-templates select="ControlNum" mode="FormMLField">
                <with-param name="formmlId">A</with-param>
                <with-param name="type">Text</with-param>
            </apply-templates>
            <!--Will try and use the CS fields for the parts of the employee name if they exist, else just put the full name as first name (not going to try and split)-->
            <choose>
                <when test="EmployeeNmCS/PersonFirstNm or EmployeeNmCS/PersonMiddleNm or EmployeeNmCS/PersonLastNm or EmployeeNmCS/PersonNmSuffix">
                    <apply-templates select="EmployeeNmCS/PersonFirstNm" mode="FormMLField">
                        <with-param name="formmlId">EFIRST</with-param>
                        <with-param name="type">Text</with-param>
                    </apply-templates>
                    <apply-templates select="EmployeeNmCS/PersonMiddleNm" mode="FormMLField">
                        <with-param name="formmlId">EMI</with-param>
                        <with-param name="type">Text</with-param>
                    </apply-templates>
                    <apply-templates select="EmployeeNmCS/PersonLastNm" mode="FormMLField">
                        <with-param name="formmlId">ELAST</with-param>
                        <with-param name="type">Text</with-param>
                    </apply-templates>
                    <apply-templates select="EmployeeNmCS/PersonNmSuffix" mode="FormMLField">
                        <with-param name="formmlId">ESF</with-param>
                        <with-param name="type">Text</with-param>
                    </apply-templates>
                </when>
                <otherwise>
                    <apply-templates select="EmployeeNm" mode="FormMLField">
                        <with-param name="formmlId">EFIRST</with-param>
                        <with-param name="type">Text</with-param>
                    </apply-templates>
                </otherwise>
            </choose>
            <!--EmployeeUSAddress/EmployeeForeignAddress should go here -->
            <if test="EmployeeUSAddress">
                <apply-templates select="EmployeeUSAddress/AddressLine1Txt" mode="FormMLField">
                    <with-param name="formmlId">FA</with-param>
                    <with-param name="type">Text</with-param>
                </apply-templates>
                <apply-templates select="EmployeeUSAddress/CityNm" mode="FormMLField">
                    <with-param name="formmlId">FADDR</with-param>
                    <with-param name="type">Text</with-param>
                </apply-templates>
                <apply-templates select="EmployeeUSAddress/StateAbbreviationCd" mode="FormMLField">
                    <with-param name="formmlId">FST</with-param>
                    <with-param name="type">Text</with-param>
                </apply-templates>
                <apply-templates select="EmployeeUSAddress/ZIPCd" mode="FormMLField">
                    <with-param name="formmlId">FZIP</with-param>
                    <with-param name="type">Text</with-param>
                </apply-templates>
            </if>
            <if test="EmployeeForeignAddress">
                <apply-templates select="EmployeeForeignAddress/AddressLine1Txt" mode="FormMLField">
                    <with-param name="formmlId">FA</with-param>
                    <with-param name="type">Text</with-param>
                </apply-templates>
                <apply-templates select="EmployeeForeignAddress/CityNm" mode="FormMLField">
                    <with-param name="formmlId">FADDR</with-param>
                    <with-param name="type">Text</with-param>
                </apply-templates>
                <apply-templates select="EmployeeForeignAddress/ProvinceOrStateNm" mode="FormMLField">
                    <with-param name="formmlId">FST</with-param>
                    <with-param name="type">Text</with-param>
                </apply-templates>
                <apply-templates select="EmployeeForeignAddress/CountryCd" mode="FormMLField">
                    <with-param name="formmlId">ECOUNTRY</with-param>
                    <with-param name="type">Text</with-param>
                </apply-templates>
                <apply-templates select="EmployeeForeignAddress/ForeignPostalCd" mode="FormMLField">
                    <with-param name="formmlId">FZIP</with-param>
                    <with-param name="type">Text</with-param>
                </apply-templates>
            </if>
            <apply-templates select="WagesAmt" mode="FormMLFieldCS">
                <with-param name="formmlId">WAGES</with-param>
                <with-param name="type">Cent</with-param>
                <with-param name="CSVal">
                    <value-of select="WagesAmtCS"/>
                </with-param>
            </apply-templates>
            <apply-templates select="WithholdingAmt" mode="FormMLFieldCS">
                <with-param name="formmlId">FEDTAX</with-param>
                <with-param name="type">Cent</with-param>
                <with-param name="CSVal">
                    <value-of select="WithholdingAmtCS"/>
                </with-param>
            </apply-templates>
            <apply-templates select="SocialSecurityWagesAmt" mode="FormMLFieldCS">
                <with-param name="formmlId">SSWAGES</with-param>
                <with-param name="type">Cent</with-param>
                <with-param name="CSVal">
                    <value-of select="SocialSecurityWagesAmtCS"/>
                </with-param>
            </apply-templates>
            <apply-templates select="SocialSecurityTaxAmt" mode="FormMLFieldCS">
                <with-param name="formmlId">SSTAX</with-param>
                <with-param name="type">Cent</with-param>
                <with-param name="CSVal">
                    <value-of select="SocialSecurityTaxAmtCS"/>
                </with-param>
            </apply-templates>
            <apply-templates select="MedicareTaxWithheldAmt" mode="FormMLFieldCS">
                <with-param name="formmlId">MEDTAX</with-param>
                <with-param name="type">Cent</with-param>
                <with-param name="CSVal">
                    <value-of select="MedicareTaxWithheldAmtCS"/>
                </with-param>
            </apply-templates>
            <apply-templates select="MedicareWagesAndTipsAmt" mode="FormMLFieldCS">
                <with-param name="formmlId">MEDWAGES</with-param>
                <with-param name="type">Cent</with-param>
                <with-param name="CSVal">
                    <value-of select="MedicareWagesAndTipsAmtCS"/>
                </with-param>
            </apply-templates>
            <apply-templates select="SocialSecurityTipsAmt" mode="FormMLFieldCS">
                <with-param name="formmlId">SSTIPS</with-param>
                <with-param name="type">Cent</with-param>
                <with-param name="CSVal">
                    <value-of select="SocialSecurityTipsAmtCS"/>
                </with-param>
            </apply-templates>
            <apply-templates select="AllocatedTipsAmt" mode="FormMLFieldCS">
                <with-param name="formmlId">ALLOCTIP</with-param>
                <with-param name="type">Cent</with-param>
                <with-param name="CSVal">
                    <value-of select="AllocatedTipsAmtCS"/>
                </with-param>
            </apply-templates>
            <apply-templates select="UnreportedMoreThanTwentyDollarsTipsAmtPP" mode="Field">
                <with-param name="tpsId">MT20</with-param>
            </apply-templates>
            <apply-templates select="UnreportedLessThanTwentyDollarsTipsAmtPP" mode="Field">
                <with-param name="tpsId">LT20</with-param>
            </apply-templates>
            <apply-templates select="UnreportedNonCashTipsAmtPP" mode="Field">
                <with-param name="tpsId">NONCASH</with-param>
            </apply-templates>
            <apply-templates select="UnreportedActualAllocatedTipsAmtPP" mode="Field">
                <with-param name="tpsId">ACTALLOC</with-param>
            </apply-templates>
            <apply-templates select="UnreportedSharedTipsAmtPP" mode="Field">
                <with-param name="tpsId">SHARING</with-param>
            </apply-templates>
            <if test="UnreportedTipsGovEmployeeIndPP[text()='true']">
                <apply-templates select="UnreportedTipsGovEmployeeIndPP" mode="EnumField">
                    <with-param name="tpsId">GOVX</with-param>
                    <with-param name="fieldValue">X</with-param>
                </apply-templates>
            </if>
            <apply-templates select="DependentCareBenefitsAmt" mode="FormMLFieldCS">
                <with-param name="formmlId">DCB</with-param>
                <with-param name="type">Cent</with-param>
                <with-param name="CSVal">
                    <value-of select="DependentCareBenefitsAmtCS"/>
                </with-param>
            </apply-templates>
            <apply-templates select="NonqualifiedPlansAmt" mode="FormMLFieldCS">
                <with-param name="formmlId">NQAMOUNT</with-param>
                <with-param name="type">Cent</with-param>
                <with-param name="CSVal">
                    <value-of select="NonqualifiedPlansAmtCS"/>
                </with-param>
            </apply-templates>
            <apply-templates select="SpouseSEReportedIncomePP" mode="Field">
                <with-param name="tpsId">NQPLANS</with-param>
            </apply-templates>
            <if test="EmployersUseGrp">
                <element name="table">
                    <attribute name="id">CODES</attribute>
                    <for-each select="EmployersUseGrp">
                        <element name="row">
                            <attribute name="copy">
                                <value-of select="position()" />
                            </attribute>
                            <apply-templates select="EmployersUseCd" mode="FormMLField">
                                <with-param name="formmlId">CODESC</with-param>
                                <with-param name="type">Text</with-param>
                            </apply-templates>
                            <apply-templates select="EmployersUseAmt" mode="FormMLFieldCS">
                                <with-param name="formmlId">CODESA</with-param>
                                <with-param name="type">Cent</with-param>
                                <with-param name="CSVal">
                                    <value-of select="EmployersUseAmtCS"/>
                                </with-param>
                            </apply-templates>
                        </element>
                    </for-each>
                </element>
            </if>
            <!--Only a value of 'X' is true, everything else including not existing is seen as false-->
            <choose>
                <when test="StatutoryEmployeeInd">
                    <call-template name="CheckboxField">
                        <with-param name="input" select="StatutoryEmployeeInd"/>
                        <with-param name="formmlId">STATX</with-param>
                        <with-param name="type">Boolean</with-param>
                    </call-template>
                </when>
                <otherwise>
                    <call-template name="CheckboxField">
                        <with-param name="input" select="StatutoryEmployeeInd"/>
                        <with-param name="formmlId">STATX</with-param>
                        <with-param name="type">Boolean</with-param>
                    </call-template>
                </otherwise>
            </choose>
            <!--Only a value of 'X' is true, everything else including not existing is seen as false-->
            <choose>
                <when test="RetirementPlanInd">
                    <call-template name="CheckboxField">
                        <with-param name="input" select="RetirementPlanInd"/>
                        <with-param name="formmlId">PPX</with-param>
                        <with-param name="type">Boolean</with-param>
                    </call-template>
                </when>
                <otherwise>
                    <call-template name="CheckboxField">
                        <with-param name="input" select="RetirementPlanInd"/>
                        <with-param name="formmlId">PPX</with-param>
                        <with-param name="type">Boolean</with-param>
                    </call-template>
                </otherwise>
            </choose>
            <!--Only a value of 'X' is true, everything else including not existing is seen as false-->
            <choose>
                <when test="ThirdPartySickPayInd">
                    <call-template name="CheckboxField">
                        <with-param name="input" select="ThirdPartySickPayInd"/>
                        <with-param name="formmlId">SICKPAYX</with-param>
                        <with-param name="type">Boolean</with-param>
                    </call-template>
                </when>
                <otherwise>
                    <call-template name="CheckboxField">
                        <with-param name="input" select="ThirdPartySickPayInd"/>
                        <with-param name="formmlId">SICKPAYX</with-param>
                        <with-param name="type">Boolean</with-param>
                    </call-template>
                </otherwise>
            </choose>
            <choose>
                <when test="OtherDeductionsBenefitsGrpCS">
                    <element name="table">
                        <attribute name="id">OTHR</attribute>
                        <for-each select="OtherDeductionsBenefitsGrpCS">
                            <element name="row">
                                <attribute name="copy">
                                    <value-of select="position()" />
                                </attribute>
                                <apply-templates select="Desc" mode="FormMLField">
                                    <with-param name="formmlId">OTHERD</with-param>
                                    <with-param name="type">Text</with-param>
                                </apply-templates>
                                <apply-templates select="Amt" mode="FormMLField">
                                    <with-param name="formmlId">OTHERA</with-param>
                                    <with-param name="type">Cent</with-param>
                                </apply-templates>
                            </element>
                        </for-each>
                    </element>
                </when>
                <otherwise>
                    <element name="table">
                        <attribute name="id">OTHR</attribute>
                        <for-each select="OtherDeductionsBenefitsGrp">
                            <element name="row">
                                <attribute name="copy">
                                    <value-of select="position()" />
                                </attribute>
                                <apply-templates select="Desc" mode="FormMLField">
                                    <with-param name="formmlId">OTHERD</with-param>
                                    <with-param name="type">Text</with-param>
                                </apply-templates>
                                <apply-templates select="Amt" mode="FormMLField">
                                    <with-param name="formmlId">OTHERA</with-param>
                                    <with-param name="type">Cent</with-param>
                                </apply-templates>
                            </element>
                        </for-each>
                    </element>
                </otherwise>
            </choose>
            <!--W2StateLocalTaxGrp should go here -->
            <if test="W2StateLocalTaxGrp/W2StateTaxGrp/StateAbbreviationCd or W2StateLocalTaxGrp/W2StateTaxGrp/EmployerStateIdNum or W2StateLocalTaxGrp/W2StateTaxGrp/StateWagesAmt or W2StateLocalTaxGrp/W2StateTaxGrp/StateIncomeTaxAmt">
                <element name="table">
                    <attribute name="id">STATE</attribute>
                    <for-each select="W2StateLocalTaxGrp/W2StateTaxGrp">
                        <!--We don't check for StateAbbreviationCd because if that's the only FormMLField this was probably created just for the Local Section-->
                        <if test="EmployerStateIdNum or StateWagesAmt or StateIncomeTaxAmt or StateAbbreviationCd">
                            <element name="row">
                                <attribute name="copy">
                                    <value-of select="position()"/>
                                </attribute>
                                <apply-templates select="StateAbbreviationCd" mode="FormMLField">
                                    <with-param name="formmlId">STATEST</with-param>
                                    <with-param name="type">Text</with-param>
                                </apply-templates>
                                <apply-templates select="EmployerStateIdNum" mode="FormMLField">
                                    <with-param name="formmlId">STATEID</with-param>
                                    <with-param name="type">Text</with-param>
                                </apply-templates>
                                <apply-templates select="StateWagesAmt" mode="FormMLFieldCS">
                                    <with-param name="formmlId">STATEWAG</with-param>
                                    <with-param name="type">Cent</with-param>
                                    <with-param name="CSVal">
                                        <value-of select="StateWagesAmtCS"/>
                                    </with-param>
                                </apply-templates>
                                <apply-templates select="StateIncomeTaxAmt" mode="FormMLFieldCS">
                                    <with-param name="formmlId">STATETAX</with-param>
                                    <with-param name="type">Cent</with-param>
                                    <with-param name="CSVal">
                                        <value-of select="StateIncomeTaxAmtCS"/>
                                    </with-param>
                                </apply-templates>
                            </element>
                        </if>
                    </for-each>
                </element>
            </if>
            <if test="W2StateLocalTaxGrp/W2StateTaxGrp/W2LocalTaxGrp/LocalWagesAndTipsAmt or W2StateLocalTaxGrp/W2StateTaxGrp/W2LocalTaxGrp/LocalIncomeTaxAmt or W2StateLocalTaxGrp/W2StateTaxGrp/W2LocalTaxGrp/LocalityNm">
                <element name="table">
                    <attribute name="id">LOCAL</attribute>
                    <for-each select="W2StateLocalTaxGrp/W2StateTaxGrp/W2LocalTaxGrp">
                        <if test="LocalWagesAndTipsAmt or LocalIncomeTaxAmt or LocalityNm">
                            <element name="row">
                                <attribute name="copy">
                                    <value-of select="position()"/>
                                </attribute>
                                <apply-templates select="LocalityNm" mode="FormMLField">
                                    <with-param name="formmlId">LCLNAME</with-param>
                                    <with-param name="type">Text</with-param>
                                </apply-templates>
                                <apply-templates select="LocalWagesAndTipsAmt" mode="FormMLFieldCS">
                                    <with-param name="formmlId">LCLWAGES</with-param>
                                    <with-param name="type">Cent</with-param>
                                    <with-param name="CSVal">
                                        <value-of select="LocalWagesAndTipsAmtCS"/>
                                    </with-param>
                                </apply-templates>
                                <apply-templates select="LocalIncomeTaxAmt" mode="FormMLFieldCS">
                                    <with-param name="formmlId">LCLTAX</with-param>
                                    <with-param name="type">Cent</with-param>
                                    <with-param name="CSVal">
                                        <value-of select="LocalIncomeTaxAmtCS"/>
                                    </with-param>
                                </apply-templates>
                                <apply-templates select="../StateAbbreviationCd" mode="FormMLField">
                                    <with-param name="formmlId">LCLSTATE</with-param>
                                    <with-param name="type">Text</with-param>
                                </apply-templates>
                            </element>
                        </if>
                    </for-each>
                </element>
            </if>
            <apply-templates select="StandardOrNonStandardCd" mode="ResolveStandardField">
                <with-param name="formmlId">NSX</with-param>
                <with-param name="type">Text</with-param>
            </apply-templates>
            <!-- Clergy Sub flow mappings -->
            <apply-templates select="ClergyDesignatedHousingAmtPP" mode="Field">
                <with-param name="tpsId">CHA</with-param>
            </apply-templates>
            <apply-templates select="ClergySmallestHousingAmtPP" mode="Field">
                <with-param name="tpsId">CUHA</with-param>
            </apply-templates>
            <apply-templates select="ClergySelfEmploymentTaxCdPP[child::text()='ClergySETaxonHousing']" mode="EnumField">
                <with-param name="tpsId">CLHAX</with-param>
                <with-param name="fieldValue">X</with-param>
            </apply-templates>
            <apply-templates select="ClergySelfEmploymentTaxCdPP[child::text()='ClergySETaxonW2']" mode="EnumField">
                <with-param name="tpsId">CLW2X</with-param>
                <with-param name="fieldValue">X</with-param>
            </apply-templates>
            <apply-templates select="ClergySelfEmploymentTaxCdPP[child::text()='ClergySETaxonHousingandW2']" mode="EnumField">
                <with-param name="tpsId">CLHAW2X</with-param>
                <with-param name="fieldValue">X</with-param>
            </apply-templates>
            <apply-templates select="ClergySelfEmploymentTaxCdPP[child::text()='ClergyExpemptfromSETax']" mode="EnumField">
                <with-param name="tpsId">CLEX</with-param>
                <with-param name="fieldValue">X</with-param>
            </apply-templates>
            <apply-templates select="ClergySelfEmploymentTaxCdPP[child::text()='NonClergySETaxonW2']" mode="EnumField">
                <with-param name="tpsId">NCLW2X</with-param>
                <with-param name="fieldValue">X</with-param>
            </apply-templates>
            <apply-templates select="ClergySelfEmploymentTaxCdPP[child::text()='NonClergyExpemptfromSETax']" mode="EnumField">
                <with-param name="tpsId">NCLEX</with-param>
                <with-param name="fieldValue">X</with-param>
            </apply-templates>
            <apply-templates select="ClergySelfEmploymentTaxCdPP[child::text()='NoSSAndMedicareTax']" mode="EnumField">
                <with-param name="tpsId">CLNONE</with-param>
                <with-param name="fieldValue">X</with-param>
            </apply-templates>
            <apply-templates select="W2ClergyFirstChoicePPR2" mode="Field">
                <with-param name="tpsId">HCLTYPE</with-param>
            </apply-templates>
            <apply-templates select="HaveClergyChurchRelSectIncomeIndPP" mode="Boolean01">
                <with-param name="tpsId">HCLINC</with-param>
            </apply-templates>
            <apply-templates select="NonStandardW2IndPP" mode="BoolToCheckBox">
                <with-param name="tpsId">NSX</with-param>
            </apply-templates>
            <!-- Other Uncommon Situations mappings -->
            <apply-templates select="WorkedOutsideUSIndPP" mode="BoolToCheckBox">
                <with-param name="tpsId">FSX</with-param>
            </apply-templates>
            <apply-templates select="PaidFamilyLeaveIndPP" mode="BoolToCheckBox">
                <with-param name="tpsId">PFLX</with-param>
            </apply-templates>
            <apply-templates select="InmateIndPP" mode="BoolToCheckBox">
                <with-param name="tpsId">INMATEX</with-param>
            </apply-templates>
            <apply-templates select="SpouseCopyIndPP" mode="BoolToCheckBox">
                <with-param name="tpsId">SPBX</with-param>
            </apply-templates>
            <apply-templates select="ActiveDutyMilitaryIndPP" mode="BoolToCheckBox">
                <with-param name="tpsId">MILPAYX</with-param>
            </apply-templates>
            <apply-templates select="HaveCombatPayIndPP" mode="Boolean01">
                <with-param name="tpsId">HHAVECOM</with-param>
            </apply-templates>
            <apply-templates select="SubstituteFormIndPP" mode="Boolean01">
                <with-param name="tpsId">HNEED4852</with-param>
            </apply-templates>
            <apply-templates select="InternationalOrgIndPP" mode="Boolean01">
                <with-param name="tpsId">GOTW2SE</with-param>
            </apply-templates>
            <apply-templates select="UnreportedTipsIndPP" mode="Boolean01">
                <with-param name="tpsId">GOTTIPS</with-param>
            </apply-templates>
            <apply-templates select="TotalTipsPP" mode="Field">
                <with-param name="tpsId">HTOTTIP</with-param>
            </apply-templates>
            <apply-templates select="MilitaryEINIndPP" mode="Boolean01">
                <with-param name="tpsId">HMILEIN</with-param>
            </apply-templates>
            <apply-templates select="PensionPlanIndPP" mode="Boolean01">
                <with-param name="tpsId">HPENSION</with-param>
            </apply-templates>
            <apply-templates select="ImportedEmployerIndPPR2" mode="Boolean01">
                <with-param name="tpsId">HEMPIMP</with-param>
            </apply-templates>
            <!-- Mappings for F4852 -->
            <apply-templates select="ExplainAmountsGrpPP" mode="ExplanationPP">
                <with-param name="tableId">TL94852</with-param>
                <with-param name="tpsId">L9F4852</with-param>
            </apply-templates>
            <apply-templates select="ExplainEffortsGrpPP" mode="ExplanationPP">
                <with-param name="tableId">TL104852</with-param>
                <with-param name="tpsId">L10F4852</with-param>
            </apply-templates>
            <apply-templates select="HaveAny4852IndPP" mode="Boolean01">
                <with-param name="tpsId">HRECSUB</with-param>
            </apply-templates>
        </form>
    </template>
    <template match="node()" mode="ExplanationPP">
        <param name="tableId"/>
        <param name="tpsId"/>
        <table id="{$tableId}">
            <apply-templates select="ExplanationPP" mode="TextPP">
                <with-param name="tpsId"><value-of select="$tpsId"/></with-param>
            </apply-templates>
        </table>
    </template>
    <template match="node()" mode="TextPP">
        <param name="tpsId"></param>
        <row>
            <copy-of select="@uuid"/>
            <apply-templates select="TextPP" mode="Field">
                <with-param name="tpsId"><value-of select="$tpsId"/></with-param>
            </apply-templates>
        </row>
    </template>

    <!-- Mappings for IRS1095Int Fields -->
    <template match="IRS1099INTCS">
        <form id="F1099INT" refId="payer name" description="">
            <!-- Pass through the uuid if present -->
            <copy-of select="@uuid"/>
            <apply-templates select="PayerNameCS/BusinessNameLine1Txt" mode="ConcatFieldSpace">
                <with-param name="formmlId">PNA1</with-param>
                <with-param name="type">Text</with-param>
                <with-param name="name2" select="PayerNameCS/BusinessNameLine2Txt"/>
            </apply-templates>
            <apply-templates select="RecipientSSNCS" mode="FieldWithType">
                <with-param name="formmlId">RECIPSSN</with-param>
                <with-param name="type">Text</with-param>
            </apply-templates>
            <apply-templates select="RecipientNmCS" mode="FieldWithType">
                <with-param name="formmlId">HRECNAME</with-param>
                <with-param name="type">Text</with-param>
            </apply-templates>
            <apply-templates select="AccountNumCS" mode="FieldWithType">
                <with-param name="formmlId">ACCTNUM</with-param>
                <with-param name="type">Text</with-param>
            </apply-templates>
            <apply-templates select="PayerRoutingTransitNumCS" mode="FieldWithType">
                <with-param name="formmlId">PAYERRTN</with-param>
                <with-param name="type">Text</with-param>
            </apply-templates>
            <apply-templates select="InterestIncomeAmtCS" mode="FieldWithType">
                <with-param name="formmlId">L1</with-param>
                <with-param name="type">Cent</with-param>
            </apply-templates>
            <apply-templates select="EarlyWithdrawalPenaltyAmtCS" mode="FieldWithType">
                <with-param name="formmlId">L2</with-param>
                <with-param name="type">Cent</with-param>
            </apply-templates>
            <apply-templates select="InterestOnBondsAndTreasuryAmtCS" mode="FieldWithType">
                <with-param name="formmlId">L3</with-param>
                <with-param name="type">Cent</with-param>
            </apply-templates>
            <apply-templates select="FederalIncomeTaxWithheldAmtCS" mode="FieldWithType">
                <with-param name="formmlId">L4</with-param>
                <with-param name="type">Cent</with-param>
            </apply-templates>
            <apply-templates select="InvestmentExpensesAmtCS" mode="FieldWithType">
                <with-param name="formmlId">L5</with-param>
                <with-param name="type">Cent</with-param>
            </apply-templates>
            <apply-templates select="ForeignTaxPaidAmtCS" mode="FieldWithType">
                <with-param name="formmlId">TAX</with-param>
                <with-param name="type">Cent</with-param>
            </apply-templates>
            <apply-templates select="CountryCdCS" mode="FieldWithType">
                <with-param name="formmlId">CTRY</with-param>
                <with-param name="type">Cent</with-param>
            </apply-templates>
            <apply-templates select="TaxExemptInterestAmtCS" mode="FieldWithType">
                <with-param name="formmlId">EXINT</with-param>
                <with-param name="type">Cent</with-param>
            </apply-templates>
            <apply-templates select="ActivityBondInterestAmtCS" mode="FieldWithType">
                <with-param name="formmlId">INTP</with-param>
                <with-param name="type">Cent</with-param>
            </apply-templates>
            <apply-templates select="MarketDiscountAmtCS" mode="FieldWithType">
                <with-param name="formmlId">MDISC</with-param>
                <with-param name="type">Cent</with-param>
            </apply-templates>
            <apply-templates select="BondPremiumAmtCS" mode="FieldWithType">
                <with-param name="formmlId">BPREM</with-param>
                <with-param name="type">Cent</with-param>
            </apply-templates>
            <apply-templates select="TaxExemptCUSIPCS" mode="FieldWithType">
                <with-param name="formmlId">CUSIP</with-param>
                <with-param name="type">Text</with-param>
            </apply-templates>
            <apply-templates select="F1099IntStateTaxGrpCS[1]" mode="StateField">
                <with-param name="taxAmt">STWH</with-param>
                <with-param name="taxAmtType">Cent</with-param>
                <with-param name="stateCode">ST2</with-param>
                <with-param name="stateCodeType">Text</with-param>
                <with-param name="stateId">STATEID</with-param>
                <with-param name="stateIdType">Text</with-param>
            </apply-templates>
            <apply-templates select="F1099IntStateTaxGrpCS[2]" mode="StateField">
                <with-param name="taxAmt">STWH2</with-param>
                <with-param name="taxAmtType">Cent</with-param>
                <with-param name="stateCode">STAT2</with-param>
                <with-param name="stateCodeType">Text</with-param>
                <with-param name="stateId">STATEID2</with-param>
                <with-param name="stateIdType">Text</with-param>
            </apply-templates>
        </form>
    </template>

    <!-- EIC TOPIC MAPPING -->
    <template match="node()" mode="FSCHEICW" name="FSCHEICW">
        <if test="ReturnData/EIC | ReturnData/IRS1040ScheduleEIC">
            <form id="FSCHEICW">
                <for-each select="ReturnData/EIC | ReturnData/IRS1040ScheduleEIC">
                    <apply-templates select="." mode="FSCHEICW-SUB"/>
                </for-each>
            </form>
        </if>
    </template>
    <template match="ReturnData/EIC" mode="FSCHEICW-SUB">
        <copy-of select="@uuid"/>
        <apply-templates select="LiveWithChldInUSOverHalfYrIndPP" mode="Boolean01">
            <with-param name="tpsId">HUSOVRHF</with-param>
        </apply-templates>
        <!--<apply-templates select="EICPreviouslyDisallowedIndPP" mode="Boolean01">
            <with-param name="tpsId">H8862REQ</with-param>
        </apply-templates>-->
        <apply-templates select="DisqualifiedFromEICIndPP" mode="Boolean01">
            <with-param name="tpsId">HDISQEIC</with-param>
        </apply-templates>
        <apply-templates select="DisqualEICDueToInternalFieldsIndPP" mode="Boolean01">
            <with-param name="tpsId">HDIEICIN</with-param>
        </apply-templates>
        <apply-templates select="DisqualEICDueToExternalFieldsIndPP" mode="Boolean01">
            <with-param name="tpsId">HDIEICEX</with-param>
        </apply-templates>
        <apply-templates select="PotentialQualifyingChildCntPP" mode="Field">
            <with-param name="tpsId">HEICPQC</with-param>
        </apply-templates>
        <apply-templates select="QualifyingChildCntPP" mode="Field">
            <with-param name="tpsId">HEICQCCT</with-param>
        </apply-templates>
        <apply-templates select="InvestmentIncomeOverLimitIndPP" mode="BoolToCheckBox">
            <with-param name="tpsId">BX3</with-param>
        </apply-templates>
        <apply-templates select="TaxpayerFSMarriedFilingSepIndPP" mode="BoolToCheckBox">
            <with-param name="tpsId">BX4</with-param>
        </apply-templates>
        <!--<apply-templates select="EICEligClmQlfyChldOfOtherIndPP" mode="BoolToCheckBox">
            <with-param name="tpsId">BX5</with-param>
        </apply-templates>-->
        <apply-templates select="Form2555OrForm2555EZIndPP" mode="BoolToCheckBox">
            <with-param name="tpsId">BX6</with-param>
        </apply-templates>
        <!--<apply-templates select="MainHomeInUSOverHalfYrIndPP" mode="BoolToCheckBox">
            <with-param name="tpsId">BX7</with-param>
        </apply-templates>-->
        <apply-templates select="TxpyerOrSpsAge25ButUnder65IndPP" mode="BoolToCheckBox">
            <with-param name="tpsId">BX8</with-param>
        </apply-templates>
        <apply-templates select="ClaimedAsDependentIndPP" mode="BoolToCheckBox">
            <with-param name="tpsId">BX9</with-param>
        </apply-templates>
        <!--<apply-templates select="NotifiedByIRSNoEICIndPP" mode="BoolToCheckBox">
            <with-param name="tpsId">BX12</with-param>
        </apply-templates>-->
        <!--<apply-templates select="FilerAndSpouseUSCitOrResAlienAllYrIndPP" mode="BoolToCheckBox">
            <with-param name="tpsId">BX13</with-param>
        </apply-templates>-->
        <apply-templates select="HOHAndLivedWithNRALast6MonthsIndPP" mode="BoolToCheckBox">
            <with-param name="tpsId">BX14</with-param>
        </apply-templates>
        <apply-templates select="InvestmentIncomeAmount" mode="BoolToCheckBox">
            <with-param name="tpsId">IITOT</with-param>
        </apply-templates>
        <apply-templates select="EarnedIncomeTableAmtPP" mode="Field">
            <with-param name="tpsId">L7</with-param>
        </apply-templates>
        <apply-templates select="EarnedIncomeCreditAmtPP" mode="Field">
            <with-param name="tpsId">L10</with-param>
        </apply-templates>
        <apply-templates select="AGIAmtPP" mode="Field">
            <with-param name="tpsId">L8</with-param>
        </apply-templates>
        <apply-templates select="DoNotGetEICFromAGIPP" mode="YesNoField">
            <with-param name="yTpsId">L9Y</with-param>
            <with-param name="nTpsId">L9N</with-param>
        </apply-templates>
        <apply-templates select="AdjustedGrossIncomeTableAmtPP" mode="Field">
            <with-param name="tpsId">L9</with-param>
        </apply-templates>
        <apply-templates select="EICWorksheetPP" mode="EICWorksheetPP"/>
    </template>
    <template match="ReturnData/IRS1040ScheduleEIC" mode="FSCHEICW-SUB">
        <if test="count(QualifyingChildInformation)>0">
            <table id="QUALCHLD">
                <for-each select="QualifyingChildInformation">
                    <apply-templates select="." mode="QualifyingChildInformation"/>
                </for-each>
            </table>
        </if>
    </template>
    <template match="ReturnData/EIC/EICWorksheetPP" mode="EICWorksheetPP">
        <apply-templates select="WagesSalariesAndTipsAmtPP" mode="Field">
            <with-param name="tpsId">L1</with-param>
        </apply-templates>
        <apply-templates select="SelfEmploymentIncomeAmtPP" mode="Field">
            <with-param name="tpsId">L2B</with-param>
        </apply-templates>
        <apply-templates select="WagesNotConsideredEarnedPP" mode="Field">
            <with-param name="tpsId">L2F</with-param>
        </apply-templates>
        <apply-templates select="Section457AndNonqualPlansPP" mode="Field">
            <with-param name="tpsId">L2G</with-param>
        </apply-templates>
        <apply-templates select="WagesSalariesAndTipsAdjPP" mode="Field">
            <with-param name="tpsId">L3</with-param>
        </apply-templates>
        <apply-templates select="SEOrStatutoryEmployeeAmtPP" mode="Field">
            <with-param name="tpsId">L5</with-param>
        </apply-templates>
        <apply-templates select="EarnedIncomePP" mode="Field">
            <with-param name="tpsId">L6</with-param>
        </apply-templates>
        <apply-templates select="TaxpayerNontaxableCombatPayPP" mode="Field">
            <with-param name="tpsId">TNTCMBAT</with-param>
        </apply-templates>
        <apply-templates select="SpouseNontaxableCombatPayPP" mode="Field">
            <with-param name="tpsId">SNTCMBAT</with-param>
        </apply-templates>
        <apply-templates select="TotalNontaxableCombatPayPP" mode="Field">
            <with-param name="tpsId">NTCOMBAT</with-param>
        </apply-templates>
        <apply-templates select="NontaxableCombatPaySmartWksPP" mode="NontaxableCombatPaySmartWksPP"/>
        <apply-templates select="NotEarnedIncomeSmartWorksheetPP" mode="NotEarnedIncomeSmartWorksheetPP"/>
    </template>
    <template match="ReturnData/EIC/EICWorksheetPP/NontaxableCombatPaySmartWksPP" mode="NontaxableCombatPaySmartWksPP">
        <apply-templates select="TaxpayerNontaxableCombatPayPP" mode="Field">
            <with-param name="tpsId">TCOMBAT</with-param>
        </apply-templates>
        <apply-templates select="SpouseNontaxableCombatPayPP" mode="Field">
            <with-param name="tpsId">SCOMBAT</with-param>
        </apply-templates>
        <apply-templates select="TaxpayerCombatPayForEICIndPP" mode="YesNoField">
            <with-param name="yTpsId">YELECT</with-param>
            <with-param name="nTpsId">NELECT</with-param>
        </apply-templates>
        <apply-templates select="SpouseCombatPayForEICIndPP" mode="YesNoField">
            <with-param name="yTpsId">SELECTY</with-param>
            <with-param name="nTpsId">SELECTN</with-param>
        </apply-templates>
    </template>
    <template match="ReturnData/EIC/EICWorksheetPP/NotEarnedIncomeSmartWorksheetPP" mode="NotEarnedIncomeSmartWorksheetPP">
        <apply-templates select="TaxpayerAmountEarnedBySpousePP" mode="Field">
            <with-param name="tpsId">L2C</with-param>
        </apply-templates>
        <apply-templates select="HasInmateIncomeIndPP" mode="Boolean01">
            <with-param name="tpsId">HEICINMT</with-param>
        </apply-templates>
        <apply-templates select="TaxpayerAmountsEarnedAsInmatePP" mode="Field">
            <with-param name="tpsId">L2D</with-param>
        </apply-templates>
        <apply-templates select="SpouseAmountsEarnedAsInmatePP" mode="Field">
            <with-param name="tpsId">L2DSP</with-param>
        </apply-templates>
    </template>
    <template match="ReturnData/IRS1040ScheduleEIC/QualifyingChildInformation" mode="QualifyingChildInformation">
        <row>
            <copy-of select="@uuid"/>
            <apply-templates select="ChildFirstAndLastName/PersonFirstNm" mode="Field">
                <with-param name="tpsId">L1A</with-param>
            </apply-templates>
            <apply-templates select="ChildFirstAndLastName/PersonLastNm" mode="Field">
                <with-param name="tpsId">L1C</with-param>
            </apply-templates>
            <apply-templates select="QualifyingChildSSN" mode="Field">
                <with-param name="tpsId">CHSSN</with-param>
            </apply-templates>
            <apply-templates select="ChildBirthYr" mode="Field">
                <with-param name="tpsId">BIRTHYR</with-param>
            </apply-templates>
            <apply-templates select="ChildRelationshipCd" mode="Field">
                <with-param name="tpsId">RELATION</with-param>
            </apply-templates>
            <apply-templates select="MonthsChildLivedWithYouCnt" mode="Field">
                <with-param name="tpsId">LIVEUS</with-param>
            </apply-templates>
            <apply-templates select="ChildIsAStudentUnder24Ind" mode="YesNoField">
                <with-param name="yTpsId">STUY</with-param>
                <with-param name="nTpsId">STUN</with-param>
            </apply-templates>
            <apply-templates select="ChildPermanentlyDisabledInd" mode="YesNoField">
                <with-param name="yTpsId">DISY</with-param>
                <with-param name="nTpsId">DISN</with-param>
            </apply-templates>
        </row>
    </template>

    <!-- EIC to FINFOWKS and FEARNINC-->
    <template match="ReturnData/EIC" mode="FINFOWKS-EIC">
        <apply-templates select="EICEligClmQlfyChldOfOtherIndPP" mode="YesNoField">
            <with-param name="yTpsId">AY</with-param>
            <with-param name="nTpsId">AN</with-param>
        </apply-templates>
        <apply-templates select="MainHomeInUSOverHalfYrIndPP" mode="YesNoField">
            <with-param name="yTpsId">BY</with-param>
            <with-param name="nTpsId">BN</with-param>
        </apply-templates>
        <apply-templates select="EICPreviouslyDisallowedIndPP" mode="YesNoField">
            <with-param name="yTpsId">FM8862</with-param>
            <with-param name="nTpsId">NO8862</with-param>
        </apply-templates>
        <apply-templates select="NotifiedByIRSNoEICIndPP" mode="BoolToCheckBox">
            <with-param name="tpsId">NOEICX</with-param>
        </apply-templates>
        <apply-templates select="SSNInvalidForEmplmnOrEICPrpsIndPP" mode="BoolToCheckBox">
            <with-param name="tpsId">DY</with-param>
        </apply-templates>
        <apply-templates select="LivedWithNRALast6MonthsIndPP" mode="BoolToCheckBox">
            <with-param name="tpsId">CY</with-param>
        </apply-templates>
        <apply-templates select="FilerOrSpouseIsDualStatusAlienIndPP" mode="BoolToCheckBox">
            <with-param name="tpsId">PDR</with-param>
        </apply-templates>
    </template>
    <template match="ReturnData/EIC/EarnedIncomeWorksheetPP">
        <form id="FEARNINC">
            <copy-of select="@uuid"/>
            <!-- TP -->
            <apply-templates select="TaxpayerEICWksNetSEIncomePP" mode="Field">
                <with-param name="tpsId">L1AA</with-param>
            </apply-templates>
            <apply-templates select="TaxpayerEICWksOptMethodAmtPP" mode="Field">
                <with-param name="tpsId">L1AB</with-param>
            </apply-templates>
            <apply-templates select="TaxpayerEICWksSumSEIncomePP" mode="Field">
                <with-param name="tpsId">L1AC</with-param>
            </apply-templates>
            <apply-templates select="TaxpayerEICWksHalfSETaxPP" mode="Field">
                <with-param name="tpsId">L1AD</with-param>
            </apply-templates>
            <apply-templates select="TaxpayerEICWksSETaxMinusIncomePP" mode="Field">
                <with-param name="tpsId">L1AE</with-param>
            </apply-templates>
            <apply-templates select="TaxpayerEICWksNetFarmAmtPP" mode="Field">
                <with-param name="tpsId">L2AA</with-param>
            </apply-templates>
            <apply-templates select="TaxpayerEICWksNetNonfarmAmtPP" mode="Field">
                <with-param name="tpsId">L2AB</with-param>
            </apply-templates>
            <apply-templates select="TaxpayerEICWksNetProfitOrLossPP" mode="Field">
                <with-param name="tpsId">L2AC</with-param>
            </apply-templates>
            <apply-templates select="TaxpayerEICWksGrossReceiptsAmtPP" mode="Field">
                <with-param name="tpsId">L3A</with-param>
            </apply-templates>
            <apply-templates select="TaxpayerEICWksComputationTtlPP" mode="Field">
                <with-param name="tpsId">L4A</with-param>
            </apply-templates>
            <!-- SP -->
            <apply-templates select="SpouseEICWksNetSEIncomePP" mode="Field">
                <with-param name="tpsId">L1BA</with-param>
            </apply-templates>
            <apply-templates select="SpouseEICWksOptMethodAmtPP" mode="Field">
                <with-param name="tpsId">L1BB</with-param>
            </apply-templates>
            <apply-templates select="SpouseEICWksSumSEIncomePP" mode="Field">
                <with-param name="tpsId">L1BC</with-param>
            </apply-templates>
            <apply-templates select="SpouseEICWksHalfSETaxPP" mode="Field">
                <with-param name="tpsId">L1BD</with-param>
            </apply-templates>
            <apply-templates select="SpouseEICWksSETaxMinusIncomePP" mode="Field">
                <with-param name="tpsId">L1BE</with-param>
            </apply-templates>
            <apply-templates select="SpouseEICWksFarmProfitOrLossPP" mode="Field">
                <with-param name="tpsId">L2BA</with-param>
            </apply-templates>
            <apply-templates select="SpouseEICWksNetNonfarmAmtPP" mode="Field">
                <with-param name="tpsId">L2BB</with-param>
            </apply-templates>
            <apply-templates select="SpouseEICWksNetProfitOrLossPP" mode="Field">
                <with-param name="tpsId">L2BC</with-param>
            </apply-templates>
            <apply-templates select="SpouseEICWksGrossReceiptsAmtPP" mode="Field">
                <with-param name="tpsId">L3B</with-param>
            </apply-templates>
            <apply-templates select="SpouseEICWksComputationTotalPP" mode="Field">
                <with-param name="tpsId">L4B</with-param>
            </apply-templates>
            <!-- Total -->
            <apply-templates select="TotalEICWksNetSEIncomePP" mode="Field">
                <with-param name="tpsId">L1CA</with-param>
            </apply-templates>
            <apply-templates select="TotalEICWksOptMethodAmtPP" mode="Field">
                <with-param name="tpsId">L1CB</with-param>
            </apply-templates>
            <apply-templates select="TotalEICWksSumSEIncomePP" mode="Field">
                <with-param name="tpsId">L1CC</with-param>
            </apply-templates>
            <apply-templates select="TotalEICWksHalfSETaxPP" mode="Field">
                <with-param name="tpsId">L1CD</with-param>
            </apply-templates>
            <apply-templates select="TotalEICWksSETaxMinusIncomePP" mode="Field">
                <with-param name="tpsId">L1CE</with-param>
            </apply-templates>
            <apply-templates select="TotalEICWksFarmProfitOrLossPP" mode="Field">
                <with-param name="tpsId">L2CA</with-param>
            </apply-templates>
            <apply-templates select="TotalEICWksNetNonfarmAmtPP" mode="Field">
                <with-param name="tpsId">L2CB</with-param>
            </apply-templates>
            <apply-templates select="TotalEICWksSumNetProfitOrLossPP" mode="Field">
                <with-param name="tpsId">L2CC</with-param>
            </apply-templates>
            <apply-templates select="TotalEICWksGrossReceiptsAmtPP" mode="Field">
                <with-param name="tpsId">L3C</with-param>
            </apply-templates>
            <apply-templates select="TotalEICWksComputationTotalPP" mode="Field">
                <with-param name="tpsId">L4C</with-param>
            </apply-templates>
        </form>
    </template>

    <!-- Mappings for Student Loan Interest -->
    <template match="node()" mode="FSTDLOAN" name="FSTDLOAN">
        <if test="ReturnData/PPStudentLoanInterestWks | ReturnData/IRS1098E">
            <form id="FSTDLOAN">
                <if test="count(ReturnData/IRS1098E) > 0">
                    <table id="SLITBL">
                        <for-each select="ReturnData/IRS1098E">
                            <row>
                                <copy-of select="@uuid"/>
                                <apply-templates select="LenderNamePP" mode="Field">
                                    <with-param name="tpsId">LENDR</with-param>
                                </apply-templates>
                                <apply-templates select="BorrowerPP" mode="Field">
                                    <with-param name="tpsId">BTSJ</with-param>
                                </apply-templates>
                                <apply-templates select="LoanInterestAmtPP" mode="Field">
                                    <with-param name="tpsId">SLIAMT</with-param>
                                </apply-templates>
                            </row>
                        </for-each>
                    </table>
                </if>
                <apply-templates select="ReturnData/PPStudentLoanInterestWks" mode="FSTDLOAN-SUB"/>
            </form>
        </if>
    </template>
    <template match="ReturnData/PPStudentLoanInterestWks" mode="FSTDLOAN-SUB">
        <apply-templates select="HaveAnyStudentLoanIntPP" mode="Field">
            <with-param name="tpsId">HSTDLOAN</with-param>
        </apply-templates>
        <apply-templates select="HaveAnyMoreStudentLoanIntPP" mode="Field">
            <with-param name="tpsId">HADDSTDL</with-param>
        </apply-templates>
        <apply-templates select="QualifiedStudentLoansInterestAmtPP" mode="Field">
            <with-param name="tpsId">L1</with-param>
        </apply-templates>
        <apply-templates select="SmallerOfLine1OrLimitAmtPP" mode="Field">
            <with-param name="tpsId">L2</with-param>
        </apply-templates>
        <apply-templates select="ModifiedAGIAmtPP" mode="Field">
            <with-param name="tpsId">L3</with-param>
        </apply-templates>
        <apply-templates select="IncomeLimitAmtPP" mode="Field">
            <with-param name="tpsId">L4</with-param>
        </apply-templates>
        <apply-templates select="IncomeLimitAmtPP" mode="Field">
            <with-param name="tpsId">L5</with-param>
        </apply-templates>
        <apply-templates select="DivideLine5RtPP" mode="Field">
            <with-param name="tpsId">L6</with-param>
        </apply-templates>
        <apply-templates select="MultiplyLine2byLine6AmtPP" mode="Field">
            <with-param name="tpsId">L7</with-param>
        </apply-templates>
        <apply-templates select="StudentLoanInterestDeductionAmtPP" mode="Field">
            <with-param name="tpsId">L8</with-param>
        </apply-templates>
    </template>


    <!-- ######################## Utility Templates ######################## -->

    <template match="node()" mode="MonthEnumField">
        <param name="tpsId"/>
        <param name="src"/>
        <choose>
            <when test="text()='JANUARY'">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue">01</with-param>
                </apply-templates>
            </when>
            <when test="text()='FEBRUARY'">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue">02</with-param>
                </apply-templates>
            </when>
            <when test="text()='MARCH'">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue">03</with-param>
                </apply-templates>
            </when>
            <when test="text()='APRIL'">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue">04</with-param>
                </apply-templates>
            </when>
            <when test="text()='MAY'">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue">05</with-param>
                </apply-templates>
            </when>
            <when test="text()='JUNE'">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue">06</with-param>
                </apply-templates>
            </when>
            <when test="text()='JULY'">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue">07</with-param>
                </apply-templates>
            </when>
            <when test="text()='AUGUST'">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue">08</with-param>
                </apply-templates>
            </when>
            <when test="text()='SEPTEMBER'">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue">09</with-param>
                </apply-templates>
            </when>
            <when test="text()='OCTOBER'">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue">10</with-param>
                </apply-templates>
            </when>
            <when test="text()='NOVEMBER'">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue">11</with-param>
                </apply-templates>
            </when>
            <when test="text()='DECEMBER'">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue">12</with-param>
                </apply-templates>
            </when>
        </choose>
    </template>

    <template match="node()" mode="EnumField">
        <param name="tpsId"/>
        <param name="src"/>
        <param name="fieldValue"/>
        <element name="field">
            <if test="attribute::code">
                <attribute name="code">
                    <value-of select="@code"/>
                </attribute>
            </if>
            <if test="attribute::message">
                <attribute name="message">
                    <value-of select="@message"/>
                </attribute>
            </if>
            <if test="attribute::hasError">
                <attribute name="hasError">
                    <value-of select="@hasError"/>
                </attribute>
            </if>
            <attribute name="id">
                <value-of select="$tpsId"/>
            </attribute>
            <choose>
                <when test="$fieldValue">
                    <value>
                        <if test="$src">
                            <attribute name="source">
                                <value-of select="$src"/>
                            </attribute>
                        </if>
                        <value-of select="$fieldValue"/>
                    </value>
                </when>
                <otherwise>
                    <value>
                        <if test="$src">
                            <attribute name="source">
                                <value-of select="$src"/>
                            </attribute>
                        </if>
                        <text>true</text>
                    </value>
                </otherwise>
            </choose>
        </element>
    </template>

    <!-- Field Template -->
    <template match="node()" mode="Field">
        <param name="tpsId"/>
        <param name="src"/>
        <element name="field">
            <attribute name="id">
                <value-of select="$tpsId"/>
            </attribute>
            <if test="attribute::code">
                <attribute name="code">
                    <value-of select="@code"/>
                </attribute>
            </if>
            <if test="attribute::message">
                <attribute name="message">
                    <value-of select="@message"/>
                </attribute>
            </if>
            <if test="attribute::hasError">
                <attribute name="hasError">
                    <value-of select="@hasError"/>
                </attribute>
            </if>
            <value>
                <if test="$src">
                    <attribute name="source">
                        <value-of select="$src"/>
                    </attribute>
                </if>
                <value-of select="."/>
            </value>
        </element>
    </template>

    <!-- Mef typs is Boolean Tps type is Checkbox. Map 'X' if Mef=true; else if Mef=false map '' -->
    <template match="node()" mode="BoolToCheckBox">
        <param name="tpsId"/>
        <param name="src"/>
        <element name="field">
            <attribute name="id">
                <value-of select="$tpsId"/>
            </attribute>
            <if test="attribute::code">
                <attribute name="code">
                    <value-of select="@code"/>
                </attribute>
            </if>
            <if test="attribute::message">
                <attribute name="message">
                    <value-of select="@message"/>
                </attribute>
            </if>
            <if test="attribute::hasError">
                <attribute name="hasError">
                    <value-of select="@hasError"/>
                </attribute>
            </if>
            <value>
                <if test="$src">
                    <attribute name="source">
                        <value-of select="$src"/>
                    </attribute>
                </if>
                <choose>
                    <when test="contains(translate(text(),'true','TRUE'),'TRUE')">
                        <text>X</text>
                    </when>
                    <when test="contains(translate(text(),'false','FALSE'),'FALSE')">
                        <value-of select="''"/>
                    </when>
                </choose>
            </value>
        </element>
    </template>

    <!-- StateField Template -->
    <template match="node()" mode="StateField">
        <param name="taxAmt"/>
        <param name="taxAmtType"/>
        <param name="stateCode"/>
        <param name="stateCodeType"/>
        <param name="stateId"/>
        <param name="stateIdType"/>
        <apply-templates select="current()/StateTaxWithheldAmtCS" mode="FieldWithType">
            <with-param name="formmlId"><value-of select="$taxAmt"/></with-param>
            <with-param name="type"><value-of select="$taxAmtType"/></with-param>
        </apply-templates>
        <apply-templates select="current()/StateAbbreviationCdCS" mode="FieldWithType">
            <with-param name="formmlId"><value-of select="$stateCode"/></with-param>
            <with-param name="type"><value-of select="$stateCodeType"/></with-param>
        </apply-templates>
        <apply-templates select="current()/PayersStateIdNumCS" mode="FieldWithType">
            <with-param name="formmlId"><value-of select="$stateId"/></with-param>
            <with-param name="type"><value-of select="$stateIdType"/></with-param>
        </apply-templates>
    </template>

    <!-- FormMLField Template -->
    <template match="node()" mode="FormMLField">
        <param name="formmlId" />
        <param name="type" />
        <element name="field">
            <attribute name="xsi:type">
                <value-of select="$type" />
            </attribute>
            <attribute name="id">
                <value-of select="$formmlId" />
            </attribute>
            <value>
                <value-of select="current()" />
            </value>
        </element>
    </template>

    <!-- FormMLFieldCS Template tries to use the CS value if it is not empty-->
    <template match="node()" mode="FormMLFieldCS">
        <param name="formmlId" />
        <param name="type" />
        <param name="CSVal" />
        <element name="field">
            <attribute name="xsi:type">
                <value-of select="$type" />
            </attribute>
            <attribute name="id">
                <value-of select="$formmlId" />
            </attribute>
            <value>
                <choose>
                    <when test="not($CSVal = '')">
                        <value-of select="$CSVal"/>
                    </when>
                    <otherwise>
                        <value-of select="current()" />
                    </otherwise>
                </choose>
            </value>
        </element>
    </template>

    <!-- Field with "type" -->
    <template match="node()" mode="FieldWithType">
        <param name="formmlId" />
        <param name="type" />
        <element name="field">
            <attribute name="xsi:type">
                <value-of select="$type" />
            </attribute>
            <attribute name="id">
                <value-of select="$formmlId" />
            </attribute>
            <value>
                <attribute name="source">generalImport</attribute>
                <value-of select="current()" />
            </value>
        </element>
    </template>

    <!-- YesNoField Template -->
    <template match="node()" mode="YesNoField">
        <param name="yTpsId"/>
        <param name="nTpsId"/>
        <param name="src"/>
        <if test="contains(text(),'true') or contains(translate(text(),'x','X'),'X')">
            <element name="field">
                <attribute name="id">
                    <value-of select="$yTpsId"/>
                </attribute>
                <value>
                    <if test="$src">
                        <attribute name="source">
                            <value-of select="$src"/>
                        </attribute>
                    </if>
                    <text>X</text>
                </value>
            </element>
        </if>
        <if test="contains(text(),'false')">
            <element name="field">
                <attribute name="id">
                    <value-of select="$nTpsId"/>
                </attribute>
                <if test="attribute::code">
                    <attribute name="code">
                        <value-of select="@code"/>
                    </attribute>
                </if>
                <if test="attribute::message">
                    <attribute name="message">
                        <value-of select="@message"/>
                    </attribute>
                </if>
                <if test="attribute::hasError">
                    <attribute name="hasError">
                        <value-of select="@hasError"/>
                    </attribute>
                </if>
                <value>
                    <if test="$src">
                        <attribute name="source">
                            <value-of select="$src"/>
                        </attribute>
                    </if>
                    <text>X</text>
                </value>
            </element>
        </if>
    </template>

    <!-- Date Template -->
    <!-- Convert YYYY-MM-DD to YYYYMMDD -->
    <template match="node()" mode="Date">
        <param name="tpsId"/>
        <param name="src"/>
        <variable name="yyyy" select="substring(text(),1,4)"/>
        <variable name="mm" select="substring(text(),6,2)"/>
        <variable name="dd" select="substring(text(),9,2)"/>
        <element name="field">
            <attribute name="id">
                <value-of select="$tpsId"/>
            </attribute>
            <if test="attribute::code">
                <attribute name="code">
                    <value-of select="@code"/>
                </attribute>
            </if>
            <if test="attribute::message">
                <attribute name="message">
                    <value-of select="@message"/>
                </attribute>
            </if>
            <if test="attribute::hasError">
                <attribute name="hasError">
                    <value-of select="@hasError"/>
                </attribute>
            </if>
            <value>
                <if test="$src">
                    <attribute name="source">
                        <value-of select="$src"/>
                    </attribute>
                </if>
                <value-of select="concat($yyyy,$mm,$dd)"/>
            </value>
        </element>
    </template>

    <!--The only valid value for true is X, all others are false based on the IRS spec for fields this is applied to-->
    <template name="CheckboxField">
        <param name="formmlId" />
        <param name="type" />
        <param name="input"/>
        <variable name="returnValue">
            <choose>
                <when test="$input = 'X'">true</when>
                <otherwise>false</otherwise>
            </choose>
        </variable>
        <element name="field">
            <attribute name="xsi:type">
                <value-of select="$type" />
            </attribute>
            <attribute name="id">
                <value-of select="$formmlId" />
            </attribute>
            <value>
                <value-of select="$returnValue" />
            </value>
        </element>
    </template>

    <!--The only valid value for true is X, all others are false based on the IRS spec for fields this is applied to-->
    <template match="node()" mode="ResolveStandardField">
        <param name="formmlId" />
        <param name="type" />
        <variable name="returnValue">
            <choose>
                <when test="current() = 'N'">X</when>
                <otherwise></otherwise>
            </choose>
        </variable>
        <element name="field">
            <attribute name="xsi:type">
                <value-of select="$type" />
            </attribute>
            <attribute name="id">
                <value-of select="$formmlId" />
            </attribute>
            <value>
                <value-of select="$returnValue" />
            </value>
        </element>
    </template>

    <!-- Concatenate 2nd field -->
    <template match="node()" mode="ConcatFieldSpace">
        <param name="formmlId" />
        <param name="type" />
        <param name="name2" />

        <element name="field">
            <attribute name="xsi:type">
                <value-of select="$type" />
            </attribute>
            <attribute name="id">
                <value-of select="$formmlId" />
            </attribute>
            <value>
                <attribute name="source">generalImport</attribute>
                <value-of select="current()" />
                <if test="$name2">
                    <value-of select="' '" />
                    <value-of select="$name2" />
                </if>
            </value>
        </element>
    </template>

    <template match="node()" mode="Boolean01">
        <param name="tpsId"/>
        <param name="src"/>
        <element name="field">
            <attribute name="id">
                <value-of select="$tpsId"/>
            </attribute>
            <if test="attribute::code">
                <attribute name="code">
                    <value-of select="@code"/>
                </attribute>
            </if>
            <if test="attribute::message">
                <attribute name="message">
                    <value-of select="@message"/>
                </attribute>
            </if>
            <if test="attribute::hasError">
                <attribute name="hasError">
                    <value-of select="@hasError"/>
                </attribute>
            </if>
            <value>
                <if test="$src">
                    <attribute name="source">
                        <value-of select="$src"/>
                    </attribute>
                </if>
                <choose>
                    <when test="contains(translate(text(),'true','TRUE'),'TRUE')">
                        <value-of select="1"/>
                    </when>
                    <when test="contains(translate(text(),'false','FALSE'),'FALSE')">
                        <value-of select="0"/>
                    </when>
                </choose>
            </value>
        </element>
    </template>

    <variable name="SON">Son</variable>
    <variable name="DAUGHTER">Daughter</variable>
    <variable name="STEPCHILD">Stepchild</variable>
    <variable name="FOSTER_CHILD">Foster Child</variable>
    <variable name="BROTHER">Brother</variable>
    <variable name="SISTER">Sister</variable>
    <variable name="STEPBROTHER">Stepbrother</variable>
    <variable name="STEPSISTER">Stepsister</variable>
    <variable name="HALF_BROTHER">Half Brother</variable>
    <variable name="HALF_SISTER">Half Sister</variable>
    <variable name="GRANDCHILD">Grandchild</variable>
    <variable name="NIECE">Niece</variable>
    <variable name="NEPHEW">Nephew</variable>
    <variable name="PARENT">Parent</variable>
    <variable name="GRANDPARENT">Grandparent</variable>
    <variable name="AUNT">Aunt</variable>
    <variable name="UNCLE">Uncle</variable>
    <variable name="OTHER">Other</variable>
    <variable name="NONE">None</variable>
    <template match="node()" mode="DependentRelationshipCdMapping">
        <param name="tpsId"/>
        <param name="src"/>
        <choose>
            <when test="translate(text(),'SON',$SON)=$SON">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue"><value-of select="$SON"/></with-param>
                </apply-templates>
            </when>
            <when test="translate(text(),'DAUGHTER',$DAUGHTER)=$DAUGHTER">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue"><value-of select="$DAUGHTER"/></with-param>
                </apply-templates>
            </when>
            <when test="translate(text(),'STEPCHILD',$STEPCHILD)=$STEPCHILD">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue"><value-of select="$STEPCHILD"/></with-param>
                </apply-templates>
            </when>
            <when test="translate(text(),'FOSTER CHILD',$FOSTER_CHILD)=$FOSTER_CHILD">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue"><value-of select="$FOSTER_CHILD"/></with-param>
                </apply-templates>
            </when>
            <when test="translate(text(),'BROTHER',$BROTHER)=$BROTHER">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue"><value-of select="$BROTHER"/></with-param>
                </apply-templates>
            </when>
            <when test="text()='SISTER' or text()=$SISTER">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue"><value-of select="$SISTER"/></with-param>
                </apply-templates>
            </when>
            <when test="translate(text(),'STEPBROTHER',$STEPBROTHER)=$STEPBROTHER">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue"><value-of select="$STEPBROTHER"/></with-param>
                </apply-templates>
            </when>
            <when test="text()='STEPSISTER' or text()=$STEPSISTER">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue"><value-of select="$STEPSISTER"/></with-param>
                </apply-templates>
            </when>
            <when test="text()='HALF BROTHER' or text()=$HALF_BROTHER">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue"><value-of select="$HALF_BROTHER"/></with-param>
                </apply-templates>
            </when>
            <when test="text()='HALF SISTER' or text()=$HALF_SISTER">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue"><value-of select="$HALF_SISTER"/></with-param>
                </apply-templates>
            </when>
            <when test="translate(text(),'GRANDCHILD',$GRANDCHILD)=$GRANDCHILD">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue"><value-of select="$GRANDCHILD"/></with-param>
                </apply-templates>
            </when>
            <when test="translate(text(),'NIECE',$NIECE)=$NIECE">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue"><value-of select="$NIECE"/></with-param>
                </apply-templates>
            </when>
            <when test="translate(text(),'NEPHEW',$NEPHEW)=$NEPHEW">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue"><value-of select="$NEPHEW"/></with-param>
                </apply-templates>
            </when>
            <when test="translate(text(),'PARENT',$PARENT)=$PARENT">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue"><value-of select="$PARENT"/></with-param>
                </apply-templates>
            </when>
            <when test="translate(text(),'GRANDPARENT',$GRANDPARENT)=$GRANDPARENT">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue"><value-of select="$GRANDPARENT"/></with-param>
                </apply-templates>
            </when>
            <when test="translate(text(),'AUNT',$AUNT)=$AUNT">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue"><value-of select="$AUNT"/></with-param>
                </apply-templates>
            </when>
            <when test="translate(text(),'UNCLE',$UNCLE)=$UNCLE">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue"><value-of select="$UNCLE"/></with-param>
                </apply-templates>
            </when>
            <when test="translate(text(),'OTHER',$OTHER)=$OTHER">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue"><value-of select="$OTHER"/></with-param>
                </apply-templates>
            </when>
            <when test="text()='NONE'or text()=$NONE">
                <apply-templates select="." mode="EnumField">
                    <with-param name="tpsId" select="$tpsId"/>
                    <with-param name="src" select="$src"/>
                    <with-param name="fieldValue"><value-of select="$NONE"/></with-param>
                </apply-templates>
            </when>
        </choose>
    </template>


    <template name="genPath">
        <param name="prevPath"/>
        <!-- Variable that determines if an attribute is needed in the xpath or not -->
        <variable name="selector">
            <choose>
                <when test="@uuid and (name() != 'ReturnData' and name() != 'ReturnHeader')">
                    <value-of select="concat('[@uuid=',@uuid,']')"/>
                </when>
                <otherwise>
                    <choose>
                        <when test="count(preceding-sibling::*[name() = name(current())]) = 0">
                            <value-of select="''"/>
                        </when>
                        <otherwise>
                            <value-of select="concat('[', count(preceding-sibling::*[name() = name(current())])+1 ,']')"/>
                        </otherwise>
                    </choose>
                </otherwise>
            </choose>
        </variable>
        <!-- Variable that holds the value of the current Path -->
        <variable name="currPath" select="concat('/',name(), $selector ,$prevPath)"/>
        <for-each select="parent::*">
            <call-template name="genPath">
                <with-param name="prevPath" select="$currPath"/>
            </call-template>
        </for-each>
        <if test="not(parent::*)">
            <value-of select="$currPath"/>
        </if>
    </template>

</stylesheet>
