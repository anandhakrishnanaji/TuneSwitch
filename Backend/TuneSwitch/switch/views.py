from rest_framework.viewsets import ModelViewSet
from rest_framework.permissions import IsAuthenticatedOrReadOnly
from rest_framework.authentication import TokenAuthentication
from switch.models import UserProfile
from switch.serializer import UserProfileSerializer
from switch.permissions import UserProfilePermission

class UserProfileViewset(ModelViewSet):
    queryset=UserProfile.objects.all()
    serializer_class=UserProfileSerializer
    permission_classes=(UserProfilePermission,)
    authentication_classes=(TokenAuthentication,)