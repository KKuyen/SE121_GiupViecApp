import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart'; // Import Slidable package
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_images.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/presentation/bloc/Voucher/delete_my_voucher_cubit.dart';

import '../../../../common/helpers/SecureStorage.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../bloc/Voucher/voucher_cubit.dart';
import '../../../bloc/Voucher/voucher_state.dart';

void main() => runApp(const MyVoucherPage());

class MyVoucherPage extends StatefulWidget {
  const MyVoucherPage({super.key});

  @override
  State<MyVoucherPage> createState() => _MyVoucherPageState();
}

class _MyVoucherPageState extends State<MyVoucherPage> {
  int? userId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const CustomListItemExample();
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.user,
    required this.viewCount,
    required this.id,
  });

  final Widget thumbnail;
  final String title;
  final String user;
  final String viewCount;
  final int id;
  Future<int> _initialize() async {
    SecureStorage secureStorage = SecureStorage();
    int userId = int.parse(await secureStorage.readId());
    return userId;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteMyVoucherCubit, VoucherState>(
      listener: (context, state) {
        if (state is ResponseVoucherSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Xóa thành công'),
              backgroundColor: AppColors.xanh_main,
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyVoucherPage()),
          );
        } else if (state is VoucherError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.do_main,
            ),
          );
        }
      },
      child: Slidable(
        // Define the slideable actions on both sides

        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                final voucherCubit =
                    BlocProvider.of<DeleteMyVoucherCubit>(context);
                _initialize().then((userId) {
                  voucherCubit.deleteMyVoucher(userId, id);
                });
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Xóa',
            ),
          ],
        ),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: thumbnail,
                ),
                const SizedBox(width: 7),
                Expanded(
                  flex: 3,
                  child: _VoucherDescription(
                    title: title,
                    user: user,
                    viewCount: viewCount,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VoucherDescription extends StatelessWidget {
  const _VoucherDescription({
    required this.title,
    required this.user,
    required this.viewCount,
  });

  final String title;
  final String user;
  final String viewCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            user,
            style: const TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            '$viewCount views',
            style: const TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class CustomListItemExample extends StatefulWidget {
  const CustomListItemExample({super.key});

  @override
  State<CustomListItemExample> createState() => _CustomListItemExampleState();
}

class _CustomListItemExampleState extends State<CustomListItemExample> {
  Future<int> _initialize() async {
    SecureStorage secureStorage = SecureStorage();
    int userId = int.parse(await secureStorage.readId());
    return userId;
  }

  @override
  Widget build(BuildContext context) {
    final voucherCubit = BlocProvider.of<VoucherCubit>(context);
    _initialize().then((userId) {
      voucherCubit.getMyVoucher(userId);
    });

    return Scaffold(
      appBar: const BasicAppbar(
        isHideBackButton: false,
        isHavePadding: false,
        title: Text(
          'Voucher của tôi',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<VoucherCubit, VoucherState>(
        builder: (context, state) {
          if (state is VoucherLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is VoucherSuccess) {
            final vouchers = state.vouchers;
            return ListView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppInfo.main_padding),
                itemCount: vouchers.length,
                itemExtent: 100.0,
                itemBuilder: (context, index) {
                  String imageUrl = "";
                  if (vouchers[index].image == "voucher1") {
                    imageUrl = AppImages.voucher1;
                  } else if (vouchers[index].image == "voucher2") {
                    imageUrl = AppImages.voucher2;
                  } else if (vouchers[index].image == "voucher3") {
                    imageUrl = AppImages.voucher3;
                  }
                  return CustomListItem(
                    id: vouchers[index].id,
                    user: vouchers[index].content,
                    viewCount: "120",
                    thumbnail: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        image: DecorationImage(
                          image: AssetImage(imageUrl),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    title: vouchers[index].header,
                  );
                });
          } else if (state is VoucherError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Không tìm thấy voucher'));
          }
          // return ListView(
          //   padding:
          //       const EdgeInsets.symmetric(horizontal: AppInfo.main_padding),
          //   itemExtent: 100.0,
          //   children: <CustomListItem>[
          //     CustomListItem(
          //       user: 'Tất cả dịch vụ',
          //       viewCount: 999000,
          //       thumbnail: Container(
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(13),
          //           image: const DecorationImage(
          //             image: AssetImage(AppImages.voucher1),
          //             fit: BoxFit.fill,
          //           ),
          //         ),
          //       ),
          //       title: 'Voucher 25%',
          //     ),
          //   ],
          // );
        },
      ),
    );
  }
}
