# Generated from java-escape by ANTLR 4.5
# encoding: utf-8
from __future__ import print_function
from antlr4 import *
from io import StringIO


def serializedATN():
    with StringIO() as buf:
        buf.write(u"\3\u0430\ud6d1\u8206\uad2d\u4417\uaef1\u8d80\uaadd\2")
        buf.write(u"\20]\b\1\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7")
        buf.write(u"\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t\13\4\f\t\f\4\r\t")
        buf.write(u"\r\4\16\t\16\4\17\t\17\3\2\3\2\3\3\3\3\3\4\3\4\3\5\3")
        buf.write(u"\5\3\6\3\6\3\7\3\7\3\b\3\b\3\t\3\t\3\n\3\n\3\13\3\13")
        buf.write(u"\7\13\64\n\13\f\13\16\13\67\13\13\3\f\6\f:\n\f\r\f\16")
        buf.write(u"\f;\3\r\6\r?\n\r\r\r\16\r@\3\r\3\r\3\16\3\16\3\16\3\16")
        buf.write(u"\7\16I\n\16\f\16\16\16L\13\16\3\16\3\16\3\16\3\16\3\16")
        buf.write(u"\3\17\3\17\3\17\3\17\7\17W\n\17\f\17\16\17Z\13\17\3\17")
        buf.write(u"\3\17\3J\2\20\3\3\5\4\7\5\t\6\13\7\r\b\17\t\21\n\23\13")
        buf.write(u"\25\f\27\r\31\16\33\17\35\20\3\2\7\5\2C\\aac|\7\2\60")
        buf.write(u";C\\^^aac|\3\2\62;\5\2\13\f\17\17\"\"\4\2\f\f\17\17a")
        buf.write(u"\2\3\3\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2\2\t\3\2\2\2\2\13")
        buf.write(u"\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2\2\2\21\3\2\2\2\2\23\3")
        buf.write(u"\2\2\2\2\25\3\2\2\2\2\27\3\2\2\2\2\31\3\2\2\2\2\33\3")
        buf.write(u"\2\2\2\2\35\3\2\2\2\3\37\3\2\2\2\5!\3\2\2\2\7#\3\2\2")
        buf.write(u"\2\t%\3\2\2\2\13\'\3\2\2\2\r)\3\2\2\2\17+\3\2\2\2\21")
        buf.write(u"-\3\2\2\2\23/\3\2\2\2\25\61\3\2\2\2\279\3\2\2\2\31>\3")
        buf.write(u"\2\2\2\33D\3\2\2\2\35R\3\2\2\2\37 \7?\2\2 \4\3\2\2\2")
        buf.write(u"!\"\7~\2\2\"\6\3\2\2\2#$\7*\2\2$\b\3\2\2\2%&\7+\2\2&")
        buf.write(u"\n\3\2\2\2\'(\7<\2\2(\f\3\2\2\2)*\7]\2\2*\16\3\2\2\2")
        buf.write(u"+,\7.\2\2,\20\3\2\2\2-.\7_\2\2.\22\3\2\2\2/\60\7B\2\2")
        buf.write(u"\60\24\3\2\2\2\61\65\t\2\2\2\62\64\t\3\2\2\63\62\3\2")
        buf.write(u"\2\2\64\67\3\2\2\2\65\63\3\2\2\2\65\66\3\2\2\2\66\26")
        buf.write(u"\3\2\2\2\67\65\3\2\2\28:\t\4\2\298\3\2\2\2:;\3\2\2\2")
        buf.write(u";9\3\2\2\2;<\3\2\2\2<\30\3\2\2\2=?\t\5\2\2>=\3\2\2\2")
        buf.write(u"?@\3\2\2\2@>\3\2\2\2@A\3\2\2\2AB\3\2\2\2BC\b\r\2\2C\32")
        buf.write(u"\3\2\2\2DE\7\61\2\2EF\7,\2\2FJ\3\2\2\2GI\13\2\2\2HG\3")
        buf.write(u"\2\2\2IL\3\2\2\2JK\3\2\2\2JH\3\2\2\2KM\3\2\2\2LJ\3\2")
        buf.write(u"\2\2MN\7,\2\2NO\7\61\2\2OP\3\2\2\2PQ\b\16\2\2Q\34\3\2")
        buf.write(u"\2\2RS\7\61\2\2ST\7\61\2\2TX\3\2\2\2UW\n\6\2\2VU\3\2")
        buf.write(u"\2\2WZ\3\2\2\2XV\3\2\2\2XY\3\2\2\2Y[\3\2\2\2ZX\3\2\2")
        buf.write(u"\2[\\\b\17\2\2\\\36\3\2\2\2\b\2\65;@JX\3\b\2\2")
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
    T__7 = 8
    T__8 = 9
    ID = 10
    CONSTANT = 11
    WS = 12
    COMMENT = 13
    LINE_COMMENT = 14

    modeNames = [ u"DEFAULT_MODE" ]

    literalNames = [ u"<INVALID>",
            u"'='", u"'|'", u"'('", u"')'", u"':'", u"'['", u"','", u"']'", 
            u"'@'" ]

    symbolicNames = [ u"<INVALID>",
            u"ID", u"CONSTANT", u"WS", u"COMMENT", u"LINE_COMMENT" ]

    ruleNames = [ u"T__0", u"T__1", u"T__2", u"T__3", u"T__4", u"T__5", 
                  u"T__6", u"T__7", u"T__8", u"ID", u"CONSTANT", u"WS", 
                  u"COMMENT", u"LINE_COMMENT" ]

    grammarFileName = u"GistScript.g4"

    def __init__(self, input=None):
        super(GistScriptLexer, self).__init__(input)
        self.checkVersion("4.5")
        self._interp = LexerATNSimulator(self, self.atn, self.decisionsToDFA, PredictionContextCache())
        self._actions = None
        self._predicates = None


