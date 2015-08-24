from django import forms
from django.core.exceptions import ValidationError

from .models import FieldMap


class FieldMapForm(forms.ModelForm):


    class Meta:
        model = FieldMap
        fields = ('tps', 'tke',)

    def clean_tps(self, *args, **kwargs):
        return self.cleaned_data['tps'].upper()

    def __init__(self, *args, **kwargs):

        super(FieldMapForm, self).__init__(*args, **kwargs)
        self.fields['tps'].widget.attrs.update({'placeholder': 'Enter TPS Field name to be mapped'})
        self.fields['tke'].widget.attrs.update({'placeholder': 'Enter MEF Mapping '})
