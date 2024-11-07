import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FirebaseImageLoader extends StatefulWidget {
  @override
  _FirebaseImageLoaderState createState() => _FirebaseImageLoaderState();
}

class _FirebaseImageLoaderState extends State<FirebaseImageLoader> {
  String imageUrl =
      'https://storage.googleapis.com/se100-af7bc.appspot.com/images/1730975253027-Xem_ho_so_nguoi_giup_viec.jpg?GoogleAccessId=firebase-adminsdk-6avlp%40se100-af7bc.iam.gserviceaccount.com&Expires=1731580057&Signature=WKoJhyA7hekpNn42ztHf3fxDVSlS%2FQ95gX5qDzIVYcDoXY%2BWbRpPmTDvBGKo1SXpzUzCpA8tJiBi0%2FqUa69unVqBaL1dlP2An7FhTD4p9kXYlMlGx7Cz%2Fh2WVvHF5g%2BSthoY24yWWIkgvAqZPboko29R2l0wcVzgY9o3SYIcbSoI9xSAChuMM9iy%2BVNWgy1omGC1B4KYQ0TwdMCijOfpJVXNrhJtL1axKLSKaVVK%2BkLg%2FPIGgjIWVkTVZOGzfey5%2FpWhmDSysY3YSdwf5Svo15n%2Fj1AM7JZjS3La5T%2BQRBebQWYrdLUv48ZXADeVulakfydIPwreCL0WRC64etlyiQ%3D%3D';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Image Loader'),
      ),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
