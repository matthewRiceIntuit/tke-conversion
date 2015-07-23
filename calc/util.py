
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


from StringIO import StringIO

def pretty_print(node):
    xmlstr= etree.tostring(node, pretty_print = True)
    print "\n\n============================================================"
    print xmlstr
    print "============================================================\n\n"
    return xmlstr

def xslt(root,xsl):
    try:
        xslt = etree.parse(xsl)
        transform = etree.XSLT(xslt)
        dom = etree.ElementTree(root)
        newdom = transform(dom)
    except Exception, e:
        print str(e)
        print e.error_log
        print(transform.error_log)
    newxml = (etree.tostring(newdom))
    return  etree.XML(newxml)

def write(filename,xml):
    with  open(filename, 'w') as target:
        target.write(xml)


