// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:collection/collection.dart';

import 'restaurant_menu_category.dart';
import 'restaurant_product.dart';

class Restaurant {
  int id;
  int chain_id;
  List<String> kitchens;
  String logo;
  String cover_photo;
  String chain_name;
  String chain_type;
  String average_rating;
  int rate_count;
  String distance;
  String page_url;
  List<MenuCategory>? menuCategories;
  Restaurant({
    this.menuCategories,
    required this.page_url,
    required this.id,
    required this.chain_id,
    required this.kitchens,
    required this.logo,
    required this.cover_photo,
    required this.chain_name,
    required this.chain_type,
    required this.average_rating,
    required this.rate_count,
    required this.distance,
  });

  Restaurant copyWith({
    MenuCategory? menuCategory,
    String? page_url,
    int? id,
    int? chainId,
    List<String>? kitchens,
    String? logo,
    String? cover_photo,
    String? chain_name,
    String? chain_type,
    String? average_rating,
    int? rate_count,
    String? distance,
  }) {
    return Restaurant(
      menuCategories: menuCategories ?? this.menuCategories,
      page_url: page_url ?? this.page_url,
      id: id ?? this.id,
      chain_id: chainId ?? this.chain_id,
      kitchens: kitchens ?? this.kitchens,
      logo: logo ?? this.logo,
      cover_photo: cover_photo ?? this.cover_photo,
      chain_name: chain_name ?? this.chain_name,
      chain_type: chain_type ?? this.chain_type,
      average_rating: average_rating ?? this.average_rating,
      rate_count: rate_count ?? this.rate_count,
      distance: distance ?? this.distance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "menuCategories": menuCategories != null ? menuCategories?.map((e) => e.toMap()).toList().toString() : null,
      'page_url': page_url,
      'id': id,
      'chainId': chain_id,
      'kitchens': kitchens.toString(),
      'logo': logo,
      'cover_photo': cover_photo,
      'chain_name': chain_name,
      'chain_type': chain_type,
      'average_rating': average_rating,
      'rate_count': rate_count,
      'distance': distance,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      page_url:
          "https://hungerstation.com/sa-ar/restaurant/dhahran/dhahran/${map['id']}?lat=26.31550864171181&lng=50.12127290237811",
      id: map['id'] as int,
      chain_id: map['chain_id'] as int,
      kitchens: List<String>.from((map['kitchens'])),
      logo: map['logo'] as String,
      cover_photo: map['cover_photo'] as String,
      chain_name: map['chain_name'] as String,
      chain_type: map['chain_type'] as String,
      average_rating: map['average_rating'] as String,
      rate_count: map['rate_count'] as int,
      distance: map['distance']['value'] as String,
    );
  }

  Future<List<MenuCategory>> getCategories() async {
    final htmlPage = parse((await http.get(Uri.parse(page_url))).body);
    List<dynamic> categoryData =
        await (jsonDecode((htmlPage.getElementById("__NEXT_DATA__")!.innerHtml))['props']['pageProps']['vendorMenu']);
    final categories = categoryData.map((e) => MenuCategory.fromMap(e as Map<String, dynamic>)).toList();
    menuCategories = categories.toList();
    return categories.toList();
  }

  String toJson() => json.encode(toMap());

  factory Restaurant.fromJson(String source) => Restaurant.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Restaurant(id: $id, chainId: $chain_id, kitchens: $kitchens, logo: $logo, cover_photo: $cover_photo, chain_name: $chain_name, chain_type: $chain_type, average_rating: $average_rating, rate_count: $rate_count, distance: $distance, page_url: $page_url)';
  }

  @override
  bool operator ==(covariant Restaurant other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.chain_id == chain_id &&
        listEquals(other.kitchens, kitchens) &&
        other.logo == logo &&
        other.cover_photo == cover_photo &&
        other.chain_name == chain_name &&
        other.chain_type == chain_type &&
        other.average_rating == average_rating &&
        other.rate_count == rate_count &&
        other.distance == distance;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        chain_id.hashCode ^
        kitchens.hashCode ^
        logo.hashCode ^
        cover_photo.hashCode ^
        chain_name.hashCode ^
        chain_type.hashCode ^
        average_rating.hashCode ^
        rate_count.hashCode ^
        distance.hashCode;
  }
}
