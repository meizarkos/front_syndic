import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:front_syndic/views/login_register/login.dart';
import 'package:front_syndic/views/union_side/co_owner_main/co_owner_main.dart';
import 'package:front_syndic/views/union_side/union_main.dart';
import 'package:front_syndic/views/work_requests/create_work_request/category.dart';
import 'package:front_syndic/views/work_requests/create_work_request/chose_time/chose_date_time.dart';
import 'package:front_syndic/views/work_requests/create_work_request/recap.dart';
import 'package:front_syndic/views/work_requests/create_work_request/take_picture.dart';
import 'package:front_syndic/views/work_requests/create_work_request/title_and_desc.dart';
import 'package:front_syndic/views/work_requests/list_work_request/work_requests_list.dart';
import 'package:front_syndic/views/work_requests/patch/recap.dart';
import 'package:front_syndic/views/work_requests/patch/timing_recap.dart';

import 'models/work_request/create_work_request.dart';

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
          ),
          labelMedium: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
          labelSmall: TextStyle(
            fontSize: 18,
            color: Colors.blue,
            decoration: TextDecoration.underline, // Apply underline
          ),
        ),
      ),
      routes: {
        '/': (context) => const ConnectAll(),
        '/union_main': (context) => const UnionMain(),
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

          case '/work_requests/detail':
            final arguments = settings.arguments;
            if (arguments is Map<String, String?>) {
              return MaterialPageRoute(
                builder: (context) => RecapPatchWorkRequest(
                  uuid: arguments['uuid'],
                  coOwnerId: arguments['coOwnerId'],
                ),
              );
            }
            break;

          case '/work_requests/timings':
            final arguments = settings.arguments;
            if (arguments is String) {
              return MaterialPageRoute(
                builder: (context) => RecapTimingChange(
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
          case '/work_requests/title_and_desc':
            final arguments = settings.arguments;
            if (arguments is CreateWorkRequest) {
              return MaterialPageRoute(
                builder: (context) => TitleAndDesc(
                  createWorkRequest: arguments,
                ),
              );
            }
            break;
          case '/work_requests/pictures':
            final arguments = settings.arguments;
            if (arguments is CreateWorkRequest) {
              return MaterialPageRoute(
                builder: (context) => CameraScreen(
                  createWorkRequest: arguments,
                ),
              );
            }
            break;

          case '/work_requests/category':
            final arguments = settings.arguments;
            if (arguments is CreateWorkRequest) {
              return MaterialPageRoute(
                builder: (context) => WorkRequestCategory(
                  createWorkRequest: arguments,
                ),
              );
            }
            break;

          case '/work_requests/chose_date_time':
            final arguments = settings.arguments;
            if (arguments is CreateWorkRequest) {
              return MaterialPageRoute(
                builder: (context) => ChoseDateTime(
                  createWorkRequest: arguments,
                ),
              );
            }
            break;

          case '/work_requests/recap':
            final arguments = settings.arguments;
            if (arguments is CreateWorkRequest) {
              return MaterialPageRoute(
                builder: (context) => RecapWorkRequest(
                  createWorkRequest: arguments,
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
