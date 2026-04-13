import 'package:flutter_test/flutter_test.dart';

import 'data/repositories/issue_repository_impl_test.dart' as repository_test;
import 'presentation/providers/issues_provider_test.dart' as provider_test;
import 'presentation/screens/issues_screen_test.dart' as issues_screen_test;
import 'presentation/screens/issue_details_screen_test.dart' as details_screen_test;

void main() {
  group('Repository Tests', () {
    repository_test.main();
  });

  group('Provider Tests', () {
    provider_test.main();
  });

  group('Widget Tests - Issues Screen', () {
    issues_screen_test.main();
  });

  group('Widget Tests - Issue Details Screen', () {
    details_screen_test.main();
  });
}
