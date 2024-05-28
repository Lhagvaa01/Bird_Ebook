// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class Birdfamilys {
  int? pk;
  String? tCFAMILYNAME;
  String? tCFAMILYIMG;
  int? birdCount;

  Birdfamilys({this.tCFAMILYNAME, this.tCFAMILYIMG, this.birdCount});

  Birdfamilys.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    tCFAMILYNAME = json['TCFAMILYNAME'];
    tCFAMILYIMG = json['TCFAMILYIMG'];
    birdCount = json['bird_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk'] = this.pk;
    data['TCFAMILYNAME'] = this.tCFAMILYNAME;
    data['TCFAMILYIMG'] = this.tCFAMILYIMG;
    data['bird_count'] = this.birdCount;
    return data;
  }
}
