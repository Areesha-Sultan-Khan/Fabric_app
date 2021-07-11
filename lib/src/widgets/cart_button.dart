import 'package:fabric_app/models/cart_model.dart';
import 'package:fabric_app/src/navigator.dart';
import 'package:fabric_app/src/order_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartButton extends StatefulWidget {
  const CartButton({Key key}) : super(key: key);

  @override
  _CartButtonState createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.lazyBox<Cart>('cart').listenable(),
      builder: (BuildContext context, LazyBox value, Widget child) {
        return Stack(children: [
          child,
          if (value.isNotEmpty)
            Positioned(
              top: 7,
              right: 7,
              child: Container(
                width: 15,
                height: 15,
                child: Center(
                  child: Text(
                    value.length > 10 ? '9+' : value.length.toString(),
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ]);
      },
      child: Center(
        child: IconButton(
          icon: Icon(Icons.shopping_cart_outlined),
          onPressed: () => navigateTo(context, OrderPage()),
        ),
      ),
    );
  }
}
