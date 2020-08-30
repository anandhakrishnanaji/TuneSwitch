from django.contrib import admin
from switch.models import UserProfile
# from channels_presence.models import Presence
from switch.models import Room
# Register your models here.

admin.site.register(UserProfile)
admin.site.register(Room)
# admin.site.register(Presence)