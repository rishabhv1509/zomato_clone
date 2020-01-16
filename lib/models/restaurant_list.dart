class RestaurantList {
  int resultsFound;
  int resultsStart;
  int resultsShown;
  List<Restaurants> restaurants;

  RestaurantList(
      {this.resultsFound,
      this.resultsStart,
      this.resultsShown,
      this.restaurants});

  RestaurantList.fromJson(Map<String, dynamic> json) {
    resultsFound = json['results_found'];
    resultsStart = json['results_start'];
    resultsShown = json['results_shown'];
    if (json['restaurants'] != null) {
      restaurants = new List<Restaurants>();
      json['restaurants'].forEach((v) {
        restaurants.add(new Restaurants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results_found'] = this.resultsFound;
    data['results_start'] = this.resultsStart;
    data['results_shown'] = this.resultsShown;
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurants {
  Restaurant restaurant;

  Restaurants({this.restaurant});

  Restaurants.fromJson(Map<String, dynamic> json) {
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant.toJson();
    }
    return data;
  }
}

class Restaurant {
  String apikey;
  String id;
  String name;
  String url;
  Location location;
  int switchToOrderMenu;
  String cuisines;
  String timings;
  int averageCostForTwo;
  String currency;
  String thumb;
  UserRating userRating;
  String photosUrl;
  String menuUrl;
  String featuredImage;
  String deeplink;
  String phoneNumbers;
  List<String> establishment;

  Restaurant(
      {this.apikey,
      this.id,
      this.name,
      this.url,
      this.location,
      this.switchToOrderMenu,
      this.cuisines,
      this.timings,
      this.averageCostForTwo,
      this.currency,
      this.thumb,
      this.userRating,
      this.photosUrl,
      this.menuUrl,
      this.featuredImage,
      this.deeplink,
      this.phoneNumbers,
      this.establishment});

  Restaurant.fromJson(Map<String, dynamic> json) {
    apikey = json['apikey'];
    id = json['id'];
    name = json['name'];
    url = json['url'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    switchToOrderMenu = json['switch_to_order_menu'];
    cuisines = json['cuisines'];
    timings = json['timings'];
    averageCostForTwo = json['average_cost_for_two'];
    currency = json['currency'];
    thumb = json['thumb'];
    userRating = json['user_rating'] != null
        ? new UserRating.fromJson(json['user_rating'])
        : null;
    photosUrl = json['photos_url'];
    menuUrl = json['menu_url'];
    featuredImage = json['featured_image'];
    deeplink = json['deeplink'];
    phoneNumbers = json['phone_numbers'];
    establishment = json['establishment'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apikey'] = this.apikey;
    data['id'] = this.id;
    data['name'] = this.name;
    data['url'] = this.url;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['switch_to_order_menu'] = this.switchToOrderMenu;
    data['cuisines'] = this.cuisines;
    data['timings'] = this.timings;
    data['average_cost_for_two'] = this.averageCostForTwo;
    data['currency'] = this.currency;
    data['thumb'] = this.thumb;
    if (this.userRating != null) {
      data['user_rating'] = this.userRating.toJson();
    }
    data['photos_url'] = this.photosUrl;
    data['menu_url'] = this.menuUrl;
    data['featured_image'] = this.featuredImage;
    data['deeplink'] = this.deeplink;
    data['phone_numbers'] = this.phoneNumbers;
    data['establishment'] = this.establishment;
    return data;
  }
}

class Location {
  String address;
  String locality;
  String city;

  Location({this.address, this.locality, this.city});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    locality = json['locality'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['locality'] = this.locality;
    data['city'] = this.city;
    return data;
  }
}

class UserRating {
  String aggregateRating;
  String ratingText;
  String ratingColor;

  UserRating({this.aggregateRating, this.ratingText, this.ratingColor});

  UserRating.fromJson(Map<String, dynamic> json) {
    aggregateRating = json['aggregate_rating'];
    ratingText = json['rating_text'];
    ratingColor = json['rating_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aggregate_rating'] = this.aggregateRating;
    data['rating_text'] = this.ratingText;
    data['rating_color'] = this.ratingColor;
    return data;
  }
}
