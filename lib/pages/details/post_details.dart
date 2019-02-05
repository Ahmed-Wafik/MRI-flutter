import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mri_booking/common_widgets/oval_bottom_boder_clipper.dart';
import 'package:mri_booking/model/posts.dart';
import 'package:mri_booking/utils/constants.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;
  const PostDetailsPage({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(post.content);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            GestureDetector(
              onTap: () => _openImage(context, post.imageUrl),
              child: ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  padding: EdgeInsets.only(bottom: 2),
                  constraints: BoxConstraints.expand(height: 250),
                  child: Stack(
                    children: <Widget>[
                      Hero(
                        tag: post.postId,
                        child: ClipPath(
                          clipper: OvalBottomBorderClipper(),
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            errorWidget: Image.asset(
                              Constants.image_not_found,
                              fit: BoxFit.fill,
                              width: double.infinity,
                            ),
                            width: double.infinity,
                            imageUrl: post.imageUrl,
                          ),
                        ),
                      ),
                      AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        leading: Container(
                          width: 60,
                          height: 60,
                          margin: EdgeInsets.all(5),
                          // decoration: BoxDecoration(
                          // color: Colors.black26, shape: BoxShape.circle,),
                          child: Center(
                            child: IconButton(
                              highlightColor: Constants.trecColor,
                              splashColor: Colors.blue,
                              alignment: Alignment.center,
                              tooltip: 'BACK',
                              color: Colors.black,
                              iconSize: 29,
                              icon: Icon(
                                Icons.chevron_left,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  post.title,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            post.content.trim() != ''
                ? Material(
                    color: Colors.transparent,
                    child: Container(
                      decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                              side: BorderSide(color: Colors.teal, width: 2))),
                      margin: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 8),
                      child: Text(
                        post.content,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ))
                : Container()
          ],
        ),
      ),
    );
  }

  _openImage(BuildContext context, String imageUrl) {
    showDialog(
        context: context,
        builder: (c) {
          return Center(
              child: CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: imageUrl,
            errorWidget: Image.asset(
              Constants.image_not_found,
              fit: BoxFit.fill,
              width: double.infinity,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2 + 50,
          ));
        });
  }
}
