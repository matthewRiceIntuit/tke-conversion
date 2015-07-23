
import sys
import os
import json
from antlr4 import *
from antlr4.InputStream import InputStream
from CalcLexer import CalcLexer
from CalcParser import CalcParser
from CalcListener import CalcListener
import lxml.etree as etree
from xml2json import  xml2json_ordered,elem2json
from util import pretty_print, xslt, write
from patterns import Accumulations


from StringIO import StringIO


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

    root = etree.parse('TestReturn.xml')
    pretty_print(root)
    import ipdb;ipdb.set_trace()
    newroot = xslt(root,'mef-tsi-formml.xsl')
    pretty_print(newroot)

    root = etree.XML('<?xml version="1.0" ?>'+listner.output)

    Accumulations(root)


    pretty_print(root)

    newroot = xslt(root,'nodes.xsl')
    xmlstr = pretty_print(newroot)

    formset=root.xpath('/CALC/FORMSET/@val')[0]
    form = root.xpath('/CALC/FORMSET/FORM/@val')[0]



    write('test/%s_%s.xml' %(formset,form),xmlstr)


    newroot = xslt(root,'schema.xsl')
    xmlstr = pretty_print(newroot)
    write('test/SampleElementTypes.xml',xmlstr)

    newroot = xslt(root,'input.xsl')
    xmlstr = pretty_print(newroot)
    write('test/inputs.xml',xmlstr)

    print "\n\n\n"
    print "./TKECalcEngine -g test/%s_%s.xml -m test/SampleElementTypes.xml -i test/inputs.xml" % (formset,form)


