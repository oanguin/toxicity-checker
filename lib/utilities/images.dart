import 'package:flutter/cupertino.dart';

class Images {
  static Image showPicture(String url) {
    if (url.isEmpty) {
      return _showImageNotAvailable();
    } else {
      try {
        return Image(image: NetworkImage(url));
      } catch (exception) {
        return _showImageNotAvailable();
      }
    }
  }

  static Image _showImageNotAvailable() {
    return Image.asset("assets/images/no-image.png");
  }
}
