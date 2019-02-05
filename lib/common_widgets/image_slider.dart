import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mri_booking/utils/constants.dart';

class ImageSlider extends StatefulWidget {
  final List<Widget> items;

  const ImageSlider({Key key, this.items}) : super(key: key);
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CarouselSlider(
        autoPlayCurve: Curves.fastOutSlowIn,
        viewportFraction: 1.0,
        height: 300,
        items: widget.items,
        autoPlay: widget.items.length ==1? false:true,
        distortion: false,
        updateCallback: (index) {
          setState(() {
            _current = index;
          });
        },
      ),
      Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Indicator(
            count: widget.items.length,
            currentIndex: _current,
          ))
    ]);
  }
}

class Indicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const Indicator({Key key, this.count, this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(count, (index) {
          return Container(
            width: currentIndex == index ? 12 : 5,
            height: currentIndex == index ? 12 : 5,
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 1,
                    color: currentIndex == index
                        ? Colors.transparent
                        : Colors.black45),
                color: currentIndex == index
                    ? Constants.redColor
                    : Colors.transparent),
          );
        }));
  }
}
