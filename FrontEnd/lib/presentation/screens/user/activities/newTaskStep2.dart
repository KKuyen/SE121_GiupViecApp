import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/common/helpers/SecureStorage.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/common/widgets/voucher/voucherCard.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/bloc/newTask1/newTask1_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/newTask2/newTask2_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/newTask2/newTask2_state.dart';
import 'package:se121_giupviec_app/presentation/screens/navigation/navigation.dart';

class Newtaskstep2 extends StatefulWidget {
  final int taskTypeId;
  final int? myvoucherId;
  int? locationId;
  final int firstPrice;
  final int userId;

  final List<Map<String, dynamic>> addPriceDetail;

  Newtaskstep2({
    required this.userId,
    required this.firstPrice,
    required this.taskTypeId,
    super.key,
    required this.addPriceDetail,
    this.myvoucherId,
    this.locationId,
  });

  @override
  State<Newtaskstep2> createState() => _Newtaskstep2State();
}

class _Newtaskstep2State extends State<Newtaskstep2> {
  int? voucherId = 0;
  String voucherName = 'Chưa có mã giảm giá nào';
  String voucherValue = '0 đ';

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String note = '';
  final TextEditingController _noteController = TextEditingController();
  var selectLocaion;

  @override
  void initState() {
    super.initState();

    _selectedDate = DateTime.now().add(const Duration(days: 1));
    _selectedTime = const TimeOfDay(hour: 8, minute: 0);
    final NewTask2 = BlocProvider.of<NewTask2Cubit>(context)
        .getLocationAndVoucher(widget.userId, widget.taskTypeId);
  }

  void setVoucherId(int id, String voucherName, String value) {
    print(voucherName);
    setState(() {
      voucherId = id;
      this.voucherName = voucherName;
      voucherValue = value;
    });
  }

  String tongThanhToan(int firstPrice, String voucherValue) {
    String sum = firstPrice.toString();
    if (voucherValue.contains('%')) {
      double discountPercentage =
          double.parse(voucherValue.replaceAll('%', ''));
      double discountAmount = firstPrice * (discountPercentage / 100);
      sum = (firstPrice - discountAmount).toString();
    } else {
      int discountAmount =
          int.parse(voucherValue.replaceAll(' đ', '').replaceAll(',', ''));
      sum = (firstPrice - discountAmount).toString();
    }
    return sum;
  }

  void setVoucherValue(String value) {
    setState(() {
      voucherValue = value;
    });
  }

