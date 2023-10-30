'''
    Views 
'''
from django.shortcuts import render
#from django.http import HttpResponse
# Create your views here.

def home(request):
    ''' home function '''
    return render(request,'frontend/index.html')
