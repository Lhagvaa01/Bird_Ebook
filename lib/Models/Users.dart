class Users {
  String? tCUSERNAME;
  String? tCPASSWORD;
  String? tCEMAIL;

  Users({this.tCUSERNAME, this.tCPASSWORD, this.tCEMAIL});

  Users.fromJson(Map<String, dynamic> json) {
    tCUSERNAME = json['TCUSERNAME'];
    tCPASSWORD = json['TCPASSWORD'];
    tCEMAIL = json['TCEMAIL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TCUSERNAME'] = this.tCUSERNAME;
    data['TCPASSWORD'] = this.tCPASSWORD;
    data['TCEMAIL'] = this.tCEMAIL;
    return data;
  }
  Map<String, dynamic> toMap() {
    return {
      'TCUSERNAME': tCUSERNAME,
      'TCPASSWORD': tCPASSWORD,
      'TCEMAIL': tCEMAIL,
    };
  }
}