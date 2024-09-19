import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_concept/app_config/style/app_palette.dart';
import 'package:ecommerce_concept/features/product/ui/pages/product_list_page.dart';
import 'package:ecommerce_concept/app_config/injector/injector.dart'
    as injector;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  await injector.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.archivoTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppPalette.black01,
        ),
        useMaterial3: true,
      ),
      home: const ProductListPage(),
    );
  }
}
