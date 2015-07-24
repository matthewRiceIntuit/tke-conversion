import lxml.etree as etree


def pprint(root):
    print(etree.tostring(root, pretty_print=True))


def resolve_vars(root):
    locals = []
    for each in  root.xpath("//DeclList/VarDecl"):
        locals.append(str(each.attrib['val']))
    form = root.xpath('/CALC/FORMSET/FORM/@val')[0]

    for each in root.xpath("//ID"):
        if str(each.attrib['val']) in locals:
            each.tag="TEMP"
            continue

        e = each.getnext()
        if None is e or e.tag != 'Sub_ID':
            each.attrib['val'] = "%s.%s" % (form,each.attrib['val'])

        else:
            each.attrib['val'] = "%s.%s" % (each.attrib['val'],e.attrib['val'])
            e.getparent().remove(e)





