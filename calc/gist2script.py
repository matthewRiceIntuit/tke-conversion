import sys

import lxml.etree as etree

from util import xslt_text, write


def pprint(root):
    print(etree.tostring(root, pretty_print=True))

if __name__ == '__main__':
    '''
    import ipdb;ipdb.set_trace()
    root = etree.parse('mapping/mef-tsi-formml.xsl')
    for form in root.getroot().xpath('//form'):
        tke_form = form.attrib['xpath'].replace('[uuid_1]','').replace('[uuid_2]','')
        tps_form = form.attrib['corecopy'].replace('FDI$','')
        for field in form.xpath('Mapping'):
            tke_field = tke_form + "/"+ field.attrib['xpath'].replace('[uuid_1]','').replace('[uuid_2]','')
            tps_field  = tps_form+"."+field.attrib['corecopy']
            #print tke_field ,' : ',tps_field
            text=text.replace(tke_field ,tps_field)
    '''
    root = etree.parse(sys.argv[1])
    #pretty_print(root)
    text = xslt_text(root.getroot(),'xsl/gist2script.xsl')
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

