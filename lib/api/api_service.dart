import 'dart:io';
import 'dart:async';
import 'package:mri_booking/model/main_response.dart';
import 'package:mri_booking/repository/repository.dart';
import 'package:mri_booking/utils/constants.dart';
import 'dart:convert';
import 'package:mri_booking/cache/local_data.dart';
import 'package:http/http.dart' as http; //for making request

class ApiRepository extends Repository {
  LocalDataRepository _localDataRepository = LocalDataRepository();

  @override
  Future<MRIResponse> getData() async {
    var uri = Uri.parse(Constants.url);
    var response = await _getJson(uri);
    if (response == null || response[Constants.success] == false) {
      print('Error fetching data from server');
      return null;
    }
    print('api called');
   // print(response.toString());
    return MRIResponse.fromJson(response);
  }

  Future<Map<String, dynamic>> _getJson(Uri uri) async {
    try {
      final response = await http.get(uri);
      if (response.statusCode != HttpStatus.ok) {
        return null;
      }
      final String responseBody = response.body;
      await _localDataRepository.writeData(responseBody);
      return json.decode(responseBody);
    } catch (e) {
      print('error connecting to server');
      return null;
    }
  }
}
