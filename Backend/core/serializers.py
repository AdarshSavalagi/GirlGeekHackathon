from rest_framework import serializers
from .models import *

class DeveloperSerializer(serializers.ModelSerializer):
    class Meta:
        model=Developer
        fields=['first_name','Category']

class ProjectSerializer(serializers.ModelSerializer):
    class Meta:
        model=Project
        fields=['id','title','supporting_urls','description','purpose','git_repo','get_status','deadline']

class TaskSerializer(serializers.ModelSerializer):
    class Meta:
        model=Task
        fields=['dev','project','progress']