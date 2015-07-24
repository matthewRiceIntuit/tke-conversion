# Generated from java-escape by ANTLR 4.5
# encoding: utf-8
from __future__ import print_function
from antlr4 import *
from io import StringIO
package = globals().get("__package__", None)
ischild = len(package)>0 if package is not None else False
if ischild:
    from .CalcListener import CalcListener
else:
    from CalcListener import CalcListener
def serializedATN():
    with StringIO() as buf:
        buf.write(u"\3\u0430\ud6d1\u8206\uad2d\u4417\uaef1\u8d80\uaadd\3")
        buf.write(u"+\u010a\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t")
        buf.write(u"\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t\13\4\f\t\f\4\r\t\r")
        buf.write(u"\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22\4")
        buf.write(u"\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30")
        buf.write(u"\t\30\4\31\t\31\4\32\t\32\3\2\3\2\5\2\67\n\2\3\2\7\2")
        buf.write(u":\n\2\f\2\16\2=\13\2\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3")
        buf.write(u"\3\3\3\4\3\4\3\5\3\5\3\5\3\5\5\5N\n\5\3\5\3\5\3\6\3\6")
        buf.write(u"\7\6T\n\6\f\6\16\6W\13\6\3\6\3\6\3\6\3\7\3\7\7\7^\n\7")
        buf.write(u"\f\7\16\7a\13\7\3\7\3\7\3\b\3\b\3\b\3\b\3\b\3\b\5\bk")
        buf.write(u"\n\b\3\t\3\t\3\t\3\t\3\t\3\n\3\n\3\n\3\n\3\n\3\13\3\13")
        buf.write(u"\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3")
        buf.write(u"\13\5\13\u0084\n\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13")
        buf.write(u"\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3")
        buf.write(u"\13\3\13\3\13\7\13\u009a\n\13\f\13\16\13\u009d\13\13")
        buf.write(u"\3\f\3\f\3\f\7\f\u00a2\n\f\f\f\16\f\u00a5\13\f\5\f\u00a7")
        buf.write(u"\n\f\3\r\3\r\7\r\u00ab\n\r\f\r\16\r\u00ae\13\r\3\16\3")
        buf.write(u"\16\3\16\7\16\u00b3\n\16\f\16\16\16\u00b6\13\16\5\16")
        buf.write(u"\u00b8\n\16\3\16\3\16\3\16\3\16\3\17\3\17\3\20\3\20\3")
        buf.write(u"\21\3\21\5\21\u00c4\n\21\3\22\3\22\3\22\3\22\3\22\3\22")
        buf.write(u"\5\22\u00cc\n\22\3\22\5\22\u00cf\n\22\3\23\3\23\3\23")
        buf.write(u"\5\23\u00d4\n\23\3\24\3\24\3\24\5\24\u00d9\n\24\3\24")
        buf.write(u"\7\24\u00dc\n\24\f\24\16\24\u00df\13\24\3\24\3\24\3\24")
        buf.write(u"\5\24\u00e4\n\24\3\25\3\25\5\25\u00e8\n\25\3\25\3\25")
        buf.write(u"\3\26\3\26\3\26\3\26\5\26\u00f0\n\26\3\26\3\26\3\27\3")
        buf.write(u"\27\7\27\u00f6\n\27\f\27\16\27\u00f9\13\27\3\27\3\27")
        buf.write(u"\3\30\3\30\3\30\3\30\5\30\u0101\n\30\3\31\3\31\5\31\u0105")
        buf.write(u"\n\31\3\32\3\32\3\32\3\32\2\3\24\33\2\4\6\b\n\f\16\20")
        buf.write(u"\22\24\26\30\32\34\36 \"$&(*,.\60\62\2\6\3\2\n\13\3\2")
        buf.write(u"\f\r\3\2\16\17\3\2\20\24\u0113\2\64\3\2\2\2\4>\3\2\2")
        buf.write(u"\2\6G\3\2\2\2\bI\3\2\2\2\nQ\3\2\2\2\f[\3\2\2\2\16j\3")
        buf.write(u"\2\2\2\20l\3\2\2\2\22q\3\2\2\2\24\u0083\3\2\2\2\26\u00a6")
        buf.write(u"\3\2\2\2\30\u00a8\3\2\2\2\32\u00b7\3\2\2\2\34\u00bd\3")
        buf.write(u"\2\2\2\36\u00bf\3\2\2\2 \u00c3\3\2\2\2\"\u00c5\3\2\2")
        buf.write(u"\2$\u00d0\3\2\2\2&\u00d5\3\2\2\2(\u00e5\3\2\2\2*\u00eb")
        buf.write(u"\3\2\2\2,\u00f3\3\2\2\2.\u00fc\3\2\2\2\60\u0102\3\2\2")
        buf.write(u"\2\62\u0106\3\2\2\2\64\66\5\4\3\2\65\67\5\30\r\2\66\65")
        buf.write(u"\3\2\2\2\66\67\3\2\2\2\67;\3\2\2\28:\5\b\5\298\3\2\2")
        buf.write(u"\2:=\3\2\2\2;9\3\2\2\2;<\3\2\2\2<\3\3\2\2\2=;\3\2\2\2")
        buf.write(u">?\7\3\2\2?@\7\4\2\2@A\7\5\2\2AB\7&\2\2BC\7\6\2\2CD\7")
        buf.write(u"\7\2\2DE\5\6\4\2EF\7\b\2\2F\5\3\2\2\2GH\7&\2\2H\7\3\2")
        buf.write(u"\2\2IJ\7\t\2\2JK\7&\2\2KM\7\b\2\2LN\5\30\r\2ML\3\2\2")
        buf.write(u"\2MN\3\2\2\2NO\3\2\2\2OP\5\n\6\2P\t\3\2\2\2QU\7#\2\2")
        buf.write(u"RT\5\16\b\2SR\3\2\2\2TW\3\2\2\2US\3\2\2\2UV\3\2\2\2V")
        buf.write(u"X\3\2\2\2WU\3\2\2\2XY\7$\2\2YZ\7\b\2\2Z\13\3\2\2\2[_")
        buf.write(u"\7#\2\2\\^\5\16\b\2]\\\3\2\2\2^a\3\2\2\2_]\3\2\2\2_`")
        buf.write(u"\3\2\2\2`b\3\2\2\2a_\3\2\2\2bc\7$\2\2c\r\3\2\2\2dk\5")
        buf.write(u"\20\t\2ef\5\22\n\2fg\7\b\2\2gk\3\2\2\2hk\5(\25\2ik\5")
        buf.write(u" \21\2jd\3\2\2\2je\3\2\2\2jh\3\2\2\2ji\3\2\2\2k\17\3")
        buf.write(u"\2\2\2lm\5\60\31\2mn\7%\2\2no\5\24\13\2op\7\b\2\2p\21")
        buf.write(u"\3\2\2\2qr\7&\2\2rs\7\5\2\2st\5\26\f\2tu\7\6\2\2u\23")
        buf.write(u"\3\2\2\2vw\b\13\1\2w\u0084\5\60\31\2x\u0084\5\22\n\2")
        buf.write(u"yz\7\26\2\2z{\7\5\2\2{|\5\26\f\2|}\7\6\2\2}\u0084\3\2")
        buf.write(u"\2\2~\u0084\7\31\2\2\177\u0080\7\5\2\2\u0080\u0081\5")
        buf.write(u"\24\13\2\u0081\u0082\7\6\2\2\u0082\u0084\3\2\2\2\u0083")
        buf.write(u"v\3\2\2\2\u0083x\3\2\2\2\u0083y\3\2\2\2\u0083~\3\2\2")
        buf.write(u"\2\u0083\177\3\2\2\2\u0084\u009b\3\2\2\2\u0085\u0086")
        buf.write(u"\f\f\2\2\u0086\u0087\t\2\2\2\u0087\u009a\5\24\13\r\u0088")
        buf.write(u"\u0089\f\13\2\2\u0089\u008a\t\3\2\2\u008a\u009a\5\24")
        buf.write(u"\13\f\u008b\u008c\f\n\2\2\u008c\u008d\t\4\2\2\u008d\u009a")
        buf.write(u"\5\24\13\13\u008e\u008f\f\t\2\2\u008f\u0090\t\5\2\2\u0090")
        buf.write(u"\u009a\5\24\13\n\u0091\u0092\f\b\2\2\u0092\u0093\7\13")
        buf.write(u"\2\2\u0093\u0094\7\5\2\2\u0094\u0095\5\24\13\2\u0095")
        buf.write(u"\u0096\7\n\2\2\u0096\u0097\7\25\2\2\u0097\u0098\7\6\2")
        buf.write(u"\2\u0098\u009a\3\2\2\2\u0099\u0085\3\2\2\2\u0099\u0088")
        buf.write(u"\3\2\2\2\u0099\u008b\3\2\2\2\u0099\u008e\3\2\2\2\u0099")
        buf.write(u"\u0091\3\2\2\2\u009a\u009d\3\2\2\2\u009b\u0099\3\2\2")
        buf.write(u"\2\u009b\u009c\3\2\2\2\u009c\25\3\2\2\2\u009d\u009b\3")
        buf.write(u"\2\2\2\u009e\u00a3\5\24\13\2\u009f\u00a0\7\27\2\2\u00a0")
        buf.write(u"\u00a2\5\24\13\2\u00a1\u009f\3\2\2\2\u00a2\u00a5\3\2")
        buf.write(u"\2\2\u00a3\u00a1\3\2\2\2\u00a3\u00a4\3\2\2\2\u00a4\u00a7")
        buf.write(u"\3\2\2\2\u00a5\u00a3\3\2\2\2\u00a6\u009e\3\2\2\2\u00a6")
        buf.write(u"\u00a7\3\2\2\2\u00a7\27\3\2\2\2\u00a8\u00ac\7\32\2\2")
        buf.write(u"\u00a9\u00ab\5\32\16\2\u00aa\u00a9\3\2\2\2\u00ab\u00ae")
        buf.write(u"\3\2\2\2\u00ac\u00aa\3\2\2\2\u00ac\u00ad\3\2\2\2\u00ad")
        buf.write(u"\31\3\2\2\2\u00ae\u00ac\3\2\2\2\u00af\u00b4\5\34\17\2")
        buf.write(u"\u00b0\u00b1\7\27\2\2\u00b1\u00b3\5\34\17\2\u00b2\u00b0")
        buf.write(u"\3\2\2\2\u00b3\u00b6\3\2\2\2\u00b4\u00b2\3\2\2\2\u00b4")
        buf.write(u"\u00b5\3\2\2\2\u00b5\u00b8\3\2\2\2\u00b6\u00b4\3\2\2")
        buf.write(u"\2\u00b7\u00af\3\2\2\2\u00b7\u00b8\3\2\2\2\u00b8\u00b9")
        buf.write(u"\3\2\2\2\u00b9\u00ba\7\30\2\2\u00ba\u00bb\5\36\20\2\u00bb")
        buf.write(u"\u00bc\7\b\2\2\u00bc\33\3\2\2\2\u00bd\u00be\7&\2\2\u00be")
        buf.write(u"\35\3\2\2\2\u00bf\u00c0\7&\2\2\u00c0\37\3\2\2\2\u00c1")
        buf.write(u"\u00c4\5\"\22\2\u00c2\u00c4\5&\24\2\u00c3\u00c1\3\2\2")
        buf.write(u"\2\u00c3\u00c2\3\2\2\2\u00c4!\3\2\2\2\u00c5\u00c6\7\33")
        buf.write(u"\2\2\u00c6\u00c7\5\24\13\2\u00c7\u00cb\7\35\2\2\u00c8")
        buf.write(u"\u00cc\5\n\6\2\u00c9\u00cc\5\16\b\2\u00ca\u00cc\5\f\7")
        buf.write(u"\2\u00cb\u00c8\3\2\2\2\u00cb\u00c9\3\2\2\2\u00cb\u00ca")
        buf.write(u"\3\2\2\2\u00cc\u00ce\3\2\2\2\u00cd\u00cf\5$\23\2\u00ce")
        buf.write(u"\u00cd\3\2\2\2\u00ce\u00cf\3\2\2\2\u00cf#\3\2\2\2\u00d0")
        buf.write(u"\u00d3\7\34\2\2\u00d1\u00d4\5\n\6\2\u00d2\u00d4\5\16")
        buf.write(u"\b\2\u00d3\u00d1\3\2\2\2\u00d3\u00d2\3\2\2\2\u00d4%\3")
        buf.write(u"\2\2\2\u00d5\u00d8\7\36\2\2\u00d6\u00d7\7\37\2\2\u00d7")
        buf.write(u"\u00d9\5\24\13\2\u00d8\u00d6\3\2\2\2\u00d8\u00d9\3\2")
        buf.write(u"\2\2\u00d9\u00dd\3\2\2\2\u00da\u00dc\5\16\b\2\u00db\u00da")
        buf.write(u"\3\2\2\2\u00dc\u00df\3\2\2\2\u00dd\u00db\3\2\2\2\u00dd")
        buf.write(u"\u00de\3\2\2\2\u00de\u00e0\3\2\2\2\u00df\u00dd\3\2\2")
        buf.write(u"\2\u00e0\u00e3\7 \2\2\u00e1\u00e2\7\37\2\2\u00e2\u00e4")
        buf.write(u"\5\24\13\2\u00e3\u00e1\3\2\2\2\u00e3\u00e4\3\2\2\2\u00e4")
        buf.write(u"\'\3\2\2\2\u00e5\u00e7\7!\2\2\u00e6\u00e8\5\24\13\2\u00e7")
        buf.write(u"\u00e6\3\2\2\2\u00e7\u00e8\3\2\2\2\u00e8\u00e9\3\2\2")
        buf.write(u"\2\u00e9\u00ea\7\b\2\2\u00ea)\3\2\2\2\u00eb\u00ec\5\60")
        buf.write(u"\31\2\u00ec\u00ed\5\60\31\2\u00ed\u00ef\5,\27\2\u00ee")
        buf.write(u"\u00f0\5\30\r\2\u00ef\u00ee\3\2\2\2\u00ef\u00f0\3\2\2")
        buf.write(u"\2\u00f0\u00f1\3\2\2\2\u00f1\u00f2\5\n\6\2\u00f2+\3\2")
        buf.write(u"\2\2\u00f3\u00f7\7\5\2\2\u00f4\u00f6\5.\30\2\u00f5\u00f4")
        buf.write(u"\3\2\2\2\u00f6\u00f9\3\2\2\2\u00f7\u00f5\3\2\2\2\u00f7")
        buf.write(u"\u00f8\3\2\2\2\u00f8\u00fa\3\2\2\2\u00f9\u00f7\3\2\2")
        buf.write(u"\2\u00fa\u00fb\7\6\2\2\u00fb-\3\2\2\2\u00fc\u00fd\5\36")
        buf.write(u"\20\2\u00fd\u0100\5\60\31\2\u00fe\u00ff\7%\2\2\u00ff")
        buf.write(u"\u0101\5\24\13\2\u0100\u00fe\3\2\2\2\u0100\u0101\3\2")
        buf.write(u"\2\2\u0101/\3\2\2\2\u0102\u0104\7&\2\2\u0103\u0105\5")
        buf.write(u"\62\32\2\u0104\u0103\3\2\2\2\u0104\u0105\3\2\2\2\u0105")
        buf.write(u"\61\3\2\2\2\u0106\u0107\7\7\2\2\u0107\u0108\7&\2\2\u0108")
        buf.write(u"\63\3\2\2\2\34\66;MU_j\u0083\u0099\u009b\u00a3\u00a6")
        buf.write(u"\u00ac\u00b4\u00b7\u00c3\u00cb\u00ce\u00d3\u00d8\u00dd")
        buf.write(u"\u00e3\u00e7\u00ef\u00f7\u0100\u0104")
        return buf.getvalue()


