import 'package:fabric_app/models/product_model.dart';
import 'package:fabric_app/src/product_page.dart';
import 'package:hive/hive.dart';

part 'cart_model.g.dart';

@HiveType(typeId:0)
class Cart extends HiveObject{
  @HiveField(0)
  Product product;
  @HiveField(1)
  int quantity;

  Cart(this.product, this.quantity);
}



