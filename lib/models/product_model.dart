import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
class Product{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double price;
  @HiveField(3)
  final String photo;
  @HiveField(4)
  final double discount;
  @HiveField(5)
  final String detail;
  @HiveField(6)
  final bool is_hot_product;
  @HiveField(7)
  final bool is_new_arrival;
  @HiveField(8)
  final int category_id;
  @HiveField(9)
  final int user_id;
  @HiveField(10)
  final DateTime created_at;
  @HiveField(11)
  final DateTime updated_at;

  Product(this.id, this.name, this.price, this.photo,
      this.discount, this.detail, this.is_hot_product,
      this.is_new_arrival, this.category_id, this.user_id,
      this.created_at, this.updated_at);

  Product.fromJson(Map<String,dynamic> json)
      : id = json['id'],
        name = json['name'],
        price = double.parse(json['price'].toString()),
        photo = json['photo'],
        discount = double.parse(json['discount'].toString()),
        detail = json['detail'],
        is_hot_product = json['is_hot_product'] == '1',
        is_new_arrival = json['is_new_arrival'] == '1',
        category_id = int.parse(json['category_id'].toString()),
        user_id = int.parse(json['user_id'].toString()),
        created_at = DateTime.parse(json['created_at'].toString()),
        updated_at = DateTime.parse(json['updated_at'].toString());

  Map<String,dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'price' : price,
    'photo' : photo,
    'discount' : discount,
    'detail' : detail,
    'is_hot_product' : is_hot_product,
    'is_new_arrival' : is_new_arrival,
    'category_id' : category_id,
    'user_id' : user_id,
    'created_at' : created_at,
    'updated_at' : updated_at,
  };

  
}