abstract class AppConfig {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://api.example.com',
  );

  static const bool remoteDatasourceMock = bool.fromEnvironment(
    'REMOTE_DATASOURCE_MOCK',
    defaultValue: false,
  );
}
