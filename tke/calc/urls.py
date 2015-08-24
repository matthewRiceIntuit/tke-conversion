from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.main, name='main'),
    url(r'^calc/', views.calc2script, name='calc2script'),
    url(r'^mappings/$', views.mappings, name='mappings'),
    ]