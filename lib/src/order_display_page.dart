import 'package:dio/dio.dart';
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
              return Dismissible(
                key: ValueKey(order['id']),
                direction: DismissDirection.endToStart,
                onDismissed: (_) async {
                  try {
                    final resp = await Dio().delete('${ProductService.apiUrl}/orders/${order['id']}');
                  } on DioError catch(e) {
                    print(e.response.data);
                  }
                  await this.order.reload();
                },
                confirmDismiss: (_) async {
                  final result = await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Are you sure?'),
                        content: Text('This order will be removed'),
                        actions: [
                          TextButton(
                            child: Text('Yes'),
                            onPressed: () => Navigator.of(context).pop(true),
                          ),
                          TextButton(
                            child: Text('No'),
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                        ],
                      );
                    },
                  );

                  return result ?? false;
                },
                background: Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete, color: Colors.red),
                  ),
                ),
                child: Card(
                  child: GestureDetector(
                    onTap: () =>
                        navigateTo(context, OrderList(order['id'].toString())),
                    child: ListTile(
                      title: Text('Ref # ' + order['id'].toString()),
                      subtitle: Text(DateFormat('d MMM y hh:mm a')
                          .format(DateTime.parse(order['order_date']))),
                      trailing: Text(
                          NumberFormat.currency(locale: 'en', name: 'PKR ')
                              .format(order['price'])),
                    ),
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
