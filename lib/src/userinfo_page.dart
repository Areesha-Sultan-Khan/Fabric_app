import 'package:flutter/material.dart';
import 'package:fabric_app/src/navigator.dart';
import 'package:fabric_app/src/shipping_page.dart';
import 'package:fabric_app/models/user_information.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final formKey = GlobalKey<FormState>();
  final user = UserInformation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 70,
        title: Image.asset('images/logo.png', height: 110, width: 110),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 15, 10),
              child: Text(
                'Contact Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: TextFormField(
                validator: required,
                onSaved: (val) => user.email = val,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 15, 10),
              child: Text(
                'Shipping Address',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: TextFormField(
                validator: required,
                onSaved: (val) => user.first_name = val,
                decoration: InputDecoration(
                  hintText: 'Enter your first name',
                  labelText: 'First Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: TextFormField(
                validator: required,
                onSaved: (val) => user.last_name = val,
                decoration: InputDecoration(
                  hintText: 'Enter your last name',
                  labelText: 'Last Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: TextFormField(
                validator: required,
                onSaved: (val) => user.address = val,
                decoration: InputDecoration(
                  hintText: 'Enter your address',
                  labelText: 'Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: TextFormField(
                validator: required,
                onSaved: (val) => user.city = val,
                decoration: InputDecoration(
                  hintText: 'Enter your city name',
                  labelText: 'City',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: TextFormField(
                validator: required,
                onSaved: (val) => user.country = val,
                decoration: InputDecoration(
                  hintText: 'Enter your country name',
                  labelText: 'Country',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: TextFormField(
                validator: required,
                onSaved: (val) => user.postal_code = int.tryParse(val) ?? 0,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter postal code',
                  labelText: 'Postal Code',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: TextFormField(
                validator: required,
                onSaved: (val) => user.phone = int.tryParse(val) ?? 0,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter your phone no.',
                  labelText: 'Phone',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(100, 10, 100, 0),
              child: SizedBox(
                width: 150,
                child: TextButton(
                  onPressed: () {
                    if (!formKey.currentState.validate()) return;
                    formKey.currentState.save();

                    navigateTo(context, Shipping(user: user));
                  },
                  child: Text(
                    'Continue to Shipping',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    side: BorderSide(color: Colors.black, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                ),
              ),
            ),
            TextButton.icon(
              label: Text('Return to Cart'),
              icon: Icon(Icons.arrow_back_ios, size: 14),
              onPressed: () => Navigator.of(context).pop(),
            )
          ]),
        ),
      ),
    );
  }
}

String required(String val) {
  if (val.isEmpty == true) {
    return 'Enter some value';
  }

  return null;
}

void saveInfo(UserInformation info) {
  info.save();
}
