import sys
from  mapping import map

import lxml.etree as etree

from util import xslt_text, write


def pprint(root):
    print(etree.tostring(root, pretty_print=True))

if __name__ == '__main__':

    root = etree.parse(sys.argv[1])
    #pretty_print(root)
    text = xslt_text(root.getroot(),'../xslt/gist2script.xsl')
    text = text.replace(' Value=','').replace(',\n\n',',\n').replace('\n)',')')
    #text = text.replace('/Return/ReturnData/EIC/EICWorksheetPP/','').replace('/Temporary/EIC/','_')\


    text=text.replace('/Return/ReturnData/','')
    for each in map.items():
        text= text.replace(each[1],"%s(##%s##)"%(each[0],each[1]))


    print "\n\n\n",text

