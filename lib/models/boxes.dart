import 'package:hive/hive.dart';
import 'cart_model.dart';

class Boxes{
     static LazyBox<Cart> getOrder() =>
         Hive.lazyBox<Cart>('cart');
}