import '../../domain/entities/link.dart';

class LinkModel extends Link {
  int id;
  String fonte;
  String url;

  LinkModel({this.id, this.fonte, this.url})
      : super(
          id: id,
          fonte: fonte,
          url: url,
        );

  LinkModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fonte = json['fonte'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fonte'] = this.fonte;
    data['url'] = this.url;
    return data;
  }
}
