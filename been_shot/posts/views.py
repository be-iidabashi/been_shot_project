from django.db.models import BooleanField, Case, Value, When
from django.shortcuts import get_object_or_404
from rest_framework import generics, status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import Like
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
        feed_type = self.request.query_params.get("feed")
        if feed_type == "timeline":
            queryset = queryset.order_by("-created_at")
        elif feed_type == "likes":
            queryset = queryset.filter(received_likes__user=self.request.user)
            queryset = queryset.order_by("-received_likes__created_at")
        return queryset


class PostDetailView(PostQuerySetMixin, generics.RetrieveUpdateDestroyAPIView):
    permission_classes = [IsOwnerOrReadOnly]
    serializer_class = PostSerializer

    def perform_destroy(self, instance):
        instance.is_deleted = True
        instance.save()

class PostLikeView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request, pk):
        post = get_object_or_404(Post, pk=pk)
        like, created = Like.objects.get_or_create(
            user=request.user,
            post=post,
        )
        if not created:
            return Response(
                {"detail": "既にいいね済みです"},
                status=status.HTTP_400_BAD_REQUEST,
            )
        return Response(
            {"detail": "いいねしました"},
            status=status.HTTP_201_CREATED,
        )

    def delete(self, request, pk):
        post = get_object_or_404(Post, pk=pk)
        like = Like.objects.filter(user=request.user, post=post).first()
        if not like:
            return Response(
                {"detail": "まだいいねしていません"},
                status=status.HTTP_400_BAD_REQUEST,
            )
        like.delete()
        return Response(
            {"detail": "いいねを取り消しました"},
            status=status.HTTP_200_OK,
        )