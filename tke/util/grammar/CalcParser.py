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
        buf.write(u"\66\u0144\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7")
        buf.write(u"\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t\13\4\f\t\f\4\r\t")
        buf.write(u"\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22")
        buf.write(u"\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4")
        buf.write(u"\30\t\30\4\31\t\31\4\32\t\32\4\33\t\33\4\34\t\34\4\35")
        buf.write(u"\t\35\4\36\t\36\4\37\t\37\4 \t \4!\t!\3\2\3\2\5\2E\n")
        buf.write(u"\2\3\2\5\2H\n\2\3\2\7\2K\n\2\f\2\16\2N\13\2\3\3\3\3\3")
        buf.write(u"\3\3\3\3\3\3\3\3\4\3\4\3\5\3\5\3\5\3\5\5\5\\\n\5\3\5")
        buf.write(u"\3\5\3\6\3\6\7\6b\n\6\f\6\16\6e\13\6\3\6\3\6\3\6\3\7")
        buf.write(u"\3\7\7\7l\n\7\f\7\16\7o\13\7\3\7\3\7\3\b\3\b\3\b\3\b")
        buf.write(u"\3\b\3\b\3\b\3\b\5\b{\n\b\3\t\3\t\3\t\3\t\3\n\3\n\3\n")
        buf.write(u"\3\n\3\n\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\f\3\f\5")
        buf.write(u"\f\u008f\n\f\3\r\3\r\5\r\u0093\n\r\3\16\3\16\3\16\3\16")
        buf.write(u"\3\16\3\16\3\16\3\16\3\16\3\16\3\16\3\16\3\16\3\16\3")
        buf.write(u"\16\3\16\3\16\5\16\u00a6\n\16\3\16\3\16\3\16\3\16\3\16")
        buf.write(u"\3\16\3\16\3\16\3\16\3\16\3\16\3\16\3\16\3\16\3\16\3")
        buf.write(u"\16\3\16\3\16\3\16\3\16\7\16\u00bc\n\16\f\16\16\16\u00bf")
        buf.write(u"\13\16\3\17\3\17\3\17\7\17\u00c4\n\17\f\17\16\17\u00c7")
        buf.write(u"\13\17\5\17\u00c9\n\17\3\20\3\20\7\20\u00cd\n\20\f\20")
        buf.write(u"\16\20\u00d0\13\20\3\21\3\21\7\21\u00d4\n\21\f\21\16")
        buf.write(u"\21\u00d7\13\21\3\22\3\22\3\22\7\22\u00dc\n\22\f\22\16")
        buf.write(u"\22\u00df\13\22\5\22\u00e1\n\22\3\22\3\22\3\22\3\22\3")
        buf.write(u"\23\3\23\3\23\3\23\3\23\3\24\3\24\3\25\5\25\u00ef\n\25")
        buf.write(u"\3\25\3\25\3\26\3\26\3\26\3\26\3\26\3\26\3\27\3\27\5")
        buf.write(u"\27\u00fb\n\27\3\30\3\30\3\30\3\30\3\30\3\30\3\30\5\30")
        buf.write(u"\u0104\n\30\3\30\5\30\u0107\n\30\3\31\3\31\3\31\5\31")
        buf.write(u"\u010c\n\31\3\32\3\32\3\32\5\32\u0111\n\32\3\32\7\32")
        buf.write(u"\u0114\n\32\f\32\16\32\u0117\13\32\3\32\3\32\3\32\5\32")
        buf.write(u"\u011c\n\32\3\33\3\33\5\33\u0120\n\33\3\33\3\33\3\34")
        buf.write(u"\3\34\3\34\3\34\5\34\u0128\n\34\3\34\3\34\3\35\3\35\7")
        buf.write(u"\35\u012e\n\35\f\35\16\35\u0131\13\35\3\35\3\35\3\36")
        buf.write(u"\3\36\3\36\3\36\5\36\u0139\n\36\3\37\3\37\5\37\u013d")
        buf.write(u"\n\37\3 \3 \3 \3!\3!\3!\2\3\32\"\2\4\6\b\n\f\16\20\22")
        buf.write(u"\24\26\30\32\34\36 \"$&(*,.\60\62\64\668:<>@\2\7\3\2")
        buf.write(u"\13\f\3\2\r\16\3\2\17\20\3\2\21\25\3\2\32\37\u014f\2")
        buf.write(u"B\3\2\2\2\4O\3\2\2\2\6U\3\2\2\2\bW\3\2\2\2\n_\3\2\2\2")
        buf.write(u"\fi\3\2\2\2\16z\3\2\2\2\20|\3\2\2\2\22\u0080\3\2\2\2")
        buf.write(u"\24\u0085\3\2\2\2\26\u008e\3\2\2\2\30\u0092\3\2\2\2\32")
        buf.write(u"\u00a5\3\2\2\2\34\u00c8\3\2\2\2\36\u00ca\3\2\2\2 \u00d1")
        buf.write(u"\3\2\2\2\"\u00e0\3\2\2\2$\u00e6\3\2\2\2&\u00eb\3\2\2")
        buf.write(u"\2(\u00ee\3\2\2\2*\u00f2\3\2\2\2,\u00fa\3\2\2\2.\u00fc")
        buf.write(u"\3\2\2\2\60\u0108\3\2\2\2\62\u010d\3\2\2\2\64\u011d\3")
        buf.write(u"\2\2\2\66\u0123\3\2\2\28\u012b\3\2\2\2:\u0134\3\2\2\2")
        buf.write(u"<\u013a\3\2\2\2>\u013e\3\2\2\2@\u0141\3\2\2\2BD\5\4\3")
        buf.write(u"\2CE\5 \21\2DC\3\2\2\2DE\3\2\2\2EG\3\2\2\2FH\5\36\20")
        buf.write(u"\2GF\3\2\2\2GH\3\2\2\2HL\3\2\2\2IK\5\b\5\2JI\3\2\2\2")
        buf.write(u"KN\3\2\2\2LJ\3\2\2\2LM\3\2\2\2M\3\3\2\2\2NL\3\2\2\2O")
        buf.write(u"P\7\3\2\2PQ\7\62\2\2QR\7\4\2\2RS\5\6\4\2ST\7\5\2\2T\5")
        buf.write(u"\3\2\2\2UV\7\62\2\2V\7\3\2\2\2WX\7(\2\2XY\7\62\2\2Y[")
        buf.write(u"\7\5\2\2Z\\\5\36\20\2[Z\3\2\2\2[\\\3\2\2\2\\]\3\2\2\2")
        buf.write(u"]^\5\n\6\2^\t\3\2\2\2_c\7/\2\2`b\5\16\b\2a`\3\2\2\2b")
        buf.write(u"e\3\2\2\2ca\3\2\2\2cd\3\2\2\2df\3\2\2\2ec\3\2\2\2fg\7")
        buf.write(u"\60\2\2gh\7\5\2\2h\13\3\2\2\2im\7/\2\2jl\5\16\b\2kj\3")
        buf.write(u"\2\2\2lo\3\2\2\2mk\3\2\2\2mn\3\2\2\2np\3\2\2\2om\3\2")
        buf.write(u"\2\2pq\7\60\2\2q\r\3\2\2\2rs\5\20\t\2st\7\5\2\2t{\3\2")
        buf.write(u"\2\2uv\5\22\n\2vw\7\5\2\2w{\3\2\2\2x{\5\64\33\2y{\5,")
        buf.write(u"\27\2zr\3\2\2\2zu\3\2\2\2zx\3\2\2\2zy\3\2\2\2{\17\3\2")
        buf.write(u"\2\2|}\5<\37\2}~\7\61\2\2~\177\5\32\16\2\177\21\3\2\2")
        buf.write(u"\2\u0080\u0081\7\62\2\2\u0081\u0082\7\6\2\2\u0082\u0083")
        buf.write(u"\5\34\17\2\u0083\u0084\7\7\2\2\u0084\23\3\2\2\2\u0085")
        buf.write(u"\u0086\5<\37\2\u0086\u0087\7\b\2\2\u0087\u0088\5\26\f")
        buf.write(u"\2\u0088\u0089\7\t\2\2\u0089\u008a\5\30\r\2\u008a\u008b")
        buf.write(u"\7\n\2\2\u008b\25\3\2\2\2\u008c\u008f\7 \2\2\u008d\u008f")
        buf.write(u"\5\32\16\2\u008e\u008c\3\2\2\2\u008e\u008d\3\2\2\2\u008f")
        buf.write(u"\27\3\2\2\2\u0090\u0093\7 \2\2\u0091\u0093\5\32\16\2")
        buf.write(u"\u0092\u0090\3\2\2\2\u0092\u0091\3\2\2\2\u0093\31\3\2")
        buf.write(u"\2\2\u0094\u0095\b\16\1\2\u0095\u0096\7*\2\2\u0096\u00a6")
        buf.write(u"\5\32\16\t\u0097\u00a6\7 \2\2\u0098\u00a6\5<\37\2\u0099")
        buf.write(u"\u00a6\5@!\2\u009a\u00a6\5\22\n\2\u009b\u00a6\5\24\13")
        buf.write(u"\2\u009c\u009d\7\27\2\2\u009d\u009e\7\6\2\2\u009e\u009f")
        buf.write(u"\5\34\17\2\u009f\u00a0\7\7\2\2\u00a0\u00a6\3\2\2\2\u00a1")
        buf.write(u"\u00a2\7\6\2\2\u00a2\u00a3\5\32\16\2\u00a3\u00a4\7\7")
        buf.write(u"\2\2\u00a4\u00a6\3\2\2\2\u00a5\u0094\3\2\2\2\u00a5\u0097")
        buf.write(u"\3\2\2\2\u00a5\u0098\3\2\2\2\u00a5\u0099\3\2\2\2\u00a5")
        buf.write(u"\u009a\3\2\2\2\u00a5\u009b\3\2\2\2\u00a5\u009c\3\2\2")
        buf.write(u"\2\u00a5\u00a1\3\2\2\2\u00a6\u00bd\3\2\2\2\u00a7\u00a8")
        buf.write(u"\f\17\2\2\u00a8\u00a9\t\2\2\2\u00a9\u00bc\5\32\16\20")
        buf.write(u"\u00aa\u00ab\f\16\2\2\u00ab\u00ac\t\3\2\2\u00ac\u00bc")
        buf.write(u"\5\32\16\17\u00ad\u00ae\f\r\2\2\u00ae\u00af\t\4\2\2\u00af")
        buf.write(u"\u00bc\5\32\16\16\u00b0\u00b1\f\f\2\2\u00b1\u00b2\t\5")
        buf.write(u"\2\2\u00b2\u00bc\5\32\16\r\u00b3\u00b4\f\13\2\2\u00b4")
        buf.write(u"\u00b5\7\f\2\2\u00b5\u00b6\7\6\2\2\u00b6\u00b7\5\32\16")
        buf.write(u"\2\u00b7\u00b8\7\13\2\2\u00b8\u00b9\7\26\2\2\u00b9\u00ba")
        buf.write(u"\7\7\2\2\u00ba\u00bc\3\2\2\2\u00bb\u00a7\3\2\2\2\u00bb")
        buf.write(u"\u00aa\3\2\2\2\u00bb\u00ad\3\2\2\2\u00bb\u00b0\3\2\2")
        buf.write(u"\2\u00bb\u00b3\3\2\2\2\u00bc\u00bf\3\2\2\2\u00bd\u00bb")
        buf.write(u"\3\2\2\2\u00bd\u00be\3\2\2\2\u00be\33\3\2\2\2\u00bf\u00bd")
        buf.write(u"\3\2\2\2\u00c0\u00c5\5\32\16\2\u00c1\u00c2\7\30\2\2\u00c2")
        buf.write(u"\u00c4\5\32\16\2\u00c3\u00c1\3\2\2\2\u00c4\u00c7\3\2")
        buf.write(u"\2\2\u00c5\u00c3\3\2\2\2\u00c5\u00c6\3\2\2\2\u00c6\u00c9")
        buf.write(u"\3\2\2\2\u00c7\u00c5\3\2\2\2\u00c8\u00c0\3\2\2\2\u00c8")
        buf.write(u"\u00c9\3\2\2\2\u00c9\35\3\2\2\2\u00ca\u00ce\7#\2\2\u00cb")
        buf.write(u"\u00cd\5\"\22\2\u00cc\u00cb\3\2\2\2\u00cd\u00d0\3\2\2")
        buf.write(u"\2\u00ce\u00cc\3\2\2\2\u00ce\u00cf\3\2\2\2\u00cf\37\3")
        buf.write(u"\2\2\2\u00d0\u00ce\3\2\2\2\u00d1\u00d5\7$\2\2\u00d2\u00d4")
        buf.write(u"\5$\23\2\u00d3\u00d2\3\2\2\2\u00d4\u00d7\3\2\2\2\u00d5")
        buf.write(u"\u00d3\3\2\2\2\u00d5\u00d6\3\2\2\2\u00d6!\3\2\2\2\u00d7")
        buf.write(u"\u00d5\3\2\2\2\u00d8\u00dd\5&\24\2\u00d9\u00da\7\30\2")
        buf.write(u"\2\u00da\u00dc\5&\24\2\u00db\u00d9\3\2\2\2\u00dc\u00df")
        buf.write(u"\3\2\2\2\u00dd\u00db\3\2\2\2\u00dd\u00de\3\2\2\2\u00de")
        buf.write(u"\u00e1\3\2\2\2\u00df\u00dd\3\2\2\2\u00e0\u00d8\3\2\2")
        buf.write(u"\2\u00e0\u00e1\3\2\2\2\u00e1\u00e2\3\2\2\2\u00e2\u00e3")
        buf.write(u"\7\31\2\2\u00e3\u00e4\5(\25\2\u00e4\u00e5\7\5\2\2\u00e5")
        buf.write(u"#\3\2\2\2\u00e6\u00e7\5&\24\2\u00e7\u00e8\7\25\2\2\u00e8")
        buf.write(u"\u00e9\7 \2\2\u00e9\u00ea\7\5\2\2\u00ea%\3\2\2\2\u00eb")
        buf.write(u"\u00ec\7\62\2\2\u00ec\'\3\2\2\2\u00ed\u00ef\5*\26\2\u00ee")
        buf.write(u"\u00ed\3\2\2\2\u00ee\u00ef\3\2\2\2\u00ef\u00f0\3\2\2")
        buf.write(u"\2\u00f0\u00f1\7\62\2\2\u00f1)\3\2\2\2\u00f2\u00f3\7")
        buf.write(u"!\2\2\u00f3\u00f4\7\b\2\2\u00f4\u00f5\7 \2\2\u00f5\u00f6")
        buf.write(u"\7\n\2\2\u00f6\u00f7\7\"\2\2\u00f7+\3\2\2\2\u00f8\u00fb")
        buf.write(u"\5.\30\2\u00f9\u00fb\5\62\32\2\u00fa\u00f8\3\2\2\2\u00fa")
        buf.write(u"\u00f9\3\2\2\2\u00fb-\3\2\2\2\u00fc\u00fd\7%\2\2\u00fd")
        buf.write(u"\u00fe\5\32\16\2\u00fe\u0103\7\'\2\2\u00ff\u0104\5\n")
        buf.write(u"\6\2\u0100\u0104\5\16\b\2\u0101\u0104\5\f\7\2\u0102\u0104")
        buf.write(u"\5\20\t\2\u0103\u00ff\3\2\2\2\u0103\u0100\3\2\2\2\u0103")
        buf.write(u"\u0101\3\2\2\2\u0103\u0102\3\2\2\2\u0104\u0106\3\2\2")
        buf.write(u"\2\u0105\u0107\5\60\31\2\u0106\u0105\3\2\2\2\u0106\u0107")
        buf.write(u"\3\2\2\2\u0107/\3\2\2\2\u0108\u010b\7&\2\2\u0109\u010c")
        buf.write(u"\5\n\6\2\u010a\u010c\5\16\b\2\u010b\u0109\3\2\2\2\u010b")
        buf.write(u"\u010a\3\2\2\2\u010c\61\3\2\2\2\u010d\u0110\7)\2\2\u010e")
        buf.write(u"\u010f\7+\2\2\u010f\u0111\5\32\16\2\u0110\u010e\3\2\2")
        buf.write(u"\2\u0110\u0111\3\2\2\2\u0111\u0115\3\2\2\2\u0112\u0114")
        buf.write(u"\5\16\b\2\u0113\u0112\3\2\2\2\u0114\u0117\3\2\2\2\u0115")
        buf.write(u"\u0113\3\2\2\2\u0115\u0116\3\2\2\2\u0116\u0118\3\2\2")
        buf.write(u"\2\u0117\u0115\3\2\2\2\u0118\u011b\7,\2\2\u0119\u011a")
        buf.write(u"\7+\2\2\u011a\u011c\5\32\16\2\u011b\u0119\3\2\2\2\u011b")
        buf.write(u"\u011c\3\2\2\2\u011c\63\3\2\2\2\u011d\u011f\7-\2\2\u011e")
        buf.write(u"\u0120\5\32\16\2\u011f\u011e\3\2\2\2\u011f\u0120\3\2")
        buf.write(u"\2\2\u0120\u0121\3\2\2\2\u0121\u0122\7\5\2\2\u0122\65")
        buf.write(u"\3\2\2\2\u0123\u0124\5<\37\2\u0124\u0125\5<\37\2\u0125")
        buf.write(u"\u0127\58\35\2\u0126\u0128\5\36\20\2\u0127\u0126\3\2")
        buf.write(u"\2\2\u0127\u0128\3\2\2\2\u0128\u0129\3\2\2\2\u0129\u012a")
        buf.write(u"\5\n\6\2\u012a\67\3\2\2\2\u012b\u012f\7\6\2\2\u012c\u012e")
        buf.write(u"\5:\36\2\u012d\u012c\3\2\2\2\u012e\u0131\3\2\2\2\u012f")
        buf.write(u"\u012d\3\2\2\2\u012f\u0130\3\2\2\2\u0130\u0132\3\2\2")
        buf.write(u"\2\u0131\u012f\3\2\2\2\u0132\u0133\7\7\2\2\u01339\3\2")
        buf.write(u"\2\2\u0134\u0135\5(\25\2\u0135\u0138\5<\37\2\u0136\u0137")
        buf.write(u"\7\61\2\2\u0137\u0139\5\32\16\2\u0138\u0136\3\2\2\2\u0138")
        buf.write(u"\u0139\3\2\2\2\u0139;\3\2\2\2\u013a\u013c\7\62\2\2\u013b")
        buf.write(u"\u013d\5> \2\u013c\u013b\3\2\2\2\u013c\u013d\3\2\2\2")
        buf.write(u"\u013d=\3\2\2\2\u013e\u013f\7\4\2\2\u013f\u0140\7\62")
        buf.write(u"\2\2\u0140?\3\2\2\2\u0141\u0142\t\6\2\2\u0142A\3\2\2")
        buf.write(u"\2!DGL[cmz\u008e\u0092\u00a5\u00bb\u00bd\u00c5\u00c8")
        buf.write(u"\u00ce\u00d5\u00dd\u00e0\u00ee\u00fa\u0103\u0106\u010b")
        buf.write(u"\u0110\u0115\u011b\u011f\u0127\u012f\u0138\u013c")
        return buf.getvalue()


