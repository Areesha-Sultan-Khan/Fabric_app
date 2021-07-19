import 'package:fabric_app/models/product_service.dart';
import 'package:flutter/foundation.dart';

String resolveImageUrl(String url) {
  if (kDebugMode) {
     return url.replaceAll('localhost', Uri.parse(ProductService.apiUrl).host).replaceAll('public/', '');
  } else {
    return url;
   }
}