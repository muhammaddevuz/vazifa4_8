import 'package:dars_8/controllers/cart_controller.dart';
import 'package:dars_8/controllers/product_controller.dart';
import 'package:dars_8/controllers/products_controller.dart';
import 'package:dars_8/controllers/user_controller.dart';
import 'package:dars_8/firebase_options.dart';
import 'package:dars_8/views/screens/firspage.dart';
import 'package:dars_8/views/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) {
          return CartController();
        }),
        ChangeNotifierProvider(create: (ctx) {
          return ProductController();
        }),
        ChangeNotifierProvider(create: (ctx) {
          return ProductsController();
        }),
        ChangeNotifierProvider(create: (ctx) {
          return UserController();
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        )),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Firspage();
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