class CalcParser ( Parser ):

    grammarFileName = "java-escape"

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    sharedContextCache = PredictionContextCache()

    literalNames = [ u"<INVALID>", u"'FORM'", u"'.'", u"';'", u"'('", u"')'", 
                     u"'['", u"'..'", u"']'", u"'/'", u"'*'", u"'+'", u"'-'", 
                     u"'and'", u"'or'", u"'>'", u"'<'", u"'<='", u"'>='", 
                     u"'='", u"'100'", u"'MAX'", u"','", u"':'", u"'true'", 
                     u"'false'", u"'checked'", u"'Checked'", u"'True'", 
                     u"'False'", u"<INVALID>", u"'Array'", u"'of'", u"<INVALID>", 
                     u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                     u"<INVALID>", u"'do'", u"'not'", u"'while'", u"'loop'", 
                     u"'return'", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                     u"':='" ]

    symbolicNames = [ u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"LITERAL", u"ARRAY", 
                      u"OF", u"VAR", u"CONSTANT", u"IF", u"ELSE", u"THEN", 
                      u"SECTION", u"DO", u"NOT", u"WHILE", u"LOOP", u"RETURN", 
                      u"WS", u"BEGIN", u"END", u"LET", u"ID", u"INT", u"STRING", 
                      u"COMMENT", u"LINE_COMMENT" ]

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
    RULE_start_index = 10
    RULE_end_index = 11
    RULE_expr = 12
    RULE_argList = 13
    RULE_vardecl = 14
    RULE_constdecl = 15
    RULE_declList = 16
    RULE_constdeclList = 17
    RULE_varDecl = 18
    RULE_r_type = 19
    RULE_arrayDecl = 20
    RULE_ctrlStruct = 21
    RULE_ifStruct = 22
    RULE_elseStruct = 23
    RULE_loopStruct = 24
    RULE_ret = 25
    RULE_function = 26
    RULE_formParList = 27
    RULE_formPar = 28
    RULE_full_id = 29
    RULE_sub_id = 30
    RULE_boolean = 31

    ruleNames =  [ u"calcfile", u"formset", u"form", u"section", u"block", 
                   u"dumbblock", u"stmt", u"assign", u"call", u"multicopy_accum", 
                   u"start_index", u"end_index", u"expr", u"argList", u"vardecl", 
                   u"constdecl", u"declList", u"constdeclList", u"varDecl", 
                   u"r_type", u"arrayDecl", u"ctrlStruct", u"ifStruct", 
                   u"elseStruct", u"loopStruct", u"ret", u"function", u"formParList", 
                   u"formPar", u"full_id", u"sub_id", u"boolean" ]

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
    T__23=24
    T__24=25
    T__25=26
    T__26=27
    T__27=28
    T__28=29
    LITERAL=30
    ARRAY=31
    OF=32
    VAR=33
    CONSTANT=34
    IF=35
    ELSE=36
    THEN=37
    SECTION=38
    DO=39
    NOT=40
    WHILE=41
    LOOP=42
    RETURN=43
    WS=44
    BEGIN=45
    END=46
    LET=47
    ID=48
    INT=49
    STRING=50
    COMMENT=51
    LINE_COMMENT=52

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
            self.state = 64
            self.formset()
            self.state = 66
            _la = self._input.LA(1)
            if _la==CalcParser.CONSTANT:
                self.state = 65
                self.constdecl()


            self.state = 69
            _la = self._input.LA(1)
            if _la==CalcParser.VAR:
                self.state = 68
                self.vardecl()


            self.state = 74
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==CalcParser.SECTION:
                self.state = 71
                self.section()
                self.state = 76
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
            self.state = 77
            self.match(CalcParser.T__0)
            self.state = 78
            self.match(CalcParser.ID)
            self.state = 79
            self.match(CalcParser.T__1)
            self.state = 80
            self.form()
            self.state = 81
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
            self.state = 83
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
            self.state = 85
            self.match(CalcParser.SECTION)
            self.state = 86
            self.match(CalcParser.ID)
            self.state = 87
            self.match(CalcParser.T__2)
            self.state = 89
            _la = self._input.LA(1)
            if _la==CalcParser.VAR:
                self.state = 88
                self.vardecl()


            self.state = 91
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
            self.state = 93
            self.match(CalcParser.BEGIN)
            self.state = 97
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.IF) | (1 << CalcParser.DO) | (1 << CalcParser.RETURN) | (1 << CalcParser.ID))) != 0):
                self.state = 94
                self.stmt()
                self.state = 99
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 100
            self.match(CalcParser.END)
            self.state = 101
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
            self.state = 103
            self.match(CalcParser.BEGIN)
            self.state = 107
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.IF) | (1 << CalcParser.DO) | (1 << CalcParser.RETURN) | (1 << CalcParser.ID))) != 0):
                self.state = 104
                self.stmt()
                self.state = 109
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 110
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
            self.state = 120
            la_ = self._interp.adaptivePredict(self._input,6,self._ctx)
            if la_ == 1:
                self.enterOuterAlt(localctx, 1)
                self.state = 112
                self.assign()
                self.state = 113
                self.match(CalcParser.T__2)
                pass

            elif la_ == 2:
                self.enterOuterAlt(localctx, 2)
                self.state = 115
                self.call()
                self.state = 116
                self.match(CalcParser.T__2)
                pass

            elif la_ == 3:
                self.enterOuterAlt(localctx, 3)
                self.state = 118
                self.ret()
                pass

            elif la_ == 4:
                self.enterOuterAlt(localctx, 4)
                self.state = 119
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
            self.state = 122
            self.full_id()
            self.state = 123
            self.match(CalcParser.LET)
            self.state = 124
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
            self.state = 126
            self.match(CalcParser.ID)
            self.state = 127
            self.match(CalcParser.T__3)
            self.state = 128
            self.argList()
            self.state = 129
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

        def full_id(self):
            return self.getTypedRuleContext(CalcParser.Full_idContext,0)


        def start_index(self):
            return self.getTypedRuleContext(CalcParser.Start_indexContext,0)


        def end_index(self):
            return self.getTypedRuleContext(CalcParser.End_indexContext,0)


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
            self.state = 131
            self.full_id()
            self.state = 132
            self.match(CalcParser.T__5)
            self.state = 133
            self.start_index()
            self.state = 134
            self.match(CalcParser.T__6)
            self.state = 135
            self.end_index()
            self.state = 136
            self.match(CalcParser.T__7)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Start_indexContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.Start_indexContext, self).__init__(parent, invokingState)
            self.parser = parser

        def LITERAL(self):
            return self.getToken(CalcParser.LITERAL, 0)

        def expr(self):
            return self.getTypedRuleContext(CalcParser.ExprContext,0)


        def getRuleIndex(self):
            return CalcParser.RULE_start_index

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterStart_index(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitStart_index(self)




    def start_index(self):

        localctx = CalcParser.Start_indexContext(self, self._ctx, self.state)
        self.enterRule(localctx, 20, self.RULE_start_index)
        try:
            self.state = 140
            la_ = self._interp.adaptivePredict(self._input,7,self._ctx)
            if la_ == 1:
                self.enterOuterAlt(localctx, 1)
                self.state = 138
                self.match(CalcParser.LITERAL)
                pass

            elif la_ == 2:
                self.enterOuterAlt(localctx, 2)
                self.state = 139
                self.expr(0)
                pass


        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class End_indexContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.End_indexContext, self).__init__(parent, invokingState)
            self.parser = parser

        def LITERAL(self):
            return self.getToken(CalcParser.LITERAL, 0)

        def expr(self):
            return self.getTypedRuleContext(CalcParser.ExprContext,0)


        def getRuleIndex(self):
            return CalcParser.RULE_end_index

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterEnd_index(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitEnd_index(self)




    def end_index(self):

        localctx = CalcParser.End_indexContext(self, self._ctx, self.state)
        self.enterRule(localctx, 22, self.RULE_end_index)
        try:
            self.state = 144
            la_ = self._interp.adaptivePredict(self._input,8,self._ctx)
            if la_ == 1:
                self.enterOuterAlt(localctx, 1)
                self.state = 142
                self.match(CalcParser.LITERAL)
                pass

            elif la_ == 2:
                self.enterOuterAlt(localctx, 2)
                self.state = 143
                self.expr(0)
                pass


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


    class BoolContext(ExprContext):

        def __init__(self, parser, ctx): # actually a CalcParser.ExprContext)
            super(CalcParser.BoolContext, self).__init__(parser)
            self.copyFrom(ctx)

        def boolean(self):
            return self.getTypedRuleContext(CalcParser.BooleanContext,0)


        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterBool(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitBool(self)


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



    def expr(self, _p=0):
        _parentctx = self._ctx
        _parentState = self.state
        localctx = CalcParser.ExprContext(self, self._ctx, _parentState)
        _prevctx = localctx
        _startState = 24
        self.enterRecursionRule(localctx, 24, self.RULE_expr, _p)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 163
            la_ = self._interp.adaptivePredict(self._input,9,self._ctx)
            if la_ == 1:
                localctx = CalcParser.NotContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx

                self.state = 147
                self.match(CalcParser.NOT)
                self.state = 148
                self.expr(7)
                pass

            elif la_ == 2:
                localctx = CalcParser.LiteralContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 149
                self.match(CalcParser.LITERAL)
                pass

            elif la_ == 3:
                localctx = CalcParser.VarRefContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 150
                self.full_id()
                pass

            elif la_ == 4:
                localctx = CalcParser.BoolContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 151
                self.boolean()
                pass

            elif la_ == 5:
                localctx = CalcParser.FunctionCallContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 152
                self.call()
                pass

            elif la_ == 6:
                localctx = CalcParser.MultiCopyAccumulateContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 153
                self.multicopy_accum()
                pass

            elif la_ == 7:
                localctx = CalcParser.MaxContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 154
                self.match(CalcParser.T__20)
                self.state = 155
                self.match(CalcParser.T__3)
                self.state = 156
                self.argList()
                self.state = 157
                self.match(CalcParser.T__4)
                pass

            elif la_ == 8:
                localctx = CalcParser.ParensContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 159
                self.match(CalcParser.T__3)
                self.state = 160
                self.expr(0)
                self.state = 161
                self.match(CalcParser.T__4)
                pass


            self._ctx.stop = self._input.LT(-1)
            self.state = 187
            self._errHandler.sync(self)
            _alt = self._interp.adaptivePredict(self._input,11,self._ctx)
            while _alt!=2 and _alt!=ATN.INVALID_ALT_NUMBER:
                if _alt==1:
                    if self._parseListeners is not None:
                        self.triggerExitRuleEvent()
                    _prevctx = localctx
                    self.state = 185
                    la_ = self._interp.adaptivePredict(self._input,10,self._ctx)
                    if la_ == 1:
                        localctx = CalcParser.DivMulContext(self, CalcParser.ExprContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expr)
                        self.state = 165
                        if not self.precpred(self._ctx, 13):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 13)")
                        self.state = 166
                        localctx.op = self._input.LT(1)
                        _la = self._input.LA(1)
                        if not(_la==CalcParser.T__8 or _la==CalcParser.T__9):
                            localctx.op = self._errHandler.recoverInline(self)
                        else:
                            self.consume()
                        self.state = 167
                        self.expr(14)
                        pass

                    elif la_ == 2:
                        localctx = CalcParser.AddSubContext(self, CalcParser.ExprContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expr)
                        self.state = 168
                        if not self.precpred(self._ctx, 12):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 12)")
                        self.state = 169
                        localctx.op = self._input.LT(1)
                        _la = self._input.LA(1)
                        if not(_la==CalcParser.T__10 or _la==CalcParser.T__11):
                            localctx.op = self._errHandler.recoverInline(self)
                        else:
                            self.consume()
                        self.state = 170
                        self.expr(13)
                        pass

                    elif la_ == 3:
                        localctx = CalcParser.LogicContext(self, CalcParser.ExprContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expr)
                        self.state = 171
                        if not self.precpred(self._ctx, 11):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 11)")
                        self.state = 172
                        localctx.op = self._input.LT(1)
                        _la = self._input.LA(1)
                        if not(_la==CalcParser.T__12 or _la==CalcParser.T__13):
                            localctx.op = self._errHandler.recoverInline(self)
                        else:
                            self.consume()
                        self.state = 173
                        self.expr(12)
                        pass

                    elif la_ == 4:
                        localctx = CalcParser.PredicateContext(self, CalcParser.ExprContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expr)
                        self.state = 174
                        if not self.precpred(self._ctx, 10):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 10)")
                        self.state = 175
                        localctx.op = self._input.LT(1)
                        _la = self._input.LA(1)
                        if not((((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.T__14) | (1 << CalcParser.T__15) | (1 << CalcParser.T__16) | (1 << CalcParser.T__17) | (1 << CalcParser.T__18))) != 0)):
                            localctx.op = self._errHandler.recoverInline(self)
                        else:
                            self.consume()
                        self.state = 176
                        self.expr(11)
                        pass

                    elif la_ == 5:
                        localctx = CalcParser.PercentageOfContext(self, CalcParser.ExprContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expr)
                        self.state = 177
                        if not self.precpred(self._ctx, 9):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 9)")
                        self.state = 178
                        self.match(CalcParser.T__9)
                        self.state = 179
                        self.match(CalcParser.T__3)
                        self.state = 180
                        self.expr(0)
                        self.state = 181
                        self.match(CalcParser.T__8)
                        self.state = 182
                        self.match(CalcParser.T__19)
                        self.state = 183
                        self.match(CalcParser.T__4)
                        pass

             
                self.state = 189
                self._errHandler.sync(self)
                _alt = self._interp.adaptivePredict(self._input,11,self._ctx)

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
        self.enterRule(localctx, 26, self.RULE_argList)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 198
            _la = self._input.LA(1)
            if (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.T__3) | (1 << CalcParser.T__20) | (1 << CalcParser.T__23) | (1 << CalcParser.T__24) | (1 << CalcParser.T__25) | (1 << CalcParser.T__26) | (1 << CalcParser.T__27) | (1 << CalcParser.T__28) | (1 << CalcParser.LITERAL) | (1 << CalcParser.NOT) | (1 << CalcParser.ID))) != 0):
                self.state = 190
                self.expr(0)
                self.state = 195
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                while _la==CalcParser.T__21:
                    self.state = 191
                    self.match(CalcParser.T__21)
                    self.state = 192
                    self.expr(0)
                    self.state = 197
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
        self.enterRule(localctx, 28, self.RULE_vardecl)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 200
            self.match(CalcParser.VAR)
            self.state = 204
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==CalcParser.T__22 or _la==CalcParser.ID:
                self.state = 201
                self.declList()
                self.state = 206
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
        self.enterRule(localctx, 30, self.RULE_constdecl)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 207
            self.match(CalcParser.CONSTANT)
            self.state = 211
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==CalcParser.ID:
                self.state = 208
                self.constdeclList()
                self.state = 213
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
        self.enterRule(localctx, 32, self.RULE_declList)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 222
            _la = self._input.LA(1)
            if _la==CalcParser.ID:
                self.state = 214
                self.varDecl()
                self.state = 219
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                while _la==CalcParser.T__21:
                    self.state = 215
                    self.match(CalcParser.T__21)
                    self.state = 216
                    self.varDecl()
                    self.state = 221
                    self._errHandler.sync(self)
                    _la = self._input.LA(1)



            self.state = 224
            self.match(CalcParser.T__22)
            self.state = 225
            self.r_type()
            self.state = 226
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
        self.enterRule(localctx, 34, self.RULE_constdeclList)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 228
            self.varDecl()
            self.state = 229
            self.match(CalcParser.T__18)
            self.state = 230
            self.match(CalcParser.LITERAL)
            self.state = 231
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
        self.enterRule(localctx, 36, self.RULE_varDecl)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 233
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
        self.enterRule(localctx, 38, self.RULE_r_type)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 236
            _la = self._input.LA(1)
            if _la==CalcParser.ARRAY:
                self.state = 235
                self.arrayDecl()


            self.state = 238
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
        self.enterRule(localctx, 40, self.RULE_arrayDecl)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 240
            self.match(CalcParser.ARRAY)
            self.state = 241
            self.match(CalcParser.T__5)
            self.state = 242
            self.match(CalcParser.LITERAL)
            self.state = 243
            self.match(CalcParser.T__7)
            self.state = 244
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
        self.enterRule(localctx, 42, self.RULE_ctrlStruct)
        try:
            self.state = 248
            token = self._input.LA(1)
            if token in [CalcParser.IF]:
                self.enterOuterAlt(localctx, 1)
                self.state = 246
                self.ifStruct()

            elif token in [CalcParser.DO]:
                self.enterOuterAlt(localctx, 2)
                self.state = 247
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
        self.enterRule(localctx, 44, self.RULE_ifStruct)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 250
            self.match(CalcParser.IF)
            self.state = 251
            self.expr(0)
            self.state = 252
            self.match(CalcParser.THEN)
            self.state = 257
            la_ = self._interp.adaptivePredict(self._input,20,self._ctx)
            if la_ == 1:
                self.state = 253
                self.block()
                pass

            elif la_ == 2:
                self.state = 254
                self.stmt()
                pass

            elif la_ == 3:
                self.state = 255
                self.dumbblock()
                pass

            elif la_ == 4:
                self.state = 256
                self.assign()
                pass


            self.state = 260
            la_ = self._interp.adaptivePredict(self._input,21,self._ctx)
            if la_ == 1:
                self.state = 259
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
        self.enterRule(localctx, 46, self.RULE_elseStruct)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 262
            self.match(CalcParser.ELSE)
            self.state = 265
            token = self._input.LA(1)
            if token in [CalcParser.BEGIN]:
                self.state = 263
                self.block()

            elif token in [CalcParser.IF, CalcParser.DO, CalcParser.RETURN, CalcParser.ID]:
                self.state = 264
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
        self.enterRule(localctx, 48, self.RULE_loopStruct)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 267
            self.match(CalcParser.DO)
            self.state = 270
            _la = self._input.LA(1)
            if _la==CalcParser.WHILE:
                self.state = 268
                self.match(CalcParser.WHILE)
                self.state = 269
                localctx.preCond = self.expr(0)


            self.state = 275
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.IF) | (1 << CalcParser.DO) | (1 << CalcParser.RETURN) | (1 << CalcParser.ID))) != 0):
                self.state = 272
                self.stmt()
                self.state = 277
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 278
            self.match(CalcParser.LOOP)
            self.state = 281
            _la = self._input.LA(1)
            if _la==CalcParser.WHILE:
                self.state = 279
                self.match(CalcParser.WHILE)
                self.state = 280
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
        self.enterRule(localctx, 50, self.RULE_ret)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 283
            self.match(CalcParser.RETURN)
            self.state = 285
            _la = self._input.LA(1)
            if (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.T__3) | (1 << CalcParser.T__20) | (1 << CalcParser.T__23) | (1 << CalcParser.T__24) | (1 << CalcParser.T__25) | (1 << CalcParser.T__26) | (1 << CalcParser.T__27) | (1 << CalcParser.T__28) | (1 << CalcParser.LITERAL) | (1 << CalcParser.NOT) | (1 << CalcParser.ID))) != 0):
                self.state = 284
                self.expr(0)


            self.state = 287
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
        self.enterRule(localctx, 52, self.RULE_function)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 289
            localctx.retType = self.full_id()
            self.state = 290
            localctx.fnName = self.full_id()
            self.state = 291
            self.formParList()
            self.state = 293
            _la = self._input.LA(1)
            if _la==CalcParser.VAR:
                self.state = 292
                self.vardecl()


            self.state = 295
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
        self.enterRule(localctx, 54, self.RULE_formParList)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 297
            self.match(CalcParser.T__3)
            self.state = 301
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==CalcParser.ARRAY or _la==CalcParser.ID:
                self.state = 298
                self.formPar()
                self.state = 303
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 304
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
        self.enterRule(localctx, 56, self.RULE_formPar)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 306
            self.r_type()
            self.state = 307
            localctx.name = self.full_id()
            self.state = 310
            _la = self._input.LA(1)
            if _la==CalcParser.LET:
                self.state = 308
                self.match(CalcParser.LET)
                self.state = 309
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
        self.enterRule(localctx, 58, self.RULE_full_id)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 312
            self.match(CalcParser.ID)
            self.state = 314
            la_ = self._interp.adaptivePredict(self._input,30,self._ctx)
            if la_ == 1:
                self.state = 313
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
        self.enterRule(localctx, 60, self.RULE_sub_id)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 316
            self.match(CalcParser.T__1)
            self.state = 317
            self.match(CalcParser.ID)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class BooleanContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(CalcParser.BooleanContext, self).__init__(parent, invokingState)
            self.parser = parser


        def getRuleIndex(self):
            return CalcParser.RULE_boolean

        def enterRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.enterBoolean(self)

        def exitRule(self, listener):
            if isinstance( listener, CalcListener ):
                listener.exitBoolean(self)




    def boolean(self):

        localctx = CalcParser.BooleanContext(self, self._ctx, self.state)
        self.enterRule(localctx, 62, self.RULE_boolean)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 319
            _la = self._input.LA(1)
            if not((((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << CalcParser.T__23) | (1 << CalcParser.T__24) | (1 << CalcParser.T__25) | (1 << CalcParser.T__26) | (1 << CalcParser.T__27) | (1 << CalcParser.T__28))) != 0)):
                self._errHandler.recoverInline(self)
            else:
                self.consume()
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
        self._predicates[12] = self.expr_sempred
        pred = self._predicates.get(ruleIndex, None)
        if pred is None:
            raise Exception("No predicate with index:" + str(ruleIndex))
        else:
            return pred(localctx, predIndex)

    def expr_sempred(self, localctx, predIndex):
            if predIndex == 0:
                return self.precpred(self._ctx, 13)
         

            if predIndex == 1:
                return self.precpred(self._ctx, 12)
         

            if predIndex == 2:
                return self.precpred(self._ctx, 11)
         

            if predIndex == 3:
                return self.precpred(self._ctx, 10)
         

            if predIndex == 4:
                return self.precpred(self._ctx, 9)
         



