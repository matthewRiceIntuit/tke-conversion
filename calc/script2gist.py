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
from resolve_vars import resolve_vars,assign_ids


def pprint(root):
    print(etree.tostring(root, pretty_print=True))

if __name__ == '__main__':

    input_stream = FileStream(sys.argv[1])

    lexer = GistScriptLexer(input_stream)
    token_stream = CommonTokenStream(lexer)
    parser = GistScriptParser(token_stream)
    tree = parser.gistscript()
    lisp_tree_str = tree.toStringTree(recog=parser)
    print(lisp_tree_str)

    walker = ParseTreeWalker()

    listner = GistScriptListener()
    walker.walk(listner, tree)

    root = etree.XML('<?xml version="1.0" ?>'+listner.output)
    pretty_print(root)
    exit()

    root = etree.parse(sys.argv[1])
    #pretty_print(root)
    text = xslt_text(root.getroot(),'xsl/script2gist.xsl')
    text = text.replace(' Value=','').replace(',\n\n',',\n').replace('\n)',')')
    #text = text.replace('/Return/ReturnData/EIC/EICWorksheetPP/','').replace('/Temporary/EIC/','_')\

    root = etree.parse('mapping/MappingSpec_EIC.xml')
    #import ipdb;ipdb.set_trace()
    for form in root.getroot().xpath('//Context'):
        tke_form = form.attrib['xpath'].replace('[uuid_1]','').replace('[uuid_2]','')
        tps_form = form.attrib['corecopy'].replace('FDI$','')
        for field in form.xpath('Mapping'):
            tke_field = tke_form + "/"+ field.attrib['xpath'].replace('[uuid_1]','').replace('[uuid_2]','')
            tps_field  = tps_form+"."+field.attrib['corecopy']
            #print tke_field ,' : ',tps_field
            text=text.replace(tke_field ,tps_field)
        for field in form.xpath('MapValueToAddress'):
            tke_field = tke_form + "/"+ field.attrib['xpath']
            try:
                tps_field  = tps_form+"."+field.xpath('Map')[0].attrib['corecopy']+"|"+field.xpath('Map')[1].attrib['corecopy']
                #print tke_field ,' : ',tps_field
                text=text.replace(tke_field ,tps_field)
            except Exception:
                import ipdb;ipdb.set_trace()


    write('test/eic.txt',text)
    print text


