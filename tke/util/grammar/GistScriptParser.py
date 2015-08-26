# Generated from java-escape by ANTLR 4.5
# encoding: utf-8
from __future__ import print_function
from antlr4 import *
from io import StringIO
package = globals().get("__package__", None)
ischild = len(package)>0 if package is not None else False
if ischild:
    from .GistScriptListener import GistScriptListener
else:
    from GistScriptListener import GistScriptListener
def serializedATN():
    with StringIO() as buf:
        buf.write(u"\3\u0430\ud6d1\u8206\uad2d\u4417\uaef1\u8d80\uaadd\3")
        buf.write(u"\21r\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7")
        buf.write(u"\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t\13\4\f\t\f\4\r\t\r\4")
        buf.write(u"\16\t\16\3\2\7\2\36\n\2\f\2\16\2!\13\2\3\3\3\3\3\3\5")
        buf.write(u"\3&\n\3\3\3\5\3)\n\3\3\3\3\3\3\3\3\4\3\4\3\4\3\4\5\4")
        buf.write(u"\62\n\4\3\5\3\5\3\5\3\5\3\5\7\59\n\5\f\5\16\5<\13\5\3")
        buf.write(u"\5\5\5?\n\5\3\5\3\5\3\6\3\6\3\6\3\6\5\6G\n\6\3\7\3\7")
        buf.write(u"\3\7\3\7\7\7M\n\7\f\7\16\7P\13\7\3\7\5\7S\n\7\3\7\3\7")
        buf.write(u"\3\b\5\bX\n\b\3\b\3\b\3\b\3\b\5\b^\n\b\3\b\5\ba\n\b\3")
        buf.write(u"\t\3\t\3\t\3\n\3\n\3\13\3\13\3\f\3\f\3\f\3\r\3\r\3\r")
        buf.write(u"\3\16\3\16\3\16\2\2\17\2\4\6\b\n\f\16\20\22\24\26\30")
        buf.write(u"\32\2\2t\2\37\3\2\2\2\4%\3\2\2\2\6-\3\2\2\2\b\63\3\2")
        buf.write(u"\2\2\nB\3\2\2\2\fH\3\2\2\2\16W\3\2\2\2\20b\3\2\2\2\22")
        buf.write(u"e\3\2\2\2\24g\3\2\2\2\26i\3\2\2\2\30l\3\2\2\2\32o\3\2")
        buf.write(u"\2\2\34\36\5\4\3\2\35\34\3\2\2\2\36!\3\2\2\2\37\35\3")
        buf.write(u"\2\2\2\37 \3\2\2\2 \3\3\2\2\2!\37\3\2\2\2\"&\5\30\r\2")
        buf.write(u"#&\5\24\13\2$&\5\26\f\2%\"\3\2\2\2%#\3\2\2\2%$\3\2\2")
        buf.write(u"\2&(\3\2\2\2\')\5\6\4\2(\'\3\2\2\2()\3\2\2\2)*\3\2\2")
        buf.write(u"\2*+\7\3\2\2+,\5\b\5\2,\5\3\2\2\2-\61\7\4\2\2.\62\5\30")
        buf.write(u"\r\2/\62\5\24\13\2\60\62\5\26\f\2\61.\3\2\2\2\61/\3\2")
        buf.write(u"\2\2\61\60\3\2\2\2\62\7\3\2\2\2\63\64\7\r\2\2\64\65\7")
        buf.write(u"\5\2\2\65:\5\n\6\2\66\67\7\6\2\2\679\5\n\6\28\66\3\2")
        buf.write(u"\2\29<\3\2\2\2:8\3\2\2\2:;\3\2\2\2;>\3\2\2\2<:\3\2\2")
        buf.write(u"\2=?\7\6\2\2>=\3\2\2\2>?\3\2\2\2?@\3\2\2\2@A\7\7\2\2")
        buf.write(u"A\t\3\2\2\2BC\5\22\n\2CF\7\b\2\2DG\5\f\7\2EG\5\16\b\2")
        buf.write(u"FD\3\2\2\2FE\3\2\2\2G\13\3\2\2\2HI\7\t\2\2IN\5\16\b\2")
        buf.write(u"JK\7\6\2\2KM\5\16\b\2LJ\3\2\2\2MP\3\2\2\2NL\3\2\2\2N")
        buf.write(u"O\3\2\2\2OR\3\2\2\2PN\3\2\2\2QS\7\6\2\2RQ\3\2\2\2RS\3")
        buf.write(u"\2\2\2ST\3\2\2\2TU\7\n\2\2U\r\3\2\2\2VX\5\20\t\2WV\3")
        buf.write(u"\2\2\2WX\3\2\2\2X]\3\2\2\2Y^\5\30\r\2Z^\5\24\13\2[^\5")
        buf.write(u"\32\16\2\\^\5\26\f\2]Y\3\2\2\2]Z\3\2\2\2][\3\2\2\2]\\")
        buf.write(u"\3\2\2\2^`\3\2\2\2_a\5\6\4\2`_\3\2\2\2`a\3\2\2\2a\17")
        buf.write(u"\3\2\2\2bc\5\22\n\2cd\7\b\2\2d\21\3\2\2\2ef\7\r\2\2f")
        buf.write(u"\23\3\2\2\2gh\7\r\2\2h\25\3\2\2\2ij\7\13\2\2jk\7\r\2")
        buf.write(u"\2k\27\3\2\2\2lm\7\f\2\2mn\7\r\2\2n\31\3\2\2\2op\7\16")
        buf.write(u"\2\2p\33\3\2\2\2\16\37%(\61:>FNRW]`")
        return buf.getvalue()


