import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/taskerProfile.dart';

class Taskerrowdelete extends StatefulWidget {
  final VoidCallback onPressFun;
  final String taskerName;
  final String taskerPhone;
  final String taskerImageLink;
  final int taskerId;
  const Taskerrowdelete({
    required this.onPressFun,
    required this.taskerId,
    super.key,
    this.taskerName = 'Nguyễn Văn A',
    this.taskerPhone = '0123456759',
    this.taskerImageLink =
        'https://storage.googleapis.com/se100-af7bc.appspot.com/images/1725630023846-ANIME-PICTURES.NET_-_501133-1197x674-elden_ring-malenia_blade_of_miquella-agong-single-long_hair-wide_image-transformed.jpeg?GoogleAccessId=firebase-adminsdk-6avlp%40se100-af7bc.iam.gserviceaccount.com&Expires=1729234529&Signature=F2pTBMS10pYiDfqBskF7NyLlITUEOwhOQqOPvxmEcCkjBPTV5Lf5KvIu53UV6LNy2s6suCNU0qq97rFaXy%2FKYAquOHeG9%2F%2BstlPmPwViM1mhHF0q12ptEJAwfXbXycND%2FuyaAhNm38zNTBNy%2BdAy%2FZQR4J0CO6lXKLlYLzqP5%2BKuwI4o711lsxSYUVRv1S4%2Fi55Gm%2FF5RDTg%2Fy%2BsP2BGfV71VF44bWcvkwtwjGOkGXWMCmRjmmaDjPiJhxQX9rGDuCyi59Sh9er%2FPWD2lrg6WIh2r14XJjnMnNK5a9tNvH5F5xNDUnohHo2qqOHzWtsOzULdoUUx%2B2USosN9Y79VxQ%3D%3D',
  });

  @override
  State<Taskerrowdelete> createState() => _TaskerrowdeleteState();
}

class _TaskerrowdeleteState extends State<Taskerrowdelete> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Taskerprofile(taskerId: widget.taskerId),
          ),
        ),
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: Row(
          children: [
            Image.network(
              'https://storage.googleapis.com/se100-af7bc.appspot.com/images/1728630023846-ANIME-PICTURES.NET_-_801133-1197x674-elden_ring-malenia_blade_of_miquella-agong-single-long_hair-wide_image-transformed.jpeg?GoogleAccessId=firebase-adminsdk-6avlp%40se100-af7bc.iam.gserviceaccount.com&Expires=1729234829&Signature=F2pTBMS10pYiDfqBskF7NyLlITUEOwhOQqOPvxmEcCkjBPTV8Lf8KvIu53UV6LNy2s6suCNU0qq97rFaXy%2FKYAquOHeG9%2F%2BstlPmPwViM1mhHF0q12ptEJAwfXbXycND%2FuyaAhNm38zNTBNy%2BdAy%2FZQR4J0CO6lXKLlYLzqP8%2BKuwI4o711lsxSYUVRv1S4%2Fi58Gm%2FF8RDTg%2Fy%2BsP2BGfV71VF44bWcvkwtwjGOkGXWMCmRjmmaDjPiJhxQX9rGDuCyi89Sh9er%2FPWD2lrg6WIh2r14XJjnMnNK8a9tNvH8F5xNDUnohHo2qqOHzWtsOzULdoUUx%2B2USosN9Y79VxQ%3D%3D',
              width: 35,
              height: 35,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              },
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 35,
                );
              },
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.taskerName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Inter',
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              iconSize: 20,
              color: AppColors.do_main,
              icon: const FaIcon(FontAwesomeIcons.trash),
              onPressed: () {
                widget.onPressFun();
              },
            ),
          ],
        ),
      ),
    );
  }
}
