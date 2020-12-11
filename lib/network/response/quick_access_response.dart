class QuickAccess {
  int statusCode;
  List<QuickAccessData> data;
  String message;

  QuickAccess({this.statusCode, this.data, this.message});

  QuickAccess.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = new List<QuickAccessData>();
      json['data'].forEach((v) {
        data.add(new QuickAccessData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class QuickAccessData {
  int id;
  String name;
  String image;
  String type;
  int target;
  String locationId;

  QuickAccessData(
      {this.id,
        this.name,
        this.image,
        this.type,
        this.target,
        this.locationId});

  QuickAccessData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    type = json['type'];
    target = json['target'];
    locationId = json['locationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['type'] = this.type;
    data['target'] = this.target;
    data['locationId'] = this.locationId;
    return data;
  }
}
