# Generated by Django 4.0.2 on 2022-02-17 15:47

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('tea_do', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='teado',
            name='body',
            field=models.CharField(max_length=100, null=True),
        ),
        migrations.AlterField(
            model_name='teado',
            name='title',
            field=models.CharField(max_length=100, null=True),
        ),
    ]
