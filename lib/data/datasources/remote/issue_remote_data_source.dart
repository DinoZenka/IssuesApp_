import 'package:dio/dio.dart';
import 'package:issues_app/data/models/issue_dto.dart';

abstract class IssueRemoteDataSource {
  Future<List<IssueDto>> fetchIssues();
  Future<IssueDto> getIssue(String id);
  Future<IssueDto> putIssue(String id, Map<String, dynamic> data);
}

class IssueRemoteDataSourceImpl implements IssueRemoteDataSource {
  final Dio _dio;
  static const String _baseUrl = 'https://api.example.com';

  IssueRemoteDataSourceImpl(this._dio);

  @override
  Future<List<IssueDto>> fetchIssues() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    final response = await _dio.get('$_baseUrl/issues');

    final List<dynamic> data = response.data;
    return data.map((json) => IssueDto.fromJson(json)).toList();
  }

  @override
  Future<IssueDto> getIssue(String id) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    final response = await _dio.get('$_baseUrl/issues/$id');
    return IssueDto.fromJson(response.data);
  }

  @override
  Future<IssueDto> putIssue(String id, Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    final response = await _dio.put('$_baseUrl/issues/$id', data: data);
    return IssueDto.fromJson(response.data);
  }
}
