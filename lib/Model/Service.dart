import 'dart:convert';

class Service{
  String service_name, service_description;

  Service(
      {required this.service_name, required this.service_description});

  fromJson(dynamic json) {
    return Service(service_name: (json['sub_category_name'] + json['service_name']) as String, service_description: json['service_description'] as String);
  }
}