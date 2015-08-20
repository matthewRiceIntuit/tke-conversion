import json
from datetime import datetime, timedelta
from django.utils import timezone
from django.utils.timezone import utc
from django.shortcuts import render
from django.http import HttpResponse

def index(request):
    return HttpResponse("Hello, world. You're at the polls index.")

def main(request,  context=None, template_name="main.html"):

    return render(request, template_name, context)