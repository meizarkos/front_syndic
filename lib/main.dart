import 'package:flutter/material.dart';
import 'package:front_syndic/models/estimate/estimate.dart';
import 'package:front_syndic/views/artisan_side/artisan_main.dart';
import 'package:front_syndic/views/artisan_side/work_request_detail/detail_work_request.dart';
import 'package:front_syndic/views/co_owner/co_owner_detail/co_owner_detail_type.dart';
import 'package:front_syndic/views/conversation/list_of_conv/all_conv_type.dart';
import 'package:front_syndic/views/conversation/list_of_conv/all_post_meeting_type.dart';
import 'package:front_syndic/views/conversation/list_of_first_conv/first_conv_type.dart';
import 'package:front_syndic/views/estimate/create_estimate/recap_estimate.dart';
import 'package:front_syndic/views/estimate/create_estimate/set_description_estimate.dart';
import 'package:front_syndic/views/estimate/create_estimate/set_price_and_commentary.dart';
import 'package:front_syndic/views/estimate/estimate_artisan/estimate_detail_type_artisan.dart';
import 'package:front_syndic/views/estimate/estimate_detail/estimate_detail_type.dart';
import 'package:front_syndic/views/login_register/login.dart';
import 'package:front_syndic/views/process/in_progress_type.dart';
import 'package:front_syndic/views/timing/timing_detail/timing_detail_type.dart';
import 'package:front_syndic/views/union_side/co_owner_list.dart';
import 'package:front_syndic/views/work_requests/create_work_request/category/category_type.dart';
import 'package:front_syndic/views/work_requests/create_work_request/chose_time/chose_date_time_type.dart';
import 'package:front_syndic/views/work_requests/create_work_request/recap/recap_type.dart';
import 'package:front_syndic/views/work_requests/create_work_request/take_picture.dart';
import 'package:front_syndic/views/work_requests/create_work_request/title_desc/title_and_desc_type.dart';
import 'package:front_syndic/views/work_requests/list_work_request/work_request_type.dart';
import 'package:front_syndic/views/work_requests/patch/recap_type.dart';
import 'package:front_syndic/views/work_requests/patch/timing_recap.dart';

