from django.urls import path,include
from rest_framework.routers import DefaultRouter
from switch.views import UserProfileViewset
from rest_framework.authtoken.views import obtain_auth_token

router=DefaultRouter()
router.register('userprofile',UserProfileViewset)


urlpatterns = [
    path('',include(router.urls)),
    path('login/',obtain_auth_token)
]
