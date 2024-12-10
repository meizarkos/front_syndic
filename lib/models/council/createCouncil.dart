import 'package:front_syndic/models/adress/adress.dart';
import 'package:front_syndic/models/co_owner/co_owner.dart';
import 'package:front_syndic/models/council/council.dart';

class CreateCouncil{
  Adress adress;
  Council council;
  CoOwner coOwner;
  String? email;

  CreateCouncil({
    required this.adress,
    required this.council,
    required this.coOwner,
  });
}