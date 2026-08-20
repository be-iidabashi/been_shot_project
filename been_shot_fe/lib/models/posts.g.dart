// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostUserImpl _$$PostUserImplFromJson(Map<String, dynamic> json) =>
    _$PostUserImpl(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$$PostUserImplToJson(_$PostUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'icon': instance.icon,
    };

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
  id: (json['id'] as num).toInt(),
  user: PostUser.fromJson(json['user'] as Map<String, dynamic>),
  content: json['content'] as String,
  photo: json['photo'] as String?,
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'content': instance.content,
      'photo': instance.photo,
      'created_at': instance.createdAt,
    };
