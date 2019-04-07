import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mri_booking/api/api_service.dart';
import 'package:mri_booking/cache/local_data.dart';
import 'package:mri_booking/common_widgets/home_widgets.dart';
import 'package:mri_booking/common_widgets/waiting_widget.dart';
import 'package:mri_booking/model/main_response.dart';
import 'package:mri_booking/pages/home/home_content.dart';
import 'package:connectivity/connectivity.dart';
import 'package:mri_booking/repository/repository.dart';
import 'package:mri_booking/utils/constants.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  ConnectivityResult _connectivityResult;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  MRIResponse result;

  Future<Null> checkConnectivity() async {
    ConnectivityResult connectionStatus;
    try {
      connectionStatus = await Connectivity().checkConnectivity();
    } catch (e) {
      print(e.toString());
      // _connectivityResult = 'Failed to get connectivity.';
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _connectivityResult = connectionStatus;
    });
  }

  @override
  void initState() {
    super.initState();
    checkConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() => _connectivityResult = result);
    });
    LocalDataRepository().getData().then((onValue) {
      print('object' + onValue.toString());
      setState(() {
        result = onValue;
      });
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: MRIImage(
              imagePath: Constants.imagePath_1,
            ),
          ),
          Expanded(
            flex: 6,
            child: StreamBuilder(
              stream: _connectivity.onConnectivityChanged,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  switch (_connectivityResult) {
                    case ConnectivityResult.mobile:
                    case ConnectivityResult.wifi:
                      // print('lllllllllllllllllllllllll');
                      return DataWidget(
                        repository: ApiRepository(),
                      );
                      break;
                    case ConnectivityResult.none:
                      // print(result.toString() + 'mmmmmmm');
                      if (result == null) {
                        return Center(
                            child: Text('Check Internet Connectivity'));
                      } else {
                        return DataWidget(
                          repository: LocalDataRepository(),
                        );
                      }
                  }
                } else {
                  return Container();
                }
                return WaitingWidget();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DataWidget extends StatefulWidget {
  final Repository repository;
  const DataWidget({Key key, this.repository}) : super(key: key);

  @override
  DataWidgetState createState() {
    return new DataWidgetState();
  }
}

class DataWidgetState extends State<DataWidget> {
  bool isActive = false;
  MRIResponse newValue;
 
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MRIResponse>(
      future: widget.repository.getData(),
      builder: (BuildContext context, AsyncSnapshot<MRIResponse> snapshot) {
        // print(snapshot.data);
        if (snapshot.hasData) {
          // print(snapshot.data.imagesList);
          return HomeContent(
            response: snapshot.data,
            onRefresh: widget.repository.getData,
          );
        } else if (snapshot.hasError) {
          Center(
            child: Text(
              "Error",
              style: TextStyle(color: Colors.red, fontSize: 30),
            ),
          );
        }
        return WaitingWidget(repository: widget.repository);
      },
    );
  }
}
