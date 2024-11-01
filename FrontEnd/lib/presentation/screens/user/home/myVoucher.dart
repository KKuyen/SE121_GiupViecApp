import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart'; // Import Slidable package
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_images.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';

import '../../../../common/helpers/SecureStorage.dart';
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
  });

  final Widget thumbnail;
  final String title;
  final String user;
  final String viewCount;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Define the slideable actions on both sides

      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              // Add your action here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Xóa $title')),
              );
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
                  return CustomListItem(
                    user: vouchers[index].content,
                    viewCount: "120",
                    thumbnail: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        image: const DecorationImage(
                          image: const AssetImage(AppImages.voucher1),
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
