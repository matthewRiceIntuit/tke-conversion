# Generated from java-escape by ANTLR 4.5
from antlr4 import *

class obj(object):

    def __init__(self,value,parent):
        self.value=value
        self.parent=parent
        self.children=[]

INDENT=3
# This class defines a complete listener for a parse tree produced by GistScriptParser.
class GistScriptListener(ParseTreeListener):


    def __init__(self):
        self.root = obj('root',None)
        self.current = self.root
        self.indent=0
        self.output =""

    def enter(self,name,value=None):
        self.indent+=INDENT
        self.output += '<%s %s>' % (name,'' if not value else 'val="%s"' % value)
        child=obj(name,self.current)
        self.current.children.append(child)
        self.current = child

    def close(self,name,value=None):
        self.output +=  '<%s %s/>' % (name,'' if not value else 'val="%s"' % value)
        child=obj(name,self.current)
        self.current.children.append(child)

    def exit(self):
        self.output +=  '</%s>' % self.current.value
        self.indent-=INDENT
        if self.current:
            self.current = self.current.parent

    # Enter a parse tree produced by GistScriptParser#gistscript.
    def enterGistscript(self, ctx):
        self.enter('Gistscript')

    # Exit a parse tree produced by GistScriptParser#gistscript.
    def exitGistscript(self, ctx):
        self.exit()


    # Enter a parse tree produced by GistScriptParser#section.
    def enterSection(self, ctx):
        self.enter('Section')

    # Exit a parse tree produced by GistScriptParser#section.
    def exitSection(self, ctx):
        self.exit()


    # Enter a parse tree produced by GistScriptParser#gist.
    def enterGist(self, ctx):
        self.enter('Gist',ctx.ID().getText())

    # Exit a parse tree produced by GistScriptParser#gist.
    def exitGist(self, ctx):
        self.exit()


    # Enter a parse tree produced by GistScriptParser#params.
    def enterParams(self, ctx):
        self.enter('Params')

    # Exit a parse tree produced by GistScriptParser#params.
    def exitParams(self, ctx):
        self.exit()


    # Enter a parse tree produced by GistScriptParser#param_list.
    def enterParam_list(self, ctx):
        self.enter('Param_list')

    # Exit a parse tree produced by GistScriptParser#param_list.
    def exitParam_list(self, ctx):
        self.exit()


    # Enter a parse tree produced by GistScriptParser#param.
    def enterParam(self, ctx):
        self.enter('Param')

    # Exit a parse tree produced by GistScriptParser#param.
    def exitParam(self, ctx):
        self.exit()


    # Enter a parse tree produced by GistScriptParser#named_param.
    def enterNamed_param(self, ctx):
        self.enter('Named_param')

    # Exit a parse tree produced by GistScriptParser#named_param.
    def exitNamed_param(self, ctx):
        self.exit()


    # Enter a parse tree produced by GistScriptParser#var.
    def enterVar(self, ctx):
        self.enter('Var',ctx.ID().getText())

    # Exit a parse tree produced by GistScriptParser#var.
    def exitVar(self, ctx):
        self.exit()

    # Enter a parse tree produced by GistScriptParser#var.
    def enterName(self, ctx):
        self.enter('Name',ctx.ID().getText())

    # Exit a parse tree produced by GistScriptParser#var.
    def exitName(self, ctx):
        self.exit()

    # Enter a parse tree produced by GistScriptParser#constant.
    def enterConstant(self, ctx):
        self.enter('Var',ctx.CONSTANT().getText())

    # Exit a parse tree produced by GistScriptParser#constant.
    def exitConstant(self, ctx):
        self.exit()

    # Enter a parse tree produced by GistScriptParser#constant.
    def enterTmp(self, ctx):
        self.enter('Tmp',ctx.ID().getText())

    # Exit a parse tree produced by GistScriptParser#constant.
    def exitTmp(self, ctx):
        self.exit()

    # Enter a parse tree produced by GistScriptParser#constant.
    def enterAlt(self, ctx):
        self.enter('Alt')

    # Exit a parse tree produced by GistScriptParser#constant.
    def exitAlt(self, ctx):
        self.exit()
