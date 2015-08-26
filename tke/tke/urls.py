from django.conf.urls import include, url
from django.contrib import admin
from django.conf import settings
from django.conf.urls.static import static
from django.contrib.staticfiles.urls import staticfiles_urlpatterns


urlpatterns = [
    url(r'^', include('calc.urls')),
    url(r'^admin/', include(admin.site.urls)),
    ]
if settings.DEBUG:
    urlpatterns += staticfiles_urlpatterns()\
