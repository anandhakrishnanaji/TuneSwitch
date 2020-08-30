from django.db import models
from django.contrib.auth.models import AbstractBaseUser,BaseUserManager,PermissionsMixin


class RoomManager(models.Manager):
    def add(self,room_name,user):
        room,cre=self.get_or_create(room_name=room_name)
        room.users.add(user)
        room.save()
        return room
    
    def remove(self,room_name,user):
        room=self.get(room_name=room_name)
        room.users.remove(user)
        room.save()



class Room(models.Model):
    room_name=models.CharField(max_length=20,unique=True,blank=False)

    objects=RoomManager()

    def __str__(self):
        return self.room_name

    def get_users(self):
        return self.users.all()


class UserProfileManager(BaseUserManager):
    def create_user(self,*args, **kwargs):
        if 'username' in kwargs.keys():
            user=self.model(username=kwargs['username'])
            user.set_password(kwargs['password'])
            user.save(using=self._db)
            return user
        else:
            return ValueError('Username field is mandatory')

    def create_superuser(self,*args, **kwargs):
        user=self.create_user(**kwargs)
        user.is_superuser=True
        user.is_staff=True
        user.save(using=self._db)
        return user



class UserProfile(AbstractBaseUser,PermissionsMixin):
    room=models.ForeignKey(Room,on_delete=models.CASCADE,related_name='users',null=True)
    username=models.CharField(max_length=50,unique=True)
    is_staff=models.BooleanField(default=False)
    channel_name=models.CharField(max_length=100,null=True)
    songid=models.CharField(max_length=100,null=True)

    USERNAME_FIELD='username'

    objects=UserProfileManager()

    def __str__(self):
        return self.username



    