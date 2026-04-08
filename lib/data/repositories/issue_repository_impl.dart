import 'package:dio/dio.dart';
import 'package:issues_app/data/models/issue_dto.dart';
import 'package:issues_app/domain/entities/issue.dart';
import 'package:issues_app/domain/repositories/issue_repository.dart';

class IssueRepositoryImpl implements IssueRepository {
  final Dio _dio;
  static const String _baseUrl = 'https://api.example.com';

  IssueRepositoryImpl(this._dio);

  @override
  Future<List<Issue>> getIssues({IssueStatus? status}) async {
    final response = await _dio.get('$_baseUrl/issues', queryParameters: {
      if (status != null) 'status': status.name,
    });
    
    final List<dynamic> data = response.data;
    return data.map((json) => IssueDto.fromJson(json).toEntity()).toList();
  }

  @override
  Future<Issue> getIssue(String id) async {
    final response = await _dio.get('$_baseUrl/issues/$id');
    return IssueDto.fromJson(response.data).toEntity();
  }
}
