class RestaurantDetails {
  String id;
  String name;
  String url;
  Location location;
  String averageCostForTwo;
  String priceRange;
  String currency;
  String thumb;
  String featuredImage;
  String photosUrl;
  String menuUrl;
  UserRating userRating;
  String allReviewsCount;
  String photoCount;
  String phoneNumbers;
  List<Photos> photos;
  List<AllReviews> allReviews;

  RestaurantDetails(
      {this.id,
      this.name,
      this.url,
      this.location,
      this.averageCostForTwo,
      this.priceRange,
      this.currency,
      this.thumb,
      this.featuredImage,
      this.photosUrl,
      this.menuUrl,
      this.userRating,
      this.allReviewsCount,
      this.photoCount,
      this.phoneNumbers,
      this.photos,
      this.allReviews});

  RestaurantDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    averageCostForTwo = json['average_cost_for_two'];
    priceRange = json['price_range'];
    currency = json['currency'];
    thumb = json['thumb'];
    featuredImage = json['featured_image'];
    photosUrl = json['photos_url'];
    menuUrl = json['menu_url'];
    userRating = json['user_rating'] != null
        ? new UserRating.fromJson(json['user_rating'])
        : null;
    allReviewsCount = json['all_reviews_count'];
    photoCount = json['photo_count'];
    phoneNumbers = json['phone_numbers'];
    if (json['photos'] != null) {
      photos = new List<Photos>();
      json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
    if (json['all_reviews'] != null) {
      allReviews = new List<AllReviews>();
      json['all_reviews'].forEach((v) {
        allReviews.add(new AllReviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['url'] = this.url;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['average_cost_for_two'] = this.averageCostForTwo;
    data['price_range'] = this.priceRange;
    data['currency'] = this.currency;
    data['thumb'] = this.thumb;
    data['featured_image'] = this.featuredImage;
    data['photos_url'] = this.photosUrl;
    data['menu_url'] = this.menuUrl;
    if (this.userRating != null) {
      data['user_rating'] = this.userRating.toJson();
    }
    data['all_reviews_count'] = this.allReviewsCount;
    data['photo_count'] = this.photoCount;
    data['phone_numbers'] = this.phoneNumbers;
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    if (this.allReviews != null) {
      data['all_reviews'] = this.allReviews.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Location {
  String address;
  String locality;
  String city;
  String zipcode;

  Location({this.address, this.locality, this.city, this.zipcode});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    locality = json['locality'];
    city = json['city'];
    zipcode = json['zipcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['locality'] = this.locality;
    data['city'] = this.city;
    data['zipcode'] = this.zipcode;
    return data;
  }
}

class UserRating {
  String aggregateRating;
  String ratingText;
  String ratingColor;
  String votes;

  UserRating(
      {this.aggregateRating, this.ratingText, this.ratingColor, this.votes});

  UserRating.fromJson(Map<String, dynamic> json) {
    aggregateRating = json['aggregate_rating'];
    ratingText = json['rating_text'];
    ratingColor = json['rating_color'];
    votes = json['votes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aggregate_rating'] = this.aggregateRating;
    data['rating_text'] = this.ratingText;
    data['rating_color'] = this.ratingColor;
    data['votes'] = this.votes;
    return data;
  }
}

class Photos {
  String id;
  String url;
  String thumbUrl;

  Photos({this.id, this.url, this.thumbUrl});

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    thumbUrl = json['thumb_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['thumb_url'] = this.thumbUrl;
    return data;
  }
}

class AllReviews {
  String rating;
  String reviewText;
  String id;
  String ratingColor;
  String reviewTimeFriendly;
  String ratingText;
  String timestamp;
  String likes;
  User user;
  String commentsCount;

  AllReviews(
      {this.rating,
      this.reviewText,
      this.id,
      this.ratingColor,
      this.reviewTimeFriendly,
      this.ratingText,
      this.timestamp,
      this.likes,
      this.user,
      this.commentsCount});

  AllReviews.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    reviewText = json['review_text'];
    id = json['id'];
    ratingColor = json['rating_color'];
    reviewTimeFriendly = json['review_time_friendly'];
    ratingText = json['rating_text'];
    timestamp = json['timestamp'];
    likes = json['likes'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    commentsCount = json['comments_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['review_text'] = this.reviewText;
    data['id'] = this.id;
    data['rating_color'] = this.ratingColor;
    data['review_time_friendly'] = this.reviewTimeFriendly;
    data['rating_text'] = this.ratingText;
    data['timestamp'] = this.timestamp;
    data['likes'] = this.likes;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['comments_count'] = this.commentsCount;
    return data;
  }
}

class User {
  String name;
  String zomatoHandle;
  String foodieLevel;
  String foodieLevelNum;
  String foodieColor;
  String profileUrl;
  String profileDeeplink;
  String profileImage;

  User(
      {this.name,
      this.zomatoHandle,
      this.foodieLevel,
      this.foodieLevelNum,
      this.foodieColor,
      this.profileUrl,
      this.profileDeeplink,
      this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    zomatoHandle = json['zomato_handle'];
    foodieLevel = json['foodie_level'];
    foodieLevelNum = json['foodie_level_num'];
    foodieColor = json['foodie_color'];
    profileUrl = json['profile_url'];
    profileDeeplink = json['profile_deeplink'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['zomato_handle'] = this.zomatoHandle;
    data['foodie_level'] = this.foodieLevel;
    data['foodie_level_num'] = this.foodieLevelNum;
    data['foodie_color'] = this.foodieColor;
    data['profile_url'] = this.profileUrl;
    data['profile_deeplink'] = this.profileDeeplink;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
