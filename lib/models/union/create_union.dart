import 'package:front_syndic/models/adress/adress.dart';
import 'package:front_syndic/models/union/union.dart';

class CreateUnion {
  UnionApi union;
  Adress adress;
  String? email;
  String? password;

  CreateUnion({
    required this.union,
    required this.adress,
  });
}