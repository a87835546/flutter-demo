import 'package:json_annotation/json_annotation.dart';


@JsonSerializable() //注解
class Active {
  int id;
  String title;
  String url;
  String picUrl;
  String description;

  Active({required this.id, required this.title, required this.url, required this.description,required this.picUrl});

  static Active fromJson(Map<String, dynamic> json) {
    Active active = Active(
        id: json['id'],
        title: json['title'],
        url: json['url'],
        picUrl: json['picUrl'],
        description: json['description'] ?? "");
    return active;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    data['description'] = description;
    data['picUrl'] = picUrl;
    return data;
  }

  @override
  String toString() {
    return 'Active{id: $id, title: $title, url: $url, picUrl: $picUrl, description: $description}';
  }
}
