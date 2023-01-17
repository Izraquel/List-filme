import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/product_add_edit.dart';
import 'package:flutter_frontend/pages/product_list.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          // primarySwatch: Colors.blue,
          textTheme: GoogleFonts.latoTextTheme(
        Theme.of(context).textTheme,
      )),
      routes: {
        '/': (context) => const ProductList(),
        '/add-product': (context) => const ProductAddEdit(),
        '/edit-product': (context) => const ProductAddEdit(),
      },
    );
  }
}
