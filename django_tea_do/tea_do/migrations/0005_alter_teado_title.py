# Generated by Django 4.0.2 on 2022-02-18 19:28

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('tea_do', '0004_alter_teado_body_alter_teado_title'),
    ]

    operations = [
        migrations.AlterField(
            model_name='teado',
            name='title',
            field=models.TextField(blank=True, null=True),
        ),
    ]