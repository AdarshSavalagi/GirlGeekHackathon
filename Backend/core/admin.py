from django.contrib import admin

from core.forms import ProjectForm
from .models import *

class adminView(admin.ModelAdmin):
    list_display=['first_name','email','Category']
    search_fields=['first_name']
    list_per_page=100
    
class projectView(admin.ModelAdmin):
    list_display=['title','get_status','deadline']
    search_fields=['first_name']
    form = ProjectForm
    list_per_page=100
    
class taskView(admin.ModelAdmin):
    list_display=['dev','project','categories','progress']
    search_fields=['dev']
    list_per_page=100

    def categories(self,obj):
        return Categories[int(obj.dev.Category)][1]
    categories.short_description = 'Category'
    
admin.site.register(Developer,adminView)
admin.site.register(Project,projectView)
admin.site.register(Task,taskView)