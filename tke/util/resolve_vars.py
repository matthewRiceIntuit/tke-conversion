import lxml.etree as etree
from calc.models import FieldMap



def pprint(root):
    print(etree.tostring(root, pretty_print=True))


def resolve_vars(root,use_tke=False):
    locals = []
    for each in  root.xpath("//DeclList/VarDecl"):
        locals.append(str(each.attrib['val']))
    form = root.xpath('/CALC/FORMSET/FORM/@val')[0]
    section = ''#root.xpath('/CALC/Section/@val')[0]
    if use_tke:
        map={}
        for each in FieldMap.objects.all():
            map[each.tps]=each.tke


    for each in root.xpath("//ID"):
        if str(each.attrib['val']) in locals:
            each.attrib['val'] = "#"+each.attrib['val']
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


def name_temporarys(root):

    for each in  root.xpath("/Nodes/Node[starts-with(@name,'/Temporary/')]"):
        name= each.get('name','blah')

        node = root.xpath("/Nodes/Node[Gist//Value/text()='%s']" % name)
        node_name="/Temporary/Temp%s"  % (node[0].get('name').split('/')[-1])
        each.set("name",  node_name)

        for value in root.xpath("//Value[text()='%s']" % name):
            value.text = node_name





def assign_ids(root):
    section = ''#root.xpath('/CALC/Section/@val')[0]
    count=1
    for each in root.xpath("//and|//DivMul|//AddSub|//FunctionCall"):
        each.attrib['id']="%s_%s"%(section,count)
        count+=1
