import 'package:fabric_app/models/cart_model.dart';
import 'package:fabric_app/models/user_information.dart';
import 'package:fabric_app/src/userinfo_page.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static UserInformation _user;
  static var _isSignedIn = false;

  static UserInformation get user => _user;
  static bool get isSignedIn => _isSignedIn;

  static Future<void> init() async {
    final box = await Hive.openBox<UserInformation>('user');

    final prefs = await SharedPreferences.getInstance();
    _isSignedIn =  prefs.getBool('auth') ?? false;
    if (box.values.isNotEmpty) _user = box.values.first;

    print(_isSignedIn);
    print(_user);
  }

  static Future<void> signIn(UserInformation user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', true);
    _isSignedIn = true;
    _user = user;
    Hive.box<UserInformation>('user').add(user);
    user.save();
  }

  static Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', false);
    _isSignedIn = false;
    _user = null;
    Hive.box<UserInformation>('user').clear();
    await Hive.lazyBox<Cart>('cart').clear();
  }
}