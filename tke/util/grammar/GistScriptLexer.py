# Generated from java-escape by ANTLR 4.5
# encoding: utf-8
from __future__ import print_function
from antlr4 import *
from io import StringIO


def serializedATN():
    with StringIO() as buf:
        buf.write(u"\3\u0430\ud6d1\u8206\uad2d\u4417\uaef1\u8d80\uaadd\2")
        buf.write(u"\21_\b\1\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7")
        buf.write(u"\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t\13\4\f\t\f\4\r\t")
        buf.write(u"\r\4\16\t\16\4\17\t\17\4\20\t\20\3\2\3\2\3\3\3\3\3\4")
        buf.write(u"\3\4\3\5\3\5\3\6\3\6\3\7\3\7\3\b\3\b\3\t\3\t\3\n\3\n")
        buf.write(u"\3\13\3\13\3\f\6\f\67\n\f\r\f\16\f8\3\r\6\r<\n\r\r\r")
        buf.write(u"\16\r=\3\16\6\16A\n\16\r\16\16\16B\3\16\3\16\3\17\3\17")
        buf.write(u"\3\17\3\17\7\17K\n\17\f\17\16\17N\13\17\3\17\3\17\3\17")
        buf.write(u"\3\17\3\17\3\20\3\20\3\20\3\20\7\20Y\n\20\f\20\16\20")
        buf.write(u"\\\13\20\3\20\3\20\3L\2\21\3\3\5\4\7\5\t\6\13\7\r\b\17")
        buf.write(u"\t\21\n\23\13\25\f\27\r\31\16\33\17\35\20\37\21\3\2\6")
        buf.write(u"\7\2\60;C\\^^aac|\3\2\62;\5\2\13\f\17\17\"\"\4\2\f\f")
        buf.write(u"\17\17c\2\3\3\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2\2\t\3\2\2")
        buf.write(u"\2\2\13\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2\2\2\21\3\2\2\2")
        buf.write(u"\2\23\3\2\2\2\2\25\3\2\2\2\2\27\3\2\2\2\2\31\3\2\2\2")
        buf.write(u"\2\33\3\2\2\2\2\35\3\2\2\2\2\37\3\2\2\2\3!\3\2\2\2\5")
        buf.write(u"#\3\2\2\2\7%\3\2\2\2\t\'\3\2\2\2\13)\3\2\2\2\r+\3\2\2")
        buf.write(u"\2\17-\3\2\2\2\21/\3\2\2\2\23\61\3\2\2\2\25\63\3\2\2")
        buf.write(u"\2\27\66\3\2\2\2\31;\3\2\2\2\33@\3\2\2\2\35F\3\2\2\2")
        buf.write(u"\37T\3\2\2\2!\"\7?\2\2\"\4\3\2\2\2#$\7~\2\2$\6\3\2\2")
        buf.write(u"\2%&\7*\2\2&\b\3\2\2\2\'(\7.\2\2(\n\3\2\2\2)*\7+\2\2")
        buf.write(u"*\f\3\2\2\2+,\7<\2\2,\16\3\2\2\2-.\7]\2\2.\20\3\2\2\2")
        buf.write(u"/\60\7_\2\2\60\22\3\2\2\2\61\62\7B\2\2\62\24\3\2\2\2")
        buf.write(u"\63\64\7&\2\2\64\26\3\2\2\2\65\67\t\2\2\2\66\65\3\2\2")
        buf.write(u"\2\678\3\2\2\28\66\3\2\2\289\3\2\2\29\30\3\2\2\2:<\t")
        buf.write(u"\3\2\2;:\3\2\2\2<=\3\2\2\2=;\3\2\2\2=>\3\2\2\2>\32\3")
        buf.write(u"\2\2\2?A\t\4\2\2@?\3\2\2\2AB\3\2\2\2B@\3\2\2\2BC\3\2")
        buf.write(u"\2\2CD\3\2\2\2DE\b\16\2\2E\34\3\2\2\2FG\7\61\2\2GH\7")
        buf.write(u",\2\2HL\3\2\2\2IK\13\2\2\2JI\3\2\2\2KN\3\2\2\2LM\3\2")
        buf.write(u"\2\2LJ\3\2\2\2MO\3\2\2\2NL\3\2\2\2OP\7,\2\2PQ\7\61\2")
        buf.write(u"\2QR\3\2\2\2RS\b\17\2\2S\36\3\2\2\2TU\7\61\2\2UV\7\61")
        buf.write(u"\2\2VZ\3\2\2\2WY\n\5\2\2XW\3\2\2\2Y\\\3\2\2\2ZX\3\2\2")
        buf.write(u"\2Z[\3\2\2\2[]\3\2\2\2\\Z\3\2\2\2]^\b\20\2\2^ \3\2\2")
        buf.write(u"\2\b\28=BLZ\3\b\2\2")
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
    T__9 = 10
    ID = 11
    CONSTANT = 12
    WS = 13
    COMMENT = 14
    LINE_COMMENT = 15

    modeNames = [ u"DEFAULT_MODE" ]

    literalNames = [ u"<INVALID>",
            u"'='", u"'|'", u"'('", u"','", u"')'", u"':'", u"'['", u"']'", 
            u"'@'", u"'$'" ]

    symbolicNames = [ u"<INVALID>",
            u"ID", u"CONSTANT", u"WS", u"COMMENT", u"LINE_COMMENT" ]

    ruleNames = [ u"T__0", u"T__1", u"T__2", u"T__3", u"T__4", u"T__5", 
                  u"T__6", u"T__7", u"T__8", u"T__9", u"ID", u"CONSTANT", 
                  u"WS", u"COMMENT", u"LINE_COMMENT" ]

    grammarFileName = u"GistScript.g4"

    def __init__(self, input=None):
        super(GistScriptLexer, self).__init__(input)
        self.checkVersion("4.5")
        self._interp = LexerATNSimulator(self, self.atn, self.decisionsToDFA, PredictionContextCache())
        self._actions = None
        self._predicates = None


