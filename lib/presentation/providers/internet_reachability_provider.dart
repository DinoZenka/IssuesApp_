import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final hasInternetProvider = StreamProvider<bool>((ref) {
  final controller = StreamController<bool>();

  Future<void> emit() async {
    final ok = await InternetConnection().hasInternetAccess;
    if (!controller.isClosed) controller.add(ok);
  }

  emit();

  final sub = Connectivity().onConnectivityChanged.listen((_) => emit());

  ref.onDispose(() async {
    await sub.cancel();
    await controller.close();
  });

  return controller.stream.distinct();
});
