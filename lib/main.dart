import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:front_syndic/models/estimate/estimate.dart';
import 'package:front_syndic/models/timing/timing_estimate.dart';
import 'package:front_syndic/views/account/artisan/modify_adress_artisan.dart';
import 'package:front_syndic/views/account/artisan/modify_artisan.dart';
import 'package:front_syndic/views/account/artisan/modify_surf_artisan.dart';
import 'package:front_syndic/views/account/chose_modify_type.dart';
import 'package:front_syndic/views/account/council/modify_adress_council.dart';
import 'package:front_syndic/views/account/council/modify_council/modify_council_type.dart';
import 'package:front_syndic/views/account/council/modify_surf_council.dart';
import 'package:front_syndic/views/account/union/modify_adress_union.dart';
import 'package:front_syndic/views/account/union/modify_login_union.dart';
import 'package:front_syndic/views/account/union/modify_union.dart';
import 'package:front_syndic/views/artisan_side/artisan_main.dart';
import 'package:front_syndic/views/artisan_side/work_request_detail/first_contact_artisan.dart';
import 'package:front_syndic/views/artisan_side/work_request_detail/detail_work_request.dart';
import 'package:front_syndic/views/co_owner/co_owner_detail/co_owner_detail_type.dart';
import 'package:front_syndic/views/conversation/conversation_in_progress/conversation_in_progress_type.dart';
import 'package:front_syndic/views/conversation/list_of_conv/all_conv_type.dart';
import 'package:front_syndic/views/conversation/list_of_conv/all_post_meeting_type.dart';
import 'package:front_syndic/views/conversation/list_of_first_conv/first_conv_type.dart';
import 'package:front_syndic/views/council_side/council_main.dart';
import 'package:front_syndic/views/estimate/create_estimate/recap_estimate.dart';
import 'package:front_syndic/views/estimate/create_estimate/set_description_estimate.dart';
import 'package:front_syndic/views/estimate/create_estimate/set_price_and_commentary.dart';
import 'package:front_syndic/views/estimate/estimate_artisan/estimate_detail_artisan.dart';
import 'package:front_syndic/views/estimate/estimate_detail/estimate_detail_type.dart';
import 'package:front_syndic/views/login_register/login.dart';
import 'package:front_syndic/views/login_register/register/artisan/bank_info_view.dart';
import 'package:front_syndic/views/login_register/register/artisan/email_passwd_artisan.dart';
import 'package:front_syndic/views/login_register/register/artisan/info_artisan.dart';
import 'package:front_syndic/views/login_register/register/artisan/recap.dart';
import 'package:front_syndic/views/login_register/register/chose_class.dart';
import 'package:front_syndic/views/login_register/register/union/confirm.dart';
import 'package:front_syndic/views/login_register/register/union/union_data.dart';
import 'package:front_syndic/views/login_register/register/union/union_passwd_email.dart';
import 'package:front_syndic/views/process/in_progress_type.dart';
import 'package:front_syndic/views/timing/create_timing/create_timing_type.dart';
import 'package:front_syndic/views/timing/timing_detail/timing_detail_type.dart';
import 'package:front_syndic/views/timing_estimate/create_timing_estimate/create_timing_estimate_type.dart';
import 'package:front_syndic/views/timing_estimate/list_timing_estimate/timing_estimate_type.dart';
import 'package:front_syndic/views/union_side/union_home.dart';
import 'package:front_syndic/views/adress/chose_adress_type.dart';
import 'package:front_syndic/views/union_side/create_council/chose_name/chose_name_type.dart';
import 'package:front_syndic/views/union_side/create_council/conctact_info/contact_info_type.dart';
import 'package:front_syndic/views/union_side/create_council/confirm/confirm_creation_from_union.dart';
import 'package:front_syndic/views/union_side/create_council/confirm/confirm_register_council.dart';
import 'package:front_syndic/views/union_side/create_council/create_password/council_passwd.dart';
import 'package:front_syndic/views/union_side/modify_council/main_modify_council.dart';
import 'package:front_syndic/views/work_requests/create_work_request/category/category_type.dart';
import 'package:front_syndic/views/work_requests/create_work_request/chose_time/chose_date_time_type.dart';
import 'package:front_syndic/views/work_requests/create_work_request/recap/recap_type.dart';
import 'package:front_syndic/views/work_requests/create_work_request/take_picture.dart';
import 'package:front_syndic/views/work_requests/create_work_request/title_desc/title_and_desc_type.dart';
import 'package:front_syndic/views/work_requests/list_work_request/work_request_type.dart';
import 'package:front_syndic/views/work_requests/modify_work_request/recap_from_conv.dart';
import 'package:front_syndic/views/work_requests/modify_work_request/recap_main_type.dart';

