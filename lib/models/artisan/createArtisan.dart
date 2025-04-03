import 'package:front_syndic/models/adress/adress.dart';
import 'package:front_syndic/models/artisan/artisan.dart';
import 'package:front_syndic/models/bank_info/bank_info.dart';

class CreateArtisan{
  Adress adress;
  Artisan artisan;
  BankInfo bankInfo;
  String? email;
  String? password;

  CreateArtisan({
    required this.adress,
    required this.artisan,
    required this.bankInfo,
  });
}