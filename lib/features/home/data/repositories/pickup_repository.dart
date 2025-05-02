import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:interview_test/features/home/data/datasources/pickup_datasouce.dart';
import 'package:interview_test/features/home/domain/entities/pickup_data.dart';
import 'package:interview_test/features/home/domain/repositories/pickup_repository.dart';

class PickupRepositoryImpl implements PickupRepository {
  PickupRepositoryImpl({required this.dataSource, required this.storage});

  final PickupDataSource dataSource;
  final FlutterSecureStorage storage;

  @override
  Future<PickupData?> getPickupData(int first, int max) async {
    try {
      String? accessToken = await storage.read(key: 'access_token');

      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      return await dataSource.getPickupData(
        first: first,
        max: max,
        accessToken: accessToken,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching pickup data: $e');
      }
      throw Exception('Failed to fetch pickup data: $e');
    }
  }
}
