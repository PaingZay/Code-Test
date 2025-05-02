import 'package:flutter/material.dart';

class PickupItemCell extends StatelessWidget {
  final String _trackingId;
  final String _osName;
  final String _osTownshipName;
  final String _pickupDate;
  final int _totalWays;
  final String _osPrimaryPhone;
  final int _totalRecords;

  const PickupItemCell({
    super.key,
    required String trackingId,
    required String osName,
    required String osTownshipName,
    required String pickupDate,
    required int totalWays,
    required String osPrimaryPhone,
    required int totalRecords,
  }) : _trackingId = trackingId,
       _osName = osName,
       _osTownshipName = osTownshipName,
       _pickupDate = pickupDate,
       _totalWays = totalWays,
       _osPrimaryPhone = osPrimaryPhone,
       _totalRecords = totalRecords;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _trackingId,
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(color: Colors.blue),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Text(
                _osName,
                style: Theme.of(context).textTheme.labelLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _osTownshipName,
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(fontFamily: 'NotoSansMyanmar'),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Text(
                _osPrimaryPhone,
                style: Theme.of(context).textTheme.labelLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  _pickupDate,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: Text(
                  _totalWays.toString(),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: Text(
                  _totalRecords.toString(),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
          onTap: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Selected: $_totalWays')));
          },
        ),
      ),
    );
  }
}
