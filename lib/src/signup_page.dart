import 'package:dio/dio.dart';
import 'package:fabric_app/models/product_service.dart';
import 'package:fabric_app/models/user_information.dart';
import 'package:fabric_app/src/home_page.dart';
import 'package:fabric_app/src/navigator.dart';
import 'package:fabric_app/src/userinfo_page.dart';
import 'package:fabric_app/src/widgets/loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final key = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final info = UserInformation();

  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(children: [
              Image.asset('images/logo.png', width: 150, height: 150),
              Text(
                'Create Your Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                onSaved: (val) {
                  info.first_name = val;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mail_outline_rounded),
                  hintText: 'First Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                onSaved: (val) {
                  info.last_name = val;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mail_outline_rounded),
                  hintText: 'Last Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                onSaved: (val) {
                  info.email = val;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mail_outline_rounded),
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                onSaved: (val) {
                  password = val;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  hintText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: 150,
                child: TextButton(
                  onPressed: () async {
                    formKey.currentState.save();
                    showDialog(context: context, builder: (_) => LoadingDialog());
                    try {
                      await Dio()
                          .post('${ProductService.apiUrl}/register', data: {
                        'name': info.first_name + ' ' + info.last_name,
                        'email': info.email,
                        'password': password
                      });
                      Navigator.of(context).pop();
                    } catch (e) {
                      print((e as Error).stackTrace);
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(content: Text(e.toString())),
                      );
                    }
                    key.currentState.showSnackBar(
                      SnackBar(content: Text('User has been registered')),
                    );
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    side: BorderSide(color: Colors.black, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
