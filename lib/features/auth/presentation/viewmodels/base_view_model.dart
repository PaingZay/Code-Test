import 'package:flutter/material.dart';
import 'package:interview_test/core/enum.dart' show ViewState;

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
