import 'dart:convert';

import 'package:html/dom.dart';
import 'package:html/parser.dart';

import '../models/restaurant.dart';
import 'package:http/http.dart' as http;

class RestaurantServices {
  //Each page in this query returns 12 restaurants from hungerstation
  //The parameters lat,lng are for location i put the destination for KFUPM
  // there is a parameter for city that i didnt explore yet

  //Furthermore reading lots of data in short periods will result in Temporary banned from accessing any data from hungerstation ( idk if there is a solution other than putting delays between calls)
  // so getAllRestaurant method will not work unfortunately

  // to use these services probably. you will need to use Pagination by using the page parameter.

  ///This function gets 12 restaurants from Hungerstation
  ///

  static Future<List<Restaurant>> getRestaurants(
      {int page = 1, double lat = 26.31550864171181, double lng = 50.12127290237811}) async {
    var headers = {
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101 Firefox/104.0',
      'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
      'Accept-Language': 'en-US,en;q=0.5',
      'Sec-Fetch-Dest': 'document',
      'Sec-Fetch-Mode': 'navigate',
      'Sec-Fetch-Site': 'none',
      'Sec-Fetch-User': '?1'
    };
    var request = await http.get(
        Uri.parse('https://hungerstation.com/sa-ar/restaurants/dhahran/dhahran?lat=${lat}&lng=${lng}&page=${page}'),
        headers: headers);

    final doc = parse(request.body);
    return _getRestaurants(doc);
  }

  ///This function parse and get the JSON data from the HTML File and transfer it to Object of type Restaurant
  static List<Restaurant> _getRestaurants(Document doc) {
    List<dynamic> restaurantData =
        (jsonDecode((doc.getElementById("__NEXT_DATA__")!.innerHtml))['props']['pageProps']['vendors']['data']);
    List<Restaurant> restaurants = restaurantData.map((e) => Restaurant.fromMap(e)).toList();
    return restaurants;
  }
  //This function will probably end up timing out u from accessing hungerstation for a short period, but maybe with more delays between request it might work

  static Future<List<Restaurant>> getAllRestaurants() async {
    List<Restaurant> allRestaurants = [];
    int numOfPages = await getNumberOfPages();
    await Future.delayed(Duration(milliseconds: 3000));
    await Future.forEach<int>(List<int>.generate(numOfPages, (index) => 1 + index), (index) async {
      final restaurantBatch = await getRestaurants(page: index);
      await Future.forEach<Restaurant>(restaurantBatch, (restaurant) async {
        await restaurant.getCategories();
        await Future.delayed(Duration(milliseconds: 6000));
      });
      allRestaurants.addAll(restaurantBatch);
      await Future.delayed(Duration(milliseconds: 6000));
    });
    final jsonData = allRestaurants
        .map(
          (e) => e.toMap(),
        )
        .toList();
    print(jsonData);
    return allRestaurants;
  }

  static Future<int> getNumberOfPages(
      {int page = 1, double lat = 26.31550864171181, double lng = 50.12127290237811}) async {
    var headers = {
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101 Firefox/104.0',
      'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
      'Accept-Language': 'en-US,en;q=0.5',
      'Sec-Fetch-Dest': 'document',
      'Sec-Fetch-Mode': 'navigate',
      'Sec-Fetch-Site': 'none',
      'Sec-Fetch-User': '?1'
    };
    var request = await http.get(
        Uri.parse('https://hungerstation.com/sa-ar/restaurants/dhahran/dhahran?lat=${lat}&lng=${lng}&page=${page}'),
        headers: headers);

    final doc = parse(request.body);
    int pages = (jsonDecode((doc.getElementById("__NEXT_DATA__")!.innerHtml))['props']['pageProps']['vendors']
        ['pagination']['total']);

    return pages;
  }
}
