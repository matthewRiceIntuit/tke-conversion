from datetime import datetime
import logging
import subprocess
import time

from django.conf import settings
from django.contrib.contenttypes.models import ContentType
from django.core.management.base import BaseCommand

##TODO-refactor: remove this whole directory
class Command(BaseCommand):
    """
    Backs up the QA/Prod ec2 instances.

    # Todo: add arguments for instance_id, env? to enable seperate backups.
    """
    def handle(self, **options):
        from util.mapping import map
        from calc.models import FieldMap
        for each in map.items():
            if FieldMap.objects.filter(tps=each[0]).exists(): continue
            field = FieldMap.objects.create(tps=each[0].upper(),tke=each[1])
            field.save()
            print each