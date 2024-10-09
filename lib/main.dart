import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_syndic/views/login_register/login.dart';
import 'package:front_syndic/views/union_side/union_main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            displayMedium: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            labelMedium: TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            displaySmall: TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
            headlineLarge: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            labelSmall: TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
          ),
        ),
        routes: {
          '/': (context) => const ConnectAll(),
          '/union_main': (context) => const UnionMain(),
        },
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
          /*case '/request_user/chose_description':
              final arguments = settings.arguments;
              if (arguments is CreateRequest) {
                return MaterialPageRoute(
                  builder: (context) => ChoseDescriptionRequestUser(createRequest : arguments),
                );
              }
              break;*/
            default:
              return null;
          }
        },
      );
  }
}
