import 'package:issues_app/data/datasources/remote/issue_remote_data_source.dart';
import 'package:issues_app/data/models/issue_dto.dart';
import 'package:issues_app/domain/entities/issue.dart';

class IssueRemoteDataSourceMockImpl implements IssueRemoteDataSource {
  static final List<Issue> _remoteIssues = <Issue>[
    Issue(
      id: '1',
      title: 'Enhance Search Functionality',
      description:
          'Nulla volutpat est a lectus tempor, nec malesuada nisi fermentum. Aenean orci dolor, condimentum vitae semper non, eleifend ac ex. Maecenas turpis dui, maximus et pellentesque eu, sollicitudin porttitor neque. Duis a neque tristique, dictum libero consequat, blandit nibh. Aenean interdum, turpis et auctor consectetur, eros urna fringilla diam, ac efficitur dui massa vel ex. Nulla viverra eros felis, id varius metus molestie ut. Etiam ut enim purus. \n Donec placerat, mauris vitae maximus convallis, metus velit blandit dolor, in ultricies augue eros non ex. Sed ut ante et magna vulputate lobortis. Ut fringilla ac enim at suscipit. Quisque quis orci nec ex elementum aliquet. In maximus urna sit amet laoreet sollicitudin. Nullam justo urna, cursus eget nisl euismod, elementum viverra sem. Mauris a turpis nisi. Integer congue ullamcorper metus ut faucibus.',
      priority: IssuePriority.high,
      status: IssueStatus.open,
      updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Issue(
      id: '2',
      title: 'Fix Login Bug',
      description:
          'Users are experiencing intermittent failures when trying to log in via OAuth. \n Etiam quis urna scelerisque, sagittis lacus vel, congue mauris. Nulla consequat leo nec leo dapibus rhoncus. Sed maximus, magna in finibus scelerisque, est ex lacinia enim, eget interdum dui eros quis nulla. Nulla mattis purus sed ipsum tempus, in pharetra nisi laoreet. In enim ante, luctus sit amet facilisis id, congue at mi. Etiam ut elementum diam. Phasellus blandit sapien non fringilla dictum. Praesent nec tortor purus. Praesent vulputate magna vel neque fermentum consequat.',
      priority: IssuePriority.high,
      status: IssueStatus.closed,
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Issue(
      id: '3',
      title: 'Update API Documentation',
      description:
          'Ensure all new endpoints are documented with clear examples and response formats. \n Nulla volutpat est a lectus tempor, nec malesuada nisi fermentum. Aenean orci dolor, condimentum vitae semper non, eleifend ac ex. Maecenas turpis dui, maximus et pellentesque eu, sollicitudin porttitor neque. Duis a neque tristique, dictum libero consequat, blandit nibh. Aenean interdum, turpis et auctor consectetur, eros urna fringilla diam, ac efficitur dui massa vel ex. Nulla viverra eros felis, id varius metus molestie ut. Etiam ut enim purus.',
      priority: IssuePriority.medium,
      status: IssueStatus.open,
      updatedAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    Issue(
      id: '4',
      title: 'UI Refactoring',
      description:
          'Clean up the CSS and move common components to a shared library. \n Nulla commodo orci leo, non pulvinar ligula congue non. Aliquam vehicula lorem pharetra dolor iaculis, at pretium eros placerat. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Etiam vitae ipsum tellus. Donec eget auctor leo. Aenean nunc metus, malesuada et massa id, tempus volutpat massa. Nam a ipsum ut mi faucibus mattis. Mauris bibendum tempus imperdiet. Nunc nec massa et ipsum rhoncus tristique in at diam. Nulla ultricies lorem urna, vel elementum est ultrices eget. Donec aliquam, lectus vel mattis euismod, elit orci scelerisque tellus, sed consequat lacus lorem ac tellus. Etiam vestibulum quam et turpis volutpat vehicula.',
      priority: IssuePriority.low,
      status: IssueStatus.closed,
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Issue(
      id: '5',
      title: 'Add Unit Tests for Auth Flow',
      description:
          'Increase test coverage for the authentication service to 90%. \n Sed vitae nunc massa. Sed maximus neque vel tortor mollis, id fringilla elit gravida. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec sit amet erat turpis. Praesent sit amet arcu quis felis fringilla imperdiet at eu est. Duis dolor turpis, suscipit cursus ornare nec, placerat id nisl. Pellentesque ornare justo felis, sit amet iaculis massa viverra sed. Praesent non porttitor ante. Suspendisse potenti. Nullam convallis placerat fringilla. Nullam sed nisl nec est ornare euismod ac a mi. In nec velit sed erat interdum sodales. Etiam at sem mi. Ut consectetur, justo rhoncus dignissim tincidunt, sapien justo blandit elit, vitae congue lectus mi eu sem. Pellentesque tempor ex metus, sit amet iaculis felis cursus in.',
      priority: IssuePriority.medium,
      status: IssueStatus.open,
      updatedAt: DateTime.now().subtract(const Duration(minutes: 45)),
    ),
    Issue(
      id: '6',
      title: 'Bottomsheet Modal does not appear',
      description:
          'Increase test coverage for the authentication service to 90%. \n Etiam quis urna scelerisque, sagittis lacus vel, congue mauris. Nulla consequat leo nec leo dapibus rhoncus. Sed maximus, magna in finibus scelerisque, est ex lacinia enim, eget interdum dui eros quis nulla. Nulla mattis purus sed ipsum tempus, in pharetra nisi laoreet. In enim ante, luctus sit amet facilisis id, congue at mi. Etiam ut elementum diam. Phasellus blandit sapien non fringilla dictum. Praesent nec tortor purus. Praesent vulputate magna vel neque fermentum consequat.',
      priority: IssuePriority.high,
      status: IssueStatus.open,
      updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),
    Issue(
      id: '7',
      title: 'Payment modal wrong color',
      description:
          'Change background color of payment button \n Donec placerat, mauris vitae maximus convallis, metus velit blandit dolor, in ultricies augue eros non ex. Sed ut ante et magna vulputate lobortis. Ut fringilla ac enim at suscipit. Quisque quis orci nec ex elementum aliquet. In maximus urna sit amet laoreet sollicitudin. Nullam justo urna, cursus eget nisl euismod, elementum viverra sem. Mauris a turpis nisi. Integer congue ullamcorper metus ut faucibus.',
      priority: IssuePriority.low,
      status: IssueStatus.closed,
      updatedAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
    Issue(
      id: '8',
      title: 'Some API handlers returns 500',
      description:
          'Investigate the problem \n Etiam vitae ipsum tellus. Donec eget auctor leo. Aenean nunc metus, malesuada et massa id, tempus volutpat massa. Nam a ipsum ut mi faucibus mattis. Mauris bibendum tempus imperdiet. Nunc nec massa et ipsum rhoncus tristique in at diam. Nulla ultricies lorem urna, vel elementum est ultrices eget. Donec aliquam, lectus vel mattis euismod, elit orci scelerisque tellus, sed consequat lacus lorem ac tellus. Etiam vestibulum quam et turpis volutpat vehicula.',
      priority: IssuePriority.medium,
      status: IssueStatus.open,
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Issue(
      id: '9',
      title: 'Support agent assistant integration error',
      description:
          'Agent doesnt appear in new app version \n Nulla commodo orci leo, non pulvinar ligula congue non. Aliquam vehicula lorem pharetra dolor iaculis, at pretium eros placerat. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Etiam vitae ipsum tellus. ',
      priority: IssuePriority.high,
      status: IssueStatus.closed,
      updatedAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
    Issue(
      id: '10',
      title: 'Animation is not working',
      description:
          'Fix animation on user profile screen \n Curabitur mollis enim nec velit feugiat, at dictum ex congue. Phasellus efficitur orci quis tellus tincidunt, in consectetur dolor blandit. Nullam dapibus ante in urna rhoncus, ac sagittis est cursus. Aliquam blandit odio sit amet magna egestas ornare. Pellentesque nec leo sem. Phasellus turpis lorem, lacinia eu ex at, gravida maximus nulla. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
      priority: IssuePriority.low,
      status: IssueStatus.open,
      updatedAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
    Issue(
      id: '11',
      title: 'Products discount not applies for specific regions',
      description:
          'Apply discount for all regions \n Donec cursus accumsan ligula, sit amet porttitor justo dignissim eget. Duis quis ullamcorper massa. Donec hendrerit elit id dui luctus, non accumsan dui luctus. Suspendisse ultricies quis neque vel semper. Nulla facilisi. Integer auctor nunc tortor, ac fringilla metus volutpat nec. Mauris eget dolor sed dolor malesuada egestas ac id dui. Sed libero odio, malesuada id purus ut, convallis tempus mi. Pellentesque aliquet enim malesuada volutpat semper. Sed eget neque ut nisi bibendum tempus.',
      priority: IssuePriority.medium,
      status: IssueStatus.open,
      updatedAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
  ];

  @override
  Future<List<IssueDto>> fetchIssues() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return _remoteIssues.map(_toDto).toList();
  }

  @override
  Future<IssueDto> getIssue(String id) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return _toDto(_remoteIssues.firstWhere((issue) => issue.id == id));
  }

  @override
  Future<IssueDto> patchIssue(String id, Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    final index = _remoteIssues.indexWhere((issue) => issue.id == id);
    if (index == -1) {
      throw Exception('Issue with id $id not found');
    }

    final current = _remoteIssues[index];
    final updated = current.copyWith(
      priority: _parsePriority(data['priority']) ?? current.priority,
      status: _parseStatus(data['status']) ?? current.status,
      updatedAt: DateTime.now(),
    );
    _remoteIssues[index] = updated;

    return _toDto(updated);
  }

  static IssueDto _toDto(Issue issue) {
    return IssueDto(
      id: issue.id,
      title: issue.title,
      description: issue.description,
      priority: issue.priority.name,
      status: issue.status.name,
      updatedAt: issue.updatedAt.toIso8601String(),
    );
  }

  static IssuePriority? _parsePriority(Object? value) {
    if (value is IssuePriority) return value;
    if (value is String && value.isNotEmpty) {
      return IssuePriority.values.byName(value.toLowerCase());
    }
    return null;
  }

  static IssueStatus? _parseStatus(Object? value) {
    if (value is IssueStatus) return value;
    if (value is String && value.isNotEmpty) {
      return IssueStatus.values.byName(value.toLowerCase());
    }
    return null;
  }
}
