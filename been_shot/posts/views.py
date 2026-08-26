from django.db.models import BooleanField, Case, Value, When
from rest_framework import generics
from rest_framework.permissions import IsAuthenticated

from posts.models import Post
from posts.permissions import IsOwnerOrReadOnly
from posts.serializers import PostSerializer

class PostQuerySetMixin:
    def get_queryset(self):
        return (
            Post.objects.filter(is_deleted=False)
            .annotate(
                created_by_me=Case(
                    When(user=self.request.user, then=Value(True)),
                    default=Value(False),
                    output_field=BooleanField(),
                ),
            )
        )

class PostListView(PostQuerySetMixin, generics.ListCreateAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = PostSerializer

    def get_queryset(self):
        queryset = super().get_queryset()
        return queryset.order_by("-created_at")


class PostDetailView(PostQuerySetMixin, generics.RetrieveUpdateDestroyAPIView):
    permission_classes = [IsOwnerOrReadOnly]
    serializer_class = PostSerializer

    def perform_destroy(self, instance):
        instance.is_deleted = True
        instance.save()