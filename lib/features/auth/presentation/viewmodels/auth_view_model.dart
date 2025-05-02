import 'package:flutter/foundation.dart';
import 'package:interview_test/core/enum.dart';
import 'package:interview_test/features/auth/domain/entities/user_session.dart';
import 'package:interview_test/features/auth/domain/usecases/login.dart';
import 'package:interview_test/features/auth/domain/usecases/refresh.dart'
    show Refresh;
import 'package:interview_test/features/auth/domain/usecases/logout.dart';
import 'package:interview_test/features/auth/presentation/viewmodels/base_view_model.dart';

class AuthViewModel extends BaseViewModel {
  AuthViewModel(this._login, this._refresh, this._logout);

  final Login _login;
  final Refresh _refresh;
  final Logout _logout;

  bool _acceptTermsAndConditions = false;
  String? _errorMessage;
  UserSession? _userSession;

  bool get acceptTermsAndConditions => _acceptTermsAndConditions;
  String? get errorMessage => _errorMessage;
  UserSession? get userSession => _userSession;

  void setAcceptTermsAndConditions(bool value) {
    _acceptTermsAndConditions = value;
    notifyListeners();
  }

  Future<void> login({required String id, required String password}) async {
    setState(ViewState.busy);
    _errorMessage = null;
    try {
      final userSession = await _login.execute(id, password);
      _userSession = userSession;
      if (kDebugMode) {
        print("Access Token ${_userSession?.accessToken}");
      }
    } catch (e) {
      _errorMessage = 'An error occurred: ${e.toString()}';
    } finally {
      setState(ViewState.idle);
      notifyListeners();
    }
  }

  Future<void> refreshToken() async {
    setState(ViewState.busy);
    _errorMessage = null;
    try {
      if (_userSession == null) {
        throw Exception('User session is null');
      }
      final userSession = await _refresh.execute();
      _userSession = userSession;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'An error occurred: ${e.toString()}';
    } finally {
      setState(ViewState.idle);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    setState(ViewState.busy);
    _errorMessage = null;
    try {
      if (_userSession == null) {
        throw Exception('User session is null');
      }
      await _logout.execute();
      _userSession = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'An error occurred: ${e.toString()}';
    } finally {
      setState(ViewState.idle);
      notifyListeners();
    }
  }
}
