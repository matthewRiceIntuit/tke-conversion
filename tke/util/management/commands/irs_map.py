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
            content = content.replace('xsd:','').replace('xmlns=','xmlnamespace=')

        root = etree.XML(content)

        form = root.xpath('/schema/element/@name')[0]

        mappings=[]

        for each in root.xpath('/schema/complexType/sequence/element[@type="USAmountType"]'):
            line = each.xpath('.//LineNumber')
            if line:
                mappings.append({'tps':("%s.L%s" %(options.get('tps_form'),line[0].text)).upper(),
                                 'mef':"/Return/ReturnData/"+form+"/"+each.get('name')})
        print json.dumps(mappings,indent=4)

        print '''
<?xml version="1.0" encoding="UTF-8"?>
    <NameDefinitions xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:noNamespaceSchemaLocation="../Documents/Calcs/FriendlyNames.xsd">
'''

        for each in root.xpath('/schema/complexType/sequence/element[@type="USAmountType" or @type="IntegerType"]'):
            mef = "/Return/ReturnData/"+form+"/"+each.get('name')

            try:
                text = each.xpath('annotation/documentation/Description/text()')[0].strip(" Amount")
            except Exception:
                    text = each.xpath('annotation/documentation/text()')[0].strip("This is the ")

            print '''
     <NameDefinition>
         <ID>{0}</ID>
         <Name>{1}</Name>
        <Phrases>
            <Standard><Text>the </Text><Value/><Text> in {2}</Text></Standard>
            <Blank><Text>your $0 of {2}</Text></Blank>
        </Phrases>
        <Questions>
            <Standard><Text>How did you calculate </Text><Value/><Text> in {2}?</Text></Standard>
            <Blank><Text>Why don't I have any {2}?</Text></Blank>
        </Questions>
     </NameDefinition>
     '''.format(mef,text,text.lower())


        for each in root.xpath('/schema/complexType/sequence/element[@type="BooleanType"]'):
            mef = "/Return/ReturnData/"+form+"/"+each.get('name')
            try:
                text = each.xpath('annotation/documentation/Description/text()')[0].strip(" Indicator")
            except Exception:
                text="UNKNOWN"

            print '''
    <NameDefinition>
        <ID>{0}</ID>
        <Name>{1}</Name>
        <BooleanPhrases>
            <True><Text>you have {2}</Text></True>
            <False><Text>you don't have {2}</Text></False>
            <Blank><Text>we don't know if you have {2}</Text></Blank>
        </BooleanPhrases>
        <BooleanQuestions>
            <True><Text>Why does having {2} disqualify me?</Text></True>
            <False><Text>Why doesn't this apply to me?</Text></False>
            <Blank><Text>Why don't you know if this applies to me?</Text></Blank>
        </BooleanQuestions>
    </NameDefinition>
     '''.format(mef,text,text.lower())
        print "</NameDefinitions>"







