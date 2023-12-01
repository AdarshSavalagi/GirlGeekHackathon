from http.client import NOT_FOUND
from rest_framework.views import Response, APIView
from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework.permissions import IsAuthenticated
from .serializers import *
from rest_framework import status
from django.core.exceptions import ObjectDoesNotExist
import os
import json



class DeveloperView(APIView):
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.workflow_data = self.load_workflow_data()

    def load_workflow_data(self):
        try:
            with open(os.path.join('static', 'workflow.json')) as file:
                return json.load(file)
        except FileNotFoundError:
            return {}

    def get_project_data(self):
        projects = Project.objects.all()
        serialized_projects = ProjectSerializer(projects, many=True)
        return serialized_projects.data

    def get_workflow_for_category(self, category):
        print(category)
        return self.workflow_data.get(str(category), {})

    def get_project_by_id(self, project_id):
        try:
            return Project.objects.get(id=project_id)
        except ObjectDoesNotExist:
            return None

    def update_task_progress(self, task, progress):
        if task:
            task.progress = progress
            task.save()
            return True
        return False

    def handle_get_request(self, request):
        projects_data = self.get_project_data()
        task = TaskSerializer( Task.objects.filter(dev=request.user),many=True)
        return Response({'projects': projects_data,'workflow':self.get_workflow_for_category( request.user.Category),'workflow_stats':task.data})

    def handle_post_request(self, request):
        try:
            req_type = request.data.get('type')
            if req_type == '1':
                project_id = request.data.get('pid')
                project = self.get_project_by_id(project_id)
                dev_category = request.user.Category
                progress_data = ProjectSerializer(project).data
                workflow_data = self.get_workflow_for_category(dev_category)
                return Response({'progress': progress_data, 'workflow': workflow_data})

            elif req_type == '2':
                project_id = request.data.get('pid')
                progress = request.data.get('progress', 1)
                task = Task.objects.filter(dev=request.user, project_id=project_id).first()
                if self.update_task_progress(task, progress):
                    return Response({'message': "Progress updated"}, status=status.HTTP_200_OK)
                else:
                    return Response({'message': "Task not found"}, status=status.HTTP_404_NOT_FOUND)

            return Response({'message': "Invalid request type"}, status=status.HTTP_400_BAD_REQUEST)

        except FileNotFoundError:
            return Response({'message': "Workflow file not found"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

        except Exception as e:
            return Response({'message 500': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def get(self, request):
        return self.handle_get_request(request)

    def post(self, request):
        return self.handle_post_request(request)


class AdminView(APIView):
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]

    def get_project_data(self):
        projects = Project.objects.all()
        serialized_projects = ProjectSerializer(projects, many=True)
        return serialized_projects.data
    
    def get_project_by_id(self, project_id):
        try:
            project = Project.objects.get(id=project_id)
            return project
        except Project.DoesNotExist:
            raise NOT_FOUND("Project not found")

    def get(self, request):
        projects_data = self.get_project_data()
        return Response({'projects': projects_data})
    
    def post(self, request):
        request_type = request.data.get('type')
        
        if request_type == '1':  # get project details
            project_id = request.data.get('pid', '')
            project = self.get_project_by_id(project_id)
            serialized_project = ProjectSerializer(project)
            return Response(serialized_project.data)
        
        elif request_type == '2':  # add project
            serializer = ProjectSerializer(data=request.data)
            if serializer.is_valid():
                serializer.save()
                return Response({'message': 'Project created successfully'}, status=200)
            return Response(serializer.errors, status=400)
        
        return Response({'message': 'Invalid request type'}, status=400)
