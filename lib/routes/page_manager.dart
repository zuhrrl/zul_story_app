import 'dart:async';

import 'package:flutter/material.dart';

class PageManager extends ChangeNotifier {
  late Completer<bool> _completer;
  String userName = '';

  Future<bool> waitForUploadSuccess() async {
    _completer = Completer<bool>();
    return _completer.future;
  }

  setUploadSuccess(bool value) {
    _completer.complete(value);
  }

  setUserName(String value) {
    userName = value;
  }
}
