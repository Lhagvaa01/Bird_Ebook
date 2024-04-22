// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class BirdDatas {
  int? pk;
  String? tCBIRDFAMILYPK;
  String? tCBIRDNAME;
  String? tCLOCATIONSPK;
  String? tCSEASONSPK;
  String? tCHABITATPK;
  String? tCBODYSHAPEPK;
  String? tCBIRDSIZEPK;
  String? tCPLUMAGECOLOURPK;
  String? tCPLUMAGEMARKSPK;
  String? tCLIFETIME;
  String? tCINFO;
  String? tCIMAGES;
  String? tCPROFILEIMAGES;
  String? tCLOCATIONIMG;
  String? tCVOICES;
  bool? isSaved;

  BirdDatas(
      {this.pk,
      this.tCBIRDFAMILYPK,
      this.tCBIRDNAME,
      this.tCLOCATIONSPK,
      this.tCSEASONSPK,
      this.tCHABITATPK,
      this.tCBODYSHAPEPK,
      this.tCBIRDSIZEPK,
      this.tCPLUMAGECOLOURPK,
      this.tCPLUMAGEMARKSPK,
      this.tCLIFETIME,
      this.tCINFO,
      this.tCIMAGES,
      this.tCPROFILEIMAGES,
      this.tCLOCATIONIMG,
      this.tCVOICES,
      this.isSaved});

  BirdDatas.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    tCBIRDFAMILYPK = json['TCBIRDFAMILYPK'];
    tCBIRDNAME = json['TCBIRDNAME'];
    tCLOCATIONSPK = json['TCLOCATIONSPK'];
    tCSEASONSPK = json['TCSEASONSPK'];
    tCHABITATPK = json['TCHABITATPK'];
    tCBODYSHAPEPK = json['TCBODYSHAPEPK'];
    tCBIRDSIZEPK = json['TCBIRDSIZEPK'];
    tCPLUMAGECOLOURPK = json['TCPLUMAGECOLOURPK'];
    tCPLUMAGEMARKSPK = json['TCPLUMAGEMARKSPK'];
    tCLIFETIME = json['TCLIFETIME'];
    tCINFO = json['TCINFO'];
    tCIMAGES = json['TCIMAGES'];
    tCPROFILEIMAGES = json['TCPROFILEIMAGES'];
    tCLOCATIONIMG = json['TCLOCATIONIMG'];
    tCVOICES = json['TCVOICES'];
    isSaved = this.isSaved;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk'] = this.pk;
    data['TCBIRDFAMILYPK'] = this.tCBIRDFAMILYPK;
    data['TCBIRDNAME'] = this.tCBIRDNAME;
    data['TCLOCATIONSPK'] = this.tCLOCATIONSPK;
    data['TCSEASONSPK'] = this.tCSEASONSPK;
    data['TCHABITATPK'] = this.tCHABITATPK;
    data['TCBODYSHAPEPK'] = this.tCBODYSHAPEPK;
    data['TCBIRDSIZEPK'] = this.tCBIRDSIZEPK;
    data['TCPLUMAGECOLOURPK'] = this.tCPLUMAGECOLOURPK;
    data['TCPLUMAGEMARKSPK'] = this.tCPLUMAGEMARKSPK;
    data['TCLIFETIME'] = this.tCLIFETIME;
    data['TCINFO'] = this.tCINFO;
    data['TCIMAGES'] = this.tCIMAGES;
    data['TCPROFILEIMAGES'] = this.tCPROFILEIMAGES;
    data['TCLOCATIONIMG'] = this.tCLOCATIONIMG;
    data['TCVOICES'] = this.tCVOICES;
    return data;
  }

  toList() {}
}
