import sys
import lxml.etree as etree
import json

from antlr4 import *
from antlr4.InputStream import InputStream

from grammar.CalcParser import CalcParser
from grammar.CalcListener import CalcListener
from grammar.CalcLexer import CalcLexer

from util import pretty_print, xslt, write, xslt_text
from patterns import accumulations
from resolve_vars import resolve_vars,assign_ids


if __name__ == '__main__':

    input_stream = FileStream(sys.argv[1])

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

    resolve_vars(root,use_tke=True)
    assign_ids(root)

    accumulations(root)


    pretty_print(root)

    text = xslt_text(root,'xsl/calc2script.xsl')
    print text
    print '\n**********************************************\n'
    adict=eval(text.strip())

    for each in adict:
        print json.dumps(each,indent=5).strip('{}').replace('"','').replace("(: {","(").rstrip('}\n').replace("_Blank","Blank") , ')'



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


