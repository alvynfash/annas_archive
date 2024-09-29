// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookImpl _$$BookImplFromJson(Map<String, dynamic> json) => _$BookImpl(
      title: json['title'] as String,
      author: json['author'] as String,
      md5: json['md5'] as String,
      imgUrl: json['imgUrl'] as String,
      size: json['size'] as String,
      genre: json['genre'] as String,
      type: $enumDecode(_$GrookTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$BookImplToJson(_$BookImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'md5': instance.md5,
      'imgUrl': instance.imgUrl,
      'size': instance.size,
      'genre': instance.genre,
      'type': _$GrookTypeEnumMap[instance.type],
    };

const _$GrookTypeEnumMap = {
  GrookType.pdf: 'pdf',
  GrookType.epub: 'epub',
  GrookType.unknown: 'unknown',
};
