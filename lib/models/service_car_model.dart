import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServiceCarModel {
  final int? id;
  final String idInfoCar;
  final String service;
  final String start;
  final String end;
  final String status;
  ServiceCarModel({
   this.id,
    required this.idInfoCar,
    required this.service,
    required this.start,
    required this.end,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idInfoCar': idInfoCar,
      'service': service,
      'start': start,
      'end': end,
      'status': status,
    };
  }

  factory ServiceCarModel.fromMap(Map<String, dynamic> map) {
    return ServiceCarModel(
      id: (map['id'] ?? 0) as int,
      idInfoCar: (map['idInfoCar'] ?? '') as String,
      service: (map['service'] ?? '') as String,
      start: (map['start'] ?? '') as String,
      end: (map['end'] ?? '') as String,
      status: (map['status'] ?? '') as String,
    );
  }

  factory ServiceCarModel.fromJson(String source) => ServiceCarModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
