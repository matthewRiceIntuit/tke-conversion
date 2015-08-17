import lxml.etree as etree
from mapping import map



def pprint(root):
    print(etree.tostring(root, pretty_print=True))


def resolve_vars(root,use_tke=False):
    locals = []
    for each in  root.xpath("//DeclList/VarDecl"):
        locals.append(str(each.attrib['val']))
    form = root.xpath('/CALC/FORMSET/FORM/@val')[0]
    section = ''#root.xpath('/CALC/Section/@val')[0]

    for each in root.xpath("//ID"):
        if str(each.attrib['val']) in locals:
            each.attrib['val'] = "@"+section+'/'+each.attrib['val']
            continue

        e = each.getnext()
        if None is e or e.tag != 'Sub_ID':
            id= str("%s.%s" % (form,each.attrib['val']) ).upper()
            if use_tke:
                each.attrib['val'] = map.get(id,id)
            else:
                each.attrib['val'] = id

        else:
            id= str("%s.%s" % (each.attrib['val'],e.attrib['val'])).upper()
            if use_tke:
                each.attrib['val'] = map.get(id,id)
            else:
                each.attrib['val'] = id
            e.getparent().remove(e)






def assign_ids(root):
    section = ''#root.xpath('/CALC/Section/@val')[0]
    count=1
    for each in root.xpath("//and|//DivMul|//AddSub|//FunctionCall"):
        each.attrib['id']="%s_%s"%(section,count)
        count+=1
