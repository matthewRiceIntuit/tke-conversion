import sys
import os
import json
from antlr4 import *
from antlr4.InputStream import InputStream
from CalcLexer import CalcLexer
from CalcParser import CalcParser
from CalcListener import CalcListener
import lxml.etree as etree
from xml2json import xml2json_ordered, elem2json
from util import pretty_print, xslt, write


def pprint(root):
    print(etree.tostring(root, pretty_print=True))


def Accumulations(root):
    accumulations = root.xpath("//AddSub[@val='+']/Accumulate")
    if accumulations:
        last_accumulation = accumulations[-1]
        return collape_accumulation(last_accumulation, root)

    additions = root.xpath("//AddSub[@val='+']/AddSub[@val='+']")
    if additions:
        last_addition = additions[-1]
        return collape_accumulation(last_addition, root)


def collape_accumulation(elem, root):
    parent_elem = elem.getparent()
    for each in elem.getchildren():
        parent_elem.append(each)
    parent_elem.remove(elem)
    parent_elem.tag = 'Accumulate'
    parent_elem.attrib.pop('val')
    return Accumulations(root)
