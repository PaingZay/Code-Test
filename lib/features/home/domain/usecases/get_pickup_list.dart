import 'package:interview_test/features/home/domain/entities/pickup_data.dart';
import 'package:interview_test/features/home/domain/repositories/pickup_repository.dart';

class GetPickupList {
  final PickupRepository _pickupRepository;

  GetPickupList(this._pickupRepository);

  Future<PickupData?> execute(int first, int max) async {
    return await _pickupRepository.getPickupData(first, max);
  }
}
