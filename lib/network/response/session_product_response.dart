class SessionProduct {
  int statusCode;
  List<SessionData> data;
  String message;

  SessionProduct({this.statusCode, this.data, this.message});

  SessionProduct.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = new List<SessionData>();
      json['data'].forEach((v) {
        data.add(new SessionData.fromJson(v));
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

class SessionData {
  String name;
  String image;
  String layout;
  String type;
  String description;
  String target;

  SessionData(
      {this.name,
      this.image,
      this.layout,
      this.type,
      this.description,
      this.target});

  SessionData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    layout = json['layout'];
    type = json['type'];
    description = json['description'];
    target = json['target'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['layout'] = this.layout;
    data['type'] = this.type;
    data['description'] = this.description;
    data['target'] = this.target;
    return data;
  }
}
