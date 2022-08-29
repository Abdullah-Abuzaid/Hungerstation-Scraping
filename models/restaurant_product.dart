// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'restaurant_menu_category.dart';

class Product {
  int? id;
  String? name;
  int? calories;
  double? price;
  int? group_id;
  String? description;
  String? image;
  Product({
    this.id,
    this.name,
    this.calories,
    this.price,
    this.group_id,
    this.description,
    this.image,
  });

  Product copyWith({
    int? id,
    String? name,
    int? calories,
    double? price,
    int? group_id,
    String? description,
    String? image,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      calories: calories ?? this.calories,
      price: price ?? this.price,
      group_id: group_id ?? this.group_id,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'calories': calories,
      'price': price,
      'group_id': group_id,
      'description': description,
      'image': image,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      calories: map['calories'] != null ? map['calories'] as int : null,
      price: map['price'] != null ? double.tryParse(map['price']) : null,
      group_id: map['group_id'] != null ? map['group_id'] as int : null,
      description: map['description'] != null ? map['description'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, calories: $calories, price: $price, group_id: $group_id, description: $description, image: $image)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.calories == calories &&
        other.price == price &&
        other.group_id == group_id &&
        other.description == description &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        calories.hashCode ^
        price.hashCode ^
        group_id.hashCode ^
        description.hashCode ^
        image.hashCode;
  }
}
