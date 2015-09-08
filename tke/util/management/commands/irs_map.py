from datetime import datetime
import logging
import subprocess
import time

from django.conf import settings
from django.contrib.contenttypes.models import ContentType
from django.core.management.base import BaseCommand
import lxml.etree as etree
from calc.models import FieldMap
from optparse import OptionParser, make_option

from datetime import datetime
import logging
import subprocess
import time
import json

from django.conf import settings
from django.contrib.contenttypes.models import ContentType
from django.core.management.base import BaseCommand
import lxml.etree as etree
from calc.models import FieldMap
from optparse import OptionParser, make_option


def pprint(root):
    print(etree.tostring(root, pretty_print=True))

##TODO-refactor: remove this whole directory
class Command(BaseCommand):
    """
    Backs up the QA/Prod ec2 instances.

    # Todo: add arguments for instance_id, env? to enable seperate backups.
    """
    option_list = BaseCommand.option_list + (
        make_option("-i", "--id", action="store", type="string", dest="tps_form", default='F1040'),
        make_option("-f", "--file", action="store", type="string", dest="filename", default=''),
    )

    def handle(self, **options):

        with open("./util/mapping/%s" % options.get('filename') ) as f:
            content = f.read()
            print content
            content = content.replace('xsd:','').replace('xmlns=','xmlnamespace=')

        root = etree.XML(content)

        form = root.xpath('/schema/element/@name')[0]
        print form

        mappings=[]

        for each in root.xpath('/schema/complexType/sequence/element[@type="USAmountType"]'):
            line = each.xpath('.//LineNumber')
            if line:
                mappings.append({'tps':"%s.L%s" %(options.get('tps_form'),line[0].text),
                                 'mef':"/Return/ReturnData/"+form+"/"+each.get('name')})
        print json.dumps(mappings,indent=4)




