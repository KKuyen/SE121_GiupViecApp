import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/common/widgets/voucher/voucherCard.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_images.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';

import '../../../presentation/bloc/Voucher/voucher_cubit.dart';
import '../../../presentation/bloc/Voucher/voucher_state.dart';

class Vouchers extends StatefulWidget {
  const Vouchers({
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
                return VoucherCard(
                  imageUrl: AppImages.voucher1,
                  title: voucher.header,
                  description: voucher.content,
                  onPressed: () {},
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

    // return SingleChildScrollView(
    //   scrollDirection: Axis.horizontal,
    //   child: Row(
    //     children: [
    //       VoucherCard(
    //         imageUrl: AppImages.voucher1,
    //         title: 'Voucher 50%',
    //         description: 'Tất cả dịch vụ',
    //         onPressed: () {},
    //       ),
    //     ],
    //   ),
    // );
  }
}
