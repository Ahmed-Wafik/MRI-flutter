import 'package:mri_booking/utils/constants.dart';

class Post {
  final String postId;
  final String content;
  final String title;
  final String imageUrl;
  Post({this.postId, this.content, this.title, this.imageUrl});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
      postId: json[Constants.postId] as String,
      content: json[Constants.postContent] as String,
      title: json[Constants.postTitle] as String,
      imageUrl: json[Constants.postImage] as String);
}
