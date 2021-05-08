import 'package:flutter/material.dart';
import 'package:product_management/database/database_service.dart';
import 'package:product_management/home_page.dart';
import 'package:product_management/themes/my_colors.dart';

import 'module/add_product_page.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await DataBaseService.openDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: MyColors.accent,
        primaryColor: MyColors.accent,
        appBarTheme: AppBarTheme(
          color: Color(0xff000072),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}