class CalcParser ( Parser ):

    grammarFileName = "java-escape"

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    sharedContextCache = PredictionContextCache()

    literalNames = [ u"<INVALID>", u"'FORM'", u"'FORMSET'", u"'('", u"')'", 
                     u"'.'", u"';'", u"'SECTION'", u"'/'", u"'*'", u"'+'", 
                     u"'-'", u"'and'", u"'or'", u"'>'", u"'<'", u"'<='", 
                     u"'>='", u"'='", u"'100'", u"'MAX'", u"','", u"':'", 
                     u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                     u"<INVALID>", u"'do'", u"'while'", u"'loop'", u"'return'", 
                     u"<INVALID>", u"<INVALID>", u"<INVALID>", u"':='" ]

    symbolicNames = [ u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"LITERAL", 
                      u"VAR", u"IF", u"ELSE", u"THEN", u"DO", u"WHILE", 
                      u"LOOP", u"RETURN", u"WS", u"BEGIN", u"END", u"LET", 
                      u"ID", u"INT", u"STRING", u"BOOLEAN", u"COMMENT", 
                      u"LINE_COMMENT" ]

    RULE_calcfile = 0
    RULE_formset = 1
    RULE_form = 2
    RULE_section = 3
    RULE_block = 4
    RULE_dumbblock = 5
    RULE_stmt = 6
    RULE_assign = 7
    RULE_call = 8
    RULE_expr = 9
    RULE_argList = 10
    RULE_decl = 11
    RULE_declList = 12
    RULE_varDecl = 13
    RULE_r_type = 14
    RULE_ctrlStruct = 15
    RULE_ifStruct = 16
    RULE_elseStruct = 17
    RULE_loopStruct = 18
    RULE_ret = 19
    RULE_function = 20
    RULE_formParList = 21
    RULE_formPar = 22
    RULE_full_id = 23
    RULE_sub_id = 24

    ruleNames =  [ u"calcfile", u"formset", u"form", u"section", u"block", 
                   u"dumbblock", u"stmt", u"assign", u"call", u"expr", u"argList", 
                   u"decl", u"declList", u"varDecl", u"r_type", u"ctrlStruct", 
                   u"ifStruct", u"elseStruct", u"loopStruct", u"ret", u"function", 
                   u"formParList", u"formPar", u"full_id", u"sub_id" ]

    EOF = Token.EOF
    T__0=1
    T__1=2
    T__2=3
    T__3=4
    T__4=5
    T__5=6
    T__6=7
    T__7=8
    T__8=9
    T__9=10
    T__10=11
    T__11=12
    T__12=13
    T__13=14
    T__14=15
    T__15=16
    T__16=17
    T__17=18
    T__18=19
    T__19=20
    T__20=21
    T__21=22
    LITERAL=23
    VAR=24
    IF=25
    ELSE=26
    THEN=27
    DO=28
    WHILE=29
    LOOP=30
    RETURN=31
    WS=32
    BEGIN=33
    END=34
    LET=35
    ID=36
    INT=37
    STRING=38
    BOOLEAN=39
    COMMENT=40
    LINE_COMMENT=41

    def __init__(self, input):
        super(CalcParser, self).__init__(input)
        self.checkVersion("4.5")
        self._interp = ParserATNSimulator(self, self.atn, self.decisionsToDFA, self.sharedContextCache)
        self._predicates = None



    class CalcfileContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.CalcfileContext, self).__init__(parent, invokingState)
            self.parser = parser

        def formset(self):
            return self.getTypedRuleContext(CalcParser.FormsetContext,0)


        def decl(self):
            return self.getTypedRuleContext(CalcParser.DeclContext,0)


        def section(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(CalcParser.SectionContext)
            else:
                return self.getTypedRuleContext(CalcParser.SectionContext,i)


        def getRuleIndex(self):
            return CalcParser.RULE_calcfile

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterCalcfile(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitCalcfile(self)




    def calcfile(self):

        localctx = CalcParser.CalcfileContext(self, self._ctx, self.state)
        self.enterRule(localctx, 0, self.RULE_calcfile)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 50
            self.formset()
            self.state = 52
            _la = self._input.LA(1)
            if _la==CalcParser.VAR:
                self.state = 51
                self.decl()


            self.state = 57
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==CalcParser.T__6:
                self.state = 54
                self.section()
                self.state = 59
                self._errHandler.sync(self)
                _la = self._input.LA(1)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class FormsetContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.FormsetContext, self).__init__(parent, invokingState)
            self.parser = parser

        def ID(self):
            return self.getToken(CalcParser.ID, 0)

        def form(self):
            return self.getTypedRuleContext(CalcParser.FormContext,0)


        def getRuleIndex(self):
            return CalcParser.RULE_formset

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterFormset(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitFormset(self)




    def formset(self):

        localctx = CalcParser.FormsetContext(self, self._ctx, self.state)
        self.enterRule(localctx, 2, self.RULE_formset)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 60
            self.match(CalcParser.T__0)
            self.state = 61
            self.match(CalcParser.T__1)
            self.state = 62
            self.match(CalcParser.T__2)
            self.state = 63
            self.match(CalcParser.ID)
            self.state = 64
            self.match(CalcParser.T__3)
            self.state = 65
            self.match(CalcParser.T__4)
            self.state = 66
            self.form()
            self.state = 67
            self.match(CalcParser.T__5)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class FormContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.FormContext, self).__init__(parent, invokingState)
            self.parser = parser

        def ID(self):
            return self.getToken(CalcParser.ID, 0)

        def getRuleIndex(self):
            return CalcParser.RULE_form

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterForm(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitForm(self)




    def form(self):

        localctx = CalcParser.FormContext(self, self._ctx, self.state)
        self.enterRule(localctx, 4, self.RULE_form)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 69
            self.match(CalcParser.ID)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class SectionContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.SectionContext, self).__init__(parent, invokingState)
            self.parser = parser

        def ID(self):
            return self.getToken(CalcParser.ID, 0)

        def block(self):
            return self.getTypedRuleContext(CalcParser.BlockContext,0)


        def decl(self):
            return self.getTypedRuleContext(CalcParser.DeclContext,0)


        def getRuleIndex(self):
            return CalcParser.RULE_section

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterSection(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitSection(self)




    def section(self):

        localctx = CalcParser.SectionContext(self, self._ctx, self.state)
        self.enterRule(localctx, 6, self.RULE_section)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 71
            self.match(CalcParser.T__6)
            self.state = 72
            self.match(CalcParser.ID)
            self.state = 73
            self.match(CalcParser.T__5)
            self.state = 75
            _la = self._input.LA(1)
            if _la==CalcParser.VAR:
                self.state = 74
                self.decl()


            self.state = 77
            self.block()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class BlockContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.BlockContext, self).__init__(parent, invokingState)
            self.parser = parser

        def BEGIN(self):
            return self.getToken(CalcParser.BEGIN, 0)

        def END(self):
            return self.getToken(CalcParser.END, 0)

        def stmt(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(CalcParser.StmtContext)
            else:
                return self.getTypedRuleContext(CalcParser.StmtContext,i)


        def getRuleIndex(self):
            return CalcParser.RULE_block

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterBlock(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitBlock(self)




    def block(self):

        localctx = CalcParser.BlockContext(self, self._ctx, self.state)
        self.enterRule(localctx, 8, self.RULE_block)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 79
            self.match(CalcParser.BEGIN)
            self.state = 83
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.IF) | (1 << CalcParser.DO) | (1 << CalcParser.RETURN) | (1 << CalcParser.ID))) != 0):
                self.state = 80
                self.stmt()
                self.state = 85
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 86
            self.match(CalcParser.END)
            self.state = 87
            self.match(CalcParser.T__5)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class DumbblockContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.DumbblockContext, self).__init__(parent, invokingState)
            self.parser = parser

        def BEGIN(self):
            return self.getToken(CalcParser.BEGIN, 0)

        def END(self):
            return self.getToken(CalcParser.END, 0)

        def stmt(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(CalcParser.StmtContext)
            else:
                return self.getTypedRuleContext(CalcParser.StmtContext,i)


        def getRuleIndex(self):
            return CalcParser.RULE_dumbblock

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterDumbblock(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitDumbblock(self)




    def dumbblock(self):

        localctx = CalcParser.DumbblockContext(self, self._ctx, self.state)
        self.enterRule(localctx, 10, self.RULE_dumbblock)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 89
            self.match(CalcParser.BEGIN)
            self.state = 93
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.IF) | (1 << CalcParser.DO) | (1 << CalcParser.RETURN) | (1 << CalcParser.ID))) != 0):
                self.state = 90
                self.stmt()
                self.state = 95
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 96
            self.match(CalcParser.END)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class StmtContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.StmtContext, self).__init__(parent, invokingState)
            self.parser = parser

        def assign(self):
            return self.getTypedRuleContext(CalcParser.AssignContext,0)


        def call(self):
            return self.getTypedRuleContext(CalcParser.CallContext,0)


        def ret(self):
            return self.getTypedRuleContext(CalcParser.RetContext,0)


        def ctrlStruct(self):
            return self.getTypedRuleContext(CalcParser.CtrlStructContext,0)


        def getRuleIndex(self):
            return CalcParser.RULE_stmt

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterStmt(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitStmt(self)




    def stmt(self):

        localctx = CalcParser.StmtContext(self, self._ctx, self.state)
        self.enterRule(localctx, 12, self.RULE_stmt)
        try:
            self.state = 104
            la_ = self._interp.adaptivePredict(self._input,5,self._ctx)
            if la_ == 1:
                self.enterOuterAlt(localctx, 1)
                self.state = 98
                self.assign()
                pass

            elif la_ == 2:
                self.enterOuterAlt(localctx, 2)
                self.state = 99
                self.call()
                self.state = 100
                self.match(CalcParser.T__5)
                pass

            elif la_ == 3:
                self.enterOuterAlt(localctx, 3)
                self.state = 102
                self.ret()
                pass

            elif la_ == 4:
                self.enterOuterAlt(localctx, 4)
                self.state = 103
                self.ctrlStruct()
                pass


        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class AssignContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.AssignContext, self).__init__(parent, invokingState)
            self.parser = parser

        def full_id(self):
            return self.getTypedRuleContext(CalcParser.Full_idContext,0)


        def LET(self):
            return self.getToken(CalcParser.LET, 0)

        def expr(self):
            return self.getTypedRuleContext(CalcParser.ExprContext,0)


        def getRuleIndex(self):
            return CalcParser.RULE_assign

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterAssign(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitAssign(self)




    def assign(self):

        localctx = CalcParser.AssignContext(self, self._ctx, self.state)
        self.enterRule(localctx, 14, self.RULE_assign)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 106
            self.full_id()
            self.state = 107
            self.match(CalcParser.LET)
            self.state = 108
            self.expr(0)
            self.state = 109
            self.match(CalcParser.T__5)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class CallContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.CallContext, self).__init__(parent, invokingState)
            self.parser = parser

        def ID(self):
            return self.getToken(CalcParser.ID, 0)

        def argList(self):
            return self.getTypedRuleContext(CalcParser.ArgListContext,0)


        def getRuleIndex(self):
            return CalcParser.RULE_call

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterCall(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitCall(self)




    def call(self):

        localctx = CalcParser.CallContext(self, self._ctx, self.state)
        self.enterRule(localctx, 16, self.RULE_call)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 111
            self.match(CalcParser.ID)
            self.state = 112
            self.match(CalcParser.T__2)
            self.state = 113
            self.argList()
            self.state = 114
            self.match(CalcParser.T__3)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class ExprContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.ExprContext, self).__init__(parent, invokingState)
            self.parser = parser


        def getRuleIndex(self):
            return CalcParser.RULE_expr

     
        def copyFrom(self, ctx):
            super(CalcParser.ExprContext, self).copyFrom(ctx)


    class LogicContext(ExprContext):

        def __init__(self, parser, ctx): # actually a CalcParser.ExprContext)
            super(CalcParser.LogicContext, self).__init__(parser)
            self.op = None # Token
            self.copyFrom(ctx)

        def expr(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(CalcParser.ExprContext)
            else:
                return self.getTypedRuleContext(CalcParser.ExprContext,i)


        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterLogic(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitLogic(self)


    class ParensContext(ExprContext):

        def __init__(self, parser, ctx): # actually a CalcParser.ExprContext)
            super(CalcParser.ParensContext, self).__init__(parser)
            self.copyFrom(ctx)

        def expr(self):
            return self.getTypedRuleContext(CalcParser.ExprContext,0)


        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterParens(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitParens(self)


    class LiteralContext(ExprContext):

        def __init__(self, parser, ctx): # actually a CalcParser.ExprContext)
            super(CalcParser.LiteralContext, self).__init__(parser)
            self.copyFrom(ctx)

        def LITERAL(self):
            return self.getToken(CalcParser.LITERAL, 0)

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterLiteral(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitLiteral(self)


    class DivMulContext(ExprContext):

        def __init__(self, parser, ctx): # actually a CalcParser.ExprContext)
            super(CalcParser.DivMulContext, self).__init__(parser)
            self.op = None # Token
            self.copyFrom(ctx)

        def expr(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(CalcParser.ExprContext)
            else:
                return self.getTypedRuleContext(CalcParser.ExprContext,i)


        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterDivMul(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitDivMul(self)


    class AddSubContext(ExprContext):

        def __init__(self, parser, ctx): # actually a CalcParser.ExprContext)
            super(CalcParser.AddSubContext, self).__init__(parser)
            self.op = None # Token
            self.copyFrom(ctx)

        def expr(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(CalcParser.ExprContext)
            else:
                return self.getTypedRuleContext(CalcParser.ExprContext,i)


        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterAddSub(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitAddSub(self)


    class PredicateContext(ExprContext):

        def __init__(self, parser, ctx): # actually a CalcParser.ExprContext)
            super(CalcParser.PredicateContext, self).__init__(parser)
            self.op = None # Token
            self.copyFrom(ctx)

        def expr(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(CalcParser.ExprContext)
            else:
                return self.getTypedRuleContext(CalcParser.ExprContext,i)


        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterPredicate(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitPredicate(self)


    class MaxContext(ExprContext):

        def __init__(self, parser, ctx): # actually a CalcParser.ExprContext)
            super(CalcParser.MaxContext, self).__init__(parser)
            self.copyFrom(ctx)

        def argList(self):
            return self.getTypedRuleContext(CalcParser.ArgListContext,0)


        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterMax(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitMax(self)


    class PercentageOfContext(ExprContext):

        def __init__(self, parser, ctx): # actually a CalcParser.ExprContext)
            super(CalcParser.PercentageOfContext, self).__init__(parser)
            self.copyFrom(ctx)

        def expr(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(CalcParser.ExprContext)
            else:
                return self.getTypedRuleContext(CalcParser.ExprContext,i)


        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterPercentageOf(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitPercentageOf(self)


    class VarRefContext(ExprContext):

        def __init__(self, parser, ctx): # actually a CalcParser.ExprContext)
            super(CalcParser.VarRefContext, self).__init__(parser)
            self.copyFrom(ctx)

        def full_id(self):
            return self.getTypedRuleContext(CalcParser.Full_idContext,0)


        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterVarRef(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitVarRef(self)


    class FunctionCallContext(ExprContext):

        def __init__(self, parser, ctx): # actually a CalcParser.ExprContext)
            super(CalcParser.FunctionCallContext, self).__init__(parser)
            self.copyFrom(ctx)

        def call(self):
            return self.getTypedRuleContext(CalcParser.CallContext,0)


        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterFunctionCall(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitFunctionCall(self)



    def expr(self, _p=0):
        _parentctx = self._ctx
        _parentState = self.state
        localctx = CalcParser.ExprContext(self, self._ctx, _parentState)
        _prevctx = localctx
        _startState = 18
        self.enterRecursionRule(localctx, 18, self.RULE_expr, _p)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 129
            la_ = self._interp.adaptivePredict(self._input,6,self._ctx)
            if la_ == 1:
                localctx = CalcParser.VarRefContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx

                self.state = 117
                self.full_id()
                pass

            elif la_ == 2:
                localctx = CalcParser.FunctionCallContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 118
                self.call()
                pass

            elif la_ == 3:
                localctx = CalcParser.MaxContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 119
                self.match(CalcParser.T__19)
                self.state = 120
                self.match(CalcParser.T__2)
                self.state = 121
                self.argList()
                self.state = 122
                self.match(CalcParser.T__3)
                pass

            elif la_ == 4:
                localctx = CalcParser.LiteralContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 124
                self.match(CalcParser.LITERAL)
                pass

            elif la_ == 5:
                localctx = CalcParser.ParensContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 125
                self.match(CalcParser.T__2)
                self.state = 126
                self.expr(0)
                self.state = 127
                self.match(CalcParser.T__3)
                pass


            self._ctx.stop = self._input.LT(-1)
            self.state = 153
            self._errHandler.sync(self)
            _alt = self._interp.adaptivePredict(self._input,8,self._ctx)
            while _alt!=2 and _alt!=ATN.INVALID_ALT_NUMBER:
                if _alt==1:
                    if self._parseListeners is not None:
                        self.triggerExitRuleEvent()
                    _prevctx = localctx
                    self.state = 151
                    la_ = self._interp.adaptivePredict(self._input,7,self._ctx)
                    if la_ == 1:
                        localctx = CalcParser.DivMulContext(self, CalcParser.ExprContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expr)
                        self.state = 131
                        if not self.precpred(self._ctx, 10):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 10)")
                        self.state = 132
                        localctx.op = self._input.LT(1)
                        _la = self._input.LA(1)
                        if not(_la==CalcParser.T__7 or _la==CalcParser.T__8):
                            localctx.op = self._errHandler.recoverInline(self)
                        else:
                            self.consume()
                        self.state = 133
                        self.expr(11)
                        pass

                    elif la_ == 2:
                        localctx = CalcParser.AddSubContext(self, CalcParser.ExprContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expr)
                        self.state = 134
                        if not self.precpred(self._ctx, 9):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 9)")
                        self.state = 135
                        localctx.op = self._input.LT(1)
                        _la = self._input.LA(1)
                        if not(_la==CalcParser.T__9 or _la==CalcParser.T__10):
                            localctx.op = self._errHandler.recoverInline(self)
                        else:
                            self.consume()
                        self.state = 136
                        self.expr(10)
                        pass

                    elif la_ == 3:
                        localctx = CalcParser.LogicContext(self, CalcParser.ExprContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expr)
                        self.state = 137
                        if not self.precpred(self._ctx, 8):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 8)")
                        self.state = 138
                        localctx.op = self._input.LT(1)
                        _la = self._input.LA(1)
                        if not(_la==CalcParser.T__11 or _la==CalcParser.T__12):
                            localctx.op = self._errHandler.recoverInline(self)
                        else:
                            self.consume()
                        self.state = 139
                        self.expr(9)
                        pass

                    elif la_ == 4:
                        localctx = CalcParser.PredicateContext(self, CalcParser.ExprContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expr)
                        self.state = 140
                        if not self.precpred(self._ctx, 7):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 7)")
                        self.state = 141
                        localctx.op = self._input.LT(1)
                        _la = self._input.LA(1)
                        if not((((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.T__13) | (1 << CalcParser.T__14) | (1 << CalcParser.T__15) | (1 << CalcParser.T__16) | (1 << CalcParser.T__17))) != 0)):
                            localctx.op = self._errHandler.recoverInline(self)
                        else:
                            self.consume()
                        self.state = 142
                        self.expr(8)
                        pass

                    elif la_ == 5:
                        localctx = CalcParser.PercentageOfContext(self, CalcParser.ExprContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expr)
                        self.state = 143
                        if not self.precpred(self._ctx, 6):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 6)")
                        self.state = 144
                        self.match(CalcParser.T__8)
                        self.state = 145
                        self.match(CalcParser.T__2)
                        self.state = 146
                        self.expr(0)
                        self.state = 147
                        self.match(CalcParser.T__7)
                        self.state = 148
                        self.match(CalcParser.T__18)
                        self.state = 149
                        self.match(CalcParser.T__3)
                        pass

             
                self.state = 155
                self._errHandler.sync(self)
                _alt = self._interp.adaptivePredict(self._input,8,self._ctx)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.unrollRecursionContexts(_parentctx)
        return localctx

    class ArgListContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.ArgListContext, self).__init__(parent, invokingState)
            self.parser = parser

        def expr(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(CalcParser.ExprContext)
            else:
                return self.getTypedRuleContext(CalcParser.ExprContext,i)


        def getRuleIndex(self):
            return CalcParser.RULE_argList

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterArgList(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitArgList(self)




    def argList(self):

        localctx = CalcParser.ArgListContext(self, self._ctx, self.state)
        self.enterRule(localctx, 20, self.RULE_argList)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 164
            _la = self._input.LA(1)
            if (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.T__2) | (1 << CalcParser.T__19) | (1 << CalcParser.LITERAL) | (1 << CalcParser.ID))) != 0):
                self.state = 156
                self.expr(0)
                self.state = 161
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                while _la==CalcParser.T__20:
                    self.state = 157
                    self.match(CalcParser.T__20)
                    self.state = 158
                    self.expr(0)
                    self.state = 163
                    self._errHandler.sync(self)
                    _la = self._input.LA(1)



        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class DeclContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.DeclContext, self).__init__(parent, invokingState)
            self.parser = parser

        def VAR(self):
            return self.getToken(CalcParser.VAR, 0)

        def declList(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(CalcParser.DeclListContext)
            else:
                return self.getTypedRuleContext(CalcParser.DeclListContext,i)


        def getRuleIndex(self):
            return CalcParser.RULE_decl

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterDecl(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitDecl(self)




    def decl(self):

        localctx = CalcParser.DeclContext(self, self._ctx, self.state)
        self.enterRule(localctx, 22, self.RULE_decl)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 166
            self.match(CalcParser.VAR)
            self.state = 170
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==CalcParser.T__21 or _la==CalcParser.ID:
                self.state = 167
                self.declList()
                self.state = 172
                self._errHandler.sync(self)
                _la = self._input.LA(1)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class DeclListContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.DeclListContext, self).__init__(parent, invokingState)
            self.parser = parser

        def r_type(self):
            return self.getTypedRuleContext(CalcParser.R_typeContext,0)


        def varDecl(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(CalcParser.VarDeclContext)
            else:
                return self.getTypedRuleContext(CalcParser.VarDeclContext,i)


        def getRuleIndex(self):
            return CalcParser.RULE_declList

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterDeclList(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitDeclList(self)




    def declList(self):

        localctx = CalcParser.DeclListContext(self, self._ctx, self.state)
        self.enterRule(localctx, 24, self.RULE_declList)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 181
            _la = self._input.LA(1)
            if _la==CalcParser.ID:
                self.state = 173
                self.varDecl()
                self.state = 178
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                while _la==CalcParser.T__20:
                    self.state = 174
                    self.match(CalcParser.T__20)
                    self.state = 175
                    self.varDecl()
                    self.state = 180
                    self._errHandler.sync(self)
                    _la = self._input.LA(1)



            self.state = 183
            self.match(CalcParser.T__21)
            self.state = 184
            self.r_type()
            self.state = 185
            self.match(CalcParser.T__5)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class VarDeclContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.VarDeclContext, self).__init__(parent, invokingState)
            self.parser = parser

        def ID(self):
            return self.getToken(CalcParser.ID, 0)

        def getRuleIndex(self):
            return CalcParser.RULE_varDecl

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterVarDecl(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitVarDecl(self)




    def varDecl(self):

        localctx = CalcParser.VarDeclContext(self, self._ctx, self.state)
        self.enterRule(localctx, 26, self.RULE_varDecl)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 187
            self.match(CalcParser.ID)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class R_typeContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.R_typeContext, self).__init__(parent, invokingState)
            self.parser = parser

        def ID(self):
            return self.getToken(CalcParser.ID, 0)

        def getRuleIndex(self):
            return CalcParser.RULE_r_type

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterR_type(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitR_type(self)




    def r_type(self):

        localctx = CalcParser.R_typeContext(self, self._ctx, self.state)
        self.enterRule(localctx, 28, self.RULE_r_type)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 189
            self.match(CalcParser.ID)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class CtrlStructContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.CtrlStructContext, self).__init__(parent, invokingState)
            self.parser = parser

        def ifStruct(self):
            return self.getTypedRuleContext(CalcParser.IfStructContext,0)


        def loopStruct(self):
            return self.getTypedRuleContext(CalcParser.LoopStructContext,0)


        def getRuleIndex(self):
            return CalcParser.RULE_ctrlStruct

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterCtrlStruct(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitCtrlStruct(self)




    def ctrlStruct(self):

        localctx = CalcParser.CtrlStructContext(self, self._ctx, self.state)
        self.enterRule(localctx, 30, self.RULE_ctrlStruct)
        try:
            self.state = 193
            token = self._input.LA(1)
            if token in [CalcParser.IF]:
                self.enterOuterAlt(localctx, 1)
                self.state = 191
                self.ifStruct()

            elif token in [CalcParser.DO]:
                self.enterOuterAlt(localctx, 2)
                self.state = 192
                self.loopStruct()

            else:
                raise NoViableAltException(self)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class IfStructContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.IfStructContext, self).__init__(parent, invokingState)
            self.parser = parser

        def IF(self):
            return self.getToken(CalcParser.IF, 0)

        def expr(self):
            return self.getTypedRuleContext(CalcParser.ExprContext,0)


        def THEN(self):
            return self.getToken(CalcParser.THEN, 0)

        def block(self):
            return self.getTypedRuleContext(CalcParser.BlockContext,0)


        def stmt(self):
            return self.getTypedRuleContext(CalcParser.StmtContext,0)


        def dumbblock(self):
            return self.getTypedRuleContext(CalcParser.DumbblockContext,0)


        def elseStruct(self):
            return self.getTypedRuleContext(CalcParser.ElseStructContext,0)


        def getRuleIndex(self):
            return CalcParser.RULE_ifStruct

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterIfStruct(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitIfStruct(self)




    def ifStruct(self):

        localctx = CalcParser.IfStructContext(self, self._ctx, self.state)
        self.enterRule(localctx, 32, self.RULE_ifStruct)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 195
            self.match(CalcParser.IF)
            self.state = 196
            self.expr(0)
            self.state = 197
            self.match(CalcParser.THEN)
            self.state = 201
            la_ = self._interp.adaptivePredict(self._input,15,self._ctx)
            if la_ == 1:
                self.state = 198
                self.block()
                pass

            elif la_ == 2:
                self.state = 199
                self.stmt()
                pass

            elif la_ == 3:
                self.state = 200
                self.dumbblock()
                pass


            self.state = 204
            la_ = self._interp.adaptivePredict(self._input,16,self._ctx)
            if la_ == 1:
                self.state = 203
                self.elseStruct()


        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class ElseStructContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.ElseStructContext, self).__init__(parent, invokingState)
            self.parser = parser

        def ELSE(self):
            return self.getToken(CalcParser.ELSE, 0)

        def block(self):
            return self.getTypedRuleContext(CalcParser.BlockContext,0)


        def stmt(self):
            return self.getTypedRuleContext(CalcParser.StmtContext,0)


        def getRuleIndex(self):
            return CalcParser.RULE_elseStruct

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterElseStruct(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitElseStruct(self)




    def elseStruct(self):

        localctx = CalcParser.ElseStructContext(self, self._ctx, self.state)
        self.enterRule(localctx, 34, self.RULE_elseStruct)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 206
            self.match(CalcParser.ELSE)
            self.state = 209
            token = self._input.LA(1)
            if token in [CalcParser.BEGIN]:
                self.state = 207
                self.block()

            elif token in [CalcParser.IF, CalcParser.DO, CalcParser.RETURN, CalcParser.ID]:
                self.state = 208
                self.stmt()

            else:
                raise NoViableAltException(self)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class LoopStructContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.LoopStructContext, self).__init__(parent, invokingState)
            self.parser = parser
            self.preCond = None # ExprContext
            self.postCond = None # ExprContext

        def DO(self):
            return self.getToken(CalcParser.DO, 0)

        def LOOP(self):
            return self.getToken(CalcParser.LOOP, 0)

        def WHILE(self, i=None):
            if i is None:
                return self.getTokens(CalcParser.WHILE)
            else:
                return self.getToken(CalcParser.WHILE, i)

        def stmt(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(CalcParser.StmtContext)
            else:
                return self.getTypedRuleContext(CalcParser.StmtContext,i)


        def expr(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(CalcParser.ExprContext)
            else:
                return self.getTypedRuleContext(CalcParser.ExprContext,i)


        def getRuleIndex(self):
            return CalcParser.RULE_loopStruct

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterLoopStruct(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitLoopStruct(self)




    def loopStruct(self):

        localctx = CalcParser.LoopStructContext(self, self._ctx, self.state)
        self.enterRule(localctx, 36, self.RULE_loopStruct)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 211
            self.match(CalcParser.DO)
            self.state = 214
            _la = self._input.LA(1)
            if _la==CalcParser.WHILE:
                self.state = 212
                self.match(CalcParser.WHILE)
                self.state = 213
                localctx.preCond = self.expr(0)


            self.state = 219
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.IF) | (1 << CalcParser.DO) | (1 << CalcParser.RETURN) | (1 << CalcParser.ID))) != 0):
                self.state = 216
                self.stmt()
                self.state = 221
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 222
            self.match(CalcParser.LOOP)
            self.state = 225
            _la = self._input.LA(1)
            if _la==CalcParser.WHILE:
                self.state = 223
                self.match(CalcParser.WHILE)
                self.state = 224
                localctx.postCond = self.expr(0)


        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class RetContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.RetContext, self).__init__(parent, invokingState)
            self.parser = parser

        def RETURN(self):
            return self.getToken(CalcParser.RETURN, 0)

        def expr(self):
            return self.getTypedRuleContext(CalcParser.ExprContext,0)


        def getRuleIndex(self):
            return CalcParser.RULE_ret

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterRet(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitRet(self)




    def ret(self):

        localctx = CalcParser.RetContext(self, self._ctx, self.state)
        self.enterRule(localctx, 38, self.RULE_ret)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 227
            self.match(CalcParser.RETURN)
            self.state = 229
            _la = self._input.LA(1)
            if (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.T__2) | (1 << CalcParser.T__19) | (1 << CalcParser.LITERAL) | (1 << CalcParser.ID))) != 0):
                self.state = 228
                self.expr(0)


            self.state = 231
            self.match(CalcParser.T__5)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class FunctionContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.FunctionContext, self).__init__(parent, invokingState)
            self.parser = parser
            self.retType = None # Full_idContext
            self.fnName = None # Full_idContext

        def formParList(self):
            return self.getTypedRuleContext(CalcParser.FormParListContext,0)


        def block(self):
            return self.getTypedRuleContext(CalcParser.BlockContext,0)


        def full_id(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(CalcParser.Full_idContext)
            else:
                return self.getTypedRuleContext(CalcParser.Full_idContext,i)


        def decl(self):
            return self.getTypedRuleContext(CalcParser.DeclContext,0)


        def getRuleIndex(self):
            return CalcParser.RULE_function

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterFunction(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitFunction(self)




    def function(self):

        localctx = CalcParser.FunctionContext(self, self._ctx, self.state)
        self.enterRule(localctx, 40, self.RULE_function)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 233
            localctx.retType = self.full_id()
            self.state = 234
            localctx.fnName = self.full_id()
            self.state = 235
            self.formParList()
            self.state = 237
            _la = self._input.LA(1)
            if _la==CalcParser.VAR:
                self.state = 236
                self.decl()


            self.state = 239
            self.block()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class FormParListContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.FormParListContext, self).__init__(parent, invokingState)
            self.parser = parser

        def formPar(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(CalcParser.FormParContext)
            else:
                return self.getTypedRuleContext(CalcParser.FormParContext,i)


        def getRuleIndex(self):
            return CalcParser.RULE_formParList

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterFormParList(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitFormParList(self)




    def formParList(self):

        localctx = CalcParser.FormParListContext(self, self._ctx, self.state)
        self.enterRule(localctx, 42, self.RULE_formParList)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 241
            self.match(CalcParser.T__2)
            self.state = 245
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==CalcParser.ID:
                self.state = 242
                self.formPar()
                self.state = 247
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 248
            self.match(CalcParser.T__3)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class FormParContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.FormParContext, self).__init__(parent, invokingState)
            self.parser = parser
            self.name = None # Full_idContext
            self.defaultVal = None # ExprContext

        def r_type(self):
            return self.getTypedRuleContext(CalcParser.R_typeContext,0)


        def full_id(self):
            return self.getTypedRuleContext(CalcParser.Full_idContext,0)


        def LET(self):
            return self.getToken(CalcParser.LET, 0)

        def expr(self):
            return self.getTypedRuleContext(CalcParser.ExprContext,0)


        def getRuleIndex(self):
            return CalcParser.RULE_formPar

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterFormPar(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitFormPar(self)




    def formPar(self):

        localctx = CalcParser.FormParContext(self, self._ctx, self.state)
        self.enterRule(localctx, 44, self.RULE_formPar)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 250
            self.r_type()
            self.state = 251
            localctx.name = self.full_id()
            self.state = 254
            _la = self._input.LA(1)
            if _la==CalcParser.LET:
                self.state = 252
                self.match(CalcParser.LET)
                self.state = 253
                localctx.defaultVal = self.expr(0)


        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Full_idContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.Full_idContext, self).__init__(parent, invokingState)
            self.parser = parser

        def ID(self):
            return self.getToken(CalcParser.ID, 0)

        def sub_id(self):
            return self.getTypedRuleContext(CalcParser.Sub_idContext,0)


        def getRuleIndex(self):
            return CalcParser.RULE_full_id

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterFull_id(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitFull_id(self)




    def full_id(self):

        localctx = CalcParser.Full_idContext(self, self._ctx, self.state)
        self.enterRule(localctx, 46, self.RULE_full_id)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 256
            self.match(CalcParser.ID)
            self.state = 258
            la_ = self._interp.adaptivePredict(self._input,25,self._ctx)
            if la_ == 1:
                self.state = 257
                self.sub_id()


        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Sub_idContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.Sub_idContext, self).__init__(parent, invokingState)
            self.parser = parser

        def ID(self):
            return self.getToken(CalcParser.ID, 0)

        def getRuleIndex(self):
            return CalcParser.RULE_sub_id

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterSub_id(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitSub_id(self)




    def sub_id(self):

        localctx = CalcParser.Sub_idContext(self, self._ctx, self.state)
        self.enterRule(localctx, 48, self.RULE_sub_id)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 260
            self.match(CalcParser.T__4)
            self.state = 261
            self.match(CalcParser.ID)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx



    def sempred(self, localctx, ruleIndex, predIndex):
        if self._predicates == None:
            self._predicates = dict()
        self._predicates[9] = self.expr_sempred
        pred = self._predicates.get(ruleIndex, None)
        if pred is None:
            raise Exception("No predicate with index:" + str(ruleIndex))
        else:
            return pred(localctx, predIndex)

    def expr_sempred(self, localctx, predIndex):
            if predIndex == 0:
                return self.precpred(self._ctx, 10)
         

            if predIndex == 1:
                return self.precpred(self._ctx, 9)
         

            if predIndex == 2:
                return self.precpred(self._ctx, 8)
         

            if predIndex == 3:
                return self.precpred(self._ctx, 7)
         

            if predIndex == 4:
                return self.precpred(self._ctx, 6)
         



