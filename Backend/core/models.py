from collections.abc import Iterable
from django.db import models
from django.contrib.auth.models import AbstractUser
import requests
from django.core.mail import send_mail
from django.contrib.auth.hashers import make_password


username = 'NITKHackathon'
access_token = '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'


Categories = [
    (0, 'admin'),
    (1, 'Frontend Dev'),
    (2, 'Content Designer'),
    (3, 'DBMS Engineer'),
    (4, 'Backend Developer'),
    (5, 'Security Developer'),
    (6, 'Quality Analysis'),
    (7, 'UI/UX designer'),
]


class Developer(AbstractUser):
    Category = models.IntegerField( choices=Categories,blank=True,default=0)

    def __str__(self):
        return self.first_name
    def save(self, *args, **kwargs):
        if not self.pk:
            self.password=make_password(self.password)
        super().save(*args, **kwargs)



class Project(models.Model):
    title = models.CharField(max_length=150)
    supporting_urls = models.URLField(max_length=150)
    description = models.TextField()
    purpose = models.TextField()
    git_repo = models.URLField(max_length=100,editable=False,blank=True)
    deadline = models.CharField(max_length=150)

    def save(self, *args, **kwargs):
        if not self.pk:
            # url = f'https://api.github.com/user/repos'
            # headers = {
            #     'Authorization': f'token {access_token}',
            #     'Accept': 'application/vnd.github.v3+json'
            # }
            # payload = {
            #     'name': self.title.replace(" ", ""),
            #     'description': self.description,
            #     'private': False
            # }
            # response = requests.post(url, headers=headers, json=payload)
            # if response.status_code == 201:
            #     self.git_repo = f'https://github.com/NITKHackathon/{self.title.replace(" ", "") }.git'
            users_emails = [user.email for user in Developer.objects.all()]
            send_mail(
                'New Project Arrival',
                f'A new project has arrived at our company: "{self.title}".\n\nDescription: \n{self.description}\n\nPurpose: {self.purpose}',
                'i92677397@gmail.com',
                users_emails,
                fail_silently=False,
            )

        super().save(*args, **kwargs)

        developers = Developer.objects.all()
        for dev in developers:
            if dev.Category != 0:
                obj = Task(dev=dev,project=self)
                obj.save()


    def get_status(self):
        tasks = Task.objects.filter(project=self)
        sum_progress = 0
        for task in tasks:
            sum_progress += task.progress
        return sum_progress / len(tasks) if len(tasks) > 0 else 0

    def __str__(self) -> str:
        return self.title


class Task(models.Model):
    dev = models.ForeignKey(Developer, on_delete=models.CASCADE)
    project = models.ForeignKey(Project, on_delete=models.CASCADE)
    progress = models.IntegerField(default=0)
