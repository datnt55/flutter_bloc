class SellerDetail {
  int statusCode;
  Data data;
  String message;

  SellerDetail({this.statusCode, this.data, this.message});

  SellerDetail.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int id;
  String name;
  String logo;
  String type;
  String phoneNumber;
  String description;
  String headQuarter;

  Data(
      {this.id,
        this.name,
        this.logo,
        this.type,
        this.phoneNumber,
        this.description,
        this.headQuarter});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    type = json['type'];
    phoneNumber = json['phoneNumber'];
    description = json['description'];
    headQuarter = json['headQuarter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['type'] = this.type;
    data['phoneNumber'] = this.phoneNumber;
    data['description'] = this.description;
    data['headQuarter'] = this.headQuarter;
    return data;
  }
}