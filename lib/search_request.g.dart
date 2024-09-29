// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchRequestImpl _$$SearchRequestImplFromJson(Map<String, dynamic> json) =>
    _$SearchRequestImpl(
      query: json['query'] as String,
      useAdvanced: json['useAdvanced'] as bool,
      author: json['author'] as String,
      epub: json['epub'] as bool,
      pdf: json['pdf'] as bool,
    );

Map<String, dynamic> _$$SearchRequestImplToJson(_$SearchRequestImpl instance) =>
    <String, dynamic>{
      'query': instance.query,
      'useAdvanced': instance.useAdvanced,
      'author': instance.author,
      'epub': instance.epub,
      'pdf': instance.pdf,
    };
