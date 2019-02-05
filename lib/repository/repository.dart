import 'dart:async';

import 'package:mri_booking/model/main_response.dart';
abstract class Repository{
  Future<MRIResponse> getData();
  
}