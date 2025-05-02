import 'package:interview_test/features/home/domain/entities/pickup_data.dart';

abstract class PickupRepository {
  Future<PickupData?> getPickupData(int first, int max);
}
