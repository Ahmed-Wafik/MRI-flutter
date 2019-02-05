import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mri_booking/model/posts.dart';
import 'package:mri_booking/utils/constants.dart';

class PostItem extends StatelessWidget {
  final Post post;
  final VoidCallback onItemTap;
  const PostItem({Key key, this.post, this.onItemTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double borderRadius = 12;
    return InkWell(
      onTap: onItemTap,
      splashColor: Colors.blue,
      highlightColor: Colors.red,
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      child: Container(
        // height: 30,
        margin: EdgeInsets.all(3),

        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  // offset: Offset(1, 1),
                  blurRadius: 1.5,
                  color: Constants.trecColor),
            ],
            borderRadius: BorderRadius.circular(borderRadius),
            color: Constants.trecColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 14,
              child: Hero(
                tag: post.postId,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(borderRadius),
                    topRight: Radius.circular(borderRadius),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: post.imageUrl,
                    errorWidget: Image.asset(
                      Constants.image_not_found,
                      fit: BoxFit.fill,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            post.title.trim().isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 2, bottom: 2, right: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(borderRadius),
                          bottomRight: Radius.circular(borderRadius),
                        ),
                      ),
                      child: Text(
                        post.title,
                        textDirection: TextDirection.rtl,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: true,
                        // textAlign: TextAlign.,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ))
                : Container()
          ],
        ),
      ),
    );
  }
}
