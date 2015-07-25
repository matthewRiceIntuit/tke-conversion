# Generated from java-escape by ANTLR 4.5
# encoding: utf-8
from __future__ import print_function
from antlr4 import *
from io import StringIO


def serializedATN():
    with StringIO() as buf:
        buf.write(u"\3\u0430\ud6d1\u8206\uad2d\u4417\uaef1\u8d80\uaadd\2")
        buf.write(u"\16U\b\1\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7")
        buf.write(u"\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t\13\4\f\t\f\4\r\t")
        buf.write(u"\r\3\2\3\2\3\3\3\3\3\4\3\4\3\5\3\5\3\6\3\6\3\7\3\7\3")
        buf.write(u"\b\3\b\3\t\3\t\7\t,\n\t\f\t\16\t/\13\t\3\n\6\n\62\n\n")
        buf.write(u"\r\n\16\n\63\3\13\6\13\67\n\13\r\13\16\138\3\13\3\13")
        buf.write(u"\3\f\3\f\3\f\3\f\7\fA\n\f\f\f\16\fD\13\f\3\f\3\f\3\f")
        buf.write(u"\3\f\3\f\3\r\3\r\3\r\3\r\7\rO\n\r\f\r\16\rR\13\r\3\r")
        buf.write(u"\3\r\3B\2\16\3\3\5\4\7\5\t\6\13\7\r\b\17\t\21\n\23\13")
        buf.write(u"\25\f\27\r\31\16\3\2\7\5\2B\\aac|\7\2\60;C\\^^aac|\3")
        buf.write(u"\2\62;\5\2\13\f\17\17\"\"\4\2\f\f\17\17Y\2\3\3\2\2\2")
        buf.write(u"\2\5\3\2\2\2\2\7\3\2\2\2\2\t\3\2\2\2\2\13\3\2\2\2\2\r")
        buf.write(u"\3\2\2\2\2\17\3\2\2\2\2\21\3\2\2\2\2\23\3\2\2\2\2\25")
        buf.write(u"\3\2\2\2\2\27\3\2\2\2\2\31\3\2\2\2\3\33\3\2\2\2\5\35")
        buf.write(u"\3\2\2\2\7\37\3\2\2\2\t!\3\2\2\2\13#\3\2\2\2\r%\3\2\2")
        buf.write(u"\2\17\'\3\2\2\2\21)\3\2\2\2\23\61\3\2\2\2\25\66\3\2\2")
        buf.write(u"\2\27<\3\2\2\2\31J\3\2\2\2\33\34\7?\2\2\34\4\3\2\2\2")
        buf.write(u"\35\36\7*\2\2\36\6\3\2\2\2\37 \7+\2\2 \b\3\2\2\2!\"\7")
        buf.write(u"<\2\2\"\n\3\2\2\2#$\7]\2\2$\f\3\2\2\2%&\7.\2\2&\16\3")
        buf.write(u"\2\2\2\'(\7_\2\2(\20\3\2\2\2)-\t\2\2\2*,\t\3\2\2+*\3")
        buf.write(u"\2\2\2,/\3\2\2\2-+\3\2\2\2-.\3\2\2\2.\22\3\2\2\2/-\3")
        buf.write(u"\2\2\2\60\62\t\4\2\2\61\60\3\2\2\2\62\63\3\2\2\2\63\61")
        buf.write(u"\3\2\2\2\63\64\3\2\2\2\64\24\3\2\2\2\65\67\t\5\2\2\66")
        buf.write(u"\65\3\2\2\2\678\3\2\2\28\66\3\2\2\289\3\2\2\29:\3\2\2")
        buf.write(u"\2:;\b\13\2\2;\26\3\2\2\2<=\7\61\2\2=>\7,\2\2>B\3\2\2")
        buf.write(u"\2?A\13\2\2\2@?\3\2\2\2AD\3\2\2\2BC\3\2\2\2B@\3\2\2\2")
        buf.write(u"CE\3\2\2\2DB\3\2\2\2EF\7,\2\2FG\7\61\2\2GH\3\2\2\2HI")
        buf.write(u"\b\f\2\2I\30\3\2\2\2JK\7\61\2\2KL\7\61\2\2LP\3\2\2\2")
        buf.write(u"MO\n\6\2\2NM\3\2\2\2OR\3\2\2\2PN\3\2\2\2PQ\3\2\2\2QS")
        buf.write(u"\3\2\2\2RP\3\2\2\2ST\b\r\2\2T\32\3\2\2\2\b\2-\638BP\3")
        buf.write(u"\b\2\2")
        return buf.getvalue()


class GistScriptLexer(Lexer):

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]


    T__0 = 1
    T__1 = 2
    T__2 = 3
    T__3 = 4
    T__4 = 5
    T__5 = 6
    T__6 = 7
    ID = 8
    CONSTANT = 9
    WS = 10
    COMMENT = 11
    LINE_COMMENT = 12

    modeNames = [ u"DEFAULT_MODE" ]

    literalNames = [ u"<INVALID>",
            u"'='", u"'('", u"')'", u"':'", u"'['", u"','", u"']'" ]

    symbolicNames = [ u"<INVALID>",
            u"ID", u"CONSTANT", u"WS", u"COMMENT", u"LINE_COMMENT" ]

    ruleNames = [ u"T__0", u"T__1", u"T__2", u"T__3", u"T__4", u"T__5", 
                  u"T__6", u"ID", u"CONSTANT", u"WS", u"COMMENT", u"LINE_COMMENT" ]

    grammarFileName = u"GistScript.g4"

    def __init__(self, input=None):
        super(GistScriptLexer, self).__init__(input)
        self.checkVersion("4.5")
        self._interp = LexerATNSimulator(self, self.atn, self.decisionsToDFA, PredictionContextCache())
        self._actions = None
        self._predicates = None


