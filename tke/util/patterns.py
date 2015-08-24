import lxml.etree as etree


def pprint(root):
    print(etree.tostring(root, pretty_print=True))


def accumulations(root):
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
    return accumulations(root)

def difference(root):
    accumulations = root.xpath("//AddSub[@val='-']/Difference")
    if accumulations:
        last_accumulation = accumulations[-1]
        return collape_accumulation(last_accumulation, root)

    additions = root.xpath("//AddSub[@val='-']/AddSub[@val='-']")
    if additions:
        last_addition = additions[-1]
        return collape_difference(last_addition, root)


def collape_difference(elem, root):
    parent_elem = elem.getparent()
    for each in elem.getchildren():
        parent_elem.append(each)
    parent_elem.remove(elem)
    parent_elem.tag = 'Accumulate'
    parent_elem.attrib.pop('val')
    return accumulations(root)


def multiplications(root):
    accumulations = root.xpath("//DivMul[@val='*']/Accumulate")
    if accumulations:
        last_accumulation = accumulations[-1]
        return collape_multiplications(last_accumulation, root)

    additions = root.xpath("//DivMul[@val='*']/DivMul[@val='*']")
    if additions:
        last_addition = additions[-1]
        return collape_multiplications(last_addition, root)


def collape_multiplications(elem, root):
    parent_elem = elem.getparent()
    for each in elem.getchildren():
        parent_elem.append(each)
    parent_elem.remove(elem)
    parent_elem.tag = 'Multiply'
    parent_elem.attrib.pop('val')
    return accumulations(root)
