import json
import random
from channels.generic.websocket import AsyncWebsocketConsumer
from channels_presence.models import Room
from channels_presence.decorators import remove_presence
from asgiref.sync import sync_to_async

class SwitchConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        print('yo')
        if self.scope['user'].is_anonymous:
            self.reject()
        else:
            self.user=self.scope['user']
            self.user.channel_name=self.channel_name
            await sync_to_async(self.user.save)()
            self.room_name='online'
            self.room=await sync_to_async(Room.objects.add)('online',self.channel_name,self.scope['user'])
            await self.accept()
    #@remove_presence
    async def disconnect(self, code):
        self.user.songid=None
        #self.user.channel_name=None
        await sync_to_async(self.user.save)()
        await sync_to_async(Room.objects.remove)(self.room_name,self.channel_name)

    async def receive(self, text_data):
        print(text_data)
        text_data_json=json.loads(text_data)
        if ('room_name' in text_data_json.keys()) and text_data_json['room_name']!=self.room_name:


            #await sync_to_async(print)(self.user.presence__room)


            await sync_to_async(Room.objects.remove)(self.room_name,self.channel_name)

            k=self.room
            glist=await sync_to_async(self.room.get_users)()
            await sync_to_async(print)(glist)
            await sync_to_async(print)(self.room_name)

            self.room_name=text_data_json['room_name']
            self.room=await sync_to_async(Room.objects.add)(self.room_name,self.channel_name,self.scope['user'])


            glist=await sync_to_async(k.get_users)()
            await sync_to_async(print)(glist)

        elif 'songid' in text_data_json.keys():
            self.songid=text_data_json['songid']
            self.user.songid=self.songid
            await sync_to_async(self.user.save)()

        
        glist=await sync_to_async(self.room.get_users)()
        glist=await sync_to_async(glist.exclude)(pk=self.user.pk)
        len=await sync_to_async(glist.count)()


        #await sync_to_async(print)(len)


        if len:
            to=await sync_to_async(random.choice)(glist)
            suri=self.user.songid

            await self.channel_layer.send(self.channel_name,{
                'type':'chat_message',
                'message':{'song':to.songid,'user':to.username}
            })
            self.songid=to.songid
            self.user.songid=to.songid
            await sync_to_async(self.user.save)()


            await self.channel_layer.send(to.channel_name,{
                'type':'chat_message',
                'message':{'song':suri,'user':self.user.username}
            })
            to.songid=suri
            await sync_to_async(to.save)()

        else:
            print(self.channel_name)
            await self.channel_layer.send(self.channel_name,{
                'type':'chat_message',
                'message':{'error':'No Channels'}
            })

    async def chat_message(self,event):
        msg=event['message']
        await self.send(text_data=json.dumps({'message':msg}))
        