class GistScriptParser ( Parser ):

    grammarFileName = "java-escape"

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    sharedContextCache = PredictionContextCache()

    literalNames = [ u"<INVALID>", u"'='", u"'|'", u"'('", u"','", u"')'", 
                     u"':'", u"'['", u"']'", u"'@'", u"'$'" ]

    symbolicNames = [ u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"ID", u"CONSTANT", 
                      u"WS", u"COMMENT", u"LINE_COMMENT" ]

    RULE_gistscript = 0
    RULE_section = 1
    RULE_alt = 2
    RULE_gist = 3
    RULE_params = 4
    RULE_param_list = 5
    RULE_param = 6
    RULE_named_param = 7
    RULE_name = 8
    RULE_var = 9
    RULE_tmp = 10
    RULE_const = 11
    RULE_constant = 12

    ruleNames =  [ u"gistscript", u"section", u"alt", u"gist", u"params", 
                   u"param_list", u"param", u"named_param", u"name", u"var", 
                   u"tmp", u"const", u"constant" ]

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
    ID=11
    CONSTANT=12
    WS=13
    COMMENT=14
    LINE_COMMENT=15

    def __init__(self, input):
        super(GistScriptParser, self).__init__(input)
        self.checkVersion("4.5")
        self._interp = ParserATNSimulator(self, self.atn, self.decisionsToDFA, self.sharedContextCache)
        self._predicates = None



    class GistscriptContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(GistScriptParser.GistscriptContext, self).__init__(parent, invokingState)
            self.parser = parser

        def section(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(GistScriptParser.SectionContext)
            else:
                return self.getTypedRuleContext(GistScriptParser.SectionContext,i)


        def getRuleIndex(self):
            return GistScriptParser.RULE_gistscript

        def enterRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.enterGistscript(self)

        def exitRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.exitGistscript(self)




    def gistscript(self):

        localctx = GistScriptParser.GistscriptContext(self, self._ctx, self.state)
        self.enterRule(localctx, 0, self.RULE_gistscript)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 29
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << GistScriptParser.T__8) | (1 << GistScriptParser.T__9) | (1 << GistScriptParser.ID))) != 0):
                self.state = 26
                self.section()
                self.state = 31
                self._errHandler.sync(self)
                _la = self._input.LA(1)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class SectionContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(GistScriptParser.SectionContext, self).__init__(parent, invokingState)
            self.parser = parser

        def gist(self):
            return self.getTypedRuleContext(GistScriptParser.GistContext,0)


        def const(self):
            return self.getTypedRuleContext(GistScriptParser.ConstContext,0)


        def var(self):
            return self.getTypedRuleContext(GistScriptParser.VarContext,0)


        def tmp(self):
            return self.getTypedRuleContext(GistScriptParser.TmpContext,0)


        def alt(self):
            return self.getTypedRuleContext(GistScriptParser.AltContext,0)


        def getRuleIndex(self):
            return GistScriptParser.RULE_section

        def enterRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.enterSection(self)

        def exitRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.exitSection(self)




    def section(self):

        localctx = GistScriptParser.SectionContext(self, self._ctx, self.state)
        self.enterRule(localctx, 2, self.RULE_section)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 35
            token = self._input.LA(1)
            if token in [GistScriptParser.T__9]:
                self.state = 32
                self.const()

            elif token in [GistScriptParser.ID]:
                self.state = 33
                self.var()

            elif token in [GistScriptParser.T__8]:
                self.state = 34
                self.tmp()

            else:
                raise NoViableAltException(self)

            self.state = 38
            _la = self._input.LA(1)
            if _la==GistScriptParser.T__1:
                self.state = 37
                self.alt()


            self.state = 40
            self.match(GistScriptParser.T__0)
            self.state = 41
            self.gist()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class AltContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(GistScriptParser.AltContext, self).__init__(parent, invokingState)
            self.parser = parser

        def const(self):
            return self.getTypedRuleContext(GistScriptParser.ConstContext,0)


        def var(self):
            return self.getTypedRuleContext(GistScriptParser.VarContext,0)


        def tmp(self):
            return self.getTypedRuleContext(GistScriptParser.TmpContext,0)


        def getRuleIndex(self):
            return GistScriptParser.RULE_alt

        def enterRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.enterAlt(self)

        def exitRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.exitAlt(self)




    def alt(self):

        localctx = GistScriptParser.AltContext(self, self._ctx, self.state)
        self.enterRule(localctx, 4, self.RULE_alt)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 43
            self.match(GistScriptParser.T__1)
            self.state = 47
            token = self._input.LA(1)
            if token in [GistScriptParser.T__9]:
                self.state = 44
                self.const()

            elif token in [GistScriptParser.ID]:
                self.state = 45
                self.var()

            elif token in [GistScriptParser.T__8]:
                self.state = 46
                self.tmp()

            else:
                raise NoViableAltException(self)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class GistContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(GistScriptParser.GistContext, self).__init__(parent, invokingState)
            self.parser = parser

        def ID(self):
            return self.getToken(GistScriptParser.ID, 0)

        def params(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(GistScriptParser.ParamsContext)
            else:
                return self.getTypedRuleContext(GistScriptParser.ParamsContext,i)


        def getRuleIndex(self):
            return GistScriptParser.RULE_gist

        def enterRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.enterGist(self)

        def exitRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.exitGist(self)




    def gist(self):

        localctx = GistScriptParser.GistContext(self, self._ctx, self.state)
        self.enterRule(localctx, 6, self.RULE_gist)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 49
            self.match(GistScriptParser.ID)
            self.state = 50
            self.match(GistScriptParser.T__2)
            self.state = 51
            self.params()
            self.state = 56
            self._errHandler.sync(self)
            _alt = self._interp.adaptivePredict(self._input,4,self._ctx)
            while _alt!=2 and _alt!=ATN.INVALID_ALT_NUMBER:
                if _alt==1:
                    self.state = 52
                    self.match(GistScriptParser.T__3)
                    self.state = 53
                    self.params() 
                self.state = 58
                self._errHandler.sync(self)
                _alt = self._interp.adaptivePredict(self._input,4,self._ctx)

            self.state = 60
            _la = self._input.LA(1)
            if _la==GistScriptParser.T__3:
                self.state = 59
                self.match(GistScriptParser.T__3)


            self.state = 62
            self.match(GistScriptParser.T__4)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class ParamsContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(GistScriptParser.ParamsContext, self).__init__(parent, invokingState)
            self.parser = parser

        def name(self):
            return self.getTypedRuleContext(GistScriptParser.NameContext,0)


        def param_list(self):
            return self.getTypedRuleContext(GistScriptParser.Param_listContext,0)


        def param(self):
            return self.getTypedRuleContext(GistScriptParser.ParamContext,0)


        def getRuleIndex(self):
            return GistScriptParser.RULE_params

        def enterRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.enterParams(self)

        def exitRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.exitParams(self)




    def params(self):

        localctx = GistScriptParser.ParamsContext(self, self._ctx, self.state)
        self.enterRule(localctx, 8, self.RULE_params)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 64
            self.name()
            self.state = 65
            self.match(GistScriptParser.T__5)
            self.state = 68
            token = self._input.LA(1)
            if token in [GistScriptParser.T__6]:
                self.state = 66
                self.param_list()

            elif token in [GistScriptParser.T__8, GistScriptParser.T__9, GistScriptParser.ID, GistScriptParser.CONSTANT]:
                self.state = 67
                self.param()

            else:
                raise NoViableAltException(self)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Param_listContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(GistScriptParser.Param_listContext, self).__init__(parent, invokingState)
            self.parser = parser

        def param(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(GistScriptParser.ParamContext)
            else:
                return self.getTypedRuleContext(GistScriptParser.ParamContext,i)


        def getRuleIndex(self):
            return GistScriptParser.RULE_param_list

        def enterRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.enterParam_list(self)

        def exitRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.exitParam_list(self)




    def param_list(self):

        localctx = GistScriptParser.Param_listContext(self, self._ctx, self.state)
        self.enterRule(localctx, 10, self.RULE_param_list)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 70
            self.match(GistScriptParser.T__6)
            self.state = 71
            self.param()
            self.state = 76
            self._errHandler.sync(self)
            _alt = self._interp.adaptivePredict(self._input,7,self._ctx)
            while _alt!=2 and _alt!=ATN.INVALID_ALT_NUMBER:
                if _alt==1:
                    self.state = 72
                    self.match(GistScriptParser.T__3)
                    self.state = 73
                    self.param() 
                self.state = 78
                self._errHandler.sync(self)
                _alt = self._interp.adaptivePredict(self._input,7,self._ctx)

            self.state = 80
            _la = self._input.LA(1)
            if _la==GistScriptParser.T__3:
                self.state = 79
                self.match(GistScriptParser.T__3)


            self.state = 82
            self.match(GistScriptParser.T__7)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class ParamContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(GistScriptParser.ParamContext, self).__init__(parent, invokingState)
            self.parser = parser

        def const(self):
            return self.getTypedRuleContext(GistScriptParser.ConstContext,0)


        def var(self):
            return self.getTypedRuleContext(GistScriptParser.VarContext,0)


        def constant(self):
            return self.getTypedRuleContext(GistScriptParser.ConstantContext,0)


        def tmp(self):
            return self.getTypedRuleContext(GistScriptParser.TmpContext,0)


        def named_param(self):
            return self.getTypedRuleContext(GistScriptParser.Named_paramContext,0)


        def alt(self):
            return self.getTypedRuleContext(GistScriptParser.AltContext,0)


        def getRuleIndex(self):
            return GistScriptParser.RULE_param

        def enterRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.enterParam(self)

        def exitRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.exitParam(self)




    def param(self):

        localctx = GistScriptParser.ParamContext(self, self._ctx, self.state)
        self.enterRule(localctx, 12, self.RULE_param)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 85
            la_ = self._interp.adaptivePredict(self._input,9,self._ctx)
            if la_ == 1:
                self.state = 84
                self.named_param()


            self.state = 91
            token = self._input.LA(1)
            if token in [GistScriptParser.T__9]:
                self.state = 87
                self.const()

            elif token in [GistScriptParser.ID]:
                self.state = 88
                self.var()

            elif token in [GistScriptParser.CONSTANT]:
                self.state = 89
                self.constant()

            elif token in [GistScriptParser.T__8]:
                self.state = 90
                self.tmp()

            else:
                raise NoViableAltException(self)

            self.state = 94
            _la = self._input.LA(1)
            if _la==GistScriptParser.T__1:
                self.state = 93
                self.alt()


        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Named_paramContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(GistScriptParser.Named_paramContext, self).__init__(parent, invokingState)
            self.parser = parser

        def name(self):
            return self.getTypedRuleContext(GistScriptParser.NameContext,0)


        def getRuleIndex(self):
            return GistScriptParser.RULE_named_param

        def enterRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.enterNamed_param(self)

        def exitRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.exitNamed_param(self)




    def named_param(self):

        localctx = GistScriptParser.Named_paramContext(self, self._ctx, self.state)
        self.enterRule(localctx, 14, self.RULE_named_param)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 96
            self.name()
            self.state = 97
            self.match(GistScriptParser.T__5)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class NameContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(GistScriptParser.NameContext, self).__init__(parent, invokingState)
            self.parser = parser

        def ID(self):
            return self.getToken(GistScriptParser.ID, 0)

        def getRuleIndex(self):
            return GistScriptParser.RULE_name

        def enterRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.enterName(self)

        def exitRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.exitName(self)




    def name(self):

        localctx = GistScriptParser.NameContext(self, self._ctx, self.state)
        self.enterRule(localctx, 16, self.RULE_name)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 99
            self.match(GistScriptParser.ID)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class VarContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(GistScriptParser.VarContext, self).__init__(parent, invokingState)
            self.parser = parser

        def ID(self):
            return self.getToken(GistScriptParser.ID, 0)

        def getRuleIndex(self):
            return GistScriptParser.RULE_var

        def enterRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.enterVar(self)

        def exitRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.exitVar(self)




    def var(self):

        localctx = GistScriptParser.VarContext(self, self._ctx, self.state)
        self.enterRule(localctx, 18, self.RULE_var)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 101
            self.match(GistScriptParser.ID)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class TmpContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(GistScriptParser.TmpContext, self).__init__(parent, invokingState)
            self.parser = parser

        def ID(self):
            return self.getToken(GistScriptParser.ID, 0)

        def getRuleIndex(self):
            return GistScriptParser.RULE_tmp

        def enterRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.enterTmp(self)

        def exitRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.exitTmp(self)




    def tmp(self):

        localctx = GistScriptParser.TmpContext(self, self._ctx, self.state)
        self.enterRule(localctx, 20, self.RULE_tmp)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 103
            self.match(GistScriptParser.T__8)
            self.state = 104
            self.match(GistScriptParser.ID)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class ConstContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(GistScriptParser.ConstContext, self).__init__(parent, invokingState)
            self.parser = parser

        def ID(self):
            return self.getToken(GistScriptParser.ID, 0)

        def getRuleIndex(self):
            return GistScriptParser.RULE_const

        def enterRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.enterConst(self)

        def exitRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.exitConst(self)




    def const(self):

        localctx = GistScriptParser.ConstContext(self, self._ctx, self.state)
        self.enterRule(localctx, 22, self.RULE_const)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 106
            self.match(GistScriptParser.T__9)
            self.state = 107
            self.match(GistScriptParser.ID)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class ConstantContext(ParserRuleContext):

        def __init__(self, parser, parent=None, invokingState=-1):
            super(GistScriptParser.ConstantContext, self).__init__(parent, invokingState)
            self.parser = parser

        def CONSTANT(self):
            return self.getToken(GistScriptParser.CONSTANT, 0)

        def getRuleIndex(self):
            return GistScriptParser.RULE_constant

        def enterRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.enterConstant(self)

        def exitRule(self, listener):
            if isinstance( listener, GistScriptListener ):
                listener.exitConstant(self)




    def constant(self):

        localctx = GistScriptParser.ConstantContext(self, self._ctx, self.state)
        self.enterRule(localctx, 24, self.RULE_constant)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 109
            self.match(GistScriptParser.CONSTANT)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx




