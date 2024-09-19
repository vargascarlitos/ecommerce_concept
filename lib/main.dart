import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_concept/app_config/injector/injector.dart'
    as injector;
import 'package:flutter/material.dart';
import 'app_config/my_app.dart';

Future<void> main() async {
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  await injector.init();
  runApp(const MyApp());
}
