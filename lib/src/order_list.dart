import 'package:fabric_app/models/product_service.dart';
import 'package:fabric_app/src/widgets/lazy_builder.dart';
import 'package:flutter/material.dart';

class OrderList extends StatefulWidget {
  final String id;

  OrderList(this.id);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final _service = ProductService();
  LazyBuilderController order;

  void initState() {
    super.initState();
    order = LazyBuilderController(() {
      return _service.orderProducts(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Order List',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: LazyBuilder(
        controller: order,
        builder: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final product = data[index];
              return Card(
                child: ListTile(
                  title: Text(product['product']['name']),
                  subtitle: Text(product['product']['price'].toString()),
                  trailing: Text(product['quantity'].toString()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
