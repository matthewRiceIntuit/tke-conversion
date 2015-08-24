from django.db import models
from jsonfield import JSONField


class Requests(models.Model):
    data = JSONField(blank=True, default="", null=False, )
    created_on = models.DateTimeField(auto_now_add=True)


class FieldMap(models.Model):
    tps = models.CharField(max_length=50)
    tke = models.CharField(max_length=200)

    def __unicode__(self):
        return "%s => %s" % (self.tps,self.tke)
