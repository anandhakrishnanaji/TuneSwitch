from django.urls import path
from channels.routing import ProtocolTypeRouter,URLRouter
from switch.token_auth import TokenAuthMiddlewareStack
import switch.routing

application=ProtocolTypeRouter({'websocket':TokenAuthMiddlewareStack(URLRouter(switch.routing.websocket_urlpatterns))})