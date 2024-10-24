import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:front_syndic/views/login_register/login.dart';
import 'package:front_syndic/views/union_side/co_owner_main/co_owner_main.dart';
import 'package:front_syndic/views/union_side/union_main.dart';
import 'package:front_syndic/views/work_requests/create_work_request/category.dart';
import 'package:front_syndic/views/work_requests/create_work_request/take_picture.dart';
import 'package:front_syndic/views/work_requests/list_work_request/work_requests_list.dart';

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
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          labelMedium: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
          labelSmall: TextStyle(
            fontSize: 14,
            color: Colors.blue,
            decoration: TextDecoration.underline, // Apply underline
          ),
        ),
      ),
      routes: {
        '/': (context) => const ConnectAll(),
        '/union_main': (context) => const UnionMain(),
        '/work_requests/category': (context) => const WorkRequestCategory(),
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/co_owner_main':
            final arguments = settings.arguments;
            if (arguments is String) {
              return MaterialPageRoute(
                builder: (context) => CoOwnerMain(
                  uuid: arguments,
                ),
              );
            }
            break;

          case '/co_owner/work_requests':
            final arguments = settings.arguments;
            if (arguments is String) {
              return MaterialPageRoute(
                builder: (context) => WorkRequestsList(
                  coOwnerUuid: arguments,
                ),
              );
            }
            break;

          case '/work_requests/pictures':
            final arguments = settings.arguments;
            if (arguments is CameraDescription) {
              return MaterialPageRoute(
                builder: (context) => CameraScreen(
                  camera: arguments,
                ),
              );
            }
            break;

          default:
            return null;
        }
        return null;
      },
    );
  }
}
