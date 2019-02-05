import 'package:mri_booking/utils/constants.dart';

class Contacts {
  final String phoneNumber_1;
  final String phoneNumber_2;

  Contacts({this.phoneNumber_1, this.phoneNumber_2});

  factory Contacts.fromJson(Map<String, dynamic> json) => Contacts(
      phoneNumber_1: json[Constants.phoneNumber1].toString().trim(),
      phoneNumber_2: json[Constants.phoneNumber2].toString().trim());
}