import 'models/artisan/createArtisan.dart';
import 'models/council/createCouncil.dart';
import 'models/to_screen/artisan_detail_work_request.dart';
import 'models/to_screen/see_conv_arg.dart';
import 'models/union/create_union.dart';
import 'models/work_request/create_work_request.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51QWlA5P3n22SAVzLvhdPoTDKJf1jk5NcN1JSf5D42zMnV6fNZylrfV5DdhqTU84acIcIFAk7MSunGXHyOH3EyBl200bjWz1ZG9';
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
            fontSize: 23,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            fontSize: 17,
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
            fontSize: 14,
            color: Colors.blue,
            decoration: TextDecoration.underline, // Apply underline
          ),
        ),
      ),
      routes: {
        '/': (context) => const ConnectAll(),
        '/register': (context) => const ChoseClass(),
        '/union_main': (context) => const UnionMain(),
        '/union/conversation': (context) => const ConversationInProgressUnion(),
        '/artisan_main': (context) => const ArtisanMain(),
        '/artisan/conversation': (context) => const ConversationInProgressArtisan(),
        '/artisan_main/first_conv': (context) => const FirstConvArtisan(),
        '/council_main': (context) => const CouncilMain(),
        '/council/conversation': (context) => const ConversationInProgressCouncil(),
        '/union/work_requests': (context) => const WorkRequestListUnion(),
        '/first_conv_council': (context) => const FirstConvCouncil(),
        "/co_owner_main": (context) => const CoOwnerDetailCouncil(),
        '/in_progress/council/conversation': (context) => const InProgressCouncilConversation(),
        '/in_progress/artisan':(context)=> const InProgressArtisanConversation(),
        '/in_progress/union':(context)=> const InProgressUnion(),
        '/artisan/account': (context) => const ChoseModifyTypeArtisan(),
        '/artisan/modify_artisan': (context) => const ModifyArtisan(),
        '/artisan/modify_artisan_address': (context) => const ModifyAdressArtisan(),
        '/artisan/modify_surf': (context) => const ModifySurfArtisan(),
        '/council/account': (context) => const ChoseModifyTypeCouncil(),
        '/council/modify_council': (context) => const ModifyCouncilForCouncil(),
        '/council/modify_council_address': (context) => const ModifyAdressCouncil(),
        '/council/modify_surf': (context) => const ModifySurfCouncil(),
        '/union/account': (context) => const ChoseModifyTypeUnion(),
        '/union/modify_account': (context) => const ModifyUnion(),
        '/union/modify_union_address': (context) => const ModifyAdressUnion(),
        '/union/modify_surf': (context) => const ModifySurfUnion(),
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {

          case '/union/council_modify':
            final arguments = settings.arguments;
            if (arguments is String) {
              return MaterialPageRoute(
                builder: (context) => MainModifyCouncilFromUnion(
                  councilId: arguments,
                ),
              );
            }
            break;

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

          case '/artisan/creation_info':
            final arguments = settings.arguments;
            if (arguments is CreateArtisan) {
              return MaterialPageRoute(
                builder: (context) => ArtisanInfo(
                  createArtisan: arguments,
                ),
              );
            }
            break;

          case '/artisan/bank_info':
            final arguments = settings.arguments;
            if (arguments is CreateArtisan) {
              return MaterialPageRoute(
                builder: (context) => BankInfoArtisan(
                  createArtisan: arguments,
                ),
              );
            }
            break;

          case '/council/modify_demand':
            final arguments = settings.arguments;
            if (arguments is String) {
              return MaterialPageRoute(
                builder: (context) => RecapMainCouncil(
                  workRequestUuid: arguments,
                ),
              );
            }

          case '/council/modify_demand/from_conv':
            final arguments = settings.arguments;
            if (arguments is String) {
              return MaterialPageRoute(
                builder: (context) => RecapMainCouncilFromConversation(
                  workRequestUuid: arguments,
                ),
              );
            }

          case '/artisan/get_passwd':
            final arguments = settings.arguments;
            if (arguments is CreateArtisan) {
              return MaterialPageRoute(
                builder: (context) => EmailPasswdArtisan(
                  createArtisan: arguments,
                ),
              );
            }
            break;

          case '/artisan/get_adress':
            final arguments = settings.arguments;
            if (arguments is CreateArtisan) {
              return MaterialPageRoute(
                builder: (context) => ChoseAdressRegisterArtisan(
                  createArtisan: arguments,
                ),
              );
            }
            break;

          case '/artisan/recap':
            final arguments = settings.arguments;
            if (arguments is CreateArtisan) {
              return MaterialPageRoute(
                builder: (context) => RecapArtisanRegister(
                  createArtisan: arguments,
                ),
              );
            }
            break;

          case 'union/specific_conv':
            final arguments = settings.arguments;
            if (arguments is String) {
              return MaterialPageRoute(
                builder: (context) => AllConvUnion(
                    id : arguments,
                ),
              );
            }
            break;

          case '/estimate/union/detail':
            final arguments = settings.arguments;
            if (arguments is String?) {
              return MaterialPageRoute(
                builder: (context) => EstimateDetailUnion(
                  convUuid: arguments,
                ),
              );
            }

          case 'union/detail_timing':
            final arguments = settings.arguments;
            if (arguments is String?) {
              return MaterialPageRoute(
                builder: (context) => TimingDetailUnion(
                  convUuid : arguments,
                ),
              );
            }
            break;

          case '/union/create_timing':
            final arguments = settings.arguments;
            if (arguments is String?) {
              return MaterialPageRoute(
                builder: (context) => CreateTimingUnion(
                  convUuid: arguments,
                ),
              );
            }
            break;

          case '/union/get_info':
            final arguments = settings.arguments;
            if (arguments is CreateUnion) {
              return MaterialPageRoute(
                builder: (context) => UnionData(
                  createUnion: arguments,
                ),
              );
            }
            break;

        case '/union/get_adress':
          final arguments = settings.arguments;
          if (arguments is CreateUnion) {
            return MaterialPageRoute(
              builder: (context) => ChoseAdressRegisterUnion(
                createUnion: arguments,
              ),
            );
          }
          break;

          case '/union/get_identification':
            final arguments = settings.arguments;
            if (arguments is CreateUnion) {
              return MaterialPageRoute(
                builder: (context) => UnionPasswdEmail(
                  createUnion: arguments,
                ),
              );
            }
            break;

          case '/union/confirm':
            final arguments = settings.arguments;
            if (arguments is CreateUnion) {
              return MaterialPageRoute(
                builder: (context) => ConfirmUnionCreation(
                  createUnion: arguments,
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

          case '/union/create_council/adress':
            final arguments = settings.arguments;
            if (arguments is CreateCouncil) {
              return MaterialPageRoute(
                builder: (context) => ChoseAdressCreateCouncil(
                  createCouncil: arguments,
                ),
              );
            }
            break;

          case '/union/create_council/confirm':
            final arguments = settings.arguments;
            if(arguments is CreateCouncil){
              return MaterialPageRoute(
                builder: (context) => ConfirmCreationCouncilUnion(
                  createCouncil: arguments,
                ),
              );
            }

          case 'council/confirm_register':
            final arguments = settings.arguments;
            if(arguments is CreateCouncil){
              return MaterialPageRoute(
                builder: (context) => CouncilConfirmRegister(
                  createCouncil: arguments,
                ),
              );
            }


          case '/union/create_council/name':
            final arguments = settings.arguments;
            if (arguments is CreateCouncil) {
              return MaterialPageRoute(
                builder: (context) => UnionChoseNameCouncil(
                  createCouncil: arguments,
                ),
              );
            }
            break;

          case '/union/create_council/contact_info':
            final arguments = settings.arguments;
            if (arguments is CreateCouncil) {
              return MaterialPageRoute(
                builder: (context) => UnionContactInfoCouncil(
                  createCouncil: arguments,
                ),
              );
            }
            break;

          case '/council/name':
            final arguments = settings.arguments;
            if (arguments is CreateCouncil) {
              return MaterialPageRoute(
                builder: (context) => CouncilChoseName(
                  createCouncil: arguments,
                ),
              );
            }
            break;

          case '/council/info_contact':
            final arguments = settings.arguments;
            if (arguments is CreateCouncil) {
              return MaterialPageRoute(
                builder: (context) => CreateContactInfoCouncil(
                  createCouncil: arguments,
                ),
              );
            }
            break;

          case 'council/adress':
            final arguments = settings.arguments;
            if (arguments is CreateCouncil) {
              return MaterialPageRoute(
                builder: (context) => ChoseAdressRegisterCouncil(
                  createCouncil: arguments,
                ),
              );
            }
            break;

          case '/council/timing_detail':
            final arguments = settings.arguments;
            if (arguments is String?) {
              return MaterialPageRoute(
                builder: (context) => TimingDetailCouncil(
                  convUuid: arguments,
                ),
              );
            }
            break;

          case '/timing/artisan/detail':
            final arguments = settings.arguments;
            if(arguments is String?){
              return MaterialPageRoute(
                builder: (context) => TimingDetailArtisan(
                  convUuid: arguments,
                ),
              );
            }
            break;

          case '/union/modify_demand':
            final arguments = settings.arguments;
            if (arguments is String) {
              return MaterialPageRoute(
                builder: (context) => RecapMainUnion(
                  workRequestUuid: arguments,
                ),
              );
            }
            break;

          case '/union/modify_demand/from_conv':
            final arguments = settings.arguments;
            if (arguments is String) {
              return MaterialPageRoute(
                builder: (context) => RecapMainUnionFromConversation(
                  workRequestUuid: arguments,
                ),
              );
            }
            break;

          case '/artisan/create_timing':
            final arguments = settings.arguments;
            if (arguments is String?) {
              return MaterialPageRoute(
                builder: (context) => CreateTimingArtisan(
                  convUuid: arguments,
                ),
              );
            }
            break;

          case '/artisan/timing_estimate':
            final arguments = settings.arguments;
            if (arguments is String?) {
              return MaterialPageRoute(
                builder: (context) => TimingEstimateArtisan(
                  convUuid: arguments,
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

          case '/artisan/create_timing_estimate':
            final arguments = settings.arguments;
            if(arguments is TimingEstimate){
              return MaterialPageRoute(
                builder: (context) => CreateTimingEstimateArtisan(
                  timingEstimate: arguments,
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

          case '/work_requests/council/adress':
            final arguments = settings.arguments;
            if (arguments is CreateWorkRequest) {
              return MaterialPageRoute(
                builder: (context) => CreateWorkRequestAdressCouncil(
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

          case 'union/work_requests/adress':
            final arguments = settings.arguments;
            if (arguments is CreateWorkRequest) {
              return MaterialPageRoute(
                builder: (context) => CreateWorkRequestAdressUnion(
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

          case 'council/get_passwd':
            final arguments = settings.arguments;
            if (arguments is CreateCouncil) {
              return MaterialPageRoute(
                builder: (context) => CouncilPasswd(
                  createCouncil: arguments,
                ),
              );
            }
            break;

          case '/estimate/artisan/detail':
            final arguments = settings.arguments;
            if(arguments is String?){
              return MaterialPageRoute(
                builder: (context) => EstimateDetailArtisan(
                  convUuid: arguments,
                ),
              );
            }

          case '/estimate/council/detail':
            final arguments = settings.arguments;
            if(arguments is String?){
              return MaterialPageRoute(
                builder: (context) => EstimateDetailCouncil(
                  convUuid: arguments
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
                builder: (context) => FirstContactArtisan(
                  uuid: arguments.uuid,
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
                  id : arguments
                ),
              );
            }
            break;

          case '/council/create_timing':
            final arguments = settings.arguments;
            if (arguments is String?) {
              return MaterialPageRoute(
                builder: (context) => CreateTimingCouncil(
                  convUuid: arguments,
                ),
              );
            }
            break;

          case '/council/timing_estimate':
            final arguments = settings.arguments;
            if (arguments is String?) {
              return MaterialPageRoute(
                builder: (context) => TimingEstimateCouncil(
                  convUuid: arguments,
                ),
              );
            }
            break;

          case  '/council/create_timing_estimate':
            final arguments = settings.arguments;
            if(arguments is TimingEstimate){
              return MaterialPageRoute(
                builder: (context) => CreateTimingEstimateCouncil(
                  timingEstimate : arguments,
                ),
              );
            }

          case '/union/timing_estimate':
            final arguments = settings.arguments;
            if (arguments is String?) {
              return MaterialPageRoute(
                builder: (context) => TimingEstimateUnion(
                  convUuid: arguments,
                ),
              );
            }
            break;

          case '/union/create_timing_estimate':
            final arguments = settings.arguments;
            if(arguments is TimingEstimate){
              return MaterialPageRoute(
                builder: (context) => CreateTimingEstimateUnion(
                  timingEstimate : arguments,
                ),
              );
            }

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
