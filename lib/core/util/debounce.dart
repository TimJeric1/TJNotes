import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debounce.g.dart';

@riverpod
Debouncer debouncer (DebouncerRef ref) {
  return Debouncer();
}

class Debouncer {
  Timer? _timer;

  Debouncer();

  void run(VoidCallback action, Duration duration) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}