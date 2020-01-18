class TrendingRestaurantList {
  List<Collections> collections;

  TrendingRestaurantList({this.collections});

  TrendingRestaurantList.fromJson(Map<String, dynamic> json) {
    if (json['collections'] != null) {
      collections = new List<Collections>();
      json['collections'].forEach((v) {
        collections.add(new Collections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.collections != null) {
      data['collections'] = this.collections.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Collections {
  Collection collection;

  Collections({this.collection});

  Collections.fromJson(Map<String, dynamic> json) {
    collection = json['collection'] != null
        ? new Collection.fromJson(json['collection'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.collection != null) {
      data['collection'] = this.collection.toJson();
    }
    return data;
  }
}

class Collection {
  int collectionId;
  int resCount;
  String imageUrl;
  String url;
  String title;
  String description;
  String shareUrl;

  Collection(
      {this.collectionId,
      this.resCount,
      this.imageUrl,
      this.url,
      this.title,
      this.description,
      this.shareUrl});

  Collection.fromJson(Map<String, dynamic> json) {
    collectionId = json['collection_id'];
    resCount = json['res_count'];
    imageUrl = json['image_url'];
    url = json['url'];
    title = json['title'];
    description = json['description'];
    shareUrl = json['share_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collection_id'] = this.collectionId;
    data['res_count'] = this.resCount;
    data['image_url'] = this.imageUrl;
    data['url'] = this.url;
    data['title'] = this.title;
    data['description'] = this.description;
    data['share_url'] = this.shareUrl;
    return data;
  }
}
