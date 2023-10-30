'''
    apps module
'''
from django.apps import AppConfig


class HomeConfig(AppConfig):
    ''' Class '''
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.home'
