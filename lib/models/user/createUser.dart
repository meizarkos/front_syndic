import 'package:front_syndic/models/user/user.dart';

import '../adress/adress.dart';

class CreateUser {
  Adress adress;
  User user;
  String? email;

  CreateUser({
    required this.adress,
    required this.user,
  });
}