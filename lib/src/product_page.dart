import 'package:carousel_slider/carousel_slider.dart';
import 'package:fabric_app/models/boxes.dart';
import 'package:fabric_app/models/cart_model.dart';
import 'package:fabric_app/models/product_model.dart';
import 'package:fabric_app/models/product_service.dart';
import 'package:fabric_app/src/arrival_page.dart';
import 'package:fabric_app/src/navigator.dart';
import 'package:fabric_app/src/order_page.dart';
import 'package:fabric_app/utils/picture_resolver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();

  ProductPage(this.product);

  final Product product;
}

class _ProductPageState extends State<ProductPage> {
  int selectedImage = 0;
  final controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          'Product Description',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Image.network(
            resolveImageUrl(widget.product.photo),
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: Text(widget.product.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: Text('Rs.' + widget.product.price.toString(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
           child: Html(
             data: widget.product.detail ,

           )
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: Text('Discount:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: Text(widget.product.discount.toString(),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: ElevatedButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  side: BorderSide(color: Colors.black, width: 1)),
              child: Text(
                'Add to Cart',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (await addCart(widget.product, 1)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Product is added to Cart')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Product is already added to Cart')),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

Future<bool> addCart(Product product, int quantity) async {
  final cart = Cart(product, quantity);
  final box = Boxes.getOrder();

  if (box.containsKey(product.id)) {
    return false;
  } else {
    await box.put(product.id, cart);
    return true;
  }
}
