import 'package:flutter/material.dart';
import 'package:mri_booking/api/api_service.dart';
import 'package:mri_booking/repository/repository.dart';

class WaitingWidget extends StatelessWidget {
  final Repository repository;
  const WaitingWidget({Key key, this.repository}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return repository is ApiRepository
        ? Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Please Wait...',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      letterSpacing: .6,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator()
              ],
            ),
          )
        : Container();
  }
}