  // Hàm định dạng ngày
  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day}/${date.month}/${date.year}';
  }

  // Hàm định dạng giờ
  String _formatTime(TimeOfDay? time) {
    if (time == null) return '';
    return time.format(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dateController.text = _formatDate(_selectedDate);
    _timeController.text = _formatTime(_selectedTime);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTask2Cubit, NewTask2State>(
      builder: (context, state) {
        if (state is NewTask2Loading) {
          return Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
              ),
              child: const Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
        } else if (state is NewTask2Success) {
          if (widget.locationId != null) {
            selectLocaion = state.Mylocations.firstWhere(
              (location) => location.id == widget.locationId,
            );
          } else {
            selectLocaion = state.dfLocation;
          }
          return Scaffold(
            backgroundColor: AppColors.nen_the,
            appBar: const BasicAppbar(
              title: Text(
                'Điền thông tin chi tiết',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              isHideBackButton: false,
              isHavePadding: true,
              color: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppInfor1.horizontal_padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thời gian làm việc',
                        style: AppTextStyle.tieudebox),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _dateController,
                      decoration: const InputDecoration(
                        labelText: 'Chọn ngày',
                        border: OutlineInputBorder(),
                        suffixIcon:
                            Icon(Icons.calendar_today, color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.xanh_main),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                        floatingLabelStyle:
                            TextStyle(color: AppColors.xanh_main),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: AppColors.xanh_main,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (pickedDate != null) {
                          if (pickedDate.isBefore(DateTime.now())) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Chọn ngày làm sớm nhất là ngày mai'),
                                backgroundColor: AppColors.cam_main,
                              ),
                            );
                          } else {
                            setState(() {
                              _selectedDate = pickedDate;
                              _dateController.text = _formatDate(_selectedDate);
                            });
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _timeController,
                      decoration: const InputDecoration(
                        labelText: 'Chọn giờ',
                        border: OutlineInputBorder(),
                        suffixIcon:
                            Icon(Icons.access_time, color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.xanh_main),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                        floatingLabelStyle:
                            TextStyle(color: AppColors.xanh_main),
                      ),
                      readOnly: true,
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: _selectedTime ?? TimeOfDay.now(),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: AppColors.xanh_main,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (pickedTime != null) {
                          setState(() {
                            _selectedTime = pickedTime;
                            _timeController.text = _formatTime(_selectedTime);
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text('Địa điểm làm việc',
                        style: AppTextStyle.tieudebox),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.xam72, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.xanh_main),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (selectLocaion.isDefault == true)
                                      const Text(
                                        'Địa chỉ mặc định',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.xanh_main,
                                        ),
                                      ),
                                    const SizedBox(height: 2),
                                    Text(
                                      selectLocaion.ownerName,
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${selectLocaion.detailAddress}, ${selectLocaion.district}, ${selectLocaion.province}, ${selectLocaion.country}',
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      selectLocaion.ownerPhoneNumber,
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                              child: Row(
                                children: [
                                  const Text(
                                    'Chọn địa chỉ khác',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Spacer(),
                                  Sizedbutton(
                                    onPressFun: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Container(
                                              constraints: const BoxConstraints(
                                                minHeight: 300,
                                                maxHeight: 500,
                                              ),
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Chọn địa chỉ',
                                                        style: TextStyle(
                                                          fontFamily: 'Inter',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .xanh_main,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.close,
                                                          color:
                                                              AppColors.xam72,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Expanded(
                                                    child: ListView.builder(
                                                      itemCount: state
                                                          .Mylocations.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final location = state
                                                            .Mylocations[index];
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  0, 0, 0, 5),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                selectLocaion =
                                                                    location;
                                                              });
                                                              widget.locationId =
                                                                  location.id;
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: location.id ==
                                                                            selectLocaion
                                                                                .id
                                                                        ? AppColors
                                                                            .xanh_main
                                                                        : const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            202,
                                                                            202,
                                                                            202)),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    if (location
                                                                            .isDefault ==
                                                                        true)
                                                                      const Text(
                                                                        'Địa chỉ mặc định',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              AppColors.xanh_main,
                                                                        ),
                                                                      ),
                                                                    Text(
                                                                      location
                                                                          .ownerName,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            2),
                                                                    Text(
                                                                      '${location.detailAddress}, ${location.district}, ${location.province}, ${location.country}',
                                                                      style:
                                                                          const TextStyle(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            2),
                                                                    Text(
                                                                      location
                                                                          .ownerPhoneNumber,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    text: 'Thay đổi',
                                    width: 120,
                                    height: 42,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('Ghi chú', style: AppTextStyle.tieudebox),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _noteController,
                      maxLength: 200,
                      cursorColor: AppColors.xanh_main,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'Nhập ghi chú',
                        hintStyle: TextStyle(
                          color: AppColors.xam72,
                          fontWeight: FontWeight.normal,
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.xanh_main),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                        floatingLabelStyle:
                            TextStyle(color: AppColors.xanh_main),
                      ),
                      onChanged: (value) {
                        setState(() {
                          note = value;
                        });
                      },
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Mã giảm giá'),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: state.vouchers.map((voucher) {
                                    return Container(
                                      child: VoucherCard(
                                        isBorder: (voucher.id == voucherId)
                                            ? true
                                            : false,
                                        imageUrl: voucher.image ?? '',
                                        title: voucher.header ?? '',
                                        description: voucher.content ?? '',
                                        onPressed: () {
                                          setVoucherId(voucher.id,
                                              voucher.header, voucher.value);
                                          Navigator.pop(context);
                                        },
                                        RpointCost:
                                            voucher.RpointCost.toString(),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Đóng'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          const Text('Mã giảm giá',
                              style: AppTextStyle.tieudebox),
                          const SizedBox(width: 10),
                          const Spacer(),
                          Text(voucherName,
                              style: (voucherId == 0
                                  ? AppTextStyle.textthuong
                                  : AppTextStyle.textthuongxanhmain)),
                          const SizedBox(width: 10),
                          const Icon(
                            FontAwesomeIcons.angleRight,
                            color: AppColors.xam72,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text('Chi tiết thanh toán',
                        style: AppTextStyle.tieudebox),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text('Tổng tiền dịch vụ',
                            style: AppTextStyle.textnhoxam),
                        const Spacer(),
                        Text('${widget.firstPrice} đ',
                            style: AppTextStyle.textnhoxam),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Giảm giá', style: AppTextStyle.textnhoxam),
                        const Spacer(),
                        Text(voucherValue, style: AppTextStyle.textnhoxam),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Tổng thanh toán',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        const Spacer(),
                        Text(
                            '${tongThanhToan(widget.firstPrice, voucherValue)} đ',
                            style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.cam_main)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Sizedbutton(
                      onPressFun: () async {
                        int userId = int.parse(await SecureStorage().readId());

                        int taskTypeId = widget.taskTypeId;
                        DateTime time = DateTime(
                          _selectedDate!.year,
                          _selectedDate!.month,
                          _selectedDate!.day,
                          _selectedTime!.hour,
                          _selectedTime!.minute,
                        );
                        int locationId = selectLocaion.id;
                        String note = this.note;
                        int? myvoucherId = widget.myvoucherId ?? 0;
                        int selectedvoucher = voucherId ?? 0;
                        List<Map<String, dynamic>> addPriceDetail =
                            widget.addPriceDetail;
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                        await context.read<NewTask1Cubit>().createTask(
                              userId,
                              taskTypeId,
                              time,
                              locationId,
                              note,
                              myvoucherId,
                              selectedvoucher,
                              addPriceDetail,
                            );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Đăng việc thành công!'),
                            backgroundColor: AppColors.xanh_main,
                          ),
                        );
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Navigation(tab: 1, userId: widget.userId),
                          ),
                        );
                      },
                      text: 'Đăng việc',
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is NewTask2Error) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No locations found'));
        }
      },
    );
  }
}
