import 'package:flutter/material.dart';
import 'package:front_syndic/models/work_request/work_request.dart';
import 'package:front_syndic/views/artisan_side/artisan_main.dart';
import 'package:front_syndic/views/artisan_side/work_request_detail/detail_work_request.dart';
import 'package:front_syndic/views/conversation/list_of_conv/all_conv_type.dart';
import 'package:front_syndic/views/conversation/list_of_conv/all_post_meeting_type.dart';
import 'package:front_syndic/views/conversation/list_of_first_conv/first_conv_type.dart';
import 'package:front_syndic/views/login_register/login.dart';
import 'package:front_syndic/views/process/in_progress_type.dart';
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
        '/artisan_main': (context) => const ArtisanMain(),
        '/artisan_main/first_conv': (context) => const FirstConvArtisan(),
        '/co_owner/work_requests': (context) => const WorkRequestsList(),
        '/first_conv_council': (context) => const FirstConvCouncil(),
        '/co_owner_main': (context) => const CoOwnerMain(),
        '/in_progress': (context) => const InProgressCouncil(),
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/work_requests/detail':
            final arguments = settings.arguments;
            if (arguments is String) {
              return MaterialPageRoute(
                builder: (context) => RecapPatchWorkRequest(
                  workRequestUuid: arguments,
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

          case '/artisan/see_conv':
            final arguments = settings.arguments;
            if (arguments is String) {
              return MaterialPageRoute(
                builder: (context) => AllConvArtisan(
                  id: arguments,
                ),
              );
            }
            break;

          case '/artisan/post_meeting':
            final arguments = settings.arguments;
            if (arguments is String) {
              return MaterialPageRoute(
                builder: (context) => PostMeetingArtisan(
                  uuid: arguments,
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

          case '/work_requests/artisan/detail':
            final arguments = settings.arguments;
            if (arguments is WorkRequest) {
              return MaterialPageRoute(
                builder: (context) => DetailWorkRequestArtisanSide(
                  workRequest: arguments,
                ),
              );
            }
            break;

          case '/work_requests/artisan/first_conv':
            final arguments = settings.arguments;
            if (arguments is String) {
              return MaterialPageRoute(
                builder: (context) => AllConvArtisanForWorkRequest(
                  id: arguments,
                ),
              );
            }
            break;

          case '/work_requests/artisan/post_meeting':
            final arguments = settings.arguments;
            if (arguments is String) {
              return MaterialPageRoute(
                builder: (context) => PostMeetingArtisanFromWorkRequest(
                  uuid: arguments,
                ),
              );
            }
            break;

          case '/council/see_conv':
            final arguments = settings.arguments;
            if (arguments is String) {
              return MaterialPageRoute(
                builder: (context) => AllConvCouncil(
                  id: arguments,
                ),
              );
            }
            break;

          case '/council/post_meeting':
            final arguments = settings.arguments;
            if (arguments is String) {
              return MaterialPageRoute(
                builder: (context) => PostMeetingCouncil(
                  uuid: arguments,
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
