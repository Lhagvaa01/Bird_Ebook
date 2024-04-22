// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class MyLists {
  int? pk;
  String? tCUSERPK;
  String? tCLOCATIONSPK;
  List<int>? tCBIRDPK;
  String? tCLISTNAME;
  String? tCDATE;

  MyLists(
      {this.pk,
      this.tCUSERPK,
      this.tCLOCATIONSPK,
      this.tCBIRDPK,
      this.tCLISTNAME,
      this.tCDATE});

  MyLists.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    tCUSERPK = json['TCUSERPK'];
    tCLOCATIONSPK = json['TCLOCATIONSPK'];
    tCBIRDPK = json['TCBIRDPK'].cast<int>();
    tCLISTNAME = json['TCLISTNAME'];
    tCDATE = json['TCDATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk'] = this.pk;
    data['TCUSERPK'] = this.tCUSERPK;
    data['TCLOCATIONSPK'] = this.tCLOCATIONSPK;
    data['TCBIRDPK'] = this.tCBIRDPK;
    data['TCLISTNAME'] = this.tCLISTNAME;
    data['TCDATE'] = this.tCDATE;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'TCUSERPK': tCUSERPK,
      'TCLOCATIONSPK': tCLOCATIONSPK,
      'TCBIRDPK': tCBIRDPK,
      'TCLISTNAME': tCLISTNAME,
      'TCDATE': tCDATE,
    };
  }
}