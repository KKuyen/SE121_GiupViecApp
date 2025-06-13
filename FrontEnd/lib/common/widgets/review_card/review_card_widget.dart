import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_icon.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:se121_giupviec_app/core/firebase/firebase_image.dart';

class ReviewCardWidget extends StatefulWidget {
  final String? userName;
  final String? userAvatar;
  final int? star;
  final String content;
  final String? image1;
  final String? image2;
  final String? image3;
  final String? image4;
  final String? taskTypeImage;
  final String? taskTypeName;
  final String? time;

  const ReviewCardWidget(
      {super.key,
      required this.userName,
      required this.userAvatar,
      this.star,
      required this.content,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.taskTypeImage,
      this.taskTypeName,
      this.time});

  @override
  State<ReviewCardWidget> createState() => _ReviewCardWidgetState();
}

class _ReviewCardWidgetState extends State<ReviewCardWidget> {
  final FirebaseImageService _firebaseImageService = FirebaseImageService();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FutureBuilder<String>(
                  future:
                      _firebaseImageService.loadImage(widget.userAvatar ?? ''),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Icon(Icons.error);
                    } else if (snapshot.hasData) {
                      return CachedNetworkImage(
                        imageUrl: snapshot.data!,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => SvgPicture.asset(
                          AppVectors.avatar,
                          width: 40.0,
                          height: 40.0,
                        ),
                        imageBuilder: (context, imageProvider) => Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Icon(Icons.error);
                    }
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userName ?? '',
                      style: AppTextStyle.textthuong,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        for (int i = 0; i < (widget.star ?? 0); i++)
                          const Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.solidStar,
                                color: Colors.amber,
                                size: 10,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                            ],
                          ),
                        for (int i = 0; i < 5 - (widget.star ?? 0); i++)
                          const Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.star,
                                color: Colors.amber,
                                size: 10,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                            ],
                          ),
                      ],
                    )
                  ],
                )
              ],
            ),
            if (widget.content != '')
              const SizedBox(
                height: 10,
              ),
            if (widget.content != '')
              Text(widget.content,
                  style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.xam72,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none)),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(spacing: 5, runSpacing: 10, children: [
                if (widget.image1 != null && widget.image1 != '')
                  FutureBuilder<String>(
                    future:
                        _firebaseImageService.loadImage(widget.image1 ?? ''),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Icon(Icons.error);
                      } else if (snapshot.hasData) {
                        return CachedNetworkImage(
                          imageUrl: snapshot.data!,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Container(
                            width: 100,
                            height: 80,
                            child: Icon(Icons.image, color: Colors.white),
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: AppColors.xam72,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            width: 100.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Icon(Icons.error);
                      }
                    },
                  ),
                if (widget.image2 != null && widget.image2 != '')
                  FutureBuilder<String>(
                    future:
                        _firebaseImageService.loadImage(widget.image2 ?? ''),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Icon(Icons.error);
                      } else if (snapshot.hasData) {
                        return CachedNetworkImage(
                          imageUrl: widget.image1 ?? '',
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Container(
                            width: 100,
                            height: 80,
                            child: Icon(Icons.image, color: Colors.white),
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: AppColors.xam72,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            width: 100.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Icon(Icons.error);
                      }
                    },
                  ),
                if (widget.image3 != null && widget.image3 != '')
                  FutureBuilder<String>(
                    future:
                        _firebaseImageService.loadImage(widget.image3 ?? ''),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Icon(Icons.error);
                      } else if (snapshot.hasData) {
                        return CachedNetworkImage(
                          imageUrl: widget.image1 ?? '',
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Container(
                            width: 100,
                            height: 80,
                            child: Icon(Icons.image, color: Colors.white),
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: AppColors.xam72,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            width: 100.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Icon(Icons.error);
                      }
                    },
                  ),
                if (widget.image4 != null && widget.image4 != '')
                  FutureBuilder<String>(
                    future:
                        _firebaseImageService.loadImage(widget.image4 ?? ''),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Icon(Icons.error);
                      } else if (snapshot.hasData) {
                        return CachedNetworkImage(
                          imageUrl: widget.image1 ?? '',
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Container(
                            width: 100,
                            height: 80,
                            child: Icon(Icons.image, color: Colors.white),
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: AppColors.xam72,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            width: 100.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Icon(Icons.error);
                      }
                    },
                  ),
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: AppColors.nen_the,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: AppColors.xanh_main,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: widget.taskTypeImage != null &&
                              widget.taskTypeImage.toString().isNotEmpty
                          ? Image.network(
                              AppIcon.getImageUrl(
                                  widget.taskTypeImage.toString())!,
                              width: 40, // hoặc giá trị bạn muốn, ví dụ 48
                              height: 40,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported,
                                      color: AppColors.xanh_main),
                            )
                          : const Icon(Icons.image, color: AppColors.xanh_main),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.taskTypeName ?? '',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            decoration: TextDecoration.none,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.normal,
                          )),
                      Text(widget.time != null ? widget.time! : '',
                          style: const TextStyle(
                            color: AppColors.xam72,
                            fontSize: 12,
                            decoration: TextDecoration.none,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.normal,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
