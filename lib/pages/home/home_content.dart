import 'package:flutter/material.dart';
import 'package:mri_booking/common_widgets/home_widgets.dart';
import 'package:mri_booking/common_widgets/image_slider.dart';
import 'package:mri_booking/common_widgets/post_widget.dart';
import 'package:mri_booking/model/main_response.dart';
import 'package:mri_booking/utils/constants.dart';
import 'package:mri_booking/utils/text_style.dart' as txtStyle;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

typedef Future<MRIResponse> RefreshCallback();

class HomeContent extends StatefulWidget {
   MRIResponse response;
  final RefreshCallback onRefresh;
   HomeContent({Key key, this.response, this.onRefresh}) : super(key: key);

  @override
  HomeContentState createState() {
    return new HomeContentState();
  }
}

class HomeContentState extends State<HomeContent> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _onRefresh,
        child: ListView(padding: EdgeInsets.all(0), children: <Widget>[
          ImageSlider(
              items: List<Widget>.generate(
                  widget.response.imagesList.length,
                  (index) => CachedNetworkImage(
                        imageUrl: widget.response.imagesList[index].imageUrl,
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ))),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.bordarRaduis)),
                gradient: LinearGradient(tileMode: TileMode.mirror, colors: [
                  Colors.black87,
                  Constants.blackColor,
                  Colors.black87,
                ])),
            child: Column(
              children: <Widget>[
                Text(
                  Constants.txt_1,
                  textAlign: TextAlign.center,
                  style: txtStyle.firstTextStyle(),
                ),
                Text(
                  Constants.txt_4,
                  textAlign: TextAlign.center,
                  style: txtStyle.firstTextStyle(),
                ),
                Text(Constants.txt_2,
                    textAlign: TextAlign.center,
                    style: txtStyle.firstTextStyle()),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Wrap(
                        runAlignment: WrapAlignment.spaceAround,
                        spacing: 100,
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Text(
                            Constants.txt_3,
                            style: txtStyle.callNowTextStyle(),
                          ),
                          // Text(
                          //   Constants.txt_3,
                          //   style: txtStyle.callNowTextStyle(),
                          // )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        direction: Axis.vertical,
                        spacing: 10,
                        children: <Widget>[
                          widget.response.contacts[0].phoneNumber_1
                                  .trim()
                                  .isNotEmpty
                              ? PhoneNumberWidget(
                                  phoneNumber: widget
                                      .response.contacts[0].phoneNumber_1
                                      .toString(),
                                  call: () => _call(widget
                                      .response.contacts[0].phoneNumber_1
                                      .toString()),
                                )
                              : Container(),
                          widget.response.contacts[0].phoneNumber_1
                                  .trim()
                                  .isNotEmpty
                              ? PhoneNumberWidget(
                                  call: () => _call(widget
                                      .response.contacts[0].phoneNumber_2
                                      .toString()),
                                  phoneNumber: widget
                                      .response.contacts[0].phoneNumber_2
                                      .toString(),
                                )
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: PostWidget(
              postList: widget.response.postsList,
            ),
          ),
          SizedBox(
            height: 15,
          )
        ]));
  }

 Future<Null> _onRefresh() {
   return widget.onRefresh().then((onValue) {
      setState(() {
        print('on refresh called');
        widget.response = onValue;
      });
    });
  }

  _call(String number) async {
    final String phoneNumber = 'tel:$number';
    try {
      if (await canLaunch(phoneNumber)) {
        await launch(phoneNumber);
      } else {
        throw 'Could not launch url';
      }
    } catch (e) {
      print('ca\'t call $e ');
    }
  }
}
