import 'package:iot/features/show%20data/domain/entity/show_data_entity.dart';

class ShowDataModel extends ShowDataEntity {
  ShowDataModel({
    super.name,
    super.value,
    super.isDigital,
    super.alertValue,
    super.alertCondition,
  });

  factory ShowDataModel.fromJson(Map<String, dynamic> map) {
    return ShowDataModel(
      name: map["name"] ?? "",
      value: map["value"] * 1.0 ?? 0.0,
      alertValue: map["alertValue"] * 1.0 ?? 0.0,
      alertCondition: map["alertCondition"] ?? "GE",
      isDigital: map["isDigital"] ?? false,
    );
  }
}
