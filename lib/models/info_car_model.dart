import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class InfoCarModel {
  final int? id;
  final String idRegister;
  final String province;
  final String car;
  final String color;
  final String model;
  InfoCarModel({
    this.id,
    required this.idRegister,
    required this.province,
    required this.car,
    required this.color,
    required this.model,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idRegister': idRegister,
      'province': province,
      'car': car,
      'color': color,
      'model': model,
    };
  }

  factory InfoCarModel.fromMap(Map<String, dynamic> map) {
    return InfoCarModel(
      id: (map['id'] ?? 0) as int,
      idRegister: (map['idRegister'] ?? '') as String,
      province: (map['province'] ?? '') as String,
      car: (map['car'] ?? '') as String,
      color: (map['color'] ?? '') as String,
      model: (map['model'] ?? '') as String,
    );
  }

  factory InfoCarModel.fromJson(String source) => InfoCarModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
