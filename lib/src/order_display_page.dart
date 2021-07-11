import 'package:fabric_app/models/cart_model.dart';
import 'package:fabric_app/models/product_model.dart';
import 'package:fabric_app/models/product_service.dart';
import 'package:fabric_app/src/order_list.dart';
import 'package:fabric_app/src/product_page.dart';
import 'package:fabric_app/src/services/auth_service.dart';
import 'package:fabric_app/src/widgets/lazy_builder.dart';
import 'package:fabric_app/utils/picture_resolver.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import 'navigator.dart';

class OrderDisplay extends StatefulWidget {
  @override
  _OrderDisplayState createState() => _OrderDisplayState();
}

class _OrderDisplayState extends State<OrderDisplay> {
  final _service = ProductService();
  LazyBuilderController order;

  void initState() {
    super.initState();
    order = LazyBuilderController(() {
      return _service.orders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Order',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: LazyBuilder(
        controller: order,
        builder: (data) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final order = data[index];
              return Card(
                child: GestureDetector(
                  onTap: () => navigateTo(context, OrderList(order['id'].toString())),
                  child: ListTile(
                    title: Text('Ref # ' + order['id'].toString()),
                    subtitle: Text(DateFormat('d MMM y hh:mm a').format(DateTime.parse(order['order_date']))),
                    trailing: Text(NumberFormat.currency(locale: 'en', name: 'PKR ').format(order['price'])),
                  ),
                ),
              );
            },
            itemCount: data.length,
          );
        },
      ),
    );
  }
}
