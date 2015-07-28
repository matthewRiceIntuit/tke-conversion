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
        buf.write(u"\20d\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7")
        buf.write(u"\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t\13\4\f\t\f\4\r\t\r\3")
        buf.write(u"\2\7\2\34\n\2\f\2\16\2\37\13\2\3\3\3\3\5\3#\n\3\3\3\5")
        buf.write(u"\3&\n\3\3\3\3\3\3\3\3\4\3\4\3\4\5\4.\n\4\3\5\3\5\3\5")
        buf.write(u"\7\5\63\n\5\f\5\16\5\66\13\5\3\5\3\5\3\6\3\6\3\6\3\6")
        buf.write(u"\5\6>\n\6\3\7\3\7\3\7\3\7\6\7D\n\7\r\7\16\7E\3\7\5\7")
        buf.write(u"I\n\7\3\7\3\7\3\b\5\bN\n\b\3\b\3\b\3\b\5\bS\n\b\3\b\5")
        buf.write(u"\bV\n\b\3\t\3\t\3\t\3\n\3\n\3\13\3\13\3\f\3\f\3\f\3\r")
        buf.write(u"\3\r\3\r\2\2\16\2\4\6\b\n\f\16\20\22\24\26\30\2\2c\2")
        buf.write(u"\35\3\2\2\2\4\"\3\2\2\2\6*\3\2\2\2\b/\3\2\2\2\n9\3\2")
        buf.write(u"\2\2\f?\3\2\2\2\16M\3\2\2\2\20W\3\2\2\2\22Z\3\2\2\2\24")
        buf.write(u"\\\3\2\2\2\26^\3\2\2\2\30a\3\2\2\2\32\34\5\4\3\2\33\32")
        buf.write(u"\3\2\2\2\34\37\3\2\2\2\35\33\3\2\2\2\35\36\3\2\2\2\36")
        buf.write(u"\3\3\2\2\2\37\35\3\2\2\2 #\5\24\13\2!#\5\26\f\2\" \3")
        buf.write(u"\2\2\2\"!\3\2\2\2#%\3\2\2\2$&\5\6\4\2%$\3\2\2\2%&\3\2")
        buf.write(u"\2\2&\'\3\2\2\2\'(\7\3\2\2()\5\b\5\2)\5\3\2\2\2*-\7\4")
        buf.write(u"\2\2+.\5\24\13\2,.\5\26\f\2-+\3\2\2\2-,\3\2\2\2.\7\3")
        buf.write(u"\2\2\2/\60\7\f\2\2\60\64\7\5\2\2\61\63\5\n\6\2\62\61")
        buf.write(u"\3\2\2\2\63\66\3\2\2\2\64\62\3\2\2\2\64\65\3\2\2\2\65")
        buf.write(u"\67\3\2\2\2\66\64\3\2\2\2\678\7\6\2\28\t\3\2\2\29:\5")
        buf.write(u"\22\n\2:=\7\7\2\2;>\5\f\7\2<>\5\16\b\2=;\3\2\2\2=<\3")
        buf.write(u"\2\2\2>\13\3\2\2\2?C\7\b\2\2@A\5\16\b\2AB\7\t\2\2BD\3")
        buf.write(u"\2\2\2C@\3\2\2\2DE\3\2\2\2EC\3\2\2\2EF\3\2\2\2FH\3\2")
        buf.write(u"\2\2GI\5\16\b\2HG\3\2\2\2HI\3\2\2\2IJ\3\2\2\2JK\7\n\2")
        buf.write(u"\2K\r\3\2\2\2LN\5\20\t\2ML\3\2\2\2MN\3\2\2\2NR\3\2\2")
        buf.write(u"\2OS\5\24\13\2PS\5\30\r\2QS\5\26\f\2RO\3\2\2\2RP\3\2")
        buf.write(u"\2\2RQ\3\2\2\2SU\3\2\2\2TV\5\6\4\2UT\3\2\2\2UV\3\2\2")
        buf.write(u"\2V\17\3\2\2\2WX\5\22\n\2XY\7\7\2\2Y\21\3\2\2\2Z[\7\f")
        buf.write(u"\2\2[\23\3\2\2\2\\]\7\f\2\2]\25\3\2\2\2^_\7\13\2\2_`")
        buf.write(u"\7\f\2\2`\27\3\2\2\2ab\7\r\2\2b\31\3\2\2\2\r\35\"%-\64")
        buf.write(u"=EHMRU")
        return buf.getvalue()


class GistScriptParser ( Parser ):

    grammarFileName = "java-escape"

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    sharedContextCache = PredictionContextCache()

    literalNames = [ u"<INVALID>", u"'='", u"'|'", u"'('", u"')'", u"':'", 
                     u"'['", u"','", u"']'", u"'@'" ]

    symbolicNames = [ u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"ID", u"CONSTANT", u"WS", 
                      u"COMMENT", u"LINE_COMMENT" ]

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
    RULE_constant = 11

    ruleNames =  [ u"gistscript", u"section", u"alt", u"gist", u"params", 
                   u"param_list", u"param", u"named_param", u"name", u"var", 
                   u"tmp", u"constant" ]

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
    ID=10
    CONSTANT=11
    WS=12
    COMMENT=13
    LINE_COMMENT=14

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
            self.state = 27
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==GistScriptParser.T__8 or _la==GistScriptParser.ID:
                self.state = 24
                self.section()
                self.state = 29
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
            self.state = 32
            token = self._input.LA(1)
            if token in [GistScriptParser.ID]:
                self.state = 30
                self.var()

            elif token in [GistScriptParser.T__8]:
                self.state = 31
                self.tmp()

            else:
                raise NoViableAltException(self)

            self.state = 35
            _la = self._input.LA(1)
            if _la==GistScriptParser.T__1:
                self.state = 34
                self.alt()


            self.state = 37
            self.match(GistScriptParser.T__0)
            self.state = 38
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
            self.state = 40
            self.match(GistScriptParser.T__1)
            self.state = 43
            token = self._input.LA(1)
            if token in [GistScriptParser.ID]:
                self.state = 41
                self.var()

            elif token in [GistScriptParser.T__8]:
                self.state = 42
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
            self.state = 45
            self.match(GistScriptParser.ID)
            self.state = 46
            self.match(GistScriptParser.T__2)
            self.state = 50
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==GistScriptParser.ID:
                self.state = 47
                self.params()
                self.state = 52
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 53
            self.match(GistScriptParser.T__3)
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
            self.state = 55
            self.name()
            self.state = 56
            self.match(GistScriptParser.T__4)
            self.state = 59
            token = self._input.LA(1)
            if token in [GistScriptParser.T__5]:
                self.state = 57
                self.param_list()

            elif token in [GistScriptParser.T__8, GistScriptParser.ID, GistScriptParser.CONSTANT]:
                self.state = 58
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
            self.state = 61
            self.match(GistScriptParser.T__5)
            self.state = 65 
            self._errHandler.sync(self)
            _alt = 1
            while _alt!=2 and _alt!=ATN.INVALID_ALT_NUMBER:
                if _alt == 1:
                    self.state = 62
                    self.param()
                    self.state = 63
                    self.match(GistScriptParser.T__6)

                else:
                    raise NoViableAltException(self)
                self.state = 67 
                self._errHandler.sync(self)
                _alt = self._interp.adaptivePredict(self._input,6,self._ctx)

            self.state = 70
            _la = self._input.LA(1)
            if (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << GistScriptParser.T__8) | (1 << GistScriptParser.ID) | (1 << GistScriptParser.CONSTANT))) != 0):
                self.state = 69
                self.param()


            self.state = 72
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
            self.state = 75
            la_ = self._interp.adaptivePredict(self._input,8,self._ctx)
            if la_ == 1:
                self.state = 74
                self.named_param()


            self.state = 80
            token = self._input.LA(1)
            if token in [GistScriptParser.ID]:
                self.state = 77
                self.var()

            elif token in [GistScriptParser.CONSTANT]:
                self.state = 78
                self.constant()

            elif token in [GistScriptParser.T__8]:
                self.state = 79
                self.tmp()

            else:
                raise NoViableAltException(self)

            self.state = 83
            _la = self._input.LA(1)
            if _la==GistScriptParser.T__1:
                self.state = 82
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
            self.state = 85
            self.name()
            self.state = 86
            self.match(GistScriptParser.T__4)
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
            self.state = 88
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
            self.state = 90
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
            self.state = 92
            self.match(GistScriptParser.T__8)
            self.state = 93
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
        self.enterRule(localctx, 22, self.RULE_constant)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 95
            self.match(GistScriptParser.CONSTANT)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx




