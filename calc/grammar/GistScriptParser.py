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
        buf.write(u"\16K\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7")
        buf.write(u"\4\b\t\b\4\t\t\t\4\n\t\n\3\2\7\2\26\n\2\f\2\16\2\31\13")
        buf.write(u"\2\3\3\3\3\3\3\3\3\3\3\7\3 \n\3\f\3\16\3#\13\3\3\3\3")
        buf.write(u"\3\3\4\3\4\3\5\3\5\3\5\3\5\5\5-\n\5\3\6\3\6\3\6\3\6\6")
        buf.write(u"\6\63\n\6\r\6\16\6\64\3\6\5\68\n\6\3\6\3\6\3\7\3\7\3")
        buf.write(u"\7\5\7?\n\7\3\b\3\b\3\b\3\b\5\bE\n\b\3\t\3\t\3\n\3\n")
        buf.write(u"\3\n\2\2\13\2\4\6\b\n\f\16\20\22\2\2I\2\27\3\2\2\2\4")
        buf.write(u"\32\3\2\2\2\6&\3\2\2\2\b(\3\2\2\2\n.\3\2\2\2\f>\3\2\2")
        buf.write(u"\2\16@\3\2\2\2\20F\3\2\2\2\22H\3\2\2\2\24\26\5\4\3\2")
        buf.write(u"\25\24\3\2\2\2\26\31\3\2\2\2\27\25\3\2\2\2\27\30\3\2")
        buf.write(u"\2\2\30\3\3\2\2\2\31\27\3\2\2\2\32\33\5\20\t\2\33\34")
        buf.write(u"\7\3\2\2\34\35\5\6\4\2\35!\7\4\2\2\36 \5\b\5\2\37\36")
        buf.write(u"\3\2\2\2 #\3\2\2\2!\37\3\2\2\2!\"\3\2\2\2\"$\3\2\2\2")
        buf.write(u"#!\3\2\2\2$%\7\5\2\2%\5\3\2\2\2&\'\7\n\2\2\'\7\3\2\2")
        buf.write(u"\2()\5\20\t\2),\7\6\2\2*-\5\n\6\2+-\5\f\7\2,*\3\2\2\2")
        buf.write(u",+\3\2\2\2-\t\3\2\2\2.\62\7\7\2\2/\60\5\f\7\2\60\61\7")
        buf.write(u"\b\2\2\61\63\3\2\2\2\62/\3\2\2\2\63\64\3\2\2\2\64\62")
        buf.write(u"\3\2\2\2\64\65\3\2\2\2\65\67\3\2\2\2\668\5\f\7\2\67\66")
        buf.write(u"\3\2\2\2\678\3\2\2\289\3\2\2\29:\7\t\2\2:\13\3\2\2\2")
        buf.write(u";?\5\16\b\2<?\5\20\t\2=?\5\22\n\2>;\3\2\2\2><\3\2\2\2")
        buf.write(u">=\3\2\2\2?\r\3\2\2\2@A\5\20\t\2AD\7\3\2\2BE\5\20\t\2")
        buf.write(u"CE\5\22\n\2DB\3\2\2\2DC\3\2\2\2E\17\3\2\2\2FG\7\n\2\2")
        buf.write(u"G\21\3\2\2\2HI\7\13\2\2I\23\3\2\2\2\t\27!,\64\67>D")
        return buf.getvalue()


class GistScriptParser ( Parser ):

    grammarFileName = "java-escape"

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    sharedContextCache = PredictionContextCache()

    literalNames = [ u"<INVALID>", u"'='", u"'('", u"')'", u"':'", u"'['", 
                     u"','", u"']'" ]

    symbolicNames = [ u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"<INVALID>", u"<INVALID>", u"<INVALID>", u"<INVALID>", 
                      u"ID", u"CONSTANT", u"WS", u"COMMENT", u"LINE_COMMENT" ]

    RULE_gistscript = 0
    RULE_section = 1
    RULE_gist = 2
    RULE_params = 3
    RULE_param_list = 4
    RULE_param = 5
    RULE_named_param = 6
    RULE_var = 7
    RULE_constant = 8

    ruleNames =  [ u"gistscript", u"section", u"gist", u"params", u"param_list", 
                   u"param", u"named_param", u"var", u"constant" ]

    EOF = Token.EOF
    T__0=1
    T__1=2
    T__2=3
    T__3=4
    T__4=5
    T__5=6
    T__6=7
    ID=8
    CONSTANT=9
    WS=10
    COMMENT=11
    LINE_COMMENT=12

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
            self.state = 21
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==GistScriptParser.ID:
                self.state = 18
                self.section()
                self.state = 23
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

        def var(self):
            return self.getTypedRuleContext(GistScriptParser.VarContext,0)


        def gist(self):
            return self.getTypedRuleContext(GistScriptParser.GistContext,0)


        def params(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(GistScriptParser.ParamsContext)
            else:
                return self.getTypedRuleContext(GistScriptParser.ParamsContext,i)


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
            self.state = 24
            self.var()
            self.state = 25
            self.match(GistScriptParser.T__0)
            self.state = 26
            self.gist()
            self.state = 27
            self.match(GistScriptParser.T__1)
            self.state = 31
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==GistScriptParser.ID:
                self.state = 28
                self.params()
                self.state = 33
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 34
            self.match(GistScriptParser.T__2)
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
        self.enterRule(localctx, 4, self.RULE_gist)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 36
            self.match(GistScriptParser.ID)
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

        def var(self):
            return self.getTypedRuleContext(GistScriptParser.VarContext,0)


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
        self.enterRule(localctx, 6, self.RULE_params)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 38
            self.var()
            self.state = 39
            self.match(GistScriptParser.T__3)
            self.state = 42
            token = self._input.LA(1)
            if token in [GistScriptParser.T__4]:
                self.state = 40
                self.param_list()

            elif token in [GistScriptParser.ID, GistScriptParser.CONSTANT]:
                self.state = 41
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
        self.enterRule(localctx, 8, self.RULE_param_list)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 44
            self.match(GistScriptParser.T__4)
            self.state = 48 
            self._errHandler.sync(self)
            _alt = 1
            while _alt!=2 and _alt!=ATN.INVALID_ALT_NUMBER:
                if _alt == 1:
                    self.state = 45
                    self.param()
                    self.state = 46
                    self.match(GistScriptParser.T__5)

                else:
                    raise NoViableAltException(self)
                self.state = 50 
                self._errHandler.sync(self)
                _alt = self._interp.adaptivePredict(self._input,3,self._ctx)

            self.state = 53
            _la = self._input.LA(1)
            if _la==GistScriptParser.ID or _la==GistScriptParser.CONSTANT:
                self.state = 52
                self.param()


            self.state = 55
            self.match(GistScriptParser.T__6)
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

        def named_param(self):
            return self.getTypedRuleContext(GistScriptParser.Named_paramContext,0)


        def var(self):
            return self.getTypedRuleContext(GistScriptParser.VarContext,0)


        def constant(self):
            return self.getTypedRuleContext(GistScriptParser.ConstantContext,0)


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
        self.enterRule(localctx, 10, self.RULE_param)
        try:
            self.state = 60
            la_ = self._interp.adaptivePredict(self._input,5,self._ctx)
            if la_ == 1:
                self.enterOuterAlt(localctx, 1)
                self.state = 57
                self.named_param()
                pass

            elif la_ == 2:
                self.enterOuterAlt(localctx, 2)
                self.state = 58
                self.var()
                pass

            elif la_ == 3:
                self.enterOuterAlt(localctx, 3)
                self.state = 59
                self.constant()
                pass


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

        def var(self, i=None):
            if i is None:
                return self.getTypedRuleContexts(GistScriptParser.VarContext)
            else:
                return self.getTypedRuleContext(GistScriptParser.VarContext,i)


        def constant(self):
            return self.getTypedRuleContext(GistScriptParser.ConstantContext,0)


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
        self.enterRule(localctx, 12, self.RULE_named_param)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 62
            self.var()
            self.state = 63
            self.match(GistScriptParser.T__0)
            self.state = 66
            token = self._input.LA(1)
            if token in [GistScriptParser.ID]:
                self.state = 64
                self.var()

            elif token in [GistScriptParser.CONSTANT]:
                self.state = 65
                self.constant()

            else:
                raise NoViableAltException(self)

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
        self.enterRule(localctx, 14, self.RULE_var)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 68
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
        self.enterRule(localctx, 16, self.RULE_constant)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 70
            self.match(GistScriptParser.CONSTANT)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx




