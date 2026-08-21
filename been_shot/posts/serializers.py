from rest_framework import serializers

from accounts.serializers import UserSerializer

from .models import Post


class PostSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)

    class Meta:
        model = Post
        fields = [
            "id",
            "user",
            "content",
            "photo",
            "created_at",
        ]
        read_only_fields = (
            "id",
            "created_at",
        )

    def create(self, validated_data):
        request = self.context.get("request")
        if request and request.user.is_authenticated:
            validated_data["user"] = request.user
        return super().create(validated_data)