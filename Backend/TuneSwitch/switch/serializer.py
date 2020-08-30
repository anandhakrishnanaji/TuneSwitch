from rest_framework.serializers import ModelSerializer,ValidationError
from switch.models import UserProfile

class UserProfileSerializer(ModelSerializer):
    class Meta:
        model=UserProfile
        fields=['username','password']
        extra_kwargs={
            'password':{'write_only':True}
        }
    
    def validate(self, attrs):
        if 'username' not in attrs.keys():
            raise ValidationError('username thaado')
        else:
            return super().validate(attrs)

    def create(self, validated_data):
        print(validated_data)
        user=UserProfile.objects.create_user(**validated_data)
        return user