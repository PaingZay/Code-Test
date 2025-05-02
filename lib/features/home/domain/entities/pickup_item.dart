class PickupItem {
  final String trackingId;
  final String osName;
  final String pickupDate;
  final String osPrimaryPhone;
  final String osTownshipName;
  final int totalWays;

  PickupItem({
    required this.trackingId,
    required this.osName,
    required this.pickupDate,
    required this.osPrimaryPhone,
    required this.osTownshipName,
    required this.totalWays,
  });
}
