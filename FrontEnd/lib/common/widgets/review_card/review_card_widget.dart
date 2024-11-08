import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_icon.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
                CachedNetworkImage(
                  imageUrl: widget.userAvatar ?? '',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
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
                if (widget.image1 != null)
                  CachedNetworkImage(
                    imageUrl: widget.image1 ?? '',
                    placeholder: (context, url) => CircularProgressIndicator(),
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
                  ),
                if (widget.image2 != null)
                  CachedNetworkImage(
                    imageUrl: widget.image2 ?? '',
                    placeholder: (context, url) => CircularProgressIndicator(),
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
                  ),
                if (widget.image3 != null)
                  CachedNetworkImage(
                    imageUrl: widget.image3 ?? '',
                    placeholder: (context, url) => CircularProgressIndicator(),
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
                  ),
                if (widget.image4 != null)
                  CachedNetworkImage(
                    imageUrl: widget.image4 ?? '',
                    placeholder: (context, url) => CircularProgressIndicator(),
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
                    child: AppIcon.getIconXanhMain(widget.taskTypeImage ?? ''),
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
