import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mri_booking/model/main_response.dart';
import 'package:mri_booking/repository/repository.dart';
import 'package:path_provider/path_provider.dart';

class LocalDataRepository extends Repository {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/MRI.txt');
  }

  writeInitialData(BuildContext context) async {
    final file = await _localFile;
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/file.json");
    file.writeAsString(data);
  }

  Future<File> writeData(String data) async {
    final file = await _localFile;
    return file.writeAsString('$data');
  }

  @override
  Future<MRIResponse> getData() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      final Map<String, dynamic> result = json.decode(contents);
      return MRIResponse.fromJson(result);
    } catch (e) {
      print("$e");
      // throw('can\'t read data from local storage');
      return null;
    }
  }
}
