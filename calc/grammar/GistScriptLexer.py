# Generated from java-escape by ANTLR 4.5
# encoding: utf-8
from __future__ import print_function
from antlr4 import *
from io import StringIO


def serializedATN():
    with StringIO() as buf:
        buf.write(u"\3\u0430\ud6d1\u8206\uad2d\u4417\uaef1\u8d80\uaadd\2")
        buf.write(u"\20[\b\1\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7")
        buf.write(u"\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t\13\4\f\t\f\4\r\t")
        buf.write(u"\r\4\16\t\16\4\17\t\17\3\2\3\2\3\3\3\3\3\4\3\4\3\5\3")
        buf.write(u"\5\3\6\3\6\3\7\3\7\3\b\3\b\3\t\3\t\3\n\3\n\3\13\6\13")
        buf.write(u"\63\n\13\r\13\16\13\64\3\f\6\f8\n\f\r\f\16\f9\3\r\6\r")
        buf.write(u"=\n\r\r\r\16\r>\3\r\3\r\3\16\3\16\3\16\3\16\7\16G\n\16")
        buf.write(u"\f\16\16\16J\13\16\3\16\3\16\3\16\3\16\3\16\3\17\3\17")
        buf.write(u"\3\17\3\17\7\17U\n\17\f\17\16\17X\13\17\3\17\3\17\3H")
        buf.write(u"\2\20\3\3\5\4\7\5\t\6\13\7\r\b\17\t\21\n\23\13\25\f\27")
        buf.write(u"\r\31\16\33\17\35\20\3\2\6\7\2\60;C\\^^aac|\3\2\62;\5")
        buf.write(u"\2\13\f\17\17\"\"\4\2\f\f\17\17_\2\3\3\2\2\2\2\5\3\2")
        buf.write(u"\2\2\2\7\3\2\2\2\2\t\3\2\2\2\2\13\3\2\2\2\2\r\3\2\2\2")
        buf.write(u"\2\17\3\2\2\2\2\21\3\2\2\2\2\23\3\2\2\2\2\25\3\2\2\2")
        buf.write(u"\2\27\3\2\2\2\2\31\3\2\2\2\2\33\3\2\2\2\2\35\3\2\2\2")
        buf.write(u"\3\37\3\2\2\2\5!\3\2\2\2\7#\3\2\2\2\t%\3\2\2\2\13\'\3")
        buf.write(u"\2\2\2\r)\3\2\2\2\17+\3\2\2\2\21-\3\2\2\2\23/\3\2\2\2")
        buf.write(u"\25\62\3\2\2\2\27\67\3\2\2\2\31<\3\2\2\2\33B\3\2\2\2")
        buf.write(u"\35P\3\2\2\2\37 \7?\2\2 \4\3\2\2\2!\"\7~\2\2\"\6\3\2")
        buf.write(u"\2\2#$\7*\2\2$\b\3\2\2\2%&\7.\2\2&\n\3\2\2\2\'(\7+\2")
        buf.write(u"\2(\f\3\2\2\2)*\7<\2\2*\16\3\2\2\2+,\7]\2\2,\20\3\2\2")
        buf.write(u"\2-.\7_\2\2.\22\3\2\2\2/\60\7B\2\2\60\24\3\2\2\2\61\63")
        buf.write(u"\t\2\2\2\62\61\3\2\2\2\63\64\3\2\2\2\64\62\3\2\2\2\64")
        buf.write(u"\65\3\2\2\2\65\26\3\2\2\2\668\t\3\2\2\67\66\3\2\2\28")
        buf.write(u"9\3\2\2\29\67\3\2\2\29:\3\2\2\2:\30\3\2\2\2;=\t\4\2\2")
        buf.write(u"<;\3\2\2\2=>\3\2\2\2><\3\2\2\2>?\3\2\2\2?@\3\2\2\2@A")
        buf.write(u"\b\r\2\2A\32\3\2\2\2BC\7\61\2\2CD\7,\2\2DH\3\2\2\2EG")
        buf.write(u"\13\2\2\2FE\3\2\2\2GJ\3\2\2\2HI\3\2\2\2HF\3\2\2\2IK\3")
        buf.write(u"\2\2\2JH\3\2\2\2KL\7,\2\2LM\7\61\2\2MN\3\2\2\2NO\b\16")
        buf.write(u"\2\2O\34\3\2\2\2PQ\7\61\2\2QR\7\61\2\2RV\3\2\2\2SU\n")
        buf.write(u"\5\2\2TS\3\2\2\2UX\3\2\2\2VT\3\2\2\2VW\3\2\2\2WY\3\2")
        buf.write(u"\2\2XV\3\2\2\2YZ\b\17\2\2Z\36\3\2\2\2\b\2\649>HV\3\b")
        buf.write(u"\2\2")
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
            u"'='", u"'|'", u"'('", u"','", u"')'", u"':'", u"'['", u"']'", 
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


