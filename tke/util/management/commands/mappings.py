from datetime import datetime
import logging
import subprocess
import time

from django.conf import settings
from django.contrib.contenttypes.models import ContentType
from django.core.management.base import BaseCommand
import lxml.etree as etree
from calc.models import FieldMap


def pprint(root):
    print(etree.tostring(root, pretty_print=True))

##TODO-refactor: remove this whole directory
class Command(BaseCommand):
    """
    Backs up the QA/Prod ec2 instances.

    # Todo: add arguments for instance_id, env? to enable seperate backups.
    """
    def handle(self, **options):
        namespace = "http://schemas.intuit.com/ctg/mapping"

        root = etree.parse('./util/mapping/fdiPerMappingRuntime.xml')
        for each in root.xpath('/ns:MappingRuntime/ns:MappingDefinitions/ns:Mapping',namespaces={'ns':namespace}):
            tps = each.get('tps','').replace('FDI$','').upper()
            if not FieldMap.objects.filter(tps=tps).exists():
                print tps
                field=FieldMap.objects.create(tps=tps,tke=each.get('mef'))
                field.save()
        for each in root.xpath('/ns:MappingRuntime/ns:MappingDefinitions/ns:ValueMapping',namespaces={'ns':namespace}):
            tps = each.get('tps','').replace('FDI$','').upper()
            if not FieldMap.objects.filter(tps=tps).exists():
                print tps
                field=FieldMap.objects.create(tps=tps,tke=each.get('mef'))
                field.save()
