# Generated by Django 2.0 on 2018-06-02 04:49

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0006_auto_20180601_0227'),
    ]

    operations = [
        migrations.AddField(
            model_name='adopter',
            name='first_name',
            field=models.CharField(default='a', max_length=30),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='adopter',
            name='last_name',
            field=models.CharField(default='b', max_length=30),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='adopter',
            name='num_pets',
            field=models.SmallIntegerField(default=0),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='giver',
            name='first_name',
            field=models.CharField(default='a', max_length=30),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='giver',
            name='last_name',
            field=models.CharField(default='b', max_length=30),
            preserve_default=False,
        ),
    ]