import 'models/to_screen/artisan_detail_work_request.dart';
import 'models/to_screen/council_work_request_detail.dart';
import 'models/to_screen/see_conv_arg.dart';
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
        '/co_owner/work_requests': (context) => const WorkRequestListCouncil(),
        '/union/work_requests': (context) => const WorkRequestListUnion(),
        '/first_conv_council': (context) => const FirstConvCouncil(),
        "/co_owner_main": (context) => const CoOwnerDetailCouncil(),
        '/in_progress/council/conversation': (context) => const InProgressCouncilConversation(),
        '/in_progress/artisan':(context)=> const InProgressArtisanConversation(),
        '/in_progress/union':(context)=> const InProgressUnion(),
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/union/co_owner_detail':
            final arguments = settings.arguments;
            if (arguments is String?) {
              return MaterialPageRoute(
                builder: (context) => CoOwnerDetailUnion(
                  uuid: arguments,
                ),
              );
            }
            break;
          case '/work_requests/detail':
            final arguments = settings.arguments;
            if (arguments is CouncilWorkRequestDetail) {
              return MaterialPageRoute(
                builder: (context) => RecapWorkRequestCouncil(
                  workRequestUuid: arguments.uuid,
                  fetchWorkRequestDetail: arguments.futureToFetchData,
                  onBack: arguments.onBack,
                  onDelete: arguments.onDelete,
                ),
              );
            }
            break;

          case 'union/work_requests/detail':
            final arguments = settings.arguments;
            if (arguments is String?) {
              return MaterialPageRoute(
                builder: (context) => RecapWorkRequestUnion(
                    workRequestUuid: arguments
                ),
              );
            }
            break;

          case 'union/specific_conv':
            final arguments = settings.arguments;
            if (arguments is SeeConvArg) {
              return MaterialPageRoute(
                builder: (context) => AllConvUnion(
                    id : arguments.uuid,
                    future: arguments.futureToFetchData,
                ),
              );
            }
            break;

          case 'union/detail_timing':
            final arguments = settings.arguments;
            if (arguments is SeeConvArg) {
              return MaterialPageRoute(
                builder: (context) => TimingDetailUnion(
                  timingUuid : arguments.uuid,
                  fetchTimingDetail: arguments.futureToFetchData,
                ),
              );
            }
            break;

          case 'union/post_meeting':
            final arguments = settings.arguments;
            if (arguments is String) {
              return MaterialPageRoute(
                builder: (context) => PostMeetingUnion(
                  uuid: arguments,
                ),
              );
            }
            break;

          case '/council/timing_detail':
            final arguments = settings.arguments;
            if (arguments is SeeConvArg) {
              return MaterialPageRoute(
                builder: (context) => TimingDetailCouncil(
                  timingUuid: arguments.uuid,
                  fetchTimingDetail: arguments.futureToFetchData,
                ),
              );
            }
            break;

          case '/timing/artisan/detail':
            final arguments = settings.arguments;
            if(arguments is SeeConvArg){
              return MaterialPageRoute(
                builder: (context) => TimingDetailArtisan(
                  timingUuid: arguments.uuid,
                  fetchTimingDetail: arguments.futureToFetchData,
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

          case '/artisan/create_estimate/description':
            final arguments = settings.arguments;
            if(arguments is Estimate){
              return MaterialPageRoute(
                builder: (context) => SetDescriptionEstimate(
                  estimate: arguments,
                ),
              );
            }

          case '/artisan/create_estimate/price':
            final arguments = settings.arguments;
            if(arguments is Estimate){
              return MaterialPageRoute(
                builder: (context) => SetPriceAndCommentary(
                  estimate: arguments,
                ),
              );
            }

          case '/artisan/create_estimate/recap':
            final arguments = settings.arguments;
            if(arguments is Estimate){
              return MaterialPageRoute(
                builder: (context) => RecapEstimate(
                  estimate: arguments,
                ),
              );
            }

          case '/artisan/see_conv':
            final arguments = settings.arguments;
            if (arguments is SeeConvArg) {
              return MaterialPageRoute(
                builder: (context) => AllConvArtisan(
                  id: arguments.uuid,
                  future: arguments.futureToFetchData,
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
                builder: (context) => TitleAndDescCouncil(
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
                builder: (context) => CategoryCouncil(
                  createWorkRequest: arguments,
                ),
              );
            }
            break;

          case '/work_requests/chose_date_time':
            final arguments = settings.arguments;
            if (arguments is CreateWorkRequest) {
              return MaterialPageRoute(
                builder: (context) => ChoseDateTimeCouncil(
                  createWorkRequest: arguments,
                ),
              );
            }
            break;

          case '/work_requests/recap':
            final arguments = settings.arguments;
            if (arguments is CreateWorkRequest) {
              return MaterialPageRoute(
                builder: (context) => RecapCouncilWorkRequest(
                  createWorkRequest: arguments,
                ),
              );
            }
            break;

          case 'union/work_requests/recap':
            final arguments = settings.arguments;
            if (arguments is CreateWorkRequest) {
              return MaterialPageRoute(
                builder: (context) => RecapUnionWorkRequest(
                  createWorkRequest: arguments,
                ),
              );
            }
            break;

          case 'union/work_requests/chose_date_time':
            final arguments = settings.arguments;
            if (arguments is CreateWorkRequest) {
              return MaterialPageRoute(
                builder: (context) => ChoseDateTimeUnion(
                  createWorkRequest: arguments,
                ),
              );
            }
            break;

          case 'union/work_requests/category':
            final arguments = settings.arguments;
            if (arguments is CreateWorkRequest) {
              return MaterialPageRoute(
                builder: (context) => CategoryUnion(
                  createWorkRequest: arguments,
                ),
              );
            }
            break;

          case 'union/work_requests/title_and_desc':
            final arguments = settings.arguments;
            if (arguments is CreateWorkRequest) {
              return MaterialPageRoute(
                builder: (context) => TitleAndDescUnion(
                  createWorkRequest: arguments,
                ),
              );
            }
            break;

          case '/estimate/artisan/detail':
            final arguments = settings.arguments;
            if(arguments is SeeConvArg){
              return MaterialPageRoute(
                builder: (context) => EstimateDetailArtisanType(
                  fetchData: arguments.futureToFetchData,
                  uuid: arguments.uuid,
                ),
              );
            }

          case '/estimate/council/detail':
            final arguments = settings.arguments;
            if(arguments is SeeConvArg){
              return MaterialPageRoute(
                builder: (context) => EstimateDetailCouncil(
                  fetchData: arguments.futureToFetchData,
                  uuid: arguments.uuid,
                ),
              );
            }

          case '/work_requests/artisan/detail':
            final arguments = settings.arguments;
            if (arguments is ArtisanWorkRequestDetailArg) {
              return MaterialPageRoute(
                builder: (context) => DetailWorkRequestArtisanSide(
                  futureToFetchData: arguments.futureToFetchData,
                  workRequestUuid: arguments.workRequestUuid,
                  showContact: arguments.showContact,
                ),
              );
            }
            break;

          case '/work_requests/artisan/first_conv':
            final arguments = settings.arguments;
            if (arguments is SeeConvArg) {
              return MaterialPageRoute(
                builder: (context) => AllConvArtisanForWorkRequest(
                  id: arguments.uuid,
                  future: arguments.futureToFetchData,
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
            if (arguments is SeeConvArg) {
              return MaterialPageRoute(
                builder: (context) => AllConvCouncil(
                  id : arguments.uuid,
                  future: arguments.futureToFetchData,
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
