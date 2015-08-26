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
        buf.write(u"\61\u0134\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7")
        buf.write(u"\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t\13\4\f\t\f\4\r\t")
        buf.write(u"\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22")
        buf.write(u"\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4")
        buf.write(u"\30\t\30\4\31\t\31\4\32\t\32\4\33\t\33\4\34\t\34\4\35")
        buf.write(u"\t\35\4\36\t\36\3\2\3\2\5\2?\n\2\3\2\5\2B\n\2\3\2\7\2")
        buf.write(u"E\n\2\f\2\16\2H\13\2\3\3\3\3\3\3\3\3\3\3\3\3\3\4\3\4")
        buf.write(u"\3\5\3\5\3\5\3\5\5\5V\n\5\3\5\3\5\3\6\3\6\7\6\\\n\6\f")
        buf.write(u"\6\16\6_\13\6\3\6\3\6\3\6\3\7\3\7\7\7f\n\7\f\7\16\7i")
        buf.write(u"\13\7\3\7\3\7\3\b\3\b\3\b\3\b\3\b\3\b\3\b\3\b\5\bu\n")
        buf.write(u"\b\3\t\3\t\3\t\3\t\3\n\3\n\3\n\3\n\3\n\3\13\3\13\3\13")
        buf.write(u"\3\13\3\13\3\13\3\13\3\13\3\f\3\f\3\f\3\f\3\f\3\f\3\f")
        buf.write(u"\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\5\f\u0098\n\f\3")
        buf.write(u"\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3")
        buf.write(u"\f\3\f\3\f\3\f\3\f\3\f\3\f\7\f\u00ae\n\f\f\f\16\f\u00b1")
        buf.write(u"\13\f\3\r\3\r\3\r\7\r\u00b6\n\r\f\r\16\r\u00b9\13\r\5")
        buf.write(u"\r\u00bb\n\r\3\16\3\16\7\16\u00bf\n\16\f\16\16\16\u00c2")
        buf.write(u"\13\16\3\17\3\17\7\17\u00c6\n\17\f\17\16\17\u00c9\13")
        buf.write(u"\17\3\20\3\20\3\20\7\20\u00ce\n\20\f\20\16\20\u00d1\13")
        buf.write(u"\20\5\20\u00d3\n\20\3\20\3\20\3\20\3\20\3\21\3\21\3\21")
        buf.write(u"\3\21\3\21\3\22\3\22\3\23\5\23\u00e1\n\23\3\23\3\23\3")
        buf.write(u"\24\3\24\3\24\3\24\3\24\3\24\3\25\3\25\5\25\u00ed\n\25")
        buf.write(u"\3\26\3\26\3\26\3\26\3\26\3\26\3\26\5\26\u00f6\n\26\3")
        buf.write(u"\26\5\26\u00f9\n\26\3\27\3\27\3\27\5\27\u00fe\n\27\3")
        buf.write(u"\30\3\30\3\30\5\30\u0103\n\30\3\30\7\30\u0106\n\30\f")
        buf.write(u"\30\16\30\u0109\13\30\3\30\3\30\3\30\5\30\u010e\n\30")
        buf.write(u"\3\31\3\31\5\31\u0112\n\31\3\31\3\31\3\32\3\32\3\32\3")
        buf.write(u"\32\5\32\u011a\n\32\3\32\3\32\3\33\3\33\7\33\u0120\n")
        buf.write(u"\33\f\33\16\33\u0123\13\33\3\33\3\33\3\34\3\34\3\34\3")
        buf.write(u"\34\5\34\u012b\n\34\3\35\3\35\5\35\u012f\n\35\3\36\3")
        buf.write(u"\36\3\36\3\36\2\3\26\37\2\4\6\b\n\f\16\20\22\24\26\30")
        buf.write(u"\32\34\36 \"$&(*,.\60\62\64\668:\2\6\3\2\13\f\3\2\r\16")
        buf.write(u"\3\2\17\20\3\2\21\25\u013f\2<\3\2\2\2\4I\3\2\2\2\6O\3")
        buf.write(u"\2\2\2\bQ\3\2\2\2\nY\3\2\2\2\fc\3\2\2\2\16t\3\2\2\2\20")
        buf.write(u"v\3\2\2\2\22z\3\2\2\2\24\177\3\2\2\2\26\u0097\3\2\2\2")
        buf.write(u"\30\u00ba\3\2\2\2\32\u00bc\3\2\2\2\34\u00c3\3\2\2\2\36")
        buf.write(u"\u00d2\3\2\2\2 \u00d8\3\2\2\2\"\u00dd\3\2\2\2$\u00e0")
        buf.write(u"\3\2\2\2&\u00e4\3\2\2\2(\u00ec\3\2\2\2*\u00ee\3\2\2\2")
        buf.write(u",\u00fa\3\2\2\2.\u00ff\3\2\2\2\60\u010f\3\2\2\2\62\u0115")
        buf.write(u"\3\2\2\2\64\u011d\3\2\2\2\66\u0126\3\2\2\28\u012c\3\2")
        buf.write(u"\2\2:\u0130\3\2\2\2<>\5\4\3\2=?\5\34\17\2>=\3\2\2\2>")
        buf.write(u"?\3\2\2\2?A\3\2\2\2@B\5\32\16\2A@\3\2\2\2AB\3\2\2\2B")
        buf.write(u"F\3\2\2\2CE\5\b\5\2DC\3\2\2\2EH\3\2\2\2FD\3\2\2\2FG\3")
        buf.write(u"\2\2\2G\3\3\2\2\2HF\3\2\2\2IJ\7\3\2\2JK\7,\2\2KL\7\4")
        buf.write(u"\2\2LM\5\6\4\2MN\7\5\2\2N\5\3\2\2\2OP\7,\2\2P\7\3\2\2")
        buf.write(u"\2QR\7\"\2\2RS\7,\2\2SU\7\5\2\2TV\5\32\16\2UT\3\2\2\2")
        buf.write(u"UV\3\2\2\2VW\3\2\2\2WX\5\n\6\2X\t\3\2\2\2Y]\7)\2\2Z\\")
        buf.write(u"\5\16\b\2[Z\3\2\2\2\\_\3\2\2\2][\3\2\2\2]^\3\2\2\2^`")
        buf.write(u"\3\2\2\2_]\3\2\2\2`a\7*\2\2ab\7\5\2\2b\13\3\2\2\2cg\7")
        buf.write(u")\2\2df\5\16\b\2ed\3\2\2\2fi\3\2\2\2ge\3\2\2\2gh\3\2")
        buf.write(u"\2\2hj\3\2\2\2ig\3\2\2\2jk\7*\2\2k\r\3\2\2\2lm\5\20\t")
        buf.write(u"\2mn\7\5\2\2nu\3\2\2\2op\5\22\n\2pq\7\5\2\2qu\3\2\2\2")
        buf.write(u"ru\5\60\31\2su\5(\25\2tl\3\2\2\2to\3\2\2\2tr\3\2\2\2")
        buf.write(u"ts\3\2\2\2u\17\3\2\2\2vw\58\35\2wx\7+\2\2xy\5\26\f\2")
        buf.write(u"y\21\3\2\2\2z{\7,\2\2{|\7\6\2\2|}\5\30\r\2}~\7\7\2\2")
        buf.write(u"~\23\3\2\2\2\177\u0080\7,\2\2\u0080\u0081\7\b\2\2\u0081")
        buf.write(u"\u0082\7\32\2\2\u0082\u0083\7\t\2\2\u0083\u0084\7,\2")
        buf.write(u"\2\u0084\u0085\7\n\2\2\u0085\u0086\7\5\2\2\u0086\25\3")
        buf.write(u"\2\2\2\u0087\u0088\b\f\1\2\u0088\u0089\7$\2\2\u0089\u0098")
        buf.write(u"\5\26\f\t\u008a\u0098\58\35\2\u008b\u0098\5\22\n\2\u008c")
        buf.write(u"\u0098\5\24\13\2\u008d\u008e\7\27\2\2\u008e\u008f\7\6")
        buf.write(u"\2\2\u008f\u0090\5\30\r\2\u0090\u0091\7\7\2\2\u0091\u0098")
        buf.write(u"\3\2\2\2\u0092\u0098\7\32\2\2\u0093\u0094\7\6\2\2\u0094")
        buf.write(u"\u0095\5\26\f\2\u0095\u0096\7\7\2\2\u0096\u0098\3\2\2")
        buf.write(u"\2\u0097\u0087\3\2\2\2\u0097\u008a\3\2\2\2\u0097\u008b")
        buf.write(u"\3\2\2\2\u0097\u008c\3\2\2\2\u0097\u008d\3\2\2\2\u0097")
        buf.write(u"\u0092\3\2\2\2\u0097\u0093\3\2\2\2\u0098\u00af\3\2\2")
        buf.write(u"\2\u0099\u009a\f\16\2\2\u009a\u009b\t\2\2\2\u009b\u00ae")
        buf.write(u"\5\26\f\17\u009c\u009d\f\r\2\2\u009d\u009e\t\3\2\2\u009e")
        buf.write(u"\u00ae\5\26\f\16\u009f\u00a0\f\f\2\2\u00a0\u00a1\t\4")
        buf.write(u"\2\2\u00a1\u00ae\5\26\f\r\u00a2\u00a3\f\13\2\2\u00a3")
        buf.write(u"\u00a4\t\5\2\2\u00a4\u00ae\5\26\f\f\u00a5\u00a6\f\n\2")
        buf.write(u"\2\u00a6\u00a7\7\f\2\2\u00a7\u00a8\7\6\2\2\u00a8\u00a9")
        buf.write(u"\5\26\f\2\u00a9\u00aa\7\13\2\2\u00aa\u00ab\7\26\2\2\u00ab")
        buf.write(u"\u00ac\7\7\2\2\u00ac\u00ae\3\2\2\2\u00ad\u0099\3\2\2")
        buf.write(u"\2\u00ad\u009c\3\2\2\2\u00ad\u009f\3\2\2\2\u00ad\u00a2")
        buf.write(u"\3\2\2\2\u00ad\u00a5\3\2\2\2\u00ae\u00b1\3\2\2\2\u00af")
        buf.write(u"\u00ad\3\2\2\2\u00af\u00b0\3\2\2\2\u00b0\27\3\2\2\2\u00b1")
        buf.write(u"\u00af\3\2\2\2\u00b2\u00b7\5\26\f\2\u00b3\u00b4\7\30")
        buf.write(u"\2\2\u00b4\u00b6\5\26\f\2\u00b5\u00b3\3\2\2\2\u00b6\u00b9")
        buf.write(u"\3\2\2\2\u00b7\u00b5\3\2\2\2\u00b7\u00b8\3\2\2\2\u00b8")
        buf.write(u"\u00bb\3\2\2\2\u00b9\u00b7\3\2\2\2\u00ba\u00b2\3\2\2")
        buf.write(u"\2\u00ba\u00bb\3\2\2\2\u00bb\31\3\2\2\2\u00bc\u00c0\7")
        buf.write(u"\35\2\2\u00bd\u00bf\5\36\20\2\u00be\u00bd\3\2\2\2\u00bf")
        buf.write(u"\u00c2\3\2\2\2\u00c0\u00be\3\2\2\2\u00c0\u00c1\3\2\2")
        buf.write(u"\2\u00c1\33\3\2\2\2\u00c2\u00c0\3\2\2\2\u00c3\u00c7\7")
        buf.write(u"\36\2\2\u00c4\u00c6\5 \21\2\u00c5\u00c4\3\2\2\2\u00c6")
        buf.write(u"\u00c9\3\2\2\2\u00c7\u00c5\3\2\2\2\u00c7\u00c8\3\2\2")
        buf.write(u"\2\u00c8\35\3\2\2\2\u00c9\u00c7\3\2\2\2\u00ca\u00cf\5")
        buf.write(u"\"\22\2\u00cb\u00cc\7\30\2\2\u00cc\u00ce\5\"\22\2\u00cd")
        buf.write(u"\u00cb\3\2\2\2\u00ce\u00d1\3\2\2\2\u00cf\u00cd\3\2\2")
        buf.write(u"\2\u00cf\u00d0\3\2\2\2\u00d0\u00d3\3\2\2\2\u00d1\u00cf")
        buf.write(u"\3\2\2\2\u00d2\u00ca\3\2\2\2\u00d2\u00d3\3\2\2\2\u00d3")
        buf.write(u"\u00d4\3\2\2\2\u00d4\u00d5\7\31\2\2\u00d5\u00d6\5$\23")
        buf.write(u"\2\u00d6\u00d7\7\5\2\2\u00d7\37\3\2\2\2\u00d8\u00d9\5")
        buf.write(u"\"\22\2\u00d9\u00da\7\25\2\2\u00da\u00db\7\32\2\2\u00db")
        buf.write(u"\u00dc\7\5\2\2\u00dc!\3\2\2\2\u00dd\u00de\7,\2\2\u00de")
        buf.write(u"#\3\2\2\2\u00df\u00e1\5&\24\2\u00e0\u00df\3\2\2\2\u00e0")
        buf.write(u"\u00e1\3\2\2\2\u00e1\u00e2\3\2\2\2\u00e2\u00e3\7,\2\2")
        buf.write(u"\u00e3%\3\2\2\2\u00e4\u00e5\7\33\2\2\u00e5\u00e6\7\b")
        buf.write(u"\2\2\u00e6\u00e7\7\32\2\2\u00e7\u00e8\7\n\2\2\u00e8\u00e9")
        buf.write(u"\7\34\2\2\u00e9\'\3\2\2\2\u00ea\u00ed\5*\26\2\u00eb\u00ed")
        buf.write(u"\5.\30\2\u00ec\u00ea\3\2\2\2\u00ec\u00eb\3\2\2\2\u00ed")
        buf.write(u")\3\2\2\2\u00ee\u00ef\7\37\2\2\u00ef\u00f0\5\26\f\2\u00f0")
        buf.write(u"\u00f5\7!\2\2\u00f1\u00f6\5\n\6\2\u00f2\u00f6\5\16\b")
        buf.write(u"\2\u00f3\u00f6\5\f\7\2\u00f4\u00f6\5\20\t\2\u00f5\u00f1")
        buf.write(u"\3\2\2\2\u00f5\u00f2\3\2\2\2\u00f5\u00f3\3\2\2\2\u00f5")
        buf.write(u"\u00f4\3\2\2\2\u00f6\u00f8\3\2\2\2\u00f7\u00f9\5,\27")
        buf.write(u"\2\u00f8\u00f7\3\2\2\2\u00f8\u00f9\3\2\2\2\u00f9+\3\2")
        buf.write(u"\2\2\u00fa\u00fd\7 \2\2\u00fb\u00fe\5\n\6\2\u00fc\u00fe")
        buf.write(u"\5\16\b\2\u00fd\u00fb\3\2\2\2\u00fd\u00fc\3\2\2\2\u00fe")
        buf.write(u"-\3\2\2\2\u00ff\u0102\7#\2\2\u0100\u0101\7%\2\2\u0101")
        buf.write(u"\u0103\5\26\f\2\u0102\u0100\3\2\2\2\u0102\u0103\3\2\2")
        buf.write(u"\2\u0103\u0107\3\2\2\2\u0104\u0106\5\16\b\2\u0105\u0104")
        buf.write(u"\3\2\2\2\u0106\u0109\3\2\2\2\u0107\u0105\3\2\2\2\u0107")
        buf.write(u"\u0108\3\2\2\2\u0108\u010a\3\2\2\2\u0109\u0107\3\2\2")
        buf.write(u"\2\u010a\u010d\7&\2\2\u010b\u010c\7%\2\2\u010c\u010e")
        buf.write(u"\5\26\f\2\u010d\u010b\3\2\2\2\u010d\u010e\3\2\2\2\u010e")
        buf.write(u"/\3\2\2\2\u010f\u0111\7\'\2\2\u0110\u0112\5\26\f\2\u0111")
        buf.write(u"\u0110\3\2\2\2\u0111\u0112\3\2\2\2\u0112\u0113\3\2\2")
        buf.write(u"\2\u0113\u0114\7\5\2\2\u0114\61\3\2\2\2\u0115\u0116\5")
        buf.write(u"8\35\2\u0116\u0117\58\35\2\u0117\u0119\5\64\33\2\u0118")
        buf.write(u"\u011a\5\32\16\2\u0119\u0118\3\2\2\2\u0119\u011a\3\2")
        buf.write(u"\2\2\u011a\u011b\3\2\2\2\u011b\u011c\5\n\6\2\u011c\63")
        buf.write(u"\3\2\2\2\u011d\u0121\7\6\2\2\u011e\u0120\5\66\34\2\u011f")
        buf.write(u"\u011e\3\2\2\2\u0120\u0123\3\2\2\2\u0121\u011f\3\2\2")
        buf.write(u"\2\u0121\u0122\3\2\2\2\u0122\u0124\3\2\2\2\u0123\u0121")
        buf.write(u"\3\2\2\2\u0124\u0125\7\7\2\2\u0125\65\3\2\2\2\u0126\u0127")
        buf.write(u"\5$\23\2\u0127\u012a\58\35\2\u0128\u0129\7+\2\2\u0129")
        buf.write(u"\u012b\5\26\f\2\u012a\u0128\3\2\2\2\u012a\u012b\3\2\2")
        buf.write(u"\2\u012b\67\3\2\2\2\u012c\u012e\7,\2\2\u012d\u012f\5")
        buf.write(u":\36\2\u012e\u012d\3\2\2\2\u012e\u012f\3\2\2\2\u012f")
        buf.write(u"9\3\2\2\2\u0130\u0131\7\4\2\2\u0131\u0132\7,\2\2\u0132")
        buf.write(u";\3\2\2\2\37>AFU]gt\u0097\u00ad\u00af\u00b7\u00ba\u00c0")
        buf.write(u"\u00c7\u00cf\u00d2\u00e0\u00ec\u00f5\u00f8\u00fd\u0102")
        buf.write(u"\u0107\u010d\u0111\u0119\u0121\u012a\u012e")
        return buf.getvalue()


