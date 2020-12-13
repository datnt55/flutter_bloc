class ProductDetail {
  int id;
  String name;
  String description;
  double price;
  String origin;
  List<String> standards;
  List<String> tags;
  String unit;
  Category category;
  List<String> imageUrls;
  List<Attributes> attributes;
  List<Variants> variants;
  int stock;
  int sellerId;
  String sharingProductUrl;
  String locationId;

  ProductDetail({this.id, this.name, this.description, this.price, this.origin, this.standards, this.tags, this.unit, this.category, this.imageUrls, this.attributes, this.variants, this.stock, this.sellerId, this.sharingProductUrl, this.locationId});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    origin = json['origin'];
    if (json['standards'] != null) {
      standards = new List<Null>();
      json['standards'].forEach((v) { standards.add(v); });
    }
    if (json['tags'] != null) {
      tags = new List<Null>();
      json['tags'].forEach((v) { tags.add(v); });
    }
    unit = json['unit'];
    category = json['category'] != null ? new Category.fromJson(json['category']) : null;
    imageUrls = json['imageUrls'].cast<String>();
    if (json['attributes'] != null) {
      attributes = new List<Attributes>();
      json['attributes'].forEach((v) { attributes.add(new Attributes.fromJson(v)); });
    }
    if (json['variants'] != null) {
      variants = new List<Variants>();
      json['variants'].forEach((v) { variants.add(new Variants.fromJson(v)); });
    }
    stock = json['stock'];
    sellerId = json['sellerId'];
    sharingProductUrl = json['sharingProductUrl'];
    locationId = json['locationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['origin'] = this.origin;
    if (this.standards != null) {
      data['standards'] = this.standards;
    }
    if (this.tags != null) {
      data['tags'] = this.tags;
    }
    data['unit'] = this.unit;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['imageUrls'] = this.imageUrls;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    if (this.variants != null) {
      data['variants'] = this.variants.map((v) => v.toJson()).toList();
    }
    data['stock'] = this.stock;
    data['sellerId'] = this.sellerId;
    data['sharingProductUrl'] = this.sharingProductUrl;
    data['locationId'] = this.locationId;
    return data;
  }
}

class Category {
  int id;
  String name;
  String imageUrl;
  int parentId;

  Category({this.id, this.name, this.imageUrl, this.parentId});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    parentId = json['parentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['parentId'] = this.parentId;
    return data;
  }
}

class Attributes {
  int id;
  String name;
  List<String> values;

  Attributes({this.id, this.name, this.values});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    try{
      values = json['values'].cast<String>();
    }catch (e){
      values = new List<String>();
      values.add(json['value']);
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();


    data['name'] = this.name;
    data['values'] = this.values;
    return data;
  }
}

class Variants {
  int id;
  String name;
  double price;
  int stock;
  List<String> imageUrls;
  List<Attributes> attributes;
  String note;
  String sku;

  Variants({this.id, this.name, this.price, this.stock, this.imageUrls, this.attributes, this.note, this.sku});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    stock = json['stock'];
    if (json['imageUrls'] != null) {
      imageUrls = new List<String>();
      json['imageUrls'].forEach((v) { imageUrls.add(v); });
    }
    if (json['attributes'] != null) {
      attributes = new List<Attributes>();
      json['attributes'].forEach((v) { attributes.add(new Attributes.fromJson(v)); });
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
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    data['note'] = this.note;
    data['sku'] = this.sku;
    return data;
  }
}
