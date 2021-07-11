import 'package:fabric_app/models/cart_model.dart';
import 'package:fabric_app/models/product_model.dart';
import 'package:fabric_app/models/user_information.dart';
import 'package:fabric_app/src/home_page.dart';
import 'package:fabric_app/src/index_page.dart';
import 'package:fabric_app/src/login_page.dart';
import 'package:fabric_app/src/product_page.dart';
import 'package:fabric_app/src/services/auth_service.dart';
import 'package:fabric_app/src/signup_page.dart';
import 'package:fabric_app/src/userinfo_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

import 'src/index_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(CartAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(UserInformationAdapter());

  await AuthService.init();
  await Hive.openLazyBox<Cart>('cart');

  runApp(
    MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: AuthService.isSignedIn ? HomePage() : IndexPage(),
    ),
  );
}
