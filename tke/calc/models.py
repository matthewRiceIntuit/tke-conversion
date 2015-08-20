from django.db import models
from jsonfield import JSONField

class Requests(models.Model):
    data = JSONField(blank=True, default="", null=False,)
    created_on = models.DateTimeField(auto_now_add=True)