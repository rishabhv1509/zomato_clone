import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:zomato_clone/models/restaurant_details_model.dart';
import 'package:zomato_clone/services/api_calls.dart';

class RestaurantDetailsScreenModel extends ChangeNotifier {
  Random random = new Random();
  Map<String, String> item = {};
  List<Map<String, String>> itemList = [];
  List<int> itemQuantity = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  int total = 0;
  int quantity = 0;
  int totalQuantity = 0;
  generateList() {
    for (var i = 1; i < 11; i++) {
      int randomNumber = 1 + random.nextInt(10);
      item = {
        'item': 'Item$i',
        'price': 'Rs ${randomNumber * 75}',
        'image': 'assets/item$i'
      };
      itemList.add(item);
    }
    // print('itemList***************>$itemList');
    notifyListeners();
  }

  increment(int index, String price) {
    quantity = itemQuantity[index];
    quantity++;
    itemQuantity[index] = quantity;
    total = total + (int.parse(price.substring(3)));
    totalQuantity = totalQuantity + 1;

    notifyListeners();
  }

  decrement(int index, String price) {
    quantity = itemQuantity[index];
    if (quantity > 0) {
      quantity--;
      total = total - (int.parse(price.substring(3)));
      totalQuantity = totalQuantity - 1;
    } else {
      quantity = 0;
      total = total;
      totalQuantity = totalQuantity;
    }

    itemQuantity[index] = quantity;
    notifyListeners();
  }

  RestaurantDetailsModel details;
  ApiCalls apiCalls = ApiCalls();
  getRestaurantDetails(int id) async {
    Response response = await apiCalls.getRestaurantDetails(id);
    details = RestaurantDetailsModel.fromJson(json.decode(response.body));
    notifyListeners();
  }
}
