// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueDto _$IssueDtoFromJson(Map<String, dynamic> json) => IssueDto(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  priority: json['priority'] as String,
  status: json['status'] as String,
  updatedAt: json['updatedAt'] as String,
);

Map<String, dynamic> _$IssueDtoToJson(IssueDto instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'priority': instance.priority,
  'status': instance.status,
  'updatedAt': instance.updatedAt,
};
