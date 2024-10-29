import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/common/widgets/voucher/voucherCard.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_images.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../../../presentation/bloc/Voucher/voucher_cubit.dart';
import '../../../presentation/bloc/Voucher/voucher_state.dart';
import '../button/sizedbutton.dart';

class Vouchers extends StatefulWidget {
  final bool isNearToExpire;
  const Vouchers({
    this.isNearToExpire = false,
    super.key,
  });

  @override
  State<Vouchers> createState() => _VouchersState();
}

class _VouchersState extends State<Vouchers> {
  @override
  void initState() {
    super.initState();
    final voucherCubit = BlocProvider.of<VoucherCubit>(context).getAllVoucher();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoucherCubit, VoucherState>(
      builder: (context, state) {
        if (state is VoucherLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is VoucherSuccess) {
          final vouchers = state.vouchers;
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: vouchers.length,
              itemBuilder: (context, index) {
                final voucher = vouchers[index];
                final currentDate = DateTime.now();
                final difference =
                    voucher.endDate.difference(currentDate).inDays;

                if (widget.isNearToExpire == true && difference > 5) {
                  return Container();
                }

                return VoucherCard(
                  imageUrl: AppImages.voucher1,
                  title: voucher.header,
                  description: voucher.content,
                  onPressed: _showDialog,
                  RpointCost: voucher.RpointCost.toString(),
                );
              });
        } else if (state is VoucherError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('Không tìm thấy voucher'));
        }
      },
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận'),
          content: const Text('Bạn có muốn lưu voucher này không?'),
          actions: <Widget>[
            Sizedbutton(
              onPressFun: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
              text: 'Hủy',
              backgroundColor: Colors.white,
              StrokeColor: AppColors.cam_main,
              isStroke: true,
              textColor: AppColors.cam_main,
            ),
            Sizedbutton(
              onPressFun: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
              text: 'Lưu',
              backgroundColor: AppColors.cam_main,
            ),
          ],
        );
      },
    );
  }
}
