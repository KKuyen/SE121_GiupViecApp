// import 'dart:ffi'; // This import is not needed

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/core/firebase/firebase_image.dart';
import 'package:se121_giupviec_app/domain/entities/task.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:se121_giupviec_app/presentation/screens/user/activities/newReview.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/reviewView.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/taskerProfile.dart';

class Taskerrowreview extends StatefulWidget {
  final int taskerId;
  final String taskerName;
  final String taskerPhone;
  final String taskerImageLink;
  final int userId;
  final String userName;
  final double? Star;
  final Task task;
  final String taskTypeAvatar;
  final String taskTypeName;
  final int taskTypeId;
  final VoidCallback? reload;
  const Taskerrowreview({
    required this.userId,
    required this.userName,
    this.reload,
    required this.taskerId,
    super.key,
    required this.taskerName,
    this.Star,
    required this.taskerPhone,
    required this.taskerImageLink,
    required this.task,
    required this.taskTypeAvatar,
    required this.taskTypeName,
    required this.taskTypeId,
  });

  @override
  State<Taskerrowreview> createState() => _TaskerrowreviewState();
}

class _TaskerrowreviewState extends State<Taskerrowreview> {
  FirebaseImageService _firebaseImageService = FirebaseImageService();
  late double? reviewStar;
  void setStar(double star) {
    setState(() {
      reviewStar = star;
    });
  }

  @override
  void initState() {
    super.initState();
    reviewStar = widget.Star;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Taskerprofile(
              taskerId: widget.taskerId,
              userId: widget.userId,
            ),
          ),
        ),
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: reviewStar != null ? 8 : 0),
        child: Row(
          children: [
            FutureBuilder<String>(
              future: _firebaseImageService.loadImage(widget.taskerImageLink),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Icon(Icons.error);
                } else {
                  return CachedNetworkImage(
                    imageUrl: snapshot.data!,
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
                  );
                }
              },
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.taskerName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                if (reviewStar != null)
                  Row(
                    children: [
                      for (int i = 0; i < 5; i++)
                        Row(
                          children: [
                            Icon(
                              i < (reviewStar ?? 0)
                                  ? FontAwesomeIcons.solidStar
                                  : FontAwesomeIcons.star,
                              color: Colors.amber,
                              size: 11,
                            ),
                            const SizedBox(
                              width: 2,
                            )
                          ],
                        ),
                    ],
                  ),
              ],
            ),
            const Spacer(),
            if (reviewStar == null)
              IconButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Newreview(
                          userName: widget.userName,
                          userId: widget.userId,
                          taskerImageLink: widget.taskerPhone,
                          taskerPhone: widget.taskerPhone,
                          taskerId: widget.taskerId,
                          taskerName: widget.taskerName,
                          task: widget.task,
                          taskTypeId: widget.taskTypeId,
                          taskTypeAvatar: widget.taskTypeAvatar,
                          taskTypeName: widget.taskTypeName,
                        ),
                      ),
                    );
                    print(result);
                    if (result != null) {
                      setStar(result);
                    }
                  },
                  icon: const Icon(
                    Icons.reviews,
                    color: Colors.amber,
                    size: 27,
                  )),
            if (reviewStar != null)
              IconButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Reviewview(
                            taskId: widget.task.id,
                            time: widget.task.time,
                            taskerId: widget.taskerId,
                            taskerName: widget.taskTypeName,
                            taskerPhone: widget.taskerPhone,
                            taskerImageLink: widget.taskTypeAvatar),
                      ),
                    );
                    print(result);
                    if (result != null) {
                      setStar(result);
                    }
                  },
                  icon: const Icon(
                    Icons.remove_red_eye,
                    color: Colors.amber,
                    size: 27,
                  )),
          ],
        ),
      ),
    );
  }
}
