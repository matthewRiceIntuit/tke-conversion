import sys
import lxml.etree as etree
import json

from antlr4 import *
from antlr4.InputStream import InputStream

from grammar.GistScriptParser import GistScriptParser
from grammar.GistScriptListener import GistScriptListener
from grammar.GistScriptLexer import GistScriptLexer

from util import pretty_print, xslt, write, xslt_text
from patterns import accumulations
from resolve_vars import resolve_vars, assign_ids, name_temporarys


def pprint(root):
    print(etree.tostring(root, pretty_print=True))


def alternatives(root):
    alts = {}

    for each in root.xpath('//Alt/*'):
        name = each.getparent().getprevious().attrib['val']
        alts[name] = each.attrib['val']
        each.getparent().remove(each)

    for each in alts.items():
        for var in root.xpath("//*[@val='%s']" % each[0]):
            var.attrib['val'] = each[1]

    print alts


# # antlr4 -Dlanguage=Python2 grammar/GistScript.g4
## python script2gist.py test/testscript.txt
def script2gist(input_stream):
    lexer = GistScriptLexer(input_stream)
    token_stream = CommonTokenStream(lexer)
    parser = GistScriptParser(token_stream)
    tree = parser.gistscript()
    lisp_tree_str = tree.toStringTree(recog=parser)
    print(lisp_tree_str)

    walker = ParseTreeWalker()

    listner = GistScriptListener()
    walker.walk(listner, tree)

    root = etree.XML('<?xml version="1.0" ?>' + listner.output)
    pretty_print(root)
    alternatives(root)

    newroot = xslt(root, 'xslt/script2gist.xsl')

    name_temporarys(newroot)

    return pretty_print(newroot).replace('<!--', '').replace('-->', '')


if __name__ == '__main__':

    input_stream = FileStream(sys.argv[1])
    script2gist(input_stream)


