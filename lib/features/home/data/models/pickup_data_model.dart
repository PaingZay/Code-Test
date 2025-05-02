import 'package:interview_test/features/home/data/models/pickup_item_model.dart';
import 'package:interview_test/features/home/domain/entities/pickup_data.dart';

class PickupDataModel extends PickupData {
  PickupDataModel({required super.items, required super.totalRecords});

  factory PickupDataModel.fromJson(Map<String, dynamic> json) {
    var itemsFromJson = json['items'] as List;
    List<PickupItemModel> itemList =
        itemsFromJson.map((item) => PickupItemModel.fromJson(item)).toList();

    return PickupDataModel(items: itemList, totalRecords: json['totalRecords']);
  }
}
