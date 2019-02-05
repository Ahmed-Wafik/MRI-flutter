import 'package:flutter/material.dart';
import 'package:mri_booking/utils/constants.dart';

class MRIImage extends StatelessWidget {
  final double _paddingTop = 24;
  final double paddingHorezintal;
  final double height;
  final String imagePath;

  const MRIImage(
      {Key key,
      this.paddingHorezintal = 40,
      this.height,
      @required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: _paddingTop),
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                tileMode: TileMode.clamp,
                  colors: <Color>[Colors.grey, Colors.grey[200]])),
        ),
        Padding(
          padding: EdgeInsets.only(
              right: paddingHorezintal,
              left: paddingHorezintal,
              top: _paddingTop),
          child: Container(
            child: Image.asset(
              imagePath,
              fit: BoxFit.fill,
              alignment: Alignment.bottomCenter,
              height: height,
              width: double.infinity,
            ),
          ),
        ),
      ],
    );
  }
}

class PhoneNumberWidget extends StatelessWidget {
  final String phoneNumber;
  final VoidCallback call;
  const PhoneNumberWidget({Key key, @required this.phoneNumber, this.call})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final colorRed = Color.fromRGBO(236, 28, 36, 1);
    return RaisedButton(
      onPressed: call,
      splashColor: colorRed,
      highlightColor: colorRed,
      // padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      color: Colors.black,
      shape: StadiumBorder(),
      elevation: 6,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.call, color: Constants.redColor),
          SizedBox(
            width: 5,
          ),
          Text(
            phoneNumber,
            style:
                TextStyle(fontSize: 18, letterSpacing: .6, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
