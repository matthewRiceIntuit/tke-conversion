import sys
import lxml.etree as etree
import json

from antlr4 import *
from antlr4.InputStream import InputStream

from grammar.CalcParser import CalcParser
from grammar.CalcListener import CalcListener
from grammar.CalcLexer import CalcLexer

from util import pretty_print, xslt, write, xslt_text
from patterns import accumulations, multiplications,difference
from resolve_vars import resolve_vars, assign_ids


# # python calc.py tps_clc/nontaxablecombsatpay.clc

def convert(input_stream):

    lexer = CalcLexer(input_stream)
    token_stream = CommonTokenStream(lexer)
    parser = CalcParser(token_stream)
    tree = parser.calcfile()
    lisp_tree_str = tree.toStringTree(recog=parser)


    walker = ParseTreeWalker()

    listner = CalcListener()
    walker.walk(listner, tree)

    root = etree.XML('<?xml version="1.0" ?>' + listner.output)

    resolve_vars(root, use_tke= '-tps' not in sys.argv)
    assign_ids(root)

    accumulations(root)
    difference(root)
    multiplications(root)


    pretty_print(root)

    section = root.xpath('/CALC/Section/@val')[0]

    root = xslt(root, 'xslt/calc2script.xsl')
    pretty_print(root)

    root = xslt(root, 'xslt/calc2script2.xsl')
    pretty_print(root)

    text = xslt_text(root, 'xslt/calc2script3.xsl')
    return text
    print text

    write('script/%s.txt' % section, text)
    print '\n\n\n####################\npython script2gist.py script/%s.txt' % section



if __name__ == '__main__':

    input_stream = FileStream(sys.argv[1])

    _debug = '-d' in sys.argv

    if '-f' in sys.argv or _debug:
        with open(sys.argv[1]) as f: print f.read()
        print "\n\n--------------------------------------------\n\n"

    convert(input_stream)

