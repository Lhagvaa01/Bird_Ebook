// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals, file_names

class UserIcons {
  int? id;
  String? image;

  UserIcons({this.id, this.image});

  UserIcons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}
