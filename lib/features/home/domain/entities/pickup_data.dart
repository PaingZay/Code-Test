import 'package:interview_test/features/home/domain/entities/pickup_item.dart';

class PickupData {
  final List<PickupItem> items;
  final int totalRecords;

  PickupData({required this.items, required this.totalRecords});
}
