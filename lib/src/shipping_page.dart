import 'package:fabric_app/models/user_information.dart';
import 'package:fabric_app/src/navigator.dart';
import 'package:fabric_app/src/payment_page.dart';
import 'package:fabric_app/src/userinfo_page.dart';
import 'package:flutter/material.dart';

class Shipping extends StatefulWidget {
  final UserInformation user;

  Shipping({this.user});

  @override
  _ShippingState createState() => _ShippingState();
}

class _ShippingState extends State<Shipping> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 70,
        backgroundColor: Colors.white,
        title: Image.asset('images/logo.png', height: 110, width: 110),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(5, 20, 5, 20),
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Card(
            child: Column(children: [
              Row(
                children: [
                  Padding(
                    child: Text('Contact'),
                    padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
                  ),
                  Text(widget.user.email),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 10, 20),
                    child: GestureDetector(
                      child: Text('Change'),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
              Divider(height: 20),
              Row(children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
                  child: Text('Ship to'),
                ),
                Text(widget.user.address + ', ', style: TextStyle(fontSize: 12)),
                Text(widget.user.city + ', ', style: TextStyle(fontSize: 12)),
                Text(widget.user.postal_code.toString() + ', ', style: TextStyle(fontSize: 12)),
                Text(widget.user.country, style: TextStyle(fontSize: 12)),
                Spacer(),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 10, 20),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Text('Change'),
                  ),
                ),
              ]),
            ]),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 200, 15),
            child: Text('Shipping Method', style: TextStyle(fontSize: 18)),
          ),
          Card(
            child: Row(children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(Icons.check_circle, size: 16),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 15, 10, 15),
                child: Text('Standard'),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                child: Text('Rs199.00'),
              ),
            ]),
          ),
          Row(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 15, 5),
              child: SizedBox(
                width: 150,
                child: TextButton(
                  onPressed: () => navigateTo(context, PaymentPage(user: widget.user)),
                  child: Text(
                    'Continue to Payment',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
              padding: EdgeInsets.only(top: 20),
              child: TextButton.icon(
                label: Text('Return to Cart'),
                icon: Icon(Icons.arrow_back_ios, size: 14),
                onPressed: () => Navigator.of(context).pop(),
              )
            )
          ])
        ]),
      ),
    );
  }
}
