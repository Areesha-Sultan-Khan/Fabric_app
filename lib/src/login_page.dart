import 'package:dio/dio.dart';
import 'package:fabric_app/models/product_service.dart';
import 'package:fabric_app/models/user_information.dart';
import 'package:fabric_app/src/home_page.dart';
import 'package:fabric_app/src/navigator.dart';
import 'package:fabric_app/src/services/auth_service.dart';
import 'package:fabric_app/src/signup_page.dart';
import 'package:fabric_app/src/widgets/loading_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final key = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  var email = '';
  var password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
            child: Column(children: [
              Image.asset(
                'images/logo.png',
                width: 150,
                height: 150,
              ),
              Container(
                height: 340,
                child: Stack(
                  children: [
                    Container(
                      height: 310,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Username',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (str) {
                                if (str?.isEmpty == true) {
                                  return 'Enter some value';
                                }

                                return null;
                              },
                              onSaved: (val) => email = val,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.account_box_rounded),
                                hintText: 'Enter your email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text('Password', style: TextStyle(fontSize: 20)),
                            SizedBox(height: 10),
                            TextFormField(
                              validator: (str) {
                                if (str?.isEmpty == true) {
                                  return 'Enter some value';
                                }

                                return null;
                              },
                              obscureText: true,
                              onSaved: (val) => password = val,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                hintText: 'Enter your password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 100,
                      bottom: 8,
                      child: SizedBox(
                        width: 120,
                        child: TextButton(
                          onPressed: () async {
                            if (!formKey.currentState.validate()) return;
                            formKey.currentState.save();

                            showDialog(
                              context: context,
                              builder: (_) => LoadingDialog(),
                            );
                            try {
                              final response = await Dio().post(
                                '${ProductService.apiUrl}/login',
                                data: {'email': email, 'password': password},
                              );
                              //navigateTo(context, HomePage());
                              if (response.data['result'] == true) {
                                key.currentState.showSnackBar(SnackBar(
                                  content: Text('Logged in successfully'),
                                ));
                                final user = UserInformation.fromJson(
                                  response.data['user'],
                                );
                                await AuthService.signIn(user);

                                Navigator.of(context).popUntil((route) => false);
                                navigateTo(context, HomePage());
                              } else {
                                Navigator.of(context).pop();
                                key.currentState.showSnackBar(SnackBar(
                                  content: Text('Invalid Email or Password'),
                                ));
                              }
                            } catch (e) {
                              Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  content: Text(e.toString()),
                                ),
                              );
                            }
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 16),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            side: BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Row(children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(50, 0, 10, 0),
                  child: Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Signup',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => navigateTo(context, SignUpPage()),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ])
            ]),
          ),
        ),
      ),
    );
  }
}
