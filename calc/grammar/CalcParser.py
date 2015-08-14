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
        buf.write(u",\u0114\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t")
        buf.write(u"\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t\13\4\f\t\f\4\r\t\r")
        buf.write(u"\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22\4")
        buf.write(u"\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30")
        buf.write(u"\t\30\4\31\t\31\4\32\t\32\4\33\t\33\3\2\3\2\5\29\n\2")
        buf.write(u"\3\2\5\2<\n\2\3\2\7\2?\n\2\f\2\16\2B\13\2\3\3\3\3\3\3")
        buf.write(u"\3\3\3\3\3\3\3\4\3\4\3\5\3\5\3\5\3\5\5\5P\n\5\3\5\3\5")
        buf.write(u"\3\6\3\6\7\6V\n\6\f\6\16\6Y\13\6\3\6\3\6\3\6\3\7\3\7")
        buf.write(u"\7\7`\n\7\f\7\16\7c\13\7\3\7\3\7\3\b\3\b\3\b\3\b\3\b")
        buf.write(u"\3\b\5\bm\n\b\3\t\3\t\3\t\3\t\3\t\3\n\3\n\3\n\3\n\3\n")
        buf.write(u"\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3")
        buf.write(u"\13\3\13\3\13\3\13\5\13\u0087\n\13\3\13\3\13\3\13\3\13")
        buf.write(u"\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3")
        buf.write(u"\13\3\13\3\13\3\13\3\13\3\13\7\13\u009d\n\13\f\13\16")
        buf.write(u"\13\u00a0\13\13\3\f\3\f\3\f\7\f\u00a5\n\f\f\f\16\f\u00a8")
        buf.write(u"\13\f\5\f\u00aa\n\f\3\r\3\r\7\r\u00ae\n\r\f\r\16\r\u00b1")
        buf.write(u"\13\r\3\16\3\16\7\16\u00b5\n\16\f\16\16\16\u00b8\13\16")
        buf.write(u"\3\17\3\17\3\17\7\17\u00bd\n\17\f\17\16\17\u00c0\13\17")
        buf.write(u"\5\17\u00c2\n\17\3\17\3\17\3\17\3\17\3\20\3\20\3\21\3")
        buf.write(u"\21\3\22\3\22\5\22\u00ce\n\22\3\23\3\23\3\23\3\23\3\23")
        buf.write(u"\3\23\5\23\u00d6\n\23\3\23\5\23\u00d9\n\23\3\24\3\24")
        buf.write(u"\3\24\5\24\u00de\n\24\3\25\3\25\3\25\5\25\u00e3\n\25")
        buf.write(u"\3\25\7\25\u00e6\n\25\f\25\16\25\u00e9\13\25\3\25\3\25")
        buf.write(u"\3\25\5\25\u00ee\n\25\3\26\3\26\5\26\u00f2\n\26\3\26")
        buf.write(u"\3\26\3\27\3\27\3\27\3\27\5\27\u00fa\n\27\3\27\3\27\3")
        buf.write(u"\30\3\30\7\30\u0100\n\30\f\30\16\30\u0103\13\30\3\30")
        buf.write(u"\3\30\3\31\3\31\3\31\3\31\5\31\u010b\n\31\3\32\3\32\5")
        buf.write(u"\32\u010f\n\32\3\33\3\33\3\33\3\33\2\3\24\34\2\4\6\b")
        buf.write(u"\n\f\16\20\22\24\26\30\32\34\36 \"$&(*,.\60\62\64\2\6")
        buf.write(u"\3\2\t\n\3\2\13\f\3\2\r\16\3\2\17\23\u011f\2\66\3\2\2")
        buf.write(u"\2\4C\3\2\2\2\6I\3\2\2\2\bK\3\2\2\2\nS\3\2\2\2\f]\3\2")
        buf.write(u"\2\2\16l\3\2\2\2\20n\3\2\2\2\22s\3\2\2\2\24\u0086\3\2")
        buf.write(u"\2\2\26\u00a9\3\2\2\2\30\u00ab\3\2\2\2\32\u00b2\3\2\2")
        buf.write(u"\2\34\u00c1\3\2\2\2\36\u00c7\3\2\2\2 \u00c9\3\2\2\2\"")
        buf.write(u"\u00cd\3\2\2\2$\u00cf\3\2\2\2&\u00da\3\2\2\2(\u00df\3")
        buf.write(u"\2\2\2*\u00ef\3\2\2\2,\u00f5\3\2\2\2.\u00fd\3\2\2\2\60")
        buf.write(u"\u0106\3\2\2\2\62\u010c\3\2\2\2\64\u0110\3\2\2\2\668")
        buf.write(u"\5\4\3\2\679\5\32\16\28\67\3\2\2\289\3\2\2\29;\3\2\2")
        buf.write(u"\2:<\5\30\r\2;:\3\2\2\2;<\3\2\2\2<@\3\2\2\2=?\5\b\5\2")
        buf.write(u">=\3\2\2\2?B\3\2\2\2@>\3\2\2\2@A\3\2\2\2A\3\3\2\2\2B")
        buf.write(u"@\3\2\2\2CD\7\3\2\2DE\7\'\2\2EF\7\4\2\2FG\5\6\4\2GH\7")
        buf.write(u"\5\2\2H\5\3\2\2\2IJ\7\'\2\2J\7\3\2\2\2KL\7\6\2\2LM\7")
        buf.write(u"\'\2\2MO\7\5\2\2NP\5\30\r\2ON\3\2\2\2OP\3\2\2\2PQ\3\2")
        buf.write(u"\2\2QR\5\n\6\2R\t\3\2\2\2SW\7$\2\2TV\5\16\b\2UT\3\2\2")
        buf.write(u"\2VY\3\2\2\2WU\3\2\2\2WX\3\2\2\2XZ\3\2\2\2YW\3\2\2\2")
        buf.write(u"Z[\7%\2\2[\\\7\5\2\2\\\13\3\2\2\2]a\7$\2\2^`\5\16\b\2")
        buf.write(u"_^\3\2\2\2`c\3\2\2\2a_\3\2\2\2ab\3\2\2\2bd\3\2\2\2ca")
        buf.write(u"\3\2\2\2de\7%\2\2e\r\3\2\2\2fm\5\20\t\2gh\5\22\n\2hi")
        buf.write(u"\7\5\2\2im\3\2\2\2jm\5*\26\2km\5\"\22\2lf\3\2\2\2lg\3")
        buf.write(u"\2\2\2lj\3\2\2\2lk\3\2\2\2m\17\3\2\2\2no\5\62\32\2op")
        buf.write(u"\7&\2\2pq\5\24\13\2qr\7\5\2\2r\21\3\2\2\2st\7\'\2\2t")
        buf.write(u"u\7\7\2\2uv\5\26\f\2vw\7\b\2\2w\23\3\2\2\2xy\b\13\1\2")
        buf.write(u"y\u0087\5\62\32\2z\u0087\5\22\n\2{\u0087\7\25\2\2|}\7")
        buf.write(u"\26\2\2}~\7\7\2\2~\177\5\26\f\2\177\u0080\7\b\2\2\u0080")
        buf.write(u"\u0087\3\2\2\2\u0081\u0087\7\31\2\2\u0082\u0083\7\7\2")
        buf.write(u"\2\u0083\u0084\5\24\13\2\u0084\u0085\7\b\2\2\u0085\u0087")
        buf.write(u"\3\2\2\2\u0086x\3\2\2\2\u0086z\3\2\2\2\u0086{\3\2\2\2")
        buf.write(u"\u0086|\3\2\2\2\u0086\u0081\3\2\2\2\u0086\u0082\3\2\2")
        buf.write(u"\2\u0087\u009e\3\2\2\2\u0088\u0089\f\r\2\2\u0089\u008a")
        buf.write(u"\t\2\2\2\u008a\u009d\5\24\13\16\u008b\u008c\f\f\2\2\u008c")
        buf.write(u"\u008d\t\3\2\2\u008d\u009d\5\24\13\r\u008e\u008f\f\13")
        buf.write(u"\2\2\u008f\u0090\t\4\2\2\u0090\u009d\5\24\13\f\u0091")
        buf.write(u"\u0092\f\n\2\2\u0092\u0093\t\5\2\2\u0093\u009d\5\24\13")
        buf.write(u"\13\u0094\u0095\f\t\2\2\u0095\u0096\7\n\2\2\u0096\u0097")
        buf.write(u"\7\7\2\2\u0097\u0098\5\24\13\2\u0098\u0099\7\t\2\2\u0099")
        buf.write(u"\u009a\7\24\2\2\u009a\u009b\7\b\2\2\u009b\u009d\3\2\2")
        buf.write(u"\2\u009c\u0088\3\2\2\2\u009c\u008b\3\2\2\2\u009c\u008e")
        buf.write(u"\3\2\2\2\u009c\u0091\3\2\2\2\u009c\u0094\3\2\2\2\u009d")
        buf.write(u"\u00a0\3\2\2\2\u009e\u009c\3\2\2\2\u009e\u009f\3\2\2")
        buf.write(u"\2\u009f\25\3\2\2\2\u00a0\u009e\3\2\2\2\u00a1\u00a6\5")
        buf.write(u"\24\13\2\u00a2\u00a3\7\27\2\2\u00a3\u00a5\5\24\13\2\u00a4")
        buf.write(u"\u00a2\3\2\2\2\u00a5\u00a8\3\2\2\2\u00a6\u00a4\3\2\2")
        buf.write(u"\2\u00a6\u00a7\3\2\2\2\u00a7\u00aa\3\2\2\2\u00a8\u00a6")
        buf.write(u"\3\2\2\2\u00a9\u00a1\3\2\2\2\u00a9\u00aa\3\2\2\2\u00aa")
        buf.write(u"\27\3\2\2\2\u00ab\u00af\7\32\2\2\u00ac\u00ae\5\34\17")
        buf.write(u"\2\u00ad\u00ac\3\2\2\2\u00ae\u00b1\3\2\2\2\u00af\u00ad")
        buf.write(u"\3\2\2\2\u00af\u00b0\3\2\2\2\u00b0\31\3\2\2\2\u00b1\u00af")
        buf.write(u"\3\2\2\2\u00b2\u00b6\7\33\2\2\u00b3\u00b5\5\34\17\2\u00b4")
        buf.write(u"\u00b3\3\2\2\2\u00b5\u00b8\3\2\2\2\u00b6\u00b4\3\2\2")
        buf.write(u"\2\u00b6\u00b7\3\2\2\2\u00b7\33\3\2\2\2\u00b8\u00b6\3")
        buf.write(u"\2\2\2\u00b9\u00be\5\36\20\2\u00ba\u00bb\7\27\2\2\u00bb")
        buf.write(u"\u00bd\5\36\20\2\u00bc\u00ba\3\2\2\2\u00bd\u00c0\3\2")
        buf.write(u"\2\2\u00be\u00bc\3\2\2\2\u00be\u00bf\3\2\2\2\u00bf\u00c2")
        buf.write(u"\3\2\2\2\u00c0\u00be\3\2\2\2\u00c1\u00b9\3\2\2\2\u00c1")
        buf.write(u"\u00c2\3\2\2\2\u00c2\u00c3\3\2\2\2\u00c3\u00c4\7\30\2")
        buf.write(u"\2\u00c4\u00c5\5 \21\2\u00c5\u00c6\7\5\2\2\u00c6\35\3")
        buf.write(u"\2\2\2\u00c7\u00c8\7\'\2\2\u00c8\37\3\2\2\2\u00c9\u00ca")
        buf.write(u"\7\'\2\2\u00ca!\3\2\2\2\u00cb\u00ce\5$\23\2\u00cc\u00ce")
        buf.write(u"\5(\25\2\u00cd\u00cb\3\2\2\2\u00cd\u00cc\3\2\2\2\u00ce")
        buf.write(u"#\3\2\2\2\u00cf\u00d0\7\34\2\2\u00d0\u00d1\5\24\13\2")
        buf.write(u"\u00d1\u00d5\7\36\2\2\u00d2\u00d6\5\n\6\2\u00d3\u00d6")
        buf.write(u"\5\16\b\2\u00d4\u00d6\5\f\7\2\u00d5\u00d2\3\2\2\2\u00d5")
        buf.write(u"\u00d3\3\2\2\2\u00d5\u00d4\3\2\2\2\u00d6\u00d8\3\2\2")
        buf.write(u"\2\u00d7\u00d9\5&\24\2\u00d8\u00d7\3\2\2\2\u00d8\u00d9")
        buf.write(u"\3\2\2\2\u00d9%\3\2\2\2\u00da\u00dd\7\35\2\2\u00db\u00de")
        buf.write(u"\5\n\6\2\u00dc\u00de\5\16\b\2\u00dd\u00db\3\2\2\2\u00dd")
        buf.write(u"\u00dc\3\2\2\2\u00de\'\3\2\2\2\u00df\u00e2\7\37\2\2\u00e0")
        buf.write(u"\u00e1\7 \2\2\u00e1\u00e3\5\24\13\2\u00e2\u00e0\3\2\2")
        buf.write(u"\2\u00e2\u00e3\3\2\2\2\u00e3\u00e7\3\2\2\2\u00e4\u00e6")
        buf.write(u"\5\16\b\2\u00e5\u00e4\3\2\2\2\u00e6\u00e9\3\2\2\2\u00e7")
        buf.write(u"\u00e5\3\2\2\2\u00e7\u00e8\3\2\2\2\u00e8\u00ea\3\2\2")
        buf.write(u"\2\u00e9\u00e7\3\2\2\2\u00ea\u00ed\7!\2\2\u00eb\u00ec")
        buf.write(u"\7 \2\2\u00ec\u00ee\5\24\13\2\u00ed\u00eb\3\2\2\2\u00ed")
        buf.write(u"\u00ee\3\2\2\2\u00ee)\3\2\2\2\u00ef\u00f1\7\"\2\2\u00f0")
        buf.write(u"\u00f2\5\24\13\2\u00f1\u00f0\3\2\2\2\u00f1\u00f2\3\2")
        buf.write(u"\2\2\u00f2\u00f3\3\2\2\2\u00f3\u00f4\7\5\2\2\u00f4+\3")
        buf.write(u"\2\2\2\u00f5\u00f6\5\62\32\2\u00f6\u00f7\5\62\32\2\u00f7")
        buf.write(u"\u00f9\5.\30\2\u00f8\u00fa\5\30\r\2\u00f9\u00f8\3\2\2")
        buf.write(u"\2\u00f9\u00fa\3\2\2\2\u00fa\u00fb\3\2\2\2\u00fb\u00fc")
        buf.write(u"\5\n\6\2\u00fc-\3\2\2\2\u00fd\u0101\7\7\2\2\u00fe\u0100")
        buf.write(u"\5\60\31\2\u00ff\u00fe\3\2\2\2\u0100\u0103\3\2\2\2\u0101")
        buf.write(u"\u00ff\3\2\2\2\u0101\u0102\3\2\2\2\u0102\u0104\3\2\2")
        buf.write(u"\2\u0103\u0101\3\2\2\2\u0104\u0105\7\b\2\2\u0105/\3\2")
        buf.write(u"\2\2\u0106\u0107\5 \21\2\u0107\u010a\5\62\32\2\u0108")
        buf.write(u"\u0109\7&\2\2\u0109\u010b\5\24\13\2\u010a\u0108\3\2\2")
        buf.write(u"\2\u010a\u010b\3\2\2\2\u010b\61\3\2\2\2\u010c\u010e\7")
        buf.write(u"\'\2\2\u010d\u010f\5\64\33\2\u010e\u010d\3\2\2\2\u010e")
        buf.write(u"\u010f\3\2\2\2\u010f\63\3\2\2\2\u0110\u0111\7\4\2\2\u0111")
        buf.write(u"\u0112\7\'\2\2\u0112\65\3\2\2\2\368;@OWal\u0086\u009c")
        buf.write(u"\u009e\u00a6\u00a9\u00af\u00b6\u00be\u00c1\u00cd\u00d5")
        buf.write(u"\u00d8\u00dd\u00e2\u00e7\u00ed\u00f1\u00f9\u0101\u010a")
        buf.write(u"\u010e")
        return buf.getvalue()


class CalcParser ( Parser ):

    grammarFileName = "java-escape"

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    sharedContextCache = PredictionContextCache()

    literalNames = [ u"<INVALID>", u"'FORM'", u"'.'", u"';'", u"'SECTION'", 
                     u"'('", u"')'", u"'/'", u"'*'", u"'+'", u"'-'", u"'and'", 
                     u"'or'", u"'>'", u"'<'", u"'<='", u"'>='", u"'='", 
                     u"'100'", u"'RunCalc'", u"'MAX'", u"','", u"':'", u"<INVALID>", 
                     u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                     u"<INVALID>", u"'do'", u"'while'", u"'loop'", u"'return'", 
                     u"<INVALID>", u"<INVALID>", u"<INVALID>", u"':='" ]

    symbolicNames = [ u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"LITERAL", 
                      u"VAR", u"CONSTANT", u"IF", u"ELSE", u"THEN", u"DO", 
                      u"WHILE", u"LOOP", u"RETURN", u"WS", u"BEGIN", u"END", 
                      u"LET", u"ID", u"INT", u"STRING", u"BOOLEAN", u"COMMENT", 
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
    RULE_vardecl = 11
    RULE_constdecl = 12
    RULE_declList = 13
    RULE_varDecl = 14
    RULE_r_type = 15
    RULE_ctrlStruct = 16
    RULE_ifStruct = 17
    RULE_elseStruct = 18
    RULE_loopStruct = 19
    RULE_ret = 20
    RULE_function = 21
    RULE_formParList = 22
    RULE_formPar = 23
    RULE_full_id = 24
    RULE_sub_id = 25

    ruleNames =  [ u"calcfile", u"formset", u"form", u"section", u"block", 
                   u"dumbblock", u"stmt", u"assign", u"call", u"expr", u"argList", 
                   u"vardecl", u"constdecl", u"declList", u"varDecl", u"r_type", 
                   u"ctrlStruct", u"ifStruct", u"elseStruct", u"loopStruct", 
                   u"ret", u"function", u"formParList", u"formPar", u"full_id", 
                   u"sub_id" ]

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
    CONSTANT=25
    IF=26
    ELSE=27
    THEN=28
    DO=29
    WHILE=30
    LOOP=31
    RETURN=32
    WS=33
    BEGIN=34
    END=35
    LET=36
    ID=37
    INT=38
    STRING=39
    BOOLEAN=40
    COMMENT=41
    LINE_COMMENT=42

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


        def constdecl(self):
            return self.getTypedRuleContext(CalcParser.ConstdeclContext,0)


        def vardecl(self):
            return self.getTypedRuleContext(CalcParser.VardeclContext,0)


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
            self.state = 52
            self.formset()
            self.state = 54
            _la = self._input.LA(1)
            if _la==CalcParser.CONSTANT:
                self.state = 53
                self.constdecl()


            self.state = 57
            _la = self._input.LA(1)
            if _la==CalcParser.VAR:
                self.state = 56
                self.vardecl()


            self.state = 62
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==CalcParser.T__3:
                self.state = 59
                self.section()
                self.state = 64
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
            self.state = 65
            self.match(CalcParser.T__0)
            self.state = 66
            self.match(CalcParser.ID)
            self.state = 67
            self.match(CalcParser.T__1)
            self.state = 68
            self.form()
            self.state = 69
            self.match(CalcParser.T__2)
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
            self.state = 71
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


        def vardecl(self):
            return self.getTypedRuleContext(CalcParser.VardeclContext,0)


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
            self.state = 73
            self.match(CalcParser.T__3)
            self.state = 74
            self.match(CalcParser.ID)
            self.state = 75
            self.match(CalcParser.T__2)
            self.state = 77
            _la = self._input.LA(1)
            if _la==CalcParser.VAR:
                self.state = 76
                self.vardecl()


            self.state = 79
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
            self.state = 81
            self.match(CalcParser.BEGIN)
            self.state = 85
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.IF) | (1 << CalcParser.DO) | (1 << CalcParser.RETURN) | (1 << CalcParser.ID))) != 0):
                self.state = 82
                self.stmt()
                self.state = 87
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 88
            self.match(CalcParser.END)
            self.state = 89
            self.match(CalcParser.T__2)
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
            self.state = 91
            self.match(CalcParser.BEGIN)
            self.state = 95
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.IF) | (1 << CalcParser.DO) | (1 << CalcParser.RETURN) | (1 << CalcParser.ID))) != 0):
                self.state = 92
                self.stmt()
                self.state = 97
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 98
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
            self.state = 106
            la_ = self._interp.adaptivePredict(self._input,6,self._ctx)
            if la_ == 1:
                self.enterOuterAlt(localctx, 1)
                self.state = 100
                self.assign()
                pass

            elif la_ == 2:
                self.enterOuterAlt(localctx, 2)
                self.state = 101
                self.call()
                self.state = 102
                self.match(CalcParser.T__2)
                pass

            elif la_ == 3:
                self.enterOuterAlt(localctx, 3)
                self.state = 104
                self.ret()
                pass

            elif la_ == 4:
                self.enterOuterAlt(localctx, 4)
                self.state = 105
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
            self.state = 108
            self.full_id()
            self.state = 109
            self.match(CalcParser.LET)
            self.state = 110
            self.expr(0)
            self.state = 111
            self.match(CalcParser.T__2)
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
            self.state = 113
            self.match(CalcParser.ID)
            self.state = 114
            self.match(CalcParser.T__4)
            self.state = 115
            self.argList()
            self.state = 116
            self.match(CalcParser.T__5)
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


    class RunCalcContext(ExprContext):

        def __init__(self, parser, ctx): # actually a CalcParser.ExprContext)
            super(CalcParser.RunCalcContext, self).__init__(parser)
            self.copyFrom(ctx)


        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterRunCalc(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitRunCalc(self)


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
            self.state = 132
            la_ = self._interp.adaptivePredict(self._input,7,self._ctx)
            if la_ == 1:
                localctx = CalcParser.VarRefContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx

                self.state = 119
                self.full_id()
                pass

            elif la_ == 2:
                localctx = CalcParser.FunctionCallContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 120
                self.call()
                pass

            elif la_ == 3:
                localctx = CalcParser.RunCalcContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 121
                self.match(CalcParser.T__18)
                pass

            elif la_ == 4:
                localctx = CalcParser.MaxContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 122
                self.match(CalcParser.T__19)
                self.state = 123
                self.match(CalcParser.T__4)
                self.state = 124
                self.argList()
                self.state = 125
                self.match(CalcParser.T__5)
                pass

            elif la_ == 5:
                localctx = CalcParser.LiteralContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 127
                self.match(CalcParser.LITERAL)
                pass

            elif la_ == 6:
                localctx = CalcParser.ParensContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 128
                self.match(CalcParser.T__4)
                self.state = 129
                self.expr(0)
                self.state = 130
                self.match(CalcParser.T__5)
                pass


            self._ctx.stop = self._input.LT(-1)
            self.state = 156
            self._errHandler.sync(self)
            _alt = self._interp.adaptivePredict(self._input,9,self._ctx)
            while _alt!=2 and _alt!=ATN.INVALID_ALT_NUMBER:
                if _alt==1:
                    if self._parseListeners is not None:
                        self.triggerExitRuleEvent()
                    _prevctx = localctx
                    self.state = 154
                    la_ = self._interp.adaptivePredict(self._input,8,self._ctx)
                    if la_ == 1:
                        localctx = CalcParser.DivMulContext(self, CalcParser.ExprContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expr)
                        self.state = 134
                        if not self.precpred(self._ctx, 11):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 11)")
                        self.state = 135
                        localctx.op = self._input.LT(1)
                        _la = self._input.LA(1)
                        if not(_la==CalcParser.T__6 or _la==CalcParser.T__7):
                            localctx.op = self._errHandler.recoverInline(self)
                        else:
                            self.consume()
                        self.state = 136
                        self.expr(12)
                        pass

                    elif la_ == 2:
                        localctx = CalcParser.AddSubContext(self, CalcParser.ExprContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expr)
                        self.state = 137
                        if not self.precpred(self._ctx, 10):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 10)")
                        self.state = 138
                        localctx.op = self._input.LT(1)
                        _la = self._input.LA(1)
                        if not(_la==CalcParser.T__8 or _la==CalcParser.T__9):
                            localctx.op = self._errHandler.recoverInline(self)
                        else:
                            self.consume()
                        self.state = 139
                        self.expr(11)
                        pass

                    elif la_ == 3:
                        localctx = CalcParser.LogicContext(self, CalcParser.ExprContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expr)
                        self.state = 140
                        if not self.precpred(self._ctx, 9):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 9)")
                        self.state = 141
                        localctx.op = self._input.LT(1)
                        _la = self._input.LA(1)
                        if not(_la==CalcParser.T__10 or _la==CalcParser.T__11):
                            localctx.op = self._errHandler.recoverInline(self)
                        else:
                            self.consume()
                        self.state = 142
                        self.expr(10)
                        pass

                    elif la_ == 4:
                        localctx = CalcParser.PredicateContext(self, CalcParser.ExprContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expr)
                        self.state = 143
                        if not self.precpred(self._ctx, 8):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 8)")
                        self.state = 144
                        localctx.op = self._input.LT(1)
                        _la = self._input.LA(1)
                        if not((((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.T__12) | (1 << CalcParser.T__13) | (1 << CalcParser.T__14) | (1 << CalcParser.T__15) | (1 << CalcParser.T__16))) != 0)):
                            localctx.op = self._errHandler.recoverInline(self)
                        else:
                            self.consume()
                        self.state = 145
                        self.expr(9)
                        pass

                    elif la_ == 5:
                        localctx = CalcParser.PercentageOfContext(self, CalcParser.ExprContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expr)
                        self.state = 146
                        if not self.precpred(self._ctx, 7):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 7)")
                        self.state = 147
                        self.match(CalcParser.T__7)
                        self.state = 148
                        self.match(CalcParser.T__4)
                        self.state = 149
                        self.expr(0)
                        self.state = 150
                        self.match(CalcParser.T__6)
                        self.state = 151
                        self.match(CalcParser.T__17)
                        self.state = 152
                        self.match(CalcParser.T__5)
                        pass

             
                self.state = 158
                self._errHandler.sync(self)
                _alt = self._interp.adaptivePredict(self._input,9,self._ctx)

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
            self.state = 167
            _la = self._input.LA(1)
            if (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.T__4) | (1 << CalcParser.T__18) | (1 << CalcParser.T__19) | (1 << CalcParser.LITERAL) | (1 << CalcParser.ID))) != 0):
                self.state = 159
                self.expr(0)
                self.state = 164
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                while _la==CalcParser.T__20:
                    self.state = 160
                    self.match(CalcParser.T__20)
                    self.state = 161
                    self.expr(0)
                    self.state = 166
                    self._errHandler.sync(self)
                    _la = self._input.LA(1)



        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class VardeclContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.VardeclContext, self).__init__(parent, invokingState)
            self.parser = parser

        def VAR(self):
            return self.getToken(CalcParser.VAR, 0)

        def declList(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(CalcParser.DeclListContext)
            else:
                return self.getTypedRuleContext(CalcParser.DeclListContext,i)


        def getRuleIndex(self):
            return CalcParser.RULE_vardecl

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterVardecl(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitVardecl(self)




    def vardecl(self):

        localctx = CalcParser.VardeclContext(self, self._ctx, self.state)
        self.enterRule(localctx, 22, self.RULE_vardecl)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 169
            self.match(CalcParser.VAR)
            self.state = 173
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==CalcParser.T__21 or _la==CalcParser.ID:
                self.state = 170
                self.declList()
                self.state = 175
                self._errHandler.sync(self)
                _la = self._input.LA(1)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class ConstdeclContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.ConstdeclContext, self).__init__(parent, invokingState)
            self.parser = parser

        def CONSTANT(self):
            return self.getToken(CalcParser.CONSTANT, 0)

        def declList(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(CalcParser.DeclListContext)
            else:
                return self.getTypedRuleContext(CalcParser.DeclListContext,i)


        def getRuleIndex(self):
            return CalcParser.RULE_constdecl

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterConstdecl(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitConstdecl(self)




    def constdecl(self):

        localctx = CalcParser.ConstdeclContext(self, self._ctx, self.state)
        self.enterRule(localctx, 24, self.RULE_constdecl)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 176
            self.match(CalcParser.CONSTANT)
            self.state = 180
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==CalcParser.T__21 or _la==CalcParser.ID:
                self.state = 177
                self.declList()
                self.state = 182
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
        self.enterRule(localctx, 26, self.RULE_declList)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 191
            _la = self._input.LA(1)
            if _la==CalcParser.ID:
                self.state = 183
                self.varDecl()
                self.state = 188
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                while _la==CalcParser.T__20:
                    self.state = 184
                    self.match(CalcParser.T__20)
                    self.state = 185
                    self.varDecl()
                    self.state = 190
                    self._errHandler.sync(self)
                    _la = self._input.LA(1)



            self.state = 193
            self.match(CalcParser.T__21)
            self.state = 194
            self.r_type()
            self.state = 195
            self.match(CalcParser.T__2)
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
        self.enterRule(localctx, 28, self.RULE_varDecl)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 197
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
        self.enterRule(localctx, 30, self.RULE_r_type)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 199
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
        self.enterRule(localctx, 32, self.RULE_ctrlStruct)
        try:
            self.state = 203
            token = self._input.LA(1)
            if token in [CalcParser.IF]:
                self.enterOuterAlt(localctx, 1)
                self.state = 201
                self.ifStruct()

            elif token in [CalcParser.DO]:
                self.enterOuterAlt(localctx, 2)
                self.state = 202
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
        self.enterRule(localctx, 34, self.RULE_ifStruct)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 205
            self.match(CalcParser.IF)
            self.state = 206
            self.expr(0)
            self.state = 207
            self.match(CalcParser.THEN)
            self.state = 211
            la_ = self._interp.adaptivePredict(self._input,17,self._ctx)
            if la_ == 1:
                self.state = 208
                self.block()
                pass

            elif la_ == 2:
                self.state = 209
                self.stmt()
                pass

            elif la_ == 3:
                self.state = 210
                self.dumbblock()
                pass


            self.state = 214
            la_ = self._interp.adaptivePredict(self._input,18,self._ctx)
            if la_ == 1:
                self.state = 213
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
        self.enterRule(localctx, 36, self.RULE_elseStruct)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 216
            self.match(CalcParser.ELSE)
            self.state = 219
            token = self._input.LA(1)
            if token in [CalcParser.BEGIN]:
                self.state = 217
                self.block()

            elif token in [CalcParser.IF, CalcParser.DO, CalcParser.RETURN, CalcParser.ID]:
                self.state = 218
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
        self.enterRule(localctx, 38, self.RULE_loopStruct)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 221
            self.match(CalcParser.DO)
            self.state = 224
            _la = self._input.LA(1)
            if _la==CalcParser.WHILE:
                self.state = 222
                self.match(CalcParser.WHILE)
                self.state = 223
                localctx.preCond = self.expr(0)


            self.state = 229
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.IF) | (1 << CalcParser.DO) | (1 << CalcParser.RETURN) | (1 << CalcParser.ID))) != 0):
                self.state = 226
                self.stmt()
                self.state = 231
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 232
            self.match(CalcParser.LOOP)
            self.state = 235
            _la = self._input.LA(1)
            if _la==CalcParser.WHILE:
                self.state = 233
                self.match(CalcParser.WHILE)
                self.state = 234
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
        self.enterRule(localctx, 40, self.RULE_ret)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 237
            self.match(CalcParser.RETURN)
            self.state = 239
            _la = self._input.LA(1)
            if (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.T__4) | (1 << CalcParser.T__18) | (1 << CalcParser.T__19) | (1 << CalcParser.LITERAL) | (1 << CalcParser.ID))) != 0):
                self.state = 238
                self.expr(0)


            self.state = 241
            self.match(CalcParser.T__2)
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


        def vardecl(self):
            return self.getTypedRuleContext(CalcParser.VardeclContext,0)


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
        self.enterRule(localctx, 42, self.RULE_function)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 243
            localctx.retType = self.full_id()
            self.state = 244
            localctx.fnName = self.full_id()
            self.state = 245
            self.formParList()
            self.state = 247
            _la = self._input.LA(1)
            if _la==CalcParser.VAR:
                self.state = 246
                self.vardecl()


            self.state = 249
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
        self.enterRule(localctx, 44, self.RULE_formParList)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 251
            self.match(CalcParser.T__4)
            self.state = 255
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==CalcParser.ID:
                self.state = 252
                self.formPar()
                self.state = 257
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 258
            self.match(CalcParser.T__5)
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
        self.enterRule(localctx, 46, self.RULE_formPar)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 260
            self.r_type()
            self.state = 261
            localctx.name = self.full_id()
            self.state = 264
            _la = self._input.LA(1)
            if _la==CalcParser.LET:
                self.state = 262
                self.match(CalcParser.LET)
                self.state = 263
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
        self.enterRule(localctx, 48, self.RULE_full_id)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 266
            self.match(CalcParser.ID)
            self.state = 268
            la_ = self._interp.adaptivePredict(self._input,27,self._ctx)
            if la_ == 1:
                self.state = 267
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
        self.enterRule(localctx, 50, self.RULE_sub_id)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 270
            self.match(CalcParser.T__1)
            self.state = 271
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
                return self.precpred(self._ctx, 11)
         

            if predIndex == 1:
                return self.precpred(self._ctx, 10)
         

            if predIndex == 2:
                return self.precpred(self._ctx, 9)
         

            if predIndex == 3:
                return self.precpred(self._ctx, 8)
         

            if predIndex == 4:
                return self.precpred(self._ctx, 7)
         



