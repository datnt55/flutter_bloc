class BannerResponse {
  int statusCode;
  List<BannerData> data;
  String message;

  BannerResponse({this.statusCode, this.data, this.message});

  BannerResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = new List<BannerData>();
      json['data'].forEach((v) {
        data.add(new BannerData.fromJson(v));
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

class BannerData {
  int id;
  String name;
  String image;
  String type;
  String target;
  String locationId;
  String background;

  BannerData(
      {this.id,
        this.name,
        this.image,
        this.type,
        this.target,
        this.locationId,
        this.background});

  BannerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    type = json['type'];
    target = json['target'].toString();
    locationId = json['locationId'];
    background = json['background'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['type'] = this.type;
    data['target'] = this.target;
    data['locationId'] = this.locationId;
    data['background'] = this.background;
    return data;
  }
}
