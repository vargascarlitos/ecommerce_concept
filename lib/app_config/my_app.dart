import 'package:ecommerce_concept/app_config/style/app_palette.dart';
import 'package:ecommerce_concept/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_concept/features/product/ui/pages/product_detail_page.dart';
import 'package:ecommerce_concept/features/product/ui/pages/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.archivoTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppPalette.black01,
        ),
        useMaterial3: true,
      ),
      routes: {
        ProductListPage.routeName: (context) => const ProductListPage(),
        ProductDetailPage.routeName: (context) => ProductDetailPage(
              product:
                  ModalRoute.of(context)!.settings.arguments as ProductEntity,
            ),
      },
      builder: (context, child) {
        return ResponsiveBreakpoints.builder(
          child: Builder(
            builder: (context) {
              return ResponsiveScaledBox(
                width: ResponsiveValue<double?>(
                  context,
                  conditionalValues: [
                    const Condition.equals(name: MOBILE, value: 450),
                    const Condition.between(start: 800, end: 1100, value: 800),
                    const Condition.between(start: 1000, end: 1200, value: 700),
                  ],
                ).value,
                child: child!,
              );
            },
          ),
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        );
      },
    );
  }
}
