import 'package:dio/dio.dart';
import 'package:fabric_app/src/services/auth_service.dart';
import 'package:hive/hive.dart';
import 'widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fabric_app/models/cart_model.dart';
import 'package:fabric_app/models/product_service.dart';
import 'package:fabric_app/models/user_information.dart';

class PaymentPage extends StatefulWidget {
  final UserInformation user;

  PaymentPage({this.user});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 70,
        backgroundColor: Colors.white,
        title: Image.asset('images/logo.png', height: 110, width: 110),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text('Contact'),
                    subtitle: Text(widget.user.email),
                  ),
                  Divider(height: 5),
                  ListTile(
                    title: Text('Ship to'),
                    subtitle: Row(children: [
                      Text(
                        '${widget.user.address}, ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${widget.user.city}, ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${widget.user.postal_code}, ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${widget.user.country}, ',
                        style: TextStyle(fontSize: 12),
                      ),
                    ]),
                  ),
                  Divider(height: 5),
                  ListTile(
                    title: Text('Method'),
                    subtitle: Text('Free Shipping - Free'),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              'Payment',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 0, 10),
              child: Text('All transactions are secure and encrypted')),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
            child: Card(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                child: Text(
                  'Cash on Delivery (COD)',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 15, 5),
            child: SizedBox(
              width: 150,
              child: TextButton(
                onPressed: () async {
                  final _box = Hive.lazyBox<Cart>('cart');
                  final _products = [];
                  for (final key in _box.keys) {
                    final item = await _box.get(key);
                    _products.add({
                      'id': item.product.id,
                      'price': item.product.price,
                      'discount': item.product.discount,
                      'quantity': item.quantity,
                    });
                  }

                  showDialog(context: context, builder: (_) => LoadingDialog());
                  try {
                    print('User ID here');
                    print(AuthService.user.id);
                    await Dio().post(
                      '${ProductService.apiUrl}/place-order',
                      data: {
                        'order_date': DateTime.now().toString(),
                        'email': widget.user.email,
                        'first_name': widget.user.first_name,
                        'last_name': widget.user.last_name,
                        'address': widget.user.address,
                        'city': widget.user.city,
                        'price': _products?.fold(
                            0.0,
                            (value, element) =>
                                value +
                                element['quantity'] * (element['price'] - element['discount'])),
                        'user_id': AuthService.user.id,
                        'postal_code': widget.user.postal_code,
                        'country': widget.user.country,
                        'phone': widget.user.phone,
                        'products': _products,
                      },
                    );
                    Navigator.of(context).pop();
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Row(children: [
                          Icon(Icons.check),
                          Text('Order has been placed'),
                        ]),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Ok'),
                          )
                        ],
                      ),
                    );

                    await _box.clear();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  } catch (e) {
                    // print(e.stackTrace);
                    print((e as DioError).response.data);
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  'Place Order',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  side: BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: TextButton.icon(
                label: Text('Return to Shipping'),
                icon: Icon(Icons.arrow_back_ios, size: 14),
                onPressed: () => Navigator.of(context).pop(),
              ))
        ],
      ),
    );
  }
}
