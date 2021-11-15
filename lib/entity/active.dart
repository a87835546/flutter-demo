import 'package:json_annotation/json_annotation.dart';


@JsonSerializable() //注解
class Active {
  int id;
  String title;
  String url;
  String description;

  Active({required this.id, required this.title, required this.url, required this.description});

  static Active fromJson(Map<String, dynamic> json) {
    Active active = Active(id: json['id'], title: json['title'], url: json['url'], description: json['description'] ?? "");
    return active;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['description'] = this.description;
    return data;
  }
}
