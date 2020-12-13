class CampaignListResponse {
  int statusCode;
  CampaignData data;
  String message;

  CampaignListResponse({this.statusCode, this.data, this.message});

  CampaignListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? new CampaignData.fromJson(json['data']) : null;
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

class CampaignData {
  List<Product> items;
  int totalPages;
  int currentPage;
  int totalItems;

  CampaignData({this.items, this.totalPages, this.currentPage, this.totalItems});

  CampaignData.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Product>();
      json['items'].forEach((v) { items.add(new Product.fromJson(v)); });
    }
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
    totalItems = json['totalItems'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = this.totalPages;
    data['currentPage'] = this.currentPage;
    data['totalItems'] = this.totalItems;
    return data;
  }
}

class Product {
  int id;
  String name;
  double price;
  int stock;
  String imageUrl;
  List<Variants> variants;
  String unit;
  String origin;
  int sellerId;
  String sku;
  String sharingProductUrl;
  String locationId;

  Product({this.id, this.name, this.price, this.stock, this.imageUrl, this.variants, this.unit, this.origin, this.sellerId, this.sku, this.sharingProductUrl, this.locationId});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    stock = json['stock'];
    imageUrl = json['imageUrl'];
    if (json['variants'] != null) {
      variants = new List<Variants>();
      json['variants'].forEach((v) {
        variants.add(new Variants.fromJson(v)); }
        );
    }else
      variants = new List<Variants>();
    unit = json['unit'];
    origin = json['origin'];
    sellerId = json['sellerId'];
    sku = json['sku'];
    sharingProductUrl = json['sharingProductUrl'];
    locationId = json['locationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['imageUrl'] = this.imageUrl;
    if (this.variants != null) {
      data['variants'] = this.variants.map((v) => v.toJson()).toList();
    }
    data['unit'] = this.unit;
    data['origin'] = this.origin;
    data['sellerId'] = this.sellerId;
    data['sku'] = this.sku;
    data['sharingProductUrl'] = this.sharingProductUrl;
    data['locationId'] = this.locationId;
    return data;
  }


  String getVariantsInfo(){
    var result = "";
    if (variants.isNotEmpty) {
      for (int i = 0; i < variants.length; i++){
        result += variants[i].name;
        if (i < variants.length -1)
          result += "/ ";
      }
    }
    return result;
  }
}

class Variants {
  int id;
  String name;
  double price;
  int stock;
  List<String> imageUrls;
  String note;
  String sku;

  Variants({this.id, this.name, this.price, this.stock, this.imageUrls, this.note, this.sku});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    stock = json['stock'];
    if (json['imageUrls'] != null) {
      imageUrls = new List<String>();
      json['imageUrls'].forEach((v) { imageUrls.add(v); });
    }
    note = json['note'];
    sku = json['sku'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['stock'] = this.stock;
    if (this.imageUrls != null) {
      data['imageUrls'] = this.imageUrls;
    }
    data['note'] = this.note;
    data['sku'] = this.sku;
    return data;
  }
}