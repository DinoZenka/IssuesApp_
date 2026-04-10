import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_snackbar_provider.g.dart';

class AppSnackbarEvent {
  final String id;
  final String message;

  const AppSnackbarEvent({required this.id, required this.message});
}

@riverpod
class AppSnackbar extends _$AppSnackbar {
  @override
  List<AppSnackbarEvent> build() => const [];

  void showMessage(String message) {
    state = [
      ...state,
      AppSnackbarEvent(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        message: message,
      ),
    ];
  }

  void remove(String id) {
    state = state.where((event) => event.id != id).toList();
  }
}
