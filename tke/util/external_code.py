import sys
import lxml.etree as etree

from calc.models import FieldMap


# # python calc.py tps_clc/nontaxablecombsatpay.clc

def find(map,value):
    for key, val in map.items():
        if value.endswith(val):
            return key
    return "##NONE##"

def external_codes(xml):

    root = etree.fromstring(xml)
    map={}
    for each in FieldMap.objects.all():
        map[each.tps]=each.tke


    inputs = {}
    outputs = {}
    text = "ExternalCodeReads(\n"
    for each in root.xpath("/Nodes/Node/Inputs/Input/text()"):
        inputs[each] = find(map,each)
    for tke,tps in inputs.items():
        text +='\t%s, //%s\n' %(tps,tke)
    text += ');\n\n'

    text += 'RunExternalCode("Calc", "");\n\n'

    text += 'ExternalCodeWrites(\n'
    for each in root.xpath("/Nodes/Node/@name"):
        if each.startswith('/Temporary/'):
            continue
        outputs[each] = find(map,each)
    for tke,tps in outputs.items():
        text +='\t%s, // %s\n' %(tps,tke)
    text += ');\n\n'

    return text




