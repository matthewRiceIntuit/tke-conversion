import sys
import json
import re
from datetime import datetime, timedelta
from django.utils import timezone
from django.utils.timezone import utc
from django.shortcuts import render
from django.http import HttpResponse
from antlr4 import InputStream

from util.calc2script import convert
from util.script2gist import script2gist
from util.external_code import external_codes


from .forms import FieldMapForm
from .models import FieldMap
from django.shortcuts import render, redirect, get_object_or_404

def main(request, context=None, template_name="main.html"):
    context = {
        'header': request.COOKIES.get('tke_header', ''),
        'tps_calc': request.COOKIES.get('tps_calc', '')
    }

    return render(request, template_name, context)


def calc2script(request, template_name="main.html"):
    header = request.POST.get('header', '')
    tps_calc = request.POST['tps_calc'].strip()
    if not bool(re.match('form ', tps_calc, re.I)):
        if not bool(re.match('section ', tps_calc, re.I)):
            tps_calc = header + "SECTION GENERIC;\nBEGIN\n" + tps_calc + "\nEND;"
        else:
            tps_calc = header + tps_calc

    stream = InputStream(tps_calc)

    gistscript = convert(stream)

    gists = script2gist(InputStream(gistscript))

    codes = external_codes(gists)

    data = {'calc2script': gistscript,
            'script2gist': gists,
            'external_codes': codes }

    response = HttpResponse(json.dumps(data, indent=1) + "\n", content_type="application/json")
    response.set_cookie('tke_header', value=header)
    response.set_cookie('tps_calc', value=request.POST['tps_calc'])
    return response


def mappings(request, template_name='mappings.html'):
    import os
    context = {
        'mappings': FieldMap.objects.all().order_by('tps'),
    }
    mapping_form = context['form'] = FieldMapForm(request.POST or None)
    if request.method == "POST":
        if mapping_form.is_valid():
            mapping_form.save()
    return render(request, template_name, context)

def bulk_mappings(request):
    mappings = request.POST.get('bulk_mappings')
    import json
    for each in json.loads(mappings):
        if not FieldMap.objects.filter(tps=each.get('tps').upper()).exists():
            field = FieldMap.objects.create(tps=each.get('tps').upper(),tke=each.get('mef'))
            field.save()
            print each
    return redirect('mappings')

