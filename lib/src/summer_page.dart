import 'package:fabric_app/models/product_model.dart';
import 'package:fabric_app/models/product_service.dart';
import 'package:fabric_app/src/navigator.dart';
import 'package:fabric_app/src/order_page.dart';
import 'package:fabric_app/src/product_page.dart';
import 'package:fabric_app/utils/picture_resolver.dart';
import 'package:flutter/material.dart';

class SummerPage extends StatefulWidget {
  @override
  _SummerPageState createState() => _SummerPageState();
}

class _SummerPageState extends State<SummerPage> {

  final _service = ProductService();
  Future<List<Product>> product;

  void initState() {
    super.initState();
    product = _service.getProductsByCategory(8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Summer Collection',
        style: TextStyle(
          color: Colors.black
        ),),
      ),
      body: FutureBuilder(
        future: product,
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('No Internet');
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2/2.7,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    final product = snapshot.data[index];
                    return Card(
                      child: GestureDetector(
                        onTap: () => navigateTo(context, ProductPage(product)),
                        child: Column(
                          children: [
                            Image.network(
                              resolveImageUrl(product.photo),
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: Text(
                                product.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text('Rs.' + product.price.toString()),
                          ],
                        ),
                      ),
                    );
                  },
                );
            }
          }

          return Text(snapshot.data.toString());
        },
      ),
    );
  }
}