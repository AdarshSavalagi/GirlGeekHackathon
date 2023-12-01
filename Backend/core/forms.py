from django import forms
from ckeditor.widgets import CKEditorWidget
from .models import Project

class ProjectForm(forms.ModelForm):
    class Meta:
        model = Project
        fields = ['title', 'supporting_urls', 'description', 'purpose', 'deadline']
        widgets = {
            'description': CKEditorWidget(),
            'purpose': CKEditorWidget(),
        }