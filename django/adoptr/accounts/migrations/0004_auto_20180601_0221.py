# Generated by Django 2.0 on 2018-06-01 02:21

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0003_auto_20180601_0219'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='user',
            name='zip_code',
        ),
        migrations.AddField(
            model_name='adopter',
            name='zip_code',
            field=models.SmallIntegerField(default=0),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='giver',
            name='zip_code',
            field=models.SmallIntegerField(default=0),
            preserve_default=False,
        ),
    ]
