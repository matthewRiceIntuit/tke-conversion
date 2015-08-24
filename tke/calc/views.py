import sys
import json
import re
from datetime import datetime, timedelta
from django.utils import timezone
from django.utils.timezone import utc
from django.shortcuts import render
from django.http import HttpResponse
from util.calc2script import convert
from util.script2gist import script2gist
from antlr4 import InputStream
from .forms import FieldMapForm
import tempfile

from django.views.generic import ListView
from .models import FieldMap


def main(request, context=None, template_name="main.html"):
    context = {
        'header': request.COOKIES.get('tke_header', ''),
        'tps_calc': request.COOKIES.get('tps_calc', '')
    }

    return render(request, template_name, context)


def calc2script(request, template_name="main.html"):

    header = request.POST.get('header', '')
    tps_calc = request.POST['tps_calc']
    if not bool(re.match('form ', tps_calc, re.I)):
        if not bool(re.match('section ', tps_calc, re.I)):
            tps_calc = header + "SECTION GENERIC; BEGIN" + tps_calc + "END;"
        else:
            tps_calc = header + tps_calc

    stream = InputStream(tps_calc)

    gistscript = convert(stream)

    gists = script2gist(InputStream(gistscript))

    data = {'calc2script': gistscript,
            'script2gist': gists}

    response = HttpResponse(json.dumps(data, indent=1) + "\n", content_type="application/json")
    response.set_cookie('tke_header', value=header)
    response.set_cookie('tps_calc', value=request.POST['tps_calc'])
    return response


def mappings(request, template_name='mappings.html'):
    context = {
        'mappings': FieldMap.objects.all().order_by('tps'),
    }
    mapping_form = context['form'] = FieldMapForm(request.POST or None)
    if request.method == "POST":
        if mapping_form.is_valid():
            mapping_form.save()
    return render(request, template_name, context)

