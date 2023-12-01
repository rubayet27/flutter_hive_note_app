import 'package:hive/hive.dart';

part 'data_model.g.dart';

@HiveType(typeId: 1)
class DataModel {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String? description;

  DataModel({required this.title, this.description});

  factory DataModel.fromMap(Map<dynamic, String> json) => DataModel(
      title: json['title'] ?? '', 
      description: json['description'] ?? ''
      );

  Map<String, dynamic> toMap() {
    return {'title': title, 'description': description};
  }
}
