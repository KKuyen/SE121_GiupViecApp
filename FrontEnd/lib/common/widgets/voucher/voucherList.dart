import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/common/widgets/voucher/voucherCard.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_images.dart';

import 'package:se121_giupviec_app/presentation/bloc/Voucher/claim_voucher_cubit.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../../../presentation/bloc/Voucher/voucher_cubit.dart';
import '../../../presentation/bloc/Voucher/voucher_state.dart';
import '../../helpers/SecureStorage.dart';
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
  }

  Future<int> _initialize() async {
    int userId = int.parse(await secureStorage.readId());
    return userId;
  }

  SecureStorage secureStorage = SecureStorage();
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
                String imageUrl = "";
                if (voucher.image == "voucher1") {
                  imageUrl = AppImages.voucher1;
                } else if (voucher.image == "voucher2") {
                  imageUrl = AppImages.voucher2;
                } else if (voucher.image == "voucher3") {
                  imageUrl = AppImages.voucher3;
                }

                return VoucherCard(
                  isBorder: false,
                  imageUrl: imageUrl,
                  title: voucher.header,
                  description: voucher.content,
                  onPressed: () async {
                    int userId = await _initialize();
                    if (userId != null) {
                      _showDialog(voucher.id, userId);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Người dùng không tồn tại"),
                            backgroundColor: AppColors.do_main),
                      );
                    }
                  },
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

  void _showDialog(int voucherId, int userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocListener<ClaimVoucherCubit, VoucherState>(
          listener: (context, state) {
            if (state is VoucherLoading) {
            } else {
              // Hide loading dialog
              Navigator.of(context).pop();

              if (state is ResponseVoucherSuccess) {
                Navigator.of(context).pop(); // Đóng dialog

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Đã lưu voucher"),
                      backgroundColor: AppColors.xanh_main),
                );
              } else if (state is VoucherError) {
                Navigator.of(context).pop(); // Đóng dialog

                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(state.message),
                      backgroundColor: AppColors.do_main),
                );
              }
            }
          },
          child: AlertDialog(
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
                  context
                      .read<ClaimVoucherCubit>()
                      .claimVoucher(userId, voucherId);
                },
                text: 'Lưu',
                backgroundColor: AppColors.cam_main,
              ),
            ],
          ),
        );
      },
    );
  }
}
