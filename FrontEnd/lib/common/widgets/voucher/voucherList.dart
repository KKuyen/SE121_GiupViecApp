import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/common/widgets/voucher/voucherCard.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_images.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';

class Vouchers extends StatelessWidget {
  const Vouchers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          VoucherCard(
            imageUrl: AppImages.voucher1,
            title: 'Voucher 50%',
            description: 'Tất cả dịch vụ',
            onPressed: () {},
          ),
          VoucherCard(
            imageUrl: AppImages.voucher2,
            title: 'Voucher 50%',
            description: 'Tất cả dịch vụ',
            onPressed: () {},
          ),
          VoucherCard(
            imageUrl: AppImages.voucher1,
            title: 'Voucher 50%',
            description: 'Tất cả dịch vụ',
            onPressed: () {},
          ),
          VoucherCard(
            imageUrl: AppImages.voucher2,
            title: 'Voucher 50%',
            description: 'Tất cả dịch vụ',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
