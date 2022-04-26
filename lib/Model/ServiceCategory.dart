import 'package:franchise/Model/Service.dart';

class ServiceCategory {
  List<Service> services;
  String category_name;

  ServiceCategory(
  {required this.services, required this.category_name});

  factory ServiceCategory.fromJson(dynamic json) {
    return ServiceCategory(services: json['services'] as List<Service>, category_name: json['category_name'] as String);
  }
}
