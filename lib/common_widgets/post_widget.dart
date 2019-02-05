import 'package:flutter/material.dart';
import 'package:mri_booking/common_widgets/post_item.dart';
import 'package:mri_booking/model/posts.dart';
import 'package:mri_booking/pages/details/post_details.dart';

class PostWidget extends StatelessWidget {
  final List<Post> postList;
  const PostWidget({Key key, this.postList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      
      crossAxisSpacing: 15,
      mainAxisSpacing: 11,
      childAspectRatio: 1.0,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      children: List.generate(
          postList.length,
          (index) => PostItem(
                post: postList[index],
                onItemTap: () => _onTap(context, postList[index]),
              )),
    );
  }

  _onTap(BuildContext context, Post post) => Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return PostDetailsPage(
          post: post,
        );
      }));
}
