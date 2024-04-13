// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class Users {
  int? id;
  String? tCUSERNAME;
  String? tCPASSWORD;
  String? tCEMAIL;
  int? tCUSERICON;

  Users(
      {this.id,
      this.tCUSERNAME,
      this.tCPASSWORD,
      this.tCEMAIL,
      this.tCUSERICON});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tCUSERNAME = json['TCUSERNAME'];
    tCPASSWORD = json['TCPASSWORD'];
    tCEMAIL = json['TCEMAIL'];
    tCUSERICON = json['TCUSERICON'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['TCUSERNAME'] = this.tCUSERNAME;
    data['TCPASSWORD'] = this.tCPASSWORD;
    data['TCEMAIL'] = this.tCEMAIL;
    data['TCUSERICON'] = this.tCUSERICON;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'TCUSERNAME': tCUSERNAME,
      'TCPASSWORD': tCPASSWORD,
      'TCEMAIL': tCEMAIL,
      'TCUSERICON': tCUSERICON,
    };
  }
}
