import 'package:mri_booking/utils/constants.dart';

class Images {
  final String imageId;
  final String imageUrl;

  Images({this.imageId, this.imageUrl});

  factory Images.fromJson(Map<String, dynamic> json) => Images(
      imageId: json[Constants.imageId] as String,
      imageUrl: json[Constants.imageUrl].toString().trim());
}
