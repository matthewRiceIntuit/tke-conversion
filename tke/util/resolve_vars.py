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
    names = set()
    for each in  root.xpath("/Nodes/Node[starts-with(@name,'/Temporary/')]"):
        try:
            name= each.get('name','blah')

            node = root.xpath("/Nodes/Node[Gist//Value/text()='%s']" % name)
            node_name= _node_name="/Temporary/Temp%s"  % (node[0].get('name').split('/')[-1])
            count=1
            while node_name in names:
                count+=1
                node_name = _node_name + "_"+str(count)
            names.add(node_name)

            each.set("name",  node_name)
            for value in root.xpath("//*[text()='%s']" % name):
                value.text = node_name
            for value in root.xpath("//*[@name='%s']" % name):
                value.set('name',node_name)
        except Exception:
            pass

    for each in  root.xpath("//*[starts-with(@name,'/Temp/')]"):
        name= each.get('name','blah')
        each.set("name",  "/Temporary" + name[5:])
    for each in  root.xpath("//*[starts-with(text(),'/Temp/')]"):
        each.text =  "/Temporary" + each.text[5:]

def name_unmapped(root):
    names = set()
    for each in  root.xpath("r"):
        name = each.get('name').split('.')
        each.set("name",  '%s/%s'%(name[0],name[1]))
    for each in  root.xpath("//Value[contains(.,'.')]|//Input[contains(.,'.')]"):
        name = each.text.split('.')
        each.text = '/Return/ReturnData/UNMAPPED/%s_%s'%(name[0],name[1])
    for each in root.xpath("/Nodes/InputNode[contains(@name,'.')]"):
        name = each.get('name').split('.')
        each.set("name",  '/Return/ReturnData/UNMAPPED/%s_%s'%(name[0],name[1]))



def assign_ids(root):
    section = ''#root.xpath('/CALC/Section/@val')[0]
    count=1
    for each in root.xpath("//and|//or|//DivMul|//AddSub|//FunctionCall"):
        each.attrib['id']="%s_%s"%(section,count)
        count+=1

def clean_temps(root):
    for each in root.xpath("//*[starts-with(text(),'@/Return/ReturnData/')]"):
        name = each.text.split('/')[-1]
        each.text = '/Temp/Temp'+name
    return root
