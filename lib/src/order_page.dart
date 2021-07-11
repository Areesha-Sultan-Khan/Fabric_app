import 'package:fabric_app/models/boxes.dart';
import 'package:fabric_app/models/cart_model.dart';
import 'package:fabric_app/models/product_model.dart';
import 'package:fabric_app/models/product_service.dart';
import 'package:fabric_app/src/home_page.dart';
import 'package:fabric_app/src/navigator.dart';
import 'package:fabric_app/src/product_page.dart';
import 'package:fabric_app/src/services/auth_service.dart';
import 'package:fabric_app/src/userinfo_page.dart';
import 'package:fabric_app/utils/picture_resolver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  var _loading = false;
  List<Cart> _products;

  final _box = Hive.lazyBox<Cart>('cart');

  double get total => _products?.fold(0.0,
      (value, element) => value + element.quantity * (element.product.price - element.product.discount));

  @override
  void initState() {
    super.initState();

    _loading = true;
    _loadProducts();
  }

  _loadProducts() async {
    _products = [];
    for (final product in _box.keys) {
      _products.add(await _box.get(product));
    }

    _loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'My Cart',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _loading
          ? Center(child: CupertinoActivityIndicator())
          : CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = _products[index];
                    return GestureDetector(
                      onTap: () =>
                          navigateTo(context, ProductPage(product.product)),
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: Image.network(
                                resolveImageUrl(product.product.photo),
                                height: 150,
                                width: 150,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    product.product.name,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 20, bottom: 20),
                                    child: Text(
                                      (product.product.price * product.quantity)
                                          .toStringAsFixed(2),
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: Text(
                                      'Quantity:',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  QuantitySelector(
                                    initialValue: product.quantity,
                                    onChanged: (val) {
                                      product.quantity = val;
                                      setState(() {});
                                      product.save();
                                    },
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: SizedBox(
                                      width: 100,
                                      child: TextButton(
                                        onPressed: () => removeProduct(product),
                                        child: Text(
                                          'Remove',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          side: BorderSide(
                                              color: Colors.black, width: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: _products.length,
                )),
                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                        child: Card(
                          color: Colors.grey.shade200,
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              'ORDER SUMMARY',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Text('Total'),
                            Spacer(),
                            Text('Rs. ${total.toStringAsFixed(2)}')
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(50, 30, 50, 10),
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.black,
                              side: BorderSide(color: Colors.black, width: 1)),
                          child: Text(
                            'Proceed To Checkout',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if(AuthService.isSignedIn == true){
                              return navigateTo(context, UserInfo());}

                            else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Please Sign In')),
                              );
                            }
                          }
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }

  void removeProduct(Cart cart) {
    _products.remove(cart);
    setState(() {});
    cart.delete();
  }
}

class QuantitySelector extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int> onChanged;

  QuantitySelector({this.onChanged, this.initialValue});

  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  var _count = 1;
  static final _borderColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _count = widget.initialValue ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: _borderColor),
            ),
            child: SizedBox(
              width: 30,
              height: 30,
              child: InkWell(
                child: Center(child: Icon(CupertinoIcons.minus, size: 18)),
                onTap: _count > 1
                    ? () {
                        setState(() => --_count);
                        widget.onChanged?.call(_count);
                      }
                    : null,
              ),
            ),
          ),
          Container(
            width: 60,
            height: 30,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: _borderColor),
                bottom: BorderSide(color: _borderColor),
              ),
            ),
            child: Center(child: Text(_count.toString())),
          ),
          Material(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: _borderColor),
            ),
            child: SizedBox(
              width: 30,
              height: 30,
              child: InkWell(
                child: Center(child: Icon(CupertinoIcons.plus, size: 18)),
                onTap: () {
                  setState(() => ++_count);
                  widget.onChanged?.call(_count);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
