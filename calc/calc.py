import sys

from antlr4 import *
from antlr4.InputStream import InputStream
import lxml.etree as etree
import json

from grammar.CalcParser import CalcParser
from grammar.CalcListener import CalcListener
from grammar.CalcLexer import CalcLexer
from util import pretty_print, xslt, write, xslt_text
from patterns import accumulations
from resolve_vars import resolve_vars


if __name__ == '__main__':

    if len(sys.argv) > 1:
        input_stream = FileStream(sys.argv[1])
    else:
        input_stream = InputStream(sys.stdin.readline())

    lexer = CalcLexer(input_stream)
    token_stream = CommonTokenStream(lexer)
    parser = CalcParser(token_stream)
    tree = parser.calcfile()
    lisp_tree_str = tree.toStringTree(recog=parser)
    print(lisp_tree_str)

    walker = ParseTreeWalker()

    listner = CalcListener()
    walker.walk(listner, tree)

    root = etree.XML('<?xml version="1.0" ?>'+listner.output)

    resolve_vars(root)

    accumulations(root)


    pretty_print(root)

    text = xslt_text(root,'xsl/calc2script.xsl')
    print text
    adict=eval(text.strip())
    for each in adict:
        print json.dumps(each,indent=5).strip('{}').replace('"','')


    exit()

    newroot = xslt(root,'xsl/nodes.xsl')
    xmlstr = pretty_print(newroot)

    formset=root.xpath('/CALC/FORMSET/@val')[0]
    form = root.xpath('/CALC/FORMSET/FORM/@val')[0]


    write('test/%s_%s.xml' %(formset,form),xmlstr)


    newroot = xslt(root,'xst/schema.xsl')
    xmlstr = pretty_print(newroot)
    write('test/SampleElementTypes.xml',xmlstr)

    newroot = xslt(root,'xsl/input.xsl')
    xmlstr = pretty_print(newroot)
    write('test/inputs.xml',xmlstr)

    print "\n\n\n"
    print "./TKECalcEngine -g test/%s_%s.xml -m test/SampleElementTypes.xml -i test/inputs.xml" % (formset,form)