class CalcParser ( Parser ):

    grammarFileName = "java-escape"

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    sharedContextCache = PredictionContextCache()

    literalNames = [ u"<INVALID>", u"'FORM'", u"'.'", u"';'", u"'('", u"')'", 
                     u"'['", u"'..'", u"']'", u"'/'", u"'*'", u"'+'", u"'-'", 
                     u"'and'", u"'or'", u"'>'", u"'<'", u"'<='", u"'>='", 
                     u"'='", u"'100'", u"'MAX'", u"','", u"':'", u"<INVALID>", 
                     u"'Array'", u"'of'", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                     u"<INVALID>", u"<INVALID>", u"<INVALID>", u"'do'", 
                     u"'not'", u"'while'", u"'loop'", u"'return'", u"<INVALID>", 
                     u"<INVALID>", u"<INVALID>", u"':='" ]

    symbolicNames = [ u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"LITERAL", u"ARRAY", u"OF", u"VAR", u"CONSTANT", 
                      u"IF", u"ELSE", u"THEN", u"SECTION", u"DO", u"NOT", 
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
    RULE_multicopy_accum = 9
    RULE_expr = 10
    RULE_argList = 11
    RULE_vardecl = 12
    RULE_constdecl = 13
    RULE_declList = 14
    RULE_constdeclList = 15
    RULE_varDecl = 16
    RULE_r_type = 17
    RULE_arrayDecl = 18
    RULE_ctrlStruct = 19
    RULE_ifStruct = 20
    RULE_elseStruct = 21
    RULE_loopStruct = 22
    RULE_ret = 23
    RULE_function = 24
    RULE_formParList = 25
    RULE_formPar = 26
    RULE_full_id = 27
    RULE_sub_id = 28

    ruleNames =  [ u"calcfile", u"formset", u"form", u"section", u"block", 
                   u"dumbblock", u"stmt", u"assign", u"call", u"multicopy_accum", 
                   u"expr", u"argList", u"vardecl", u"constdecl", u"declList", 
                   u"constdeclList", u"varDecl", u"r_type", u"arrayDecl", 
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
    T__22=23
    LITERAL=24
    ARRAY=25
    OF=26
    VAR=27
    CONSTANT=28
    IF=29
    ELSE=30
    THEN=31
    SECTION=32
    DO=33
    NOT=34
    WHILE=35
    LOOP=36
    RETURN=37
    WS=38
    BEGIN=39
    END=40
    LET=41
    ID=42
    INT=43
    STRING=44
    BOOLEAN=45
    COMMENT=46
    LINE_COMMENT=47

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
            self.state = 58
            self.formset()
            self.state = 60
            _la = self._input.LA(1)
            if _la==CalcParser.CONSTANT:
                self.state = 59
                self.constdecl()


            self.state = 63
            _la = self._input.LA(1)
            if _la==CalcParser.VAR:
                self.state = 62
                self.vardecl()


            self.state = 68
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==CalcParser.SECTION:
                self.state = 65
                self.section()
                self.state = 70
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
            self.state = 71
            self.match(CalcParser.T__0)
            self.state = 72
            self.match(CalcParser.ID)
            self.state = 73
            self.match(CalcParser.T__1)
            self.state = 74
            self.form()
            self.state = 75
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
            self.state = 77
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

        def SECTION(self):
            return self.getToken(CalcParser.SECTION, 0)

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
            self.state = 79
            self.match(CalcParser.SECTION)
            self.state = 80
            self.match(CalcParser.ID)
            self.state = 81
            self.match(CalcParser.T__2)
            self.state = 83
            _la = self._input.LA(1)
            if _la==CalcParser.VAR:
                self.state = 82
                self.vardecl()


            self.state = 85
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
            self.state = 87
            self.match(CalcParser.BEGIN)
            self.state = 91
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.IF) | (1 << CalcParser.DO) | (1 << CalcParser.RETURN) | (1 << CalcParser.ID))) != 0):
                self.state = 88
                self.stmt()
                self.state = 93
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 94
            self.match(CalcParser.END)
            self.state = 95
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
            self.state = 97
            self.match(CalcParser.BEGIN)
            self.state = 101
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.IF) | (1 << CalcParser.DO) | (1 << CalcParser.RETURN) | (1 << CalcParser.ID))) != 0):
                self.state = 98
                self.stmt()
                self.state = 103
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 104
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
            self.state = 114
            la_ = self._interp.adaptivePredict(self._input,6,self._ctx)
            if la_ == 1:
                self.enterOuterAlt(localctx, 1)
                self.state = 106
                self.assign()
                self.state = 107
                self.match(CalcParser.T__2)
                pass

            elif la_ == 2:
                self.enterOuterAlt(localctx, 2)
                self.state = 109
                self.call()
                self.state = 110
                self.match(CalcParser.T__2)
                pass

            elif la_ == 3:
                self.enterOuterAlt(localctx, 3)
                self.state = 112
                self.ret()
                pass

            elif la_ == 4:
                self.enterOuterAlt(localctx, 4)
                self.state = 113
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
            self.state = 116
            self.full_id()
            self.state = 117
            self.match(CalcParser.LET)
            self.state = 118
            self.expr(0)
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
            self.state = 120
            self.match(CalcParser.ID)
            self.state = 121
            self.match(CalcParser.T__3)
            self.state = 122
            self.argList()
            self.state = 123
            self.match(CalcParser.T__4)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Multicopy_accumContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.Multicopy_accumContext, self).__init__(parent, invokingState)
            self.parser = parser

        def ID(self, i=None):
            if i is None:
                return self.getTokens(CalcParser.ID)
            else:
                return self.getToken(CalcParser.ID, i)

        def LITERAL(self):
            return self.getToken(CalcParser.LITERAL, 0)

        def getRuleIndex(self):
            return CalcParser.RULE_multicopy_accum

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterMulticopy_accum(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitMulticopy_accum(self)




    def multicopy_accum(self):

        localctx = CalcParser.Multicopy_accumContext(self, self._ctx, self.state)
        self.enterRule(localctx, 18, self.RULE_multicopy_accum)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 125
            self.match(CalcParser.ID)
            self.state = 126
            self.match(CalcParser.T__5)
            self.state = 127
            self.match(CalcParser.LITERAL)
            self.state = 128
            self.match(CalcParser.T__6)
            self.state = 129
            self.match(CalcParser.ID)
            self.state = 130
            self.match(CalcParser.T__7)
            self.state = 131
            self.match(CalcParser.T__2)
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


    class MultiCopyAccumulateContext(ExprContext):

        def __init__(self, parser, ctx): # actually a CalcParser.ExprContext)
            super(CalcParser.MultiCopyAccumulateContext, self).__init__(parser)
            self.copyFrom(ctx)

        def multicopy_accum(self):
            return self.getTypedRuleContext(CalcParser.Multicopy_accumContext,0)


        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterMultiCopyAccumulate(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitMultiCopyAccumulate(self)


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


    class NotContext(ExprContext):

        def __init__(self, parser, ctx): # actually a CalcParser.ExprContext)
            super(CalcParser.NotContext, self).__init__(parser)
            self.copyFrom(ctx)

        def NOT(self):
            return self.getToken(CalcParser.NOT, 0)
        def expr(self):
            return self.getTypedRuleContext(CalcParser.ExprContext,0)


        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterNot(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitNot(self)



    def expr(self, _p=0):
        _parentctx = self._ctx
        _parentState = self.state
        localctx = CalcParser.ExprContext(self, self._ctx, _parentState)
        _prevctx = localctx
        _startState = 20
        self.enterRecursionRule(localctx, 20, self.RULE_expr, _p)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 149
            la_ = self._interp.adaptivePredict(self._input,7,self._ctx)
            if la_ == 1:
                localctx = CalcParser.NotContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx

                self.state = 134
                self.match(CalcParser.NOT)
                self.state = 135
                self.expr(7)
                pass

            elif la_ == 2:
                localctx = CalcParser.VarRefContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 136
                self.full_id()
                pass

            elif la_ == 3:
                localctx = CalcParser.FunctionCallContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 137
                self.call()
                pass

            elif la_ == 4:
                localctx = CalcParser.MultiCopyAccumulateContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 138
                self.multicopy_accum()
                pass

            elif la_ == 5:
                localctx = CalcParser.MaxContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 139
                self.match(CalcParser.T__20)
                self.state = 140
                self.match(CalcParser.T__3)
                self.state = 141
                self.argList()
                self.state = 142
                self.match(CalcParser.T__4)
                pass

            elif la_ == 6:
                localctx = CalcParser.LiteralContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 144
                self.match(CalcParser.LITERAL)
                pass

            elif la_ == 7:
                localctx = CalcParser.ParensContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 145
                self.match(CalcParser.T__3)
                self.state = 146
                self.expr(0)
                self.state = 147
                self.match(CalcParser.T__4)
                pass


            self._ctx.stop = self._input.LT(-1)
            self.state = 173
            self._errHandler.sync(self)
            _alt = self._interp.adaptivePredict(self._input,9,self._ctx)
            while _alt!=2 and _alt!=ATN.INVALID_ALT_NUMBER:
                if _alt==1:
                    if self._parseListeners is not None:
                        self.triggerExitRuleEvent()
                    _prevctx = localctx
                    self.state = 171
                    la_ = self._interp.adaptivePredict(self._input,8,self._ctx)
                    if la_ == 1:
                        localctx = CalcParser.DivMulContext(self, CalcParser.ExprContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expr)
                        self.state = 151
                        if not self.precpred(self._ctx, 12):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 12)")
                        self.state = 152
                        localctx.op = self._input.LT(1)
                        _la = self._input.LA(1)
                        if not(_la==CalcParser.T__8 or _la==CalcParser.T__9):
                            localctx.op = self._errHandler.recoverInline(self)
                        else:
                            self.consume()
                        self.state = 153
                        self.expr(13)
                        pass

                    elif la_ == 2:
                        localctx = CalcParser.AddSubContext(self, CalcParser.ExprContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expr)
                        self.state = 154
                        if not self.precpred(self._ctx, 11):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 11)")
                        self.state = 155
                        localctx.op = self._input.LT(1)
                        _la = self._input.LA(1)
                        if not(_la==CalcParser.T__10 or _la==CalcParser.T__11):
                            localctx.op = self._errHandler.recoverInline(self)
                        else:
                            self.consume()
                        self.state = 156
                        self.expr(12)
                        pass

                    elif la_ == 3:
                        localctx = CalcParser.LogicContext(self, CalcParser.ExprContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expr)
                        self.state = 157
                        if not self.precpred(self._ctx, 10):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 10)")
                        self.state = 158
                        localctx.op = self._input.LT(1)
                        _la = self._input.LA(1)
                        if not(_la==CalcParser.T__12 or _la==CalcParser.T__13):
                            localctx.op = self._errHandler.recoverInline(self)
                        else:
                            self.consume()
                        self.state = 159
                        self.expr(11)
                        pass

                    elif la_ == 4:
                        localctx = CalcParser.PredicateContext(self, CalcParser.ExprContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expr)
                        self.state = 160
                        if not self.precpred(self._ctx, 9):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 9)")
                        self.state = 161
                        localctx.op = self._input.LT(1)
                        _la = self._input.LA(1)
                        if not((((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.T__14) | (1 << CalcParser.T__15) | (1 << CalcParser.T__16) | (1 << CalcParser.T__17) | (1 << CalcParser.T__18))) != 0)):
                            localctx.op = self._errHandler.recoverInline(self)
                        else:
                            self.consume()
                        self.state = 162
                        self.expr(10)
                        pass

                    elif la_ == 5:
                        localctx = CalcParser.PercentageOfContext(self, CalcParser.ExprContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expr)
                        self.state = 163
                        if not self.precpred(self._ctx, 8):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 8)")
                        self.state = 164
                        self.match(CalcParser.T__9)
                        self.state = 165
                        self.match(CalcParser.T__3)
                        self.state = 166
                        self.expr(0)
                        self.state = 167
                        self.match(CalcParser.T__8)
                        self.state = 168
                        self.match(CalcParser.T__19)
                        self.state = 169
                        self.match(CalcParser.T__4)
                        pass

             
                self.state = 175
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
        self.enterRule(localctx, 22, self.RULE_argList)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 184
            _la = self._input.LA(1)
            if (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.T__3) | (1 << CalcParser.T__20) | (1 << CalcParser.LITERAL) | (1 << CalcParser.NOT) | (1 << CalcParser.ID))) != 0):
                self.state = 176
                self.expr(0)
                self.state = 181
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                while _la==CalcParser.T__21:
                    self.state = 177
                    self.match(CalcParser.T__21)
                    self.state = 178
                    self.expr(0)
                    self.state = 183
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
        self.enterRule(localctx, 24, self.RULE_vardecl)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 186
            self.match(CalcParser.VAR)
            self.state = 190
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==CalcParser.T__22 or _la==CalcParser.ID:
                self.state = 187
                self.declList()
                self.state = 192
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

        def constdeclList(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(CalcParser.ConstdeclListContext)
            else:
                return self.getTypedRuleContext(CalcParser.ConstdeclListContext,i)


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
        self.enterRule(localctx, 26, self.RULE_constdecl)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 193
            self.match(CalcParser.CONSTANT)
            self.state = 197
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==CalcParser.ID:
                self.state = 194
                self.constdeclList()
                self.state = 199
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
        self.enterRule(localctx, 28, self.RULE_declList)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 208
            _la = self._input.LA(1)
            if _la==CalcParser.ID:
                self.state = 200
                self.varDecl()
                self.state = 205
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                while _la==CalcParser.T__21:
                    self.state = 201
                    self.match(CalcParser.T__21)
                    self.state = 202
                    self.varDecl()
                    self.state = 207
                    self._errHandler.sync(self)
                    _la = self._input.LA(1)



            self.state = 210
            self.match(CalcParser.T__22)
            self.state = 211
            self.r_type()
            self.state = 212
            self.match(CalcParser.T__2)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class ConstdeclListContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.ConstdeclListContext, self).__init__(parent, invokingState)
            self.parser = parser

        def varDecl(self):
            return self.getTypedRuleContext(CalcParser.VarDeclContext,0)


        def LITERAL(self):
            return self.getToken(CalcParser.LITERAL, 0)

        def getRuleIndex(self):
            return CalcParser.RULE_constdeclList

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterConstdeclList(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitConstdeclList(self)




    def constdeclList(self):

        localctx = CalcParser.ConstdeclListContext(self, self._ctx, self.state)
        self.enterRule(localctx, 30, self.RULE_constdeclList)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 214
            self.varDecl()
            self.state = 215
            self.match(CalcParser.T__18)
            self.state = 216
            self.match(CalcParser.LITERAL)
            self.state = 217
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
        self.enterRule(localctx, 32, self.RULE_varDecl)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 219
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

        def arrayDecl(self):
            return self.getTypedRuleContext(CalcParser.ArrayDeclContext,0)


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
        self.enterRule(localctx, 34, self.RULE_r_type)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 222
            _la = self._input.LA(1)
            if _la==CalcParser.ARRAY:
                self.state = 221
                self.arrayDecl()


            self.state = 224
            self.match(CalcParser.ID)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class ArrayDeclContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.ArrayDeclContext, self).__init__(parent, invokingState)
            self.parser = parser

        def ARRAY(self):
            return self.getToken(CalcParser.ARRAY, 0)

        def LITERAL(self):
            return self.getToken(CalcParser.LITERAL, 0)

        def OF(self):
            return self.getToken(CalcParser.OF, 0)

        def getRuleIndex(self):
            return CalcParser.RULE_arrayDecl

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterArrayDecl(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitArrayDecl(self)




    def arrayDecl(self):

        localctx = CalcParser.ArrayDeclContext(self, self._ctx, self.state)
        self.enterRule(localctx, 36, self.RULE_arrayDecl)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 226
            self.match(CalcParser.ARRAY)
            self.state = 227
            self.match(CalcParser.T__5)
            self.state = 228
            self.match(CalcParser.LITERAL)
            self.state = 229
            self.match(CalcParser.T__7)
            self.state = 230
            self.match(CalcParser.OF)
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
        self.enterRule(localctx, 38, self.RULE_ctrlStruct)
        try:
            self.state = 234
            token = self._input.LA(1)
            if token in [CalcParser.IF]:
                self.enterOuterAlt(localctx, 1)
                self.state = 232
                self.ifStruct()

            elif token in [CalcParser.DO]:
                self.enterOuterAlt(localctx, 2)
                self.state = 233
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


        def assign(self):
            return self.getTypedRuleContext(CalcParser.AssignContext,0)


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
        self.enterRule(localctx, 40, self.RULE_ifStruct)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 236
            self.match(CalcParser.IF)
            self.state = 237
            self.expr(0)
            self.state = 238
            self.match(CalcParser.THEN)
            self.state = 243
            la_ = self._interp.adaptivePredict(self._input,18,self._ctx)
            if la_ == 1:
                self.state = 239
                self.block()
                pass

            elif la_ == 2:
                self.state = 240
                self.stmt()
                pass

            elif la_ == 3:
                self.state = 241
                self.dumbblock()
                pass

            elif la_ == 4:
                self.state = 242
                self.assign()
                pass


            self.state = 246
            la_ = self._interp.adaptivePredict(self._input,19,self._ctx)
            if la_ == 1:
                self.state = 245
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
        self.enterRule(localctx, 42, self.RULE_elseStruct)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 248
            self.match(CalcParser.ELSE)
            self.state = 251
            token = self._input.LA(1)
            if token in [CalcParser.BEGIN]:
                self.state = 249
                self.block()

            elif token in [CalcParser.IF, CalcParser.DO, CalcParser.RETURN, CalcParser.ID]:
                self.state = 250
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
        self.enterRule(localctx, 44, self.RULE_loopStruct)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 253
            self.match(CalcParser.DO)
            self.state = 256
            _la = self._input.LA(1)
            if _la==CalcParser.WHILE:
                self.state = 254
                self.match(CalcParser.WHILE)
                self.state = 255
                localctx.preCond = self.expr(0)


            self.state = 261
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.IF) | (1 << CalcParser.DO) | (1 << CalcParser.RETURN) | (1 << CalcParser.ID))) != 0):
                self.state = 258
                self.stmt()
                self.state = 263
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 264
            self.match(CalcParser.LOOP)
            self.state = 267
            _la = self._input.LA(1)
            if _la==CalcParser.WHILE:
                self.state = 265
                self.match(CalcParser.WHILE)
                self.state = 266
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
        self.enterRule(localctx, 46, self.RULE_ret)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 269
            self.match(CalcParser.RETURN)
            self.state = 271
            _la = self._input.LA(1)
            if (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.T__3) | (1 << CalcParser.T__20) | (1 << CalcParser.LITERAL) | (1 << CalcParser.NOT) | (1 << CalcParser.ID))) != 0):
                self.state = 270
                self.expr(0)


            self.state = 273
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
        self.enterRule(localctx, 48, self.RULE_function)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 275
            localctx.retType = self.full_id()
            self.state = 276
            localctx.fnName = self.full_id()
            self.state = 277
            self.formParList()
            self.state = 279
            _la = self._input.LA(1)
            if _la==CalcParser.VAR:
                self.state = 278
                self.vardecl()


            self.state = 281
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
        self.enterRule(localctx, 50, self.RULE_formParList)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 283
            self.match(CalcParser.T__3)
            self.state = 287
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==CalcParser.ARRAY or _la==CalcParser.ID:
                self.state = 284
                self.formPar()
                self.state = 289
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 290
            self.match(CalcParser.T__4)
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
        self.enterRule(localctx, 52, self.RULE_formPar)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 292
            self.r_type()
            self.state = 293
            localctx.name = self.full_id()
            self.state = 296
            _la = self._input.LA(1)
            if _la==CalcParser.LET:
                self.state = 294
                self.match(CalcParser.LET)
                self.state = 295
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
        self.enterRule(localctx, 54, self.RULE_full_id)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 298
            self.match(CalcParser.ID)
            self.state = 300
            la_ = self._interp.adaptivePredict(self._input,28,self._ctx)
            if la_ == 1:
                self.state = 299
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
        self.enterRule(localctx, 56, self.RULE_sub_id)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 302
            self.match(CalcParser.T__1)
            self.state = 303
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
        self._predicates[10] = self.expr_sempred
        pred = self._predicates.get(ruleIndex, None)
        if pred is None:
            raise Exception("No predicate with index:" + str(ruleIndex))
        else:
            return pred(localctx, predIndex)

    def expr_sempred(self, localctx, predIndex):
            if predIndex == 0:
                return self.precpred(self._ctx, 12)
         

            if predIndex == 1:
                return self.precpred(self._ctx, 11)
         

            if predIndex == 2:
                return self.precpred(self._ctx, 10)
         

            if predIndex == 3:
                return self.precpred(self._ctx, 9)
         

            if predIndex == 4:
                return self.precpred(self._ctx, 8)
         



