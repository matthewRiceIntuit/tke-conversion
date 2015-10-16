import sys
import lxml.etree as etree
import json
from django.conf import settings

from antlr4 import *
from antlr4.InputStream import InputStream
import xmlformatter
import random
import string

from grammar.GistScriptParser import GistScriptParser
from grammar.GistScriptListener import GistScriptListener
from grammar.GistScriptLexer import GistScriptLexer

from util import pretty_print, xslt, write, xslt_text
from patterns import accumulations
from resolve_vars import resolve_vars, assign_ids, name_temporarys, name_unmapped


def pprint(root):
    print(etree.tostring(root, pretty_print=True))


def write(root, filename):
    if settings.IS_LOCAL:
        with open('../../output/' + filename, 'w') as f:
            f.write(etree.tostring(root, pretty_print=True))


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
# # python script2gist.py test/testscript.txt
def script2gist(input_stream):
    print input_stream
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
    print "###### script2gist ######"
    pretty_print(newroot)

    name_temporarys(newroot)
    #name_unmapped(newroot)
    # print "###### name temps ######"
    # pretty_print(newroot)

    newroot = xslt(newroot, 'xslt/script2gist2.xsl')

    write(newroot, 'graph.xml')

    return newroot


def generate_inputs(root):
    filename = "../../output/inputs.xml"

    parser = etree.XMLParser(remove_blank_text=True)
    input_xml = etree.parse(filename, parser=parser)

    for each in root.xpath('//InputNode/@name'):
        if each.startswith('/Temporary') or each.startswith('/Constant'):
            continue
        if input_xml.xpath(each):
            continue
        parent = input_xml.xpath('/Return/ReturnData')[0]
        for tag in each.split('/')[3:]:
            if parent.xpath(tag):
                parent = parent.xpath(tag)[0]
            else:
                node = etree.Element(tag)
                parent.append(node)
                parent = node
        parent.text = (''.join(random.choice(string.digits ) for _ in range(2)))+"00"



    formatter = xmlformatter.Formatter()
    pretty = formatter.format_string(etree.tostring(input_xml))
    with open(filename, 'w') as f: f.write( pretty )
    return pretty

def generate_schema(root):

    if not root.xpath('//InputNode/@name[starts-with(.,"/Return/ReturnData/UNMAPPED")]'):
        return
    filename = 'util/mapping/ElementTypesReturn1040.xml'
    schema = etree.parse(filename)
    parent  =   schema.xpath('/Return/ReturnData/UNMAPPED')[0]
    dirty=False
    for each in root.xpath('//InputNode/@name[starts-with(.,"/Return/ReturnData/UNMAPPED")]|/Nodes/Node[starts-with(@name,"/Return/ReturnData/UNMAPPED")]/@name'):
        if schema.xpath(each):
            continue
        node = etree.SubElement(parent, each.split('/')[-1])
        node.set('baseType',"xsd:integer")
        node.set('structure',"field")
        node.set('type',"USAmountType")
        dirty=True

    if dirty:
        print "#### UPDATING SCHEMA ####"
        formatter = xmlformatter.Formatter()
        pretty = formatter.format_string(etree.tostring(schema))
        #with open(filename, 'w') as f: f.write( pretty )





if __name__ == '__main__':

    input_stream = FileStream(sys.argv[1])
    script2gist(input_stream)


