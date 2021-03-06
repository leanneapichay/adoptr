# Generated by Django 2.0 on 2018-06-02 22:10

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('dogs', '0003_dog_age_range'),
    ]

    operations = [
        migrations.AddField(
            model_name='dog',
            name='hypoallergenic',
            field=models.BooleanField(default=False),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='dog',
            name='owner',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='dog',
            name='size',
            field=models.SmallIntegerField(default=1),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='dog',
            name='active',
            field=models.BooleanField(),
        ),
        migrations.AlterField(
            model_name='dog',
            name='trained',
            field=models.BooleanField(),
        ),
    ]
