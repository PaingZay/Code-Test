import 'package:interview_test/features/home/domain/entities/pickup_item.dart';

class PickupItemModel extends PickupItem {
  PickupItemModel({
    required super.trackingId,
    required super.osName,
    required super.pickupDate,
    required super.osPrimaryPhone,
    required super.osTownshipName,
    required super.totalWays,
  });

  factory PickupItemModel.fromJson(Map<String, dynamic> json) {
    return PickupItemModel(
      trackingId: json['trackingId'],
      osName: json['osName'],
      pickupDate: json['pickupDate'],
      osPrimaryPhone: json['osPrimaryPhone'],
      osTownshipName: json['osTownshipName'],
      totalWays: json['totalWays'],
    );
  }
}
