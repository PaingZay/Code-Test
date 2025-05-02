import 'package:interview_test/core/enum.dart';
import 'package:interview_test/features/auth/domain/entities/user_session.dart';
import 'package:interview_test/features/auth/domain/usecases/logout.dart';
import 'package:interview_test/features/auth/domain/usecases/refresh.dart';
import 'package:interview_test/features/auth/presentation/viewmodels/base_view_model.dart';
import 'package:interview_test/features/home/domain/entities/pickup_item.dart';
import 'package:interview_test/features/home/domain/usecases/get_pickup_list.dart';

class PickupViewModel extends BaseViewModel {
  PickupViewModel(this._getPickupList, this._refresh, this._logout);

  final GetPickupList _getPickupList;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  List<PickupItem>? pickupItems;
  int? totalRecord;

  final int _max = 10;

  UserSession? _userSession;
  UserSession? get userSession => _userSession;

  final Refresh _refresh;
  final Logout _logout;

  Future<void> getPickupData({int page = 0}) async {
    setState(ViewState.busy);
    await Future.delayed(Duration(seconds: 2));
    _errorMessage = null;
    try {
      final pickupData = await _getPickupList.execute(page, _max);

      if (pickupData != null) {
        pickupItems = pickupData.items;
        totalRecord = pickupData.totalRecords;
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

  Future<bool> logout() async {
    setState(ViewState.busy);
    _errorMessage = null;
    try {
      final result = await _logout.execute();

      if (result) {
        _userSession = null;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      _errorMessage = 'An error occurred: ${e.toString()}';
      return false;
    } finally {
      setState(ViewState.idle);
      notifyListeners();
    }
  }
}
