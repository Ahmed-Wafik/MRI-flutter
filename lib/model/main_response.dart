import 'package:mri_booking/model/contacts.dart';
import 'package:mri_booking/model/images.dart';
import 'package:mri_booking/model/posts.dart';
import 'package:mri_booking/utils/constants.dart';

class MRIResponse {
  final bool success;
  final List<Images> imagesList;
  final List<Post> postsList;
  final List<Contacts> contacts;

  MRIResponse({this.success, this.imagesList, this.postsList, this.contacts});

  MRIResponse.fromJson(Map<String, dynamic> json)
      : success = json[Constants.success] as bool,
        imagesList = (json[Constants.images] as List)
            .map((v) => Images.fromJson(v))
            .toList(),
        postsList = (json[Constants.posts] as List)
            .map((v) => Post.fromJson(v))
            .toList(),
        contacts = (json[Constants.contacts] as List)
            .map((v) => Contacts.fromJson(v))
            .toList();

  @override
  String toString() =>'$success ${contacts.toString()} ${imagesList.toString()}';

}
