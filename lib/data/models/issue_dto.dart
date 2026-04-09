import 'package:json_annotation/json_annotation.dart';
import 'package:issues_app/domain/entities/issue.dart';

part 'issue_dto.g.dart';

@JsonSerializable()
class IssueDto {
  final String id;
  final String title;
  final String description;
  final String priority;
  final String status;
  final String updatedAt;

  const IssueDto({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.updatedAt,
  });

  factory IssueDto.fromJson(Map<String, dynamic> json) =>
      _$IssueDtoFromJson(json);

  Map<String, dynamic> toJson() => _$IssueDtoToJson(this);

  Issue toEntity() {
    return Issue(
      id: id,
      title: title,
      description: description,
      priority: IssuePriority.values.byName(priority.toLowerCase()),
      status: IssueStatus.values.byName(status.toLowerCase()),
      updatedAt: DateTime.parse(updatedAt),
    );
  }
}
