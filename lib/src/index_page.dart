import 'package:fabric_app/src/home_page.dart';
import 'package:fabric_app/src/login_page.dart';
import 'package:fabric_app/src/navigator.dart';
import 'package:fabric_app/src/services/auth_service.dart';
import 'package:fabric_app/src/signup_page.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 150, 20, 0),
        child: Column(
          children: [
            Image.asset('images/logo.png', width:250,height: 200,),
            SizedBox(
              height: 30,
            ),
            Text('Welcome',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: SizedBox(
                width: 200,
                child: TextButton(
                  onPressed: () => navigateTo(context, LoginPage()),
                     child: Text('Login',
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 16,
                     ),),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                    side: BorderSide(color: Colors.black,
                    width: 1),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: SizedBox(
                width: 200,
                child: TextButton(
                  onPressed: () => navigateTo(context, SignUpPage()),
                  child: Text('Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                    side: BorderSide(color: Colors.black,
                        width: 1),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(150, 20, 10, 0),
                    child: Text('Guest Sign In',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),)),
                 Padding(
                   padding: EdgeInsets.fromLTRB(0, 20, 10, 0),
                   child: CircleAvatar(
                     child: IconButton(
                       icon: Icon(Icons.arrow_forward_ios_sharp,
                       size: 18,
                       ),
                       onPressed: () => navigateTo(context, HomePage()),
                     )),
                 ),
              ],

            ),



          ],
        ),
      ),
    );
  }
}
