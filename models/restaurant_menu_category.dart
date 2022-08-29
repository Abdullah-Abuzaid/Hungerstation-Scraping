// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

import 'restaurant_product.dart';

class MenuCategory {
  int? id;
  String? name;
  int? branch_id;
  List<Product>? items;
  MenuCategory({
    this.id,
    this.name,
    this.branch_id,
    this.items,
  });

  MenuCategory copyWith({
    int? id,
    String? name,
    int? branch_id,
    List<Product>? items,
  }) {
    return MenuCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      branch_id: branch_id ?? this.branch_id,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'branch_id': branch_id,
      'items': items != null ? items!.map((e) => e.toMap()).toList().toString() : null,
    };
  }

  factory MenuCategory.fromMap(Map<String, dynamic> map) {
    return MenuCategory(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      branch_id: map['branch_id'] != null ? map['branch_id'] as int : null,
      items: map['items'] != null ? ((map['items'] as List<dynamic>).map((e) => Product.fromMap(e)).toList()) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuCategory.fromJson(String source) => MenuCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MenuCategory(id: $id, name: $name, branch_id: $branch_id, items: $items)';
  }

  @override
  bool operator ==(covariant MenuCategory other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id && other.name == name && other.branch_id == branch_id && listEquals(other.items, items);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ branch_id.hashCode ^ items.hashCode;
  }
}
